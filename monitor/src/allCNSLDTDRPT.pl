#!/usr/bin/perl
use DBI;
use Time::Local;
use strict;
use warnings;
use diagnostics;
use Benchmark;
use Data::Dumper;
#require "MabelUtil.pm";

#*******************************************************************************
#  Program Name: allCNSLDTDRPT.pl (originally called checkPSMABELONLY.pl)
#  Author      : Jacob Ray
#  Date        : 11/20/2013
#                This program finds all the customers that have some sort of
#                consolidation for the month, either MABEL or INvoice Reports
#********************************************************************************
#  History of Changes
#--------------------------------------------------------------------------------
# 1) Turned AutoCommit off, and explicitly commit after all inserts have completed,
#    versus committing after each insert.
# 2) Added parallel hints to the driving query, add bind_columns, and use 
#    fetchrow_arrayref to improve performance.
# 3) Removed function calls to mabel_control and mabel_audit and pre-loaded the 
#    relevant table data into complex hashes.
# 4) Moved calls from the BRM database over to the ODS database as the explain
#    plans were better.
# 5) Used <perl -d:DProf program.pl> to find where this script was spending most
#    of its time and <dprofpp -I tmon.out | less> to view the results.
#--------------------------------------------------------------------------------
#********************************************************************************
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
my $currentmonth = ( localtime( time() ) )[4]+1;
my $currentyear = 1900+( localtime( time() ) )[5];
my $timestamp = $currentyear.$currentmonth.$mday.$hour.$min.$sec;
open(F, ">log/ALLCONSOLIDATED_report_daemon_".$timestamp.".log") or die "Cannot open log/ALLCONSOLIDATED_report_daemon_".$timestamp.".log..\n";
*STDERR = *F;

  my $appId = 'CHECK';
  my $inputMonth = $ARGV[0];
  my $inputYear= $ARGV[1];
  my (%HoH,%HoHHP,%MCHoHoHoH,%MAHoHoHoH,$mblCtrlResults,$mblAdtResults);


my $dbh_BRM = DBI->connect("dbi:Oracle:BRM_SVC_BILLINGOPS",,)
    or die "Unable to connect to Oracle Database (BRM): " . DBI->errstr;   # shell script will have set $MABEL_BRM_DB via GetDBConnection call
my $dbh_ODS = DBI->connect("dbi:Oracle:BODS_SVC_BILLINGOPS",,)
    or die "Unable to connect to Oracle Database (ODS): " . DBI->errstr;   # shell script will have set $MABEL_ODS_DB via GetDBConnection call
my $dbh_TOPS = DBI->connect("dbi:Oracle:CST_SVC_BILLINGOPS",,)
    or die "Unable to connect to Oracle Database (TOPS): " . DBI->errstr;   # shell script will have set $MABEL_TOPS_DB via GetDBConnection call

# turn auto commit off;
$dbh_TOPS->{AutoCommit} = 0;

# turn autoflush on
$| =1;

# redirect warnings to STDOUT
#$SIG{__WARN__} = sub
#{
#    my @loc = caller(1);
#    print STDOUT "Warning generated at line $loc[2] in $loc[1]:\n", @_, "\n";
#    return 1;
#};

#preload relevant data from mabel_control,mabel_audit,hold_table, and hold_prod
#into complex hashes
  getMblCtrlHOHOH(\$inputMonth, \$inputYear);
  getMblAudtHOHOH(\$inputMonth, \$inputYear);
  getDefectHoH(\$inputMonth, \$inputYear);

  checkMonthFileExists(\$inputMonth, \$inputYear);
  $dbh_TOPS->commit;
  close (F);
  exit(0);

#******************************************************************************
#  call BILL ARCH
#******************************************************************************
sub callBILLARCH{
  my ($bill_seq_no) = @_;

       my $SELECTBILLARCH = qq/

        select nvl((select 'Y' from  bf1_archive_bill bf where bf.bill_id = to_char($bill_seq_no)),'N') from dual

    /;

  my $stmt_hd14 = $dbh_ODS->prepare($SELECTBILLARCH) or die $dbh_ODS->errstr();

  $stmt_hd14->execute() or die $stmt_hd14->errstr();
  my $bill_arch = $stmt_hd14->fetchrow_array();
  #print " prashant printing befor return $bill_arch \n";

  return $bill_arch;

  }

#******************************************************************************
#  this subroutine checks to see if the inputed account is on the MABEL_CONTROL
#  table, which means that the account should have a file to be consolidated
#  If the account is not present, or there are multiple entries it will
#  create an entry on the MABEL_ERROR table.
#******************************************************************************

#******************************************************************************
#  this subroutine retrieves any defects from the HOLD_TABLE on PRDCUST that
#  may be preventing the customer from successfully billing
#******************************************************************************

sub callHldTbl{

  my ($account_no) = @_;
  my $defect_string;
  my $cnt=0;
# if a hash with key of $account_no exists, print all of the defect/status
# key/value pairs. If not, return an empty string.

#Work with HOLD_TABLE hash

  if (exists $HoH{$account_no}) {
    # print $key is $value,...
    foreach my $k1 (keys %{$HoH{$account_no}}) {
#      print "$k1 => $HoH{$account_no}{$k1}\n";}
      if ($cnt==0) {
        $defect_string="$k1 is $HoH{$account_no}{$k1}";
      } else {$defect_string .= ", $k1 is $HoH{$account_no}{$k1}"}
    $cnt++;
    }
  } else {
    $defect_string="";
  }


#work with HOLD_PROD table
  $cnt=0;
  $defect_string .= "\t";

# if a hash with key of $account_no exists, print all of the defect/status
# key/value pairs. If not, return an empty string.

  if (exists $HoHHP{$account_no}) {
    # print $key is $value,...
    foreach my $k2 (keys %{$HoHHP{$account_no}}) {
#      print "$k2 => $HoHHP{$account_no}{$k2}\n";}
      if ($cnt==0) {
        $defect_string.="$k2 is $HoHHP{$account_no}{$k2}";
      } else {$defect_string .= ", $k2 is $HoHHP{$account_no}{$k2}"}
    $cnt++;
    }
  } else {
    $defect_string .="";
  }

  return $defect_string;
}

#******************************************************************************
#  this subroutine retrieves the error codes from bl1_cycle_errors
#******************************************************************************

sub callCycErr{
  my ($account_no, $cycle_run_month, $cycle_run_year) = @_;

  my $mblCycErrPop = qq/
     SELECT error_code
     FROM bl1_cyc_payer_pop cpp,
     bl1_cycle_control cc,
     ABP_CUST.bl1_cycle_errors ce
     WHERE ba_no = $$account_no
     AND cycle_instance = $$cycle_run_month
     AND cycle_year = $$cycle_run_year
     AND cpp.period_key = cc.period_key
     AND cpp.cycle_seq_no = cc.cycle_seq_no
     AND cpp.cycle_seq_no = ce.cycle_seq_no
     AND cpp.ba_no = ce.entity_id
    /;


  my $stmt_hd2 = $dbh_ODS->prepare($mblCycErrPop) or die $dbh_ODS->errstr();
  $stmt_hd2->execute() or die $stmt_hd2->errstr();
  my ($errors,$error_string,$cnt);
  $cnt=0;
  $error_string = "";
  while ($errors = $stmt_hd2->fetchrow_arrayref()) {
    $cnt++;
    if ($cnt==1) {
       $error_string .= "@$errors[0]";
    } elsif ($cnt>1) {$error_string .= ",@$errors[0]"}
  }
  if ($cnt==0){$error_string=""}
  return $error_string;
}

#**************************************************************************
#  This subroutine creates a hash of hashes which contain a key of the
#  ba_account_no which may have one or more key/values of defects and
#  their status.
#**************************************************************************
sub getDefectHoH{
  my ($cycle_run_month, $cycle_run_year) = @_;

#START HOLD_TABLE

  my $loadHoldTables = qq/
    SELECT ba_account_no,NVL(defect,'NULL'),status
     FROM hold_table h, bl1_blng_arrangement b
     where h.customer_id = b.ba_customer_no
     AND cycle_seq_no in (select cycle_seq_no from bl1_cycle_control
                                    where cycle_instance = $$cycle_run_month
                                    and cycle_year = $$cycle_run_year)
    /;

  my $stmt_hd2 = $dbh_TOPS->prepare($loadHoldTables) or die $dbh_TOPS->errstr();
  $stmt_hd2->execute() or die $stmt_hd2->errstr();

  my ($defects,$cnt);
  $cnt=0;
  while ($defects = $stmt_hd2->fetchrow_arrayref()) {
    $cnt++;
    # this works whether or not a HoH key exists through autovivification.
    $HoH{@$defects[0]}{@$defects[1]}=@$defects[2];  # add to hash

#    THIS OVERWRITES INSTEAD OF ADDS!!
#    $HoH{@$defects[0]} = {@$defects[1]=>@$defects[2]};
  }
#  print Dumper (\%HoH);


#Start HOLD_PROD
  my $loadHoldProd = qq/
     SELECT  ba_account_no,defect,status
     FROM hold_prod h, bl1_blng_arrangement b
     where h.customer_id = b.ba_customer_no
       and h.account_no = b.ba_account_no
     and cycle_seq_no in (select cycle_seq_no from bl1_cycle_control
                                    where cycle_instance = $$cycle_run_month
                                    and cycle_year = $$cycle_run_year)
    /;

  my $stmt_hd3 = $dbh_TOPS->prepare($loadHoldProd) or die $dbh_TOPS->errstr();
  $stmt_hd3->execute() or die $stmt_hd3->errstr();

  my ($defectsHP,$cntHP);
  $cntHP=0;
  while ($defectsHP = $stmt_hd3->fetchrow_arrayref()) {
    $cntHP++;
    # this works whether or not a HoH key exists through autovivification.
    $HoHHP{@$defectsHP[0]}{@$defectsHP[1]}=@$defectsHP[2];  # add to hash

#    THIS OVERWRITES INSTEAD OF ADDS!!
#    $HoHHP{@$defectsHP[0]} = {@$defectsHP[1]=>@$defectsHP[2]};
  }
#  print Dumper (\%HoHHP);
}

sub getMblCtrlHOHOH {
  my ($cycle_run_month, $cycle_run_year) = @_;
  my $stmt = $dbh_ODS->prepare("SELECT account_no,cycle_code,consolidator,
     file_name,file_create_date,
     DECODE(file_status,'RD','READY','IU','IN USE','WA','WAITING','CO','COMPLETED',
        'RJ','REJECTED','CR','CANCELLED','ZZ') as file_status
     FROM mabel_control
     WHERE file_type = 'ACT'
     AND cycle_run_month = ?
     AND cycle_run_year = ?") or die $dbh_ODS->errstr();

#  my $t0 = Benchmark->new;
    $stmt->execute($$cycle_run_month,$$cycle_run_year) or die $stmt->errstr();
#  my $t1 = Benchmark->new;
#  my $td = timediff($t1, $t0);
#  print F "the MABEL_CONTROL execute code took:",timestr($td),"\n";

#  my ($mblCtrlResults);
#  $t0 = Benchmark->new;
  while ($mblCtrlResults = $stmt->fetchrow_arrayref()) {
    # this works whether or not a HoHoH key exists through autovivification. 
    $MCHoHoHoH{@$mblCtrlResults[0]}{@$mblCtrlResults[1]}{@$mblCtrlResults[2]}{'file_name'}=@$mblCtrlResults[3]; # add to hash
    $MCHoHoHoH{@$mblCtrlResults[0]}{@$mblCtrlResults[1]}{@$mblCtrlResults[2]}{'file_create_date'}=@$mblCtrlResults[4];
    $MCHoHoHoH{@$mblCtrlResults[0]}{@$mblCtrlResults[1]}{@$mblCtrlResults[2]}{'file_status'}=@$mblCtrlResults[5];
  }
#  $t1 = Benchmark->new;
#  $td = timediff($t1, $t0);
#  print F "the MABEL_CONTROL fetchrow_arrayref to HoHoHoH code took:",timestr($td),"\n";
#  print Dumper (\%MCHoHoHoH);
}

sub getMblAudtHOHOH {
  my ($cycle_run_month, $cycle_run_year) = @_;
  my $stmt = $dbh_ODS->prepare("select account_no,cycle_code,consolidator,
     min(orig_file_name),min(sent_file_name),min(sent_date)
     from mabel_audit
     WHERE cycle_run_month = ?
     AND cycle_run_year = ?
     group by account_no,cycle_code,consolidator") or die $dbh_ODS->errstr();
#  my $t0 = Benchmark->new;
    $stmt->execute($$cycle_run_month,$$cycle_run_year) or die $stmt->errstr();
#  my $t1 = Benchmark->new;
#  my $td = timediff($t1, $t0);
#  print F "the MABEL_AUDIT execute code took:",timestr($td),"\n";

#  my ($mblAdtResults);
#  $t0 = Benchmark->new;
  while ($mblAdtResults = $stmt->fetchrow_arrayref()) {
    # this works whether or not a HoHoH key exists through autovivification. 
    $MAHoHoHoH{@$mblAdtResults[0]}{@$mblAdtResults[1]}{@$mblAdtResults[2]}{'orig_file_name'}=@$mblAdtResults[3]; # add to hash
    $MAHoHoHoH{@$mblAdtResults[0]}{@$mblAdtResults[1]}{@$mblAdtResults[2]}{'sent_file_name'}=@$mblAdtResults[4];
    $MAHoHoHoH{@$mblAdtResults[0]}{@$mblAdtResults[1]}{@$mblAdtResults[2]}{'sent_date'}=@$mblAdtResults[5];
  }
#  $t1 = Benchmark->new;
#  $td = timediff($t1, $t0);
#  print F "the MABEL_AUDIT fetchrow_arrayref to HoHoHoH code took:",timestr($td),"\n";
#  print Dumper (\%MAHoHoHoH);
}


#******************************************************************************
#  this subroutine cleans up old runs of the report table in prodcust
#******************************************************************************
sub cleanupReportTable{
my $sth = $dbh_TOPS->prepare("DELETE FROM CNSLDTD_RPT_TBL WHERE creation_Date <= TRUNC(SYSDATE) - 10"); $sth->execute();
}

#******************************************************************************
#  See if there is an error message on the MABEL_ERROR table.
#
#  Deutscher, Donald: we don't put the errors in MABEL_ERROR for the single file
#  validator, just the final validation, this is something that we might have to incorporate
#******************************************************************************

sub checkMonthFileExists{


  my ($cycle_run_month, $cycle_run_year) = @_;
  my $auditCycle = 0;
  my $rejectMsg='';
  my $defectMsg='';
  my $mblStatus='';
  my $mblDate;
  my $acc_mabel_file;
  my $mbl_org_fname;
  my $mbl_sent_fname;


#get the list of ACCOUNT_NOs for INVOICE_REPORT Destination
my $hint = "/*+ parallel(16) */";
my $documentStmnt = qq/
SELECT ACCOUNT_NO,DESCRIPTION,CYCLE_CODE,CYCLE_SEQ_NO,L3_BILL_FORMAT,MEDIA,MABEL_VERSION,MABEL_CONSOLIDATOR,INVRPT_DESTINATION,TOPS_STATUS,REJECT_IND,
TOTAL_INVOICE_AMT,PREV_BALANCE_AMT,TOTAL_AMT_DUE,ACCOUNT_STATUS,HOLD_IND,MABEL_PERIOD,INVRPT_PERIOD,BA_NO,CUSTOMER_NO,AMDD_STATUS,AMDD_RJ_IND,
AMDD_ERROR_CD,MABEL_EFF_DATE,INVRPT_DATE,REPORT_STATUS,XML_STATUS,DOC_STATUS,MABEL_ID,XMISSION_MEDIA_TYPE,XML_DATE,SENT_DATE,
FORMAT_EXT_GROUP,CREATION_DATE,FORMAT_EXT_DATE,DB_STATUS_DATE,INV_REPORT_CREATION_DATE,BA_STATUS_DATE,DOC_SEQ_NO,PRODUCTION_TYPE,BILL_DATE,
PERIOD_CVRG_START_DATE,PERIOD_CVRG_END_DATE,X_BAN_GROUP_NAME,X_BAN_GROUP_ID
FROM (
SELECT ACCOUNT_NO,DESCRIPTION,CYCLE_CODE,CYCLE_SEQ_NO,L3_BILL_FORMAT,MEDIA,MABEL_VERSION,MABEL_CONSOLIDATOR,INVRPT_DESTINATION,TOPS_STATUS,REJECT_IND,
TOTAL_INVOICE_AMT,PREV_BALANCE_AMT,TOTAL_AMT_DUE,ACCOUNT_STATUS,HOLD_IND,MABEL_PERIOD,INVRPT_PERIOD,BA_NO,CUSTOMER_NO,AMDD_STATUS,AMDD_RJ_IND,
AMDD_ERROR_CD,MABEL_EFF_DATE,INVRPT_DATE,REPORT_STATUS,XML_STATUS,DOC_STATUS,MABEL_ID,XMISSION_MEDIA_TYPE,XML_DATE,SENT_DATE,
FORMAT_EXT_GROUP,CREATION_DATE,FORMAT_EXT_DATE,DB_STATUS_DATE,INV_REPORT_CREATION_DATE,BA_STATUS_DATE,DOC_SEQ_NO,PRODUCTION_TYPE,BILL_DATE,
PERIOD_CVRG_START_DATE,PERIOD_CVRG_END_DATE,X_BAN_GROUP_NAME,X_BAN_GROUP_ID,RANK() OVER (PARTITION BY CYCLE_SEQ_NO,CUSTOMER_NO,ACCOUNT_NO,BA_NO ORDER BY BILL_DATE DESC) RANK
FROM (
WITH invrpt_list AS (select $hint iadl.ba_account_no, id.dest_name, cc.cycle_code, id.invrpt_dest_code, id.bill_method_ind,
                              cpp.cycle_seq_no, cpp.period_key, ba.ba_no,ba.ba_status, bd.doc_produce_ind, cb.l3_bill_format,bc.hold_ind,
                              nvl(iadl.eff_date,nvl(iadl.sys_update_date,iadl.sys_creation_date)) as invrpt_eff_date, cpp.customer_no,
                              ba.creation_date,ba.ba_status_date,nvl(bd.doc_seq_no,0) doc_seq_no,nvl(bd.production_type,'NA') production_type,nvl(bd.bill_date,to_date('01-JAN-1900','DD-MON-YYYY'))bill_date,nvl(bd.period_cvrg_start_date,to_date('01-JAN-1900','DD-MON-YYYY')) period_cvrg_start_date,nvl(bd.period_cvrg_end_date,to_date('01-JAN-1900','DD-MON-YYYY')) period_cvrg_end_date
                        from bl1_document bd,
                             INVRPT_ACCT_DEST_LINK_mv iadl,
                             invrpt_destination_mv id,
                             bl1_cycle_control cc,
                             bl1_cyc_payer_pop cpp,
                             bl1_blng_arrangement ba,
                             csm_ben cb,
                             bl1_customer bc
                        where iadl.ba_account_no = ba.ba_account_no
                          and cb.ban= ba.ba_account_no
                          and id.invrpt_dest_code = iadl.invrpt_dest_code
                          and cpp.period_key = cc.period_key
                          and cpp.cycle_seq_no = cc.cycle_seq_no
                          and cpp.ba_no = ba.ba_no
                          and cpp.ba_no = bd.ba_no(+)
                          and cpp.period_key = bd.period_key(+)
                          and cpp.cycle_seq_no = bd.cycle_seq_no(+)
                          and cpp.customer_key = bd.customer_key(+)
                          and (cpp.period_key, cpp.cycle_seq_no) in (select period_key, cycle_seq_no
                                                                     from bl1_cycle_control
                                                                     where cycle_instance = $$cycle_run_month
                                                                       and cycle_year = $$cycle_run_year
                                                                       and cycle_code = cc.cycle_code)
                          and ba.ba_no = cpp.ba_no
                          and (nvl(iadl.eff_date,to_date(01012000,'DDMMYYYY')) < to_date(substr(lpad(cc.cycle_code,4,'0'),3,2)||lpad('$$cycle_run_month',2,'0')||'$$cycle_run_year', 'DDMMYYYY') and
                               nvl(iadl.exp_date,to_date(31122045,'DDMMYYYY')) > to_date(substr(lpad(cc.cycle_code,4,'0'),3,2)||lpad('$$cycle_run_month',2,'0')||'$$cycle_run_year', 'DDMMYYYY'))
                          and bc.customer_id = ba.ba_customer_no
                          and (nvl(id.eff_date,to_date(01012000,'DDMMYYYY')) < to_date(substr(lpad(cc.cycle_code,4,'0'),3,2)||lpad('$$cycle_run_month',2,'0')||'$$cycle_run_year', 'DDMMYYYY')
                          and nvl(id.exp_date,to_date(31122045,'DDMMYYYY')) > to_date(substr(lpad(cc.cycle_code,4,'0'),3,2)||lpad('$$cycle_run_month',2,'0')||'$$cycle_run_year', 'DDMMYYYY'))
                       union
                       select iadl.ba_account_no, id.dest_name, bc.cycle_code, id.invrpt_dest_code, id.bill_method_ind,
                              cc.cycle_seq_no,cc.period_key, ba.ba_no, ba.ba_status, 'NA', cb.l3_bill_format, bc.hold_ind,
                              nvl(iadl.eff_date,nvl(iadl.sys_update_date,iadl.sys_creation_date)) as invrpt_eff_date, ba.ba_customer_no,
                              ba.creation_date,ba.ba_status_date,0,'NA',to_date('01-JAN-1900','DD-MON-YYYY'),to_date('01-JAN-1900','DD-MON-YYYY'),to_date('01-JAN-1900','DD-MON-YYYY')
                       from bl1_blng_arrangement ba,
                            bl1_customer bc,
                            INVRPT_ACCT_DEST_LINK_mv iadl,
                            invrpt_destination_mv id,
                            bl1_cycle_control cc,
                            csm_ben cb
                       where bc.customer_id = ba.ba_customer_no
                         and iadl.ba_account_no = ba.ba_account_no
                         and cb.ban= ba.ba_account_no
                         and id.invrpt_dest_code = iadl.invrpt_dest_code
                         and ba.ba_status in ('N', 'O')
                         AND (ba.last_cycle_seq_no IN (SELECT cc.cycle_seq_no FROM bl1_cycle_control cc
                                     WHERE cc.cycle_year || LPAD(cc.cycle_instance,2,'0') <=
                                             TO_CHAR(ADD_MONTHS(TO_DATE(LPAD('$$cycle_run_month',2,'0')||'$$cycle_run_year','MMYYYY'),-1), 'YYYY') ||
                                             TO_CHAR(ADD_MONTHS(TO_DATE(LPAD('$$cycle_run_month',2,'0'), 'MM'), -1), 'MM')) OR ba.last_cycle_seq_no IS NULL)
                         and cc.cycle_code = bc.cycle_code
                         and cc.cycle_instance = $$cycle_run_month
                         and cc.cycle_year =$$cycle_run_year
                         and (nvl(iadl.eff_date,to_date(01012000,'DDMMYYYY')) < to_date(substr(lpad(bc.cycle_code,4,'0'),3,2)||lpad('$$cycle_run_month',2,'0')||'$$cycle_run_year', 'DDMMYYYY') and
                               nvl(iadl.exp_date,to_date(31122045,'DDMMYYYY')) > to_date(substr(lpad(bc.cycle_code,4,'0'),3,2)||lpad('$$cycle_run_month',2,'0')||'$$cycle_run_year', 'DDMMYYYY'))
                         and bc.customer_id = ba.ba_customer_no
                         and (nvl(id.eff_date,to_date(01012000,'DDMMYYYY')) < to_date(substr(lpad(bc.cycle_code,4,'0'),3,2)||lpad('$$cycle_run_month',2,'0')||'$$cycle_run_year', 'DDMMYYYY')
                          and nvl(id.exp_date,to_date(31122045,'DDMMYYYY')) > to_date(substr(lpad(cc.cycle_code,4,'0'),3,2)||lpad('$$cycle_run_month',2,'0')||'$$cycle_run_year', 'DDMMYYYY'))
                       union
                       select iadl.ba_account_no, id.dest_name, bc.new_cycle, id.invrpt_dest_code, id.bill_method_ind,
                              cc.cycle_seq_no,cc.period_key,ba.ba_no, ba.ba_status, 'NA', cb.l3_bill_format, bc.hold_ind,
                              nvl(iadl.eff_date,nvl(iadl.sys_update_date,iadl.sys_creation_date)) as invrpt_eff_date, ba.ba_customer_no,
                              ba.creation_date,ba.ba_status_date,0,'NA',to_date('01-JAN-1900','DD-MON-YYYY'),to_date('01-JAN-1900','DD-MON-YYYY'),to_date('01-JAN-1900','DD-MON-YYYY')
                       from bl1_customer bc,
                            bl1_blng_arrangement ba,
                            INVRPT_ACCT_DEST_LINK_mv iadl,
                            invrpt_destination_mv id,
                            bl1_cycle_control cc,
                            csm_ben cb
                      where bc.customer_id = ba.ba_customer_no
                        and iadl.ba_account_no = ba.ba_account_no
                        and cb.ban= ba.ba_account_no
                        and id.invrpt_dest_code = iadl.invrpt_dest_code
                        and ba.ba_status in ('N', 'O')
                        and (ba.last_cycle_seq_no is NULL
                             and ba.sys_creation_date < to_date(substr(lpad(bc.new_cycle,4,'0'),3,2)||lpad('$$cycle_run_month',2,'0')||'$$cycle_run_year', 'DDMMYYYY'))
                        and new_cycle is not NULL
                        and new_cycle > old_cycle_code
                        and bc.new_cycle = cc.cycle_code
                        and cc.cycle_year =$$cycle_run_year
                        and cc.cycle_instance =$$cycle_run_month
                        and (nvl(iadl.eff_date,to_date(01012000,'DDMMYYYY')) < to_date(substr(lpad(bc.cycle_code,4,'0'),3,2)||lpad('$$cycle_run_month',2,'0')||'$$cycle_run_year', 'DDMMYYYY') and
                               nvl(iadl.exp_date,to_date(31122045,'DDMMYYYY')) > to_date(substr(lpad(bc.cycle_code,4,'0'),3,2)||lpad('$$cycle_run_month',2,'0')||'$$cycle_run_year', 'DDMMYYYY'))
                        and bc.customer_id = ba.ba_customer_no
                        and (nvl(id.eff_date,to_date(01012000,'DDMMYYYY')) < to_date(substr(lpad(bc.cycle_code,4,'0'),3,2)||lpad('$$cycle_run_month',2,'0')||'$$cycle_run_year', 'DDMMYYYY')
                        and nvl(id.exp_date,to_date(31122045,'DDMMYYYY')) > to_date(substr(lpad(cc.cycle_code,4,'0'),3,2)||lpad('$$cycle_run_month',2,'0')||'$$cycle_run_year', 'DDMMYYYY'))),
mabel_id_list AS (select $hint bd.account_no, mi.description, bd.printing_category, cc.cycle_code, mi.consolidator, mi.consolidation_period,
                              cpp.cycle_seq_no, cpp.period_key, bd.ba_no,ba.ba_status, cb.l3_bill_format, md.xmission_media_type, bc.hold_ind,mi.MABEL_BILL_FORMAT,
                              nvl(md.effective_date,nvl(md.sys_update_date,md.sys_creation_date)) as mabel_eff_date, mi.mabel_id, bd.customer_no,
                              ba.creation_date,ba.ba_status_date,nvl(bd.doc_seq_no,0) doc_seq_no,nvl(bd.production_type,'NA') production_type,nvl(bd.bill_date,to_date('01-JAN-1900','DD-MON-YYYY'))bill_date,nvl(bd.period_cvrg_start_date,to_date('01-JAN-1900','DD-MON-YYYY')) period_cvrg_start_date,nvl(bd.period_cvrg_end_date,to_date('01-JAN-1900','DD-MON-YYYY')) period_cvrg_end_date
                        from bl1_document bd,
                             add9_mabel_ids mi,
                             bl1_cycle_control cc,
                             bl1_cyc_payer_pop cpp,
                             bl1_blng_arrangement ba,
                             csm_ben cb,
                             mabel_destination md,
                             bl1_customer bc
                        where mi.mabel_id = bd.printing_category
                          and md.consolidator = mi.consolidator
                          and md.xmission_media_type <> 'HELD'
                          and cb.ban= ba.ba_account_no
                          and bd.period_key = cc.period_key
                          and bd.cycle_seq_no = cc.cycle_seq_no
                          and bd.doc_produce_ind = 'Y'
                          and cpp.ba_no = bd.ba_no
                          and cpp.period_key = bd.period_key
                          and cpp.cycle_seq_no = bd.cycle_seq_no
                          and cpp.customer_key = bd.customer_key
                          and (bd.period_key, bd.cycle_seq_no) in (select period_key, cycle_seq_no
                                                                     from bl1_cycle_control
                                                                     where cycle_instance = $$cycle_run_month
                                                                       and cycle_year =$$cycle_run_year
                                                                       and cycle_code = cc.cycle_code)
                          and ba.ba_no = cpp.ba_no
                          and bc.customer_id = ba.ba_customer_no
                       union
                       select ba.ba_account_no, mi.description, ba.perm_printing_cat, bc.cycle_code, mi.consolidator, mi.consolidation_period,
                              cc.cycle_seq_no,cc.period_key, ba.ba_no, ba.ba_status, cb.l3_bill_format, md.xmission_media_type, bc.hold_ind, mi.MABEL_BILL_FORMAT,
                              nvl(md.effective_date,nvl(md.sys_update_date,md.sys_creation_date)) as mabel_eff_date, mi.mabel_id, ba.ba_customer_no,
                              ba.creation_date,ba.ba_status_date,0,'NA',to_date('01-JAN-1900','DD-MON-YYYY'),to_date('01-JAN-1900','DD-MON-YYYY'),to_date('01-JAN-1900','DD-MON-YYYY')
                       from csm_ben cb,
                            bl1_blng_arrangement ba,
                            bl1_customer bc,
                            add9_mabel_ids mi,
                            bl1_cycle_control cc,
                            mabel_destination md
                       where 1=1
                         --and cb.l3_bill_format in ('Paper-Mabel', 'Mabel','Paper-Mabel-wPg-Brk')
                         and bc.customer_id = ba.ba_customer_no
                         and cb.ban= ba.ba_account_no
                         and ba.perm_printing_cat = mi.mabel_id
                         and mi.consolidator = md.consolidator
                         and md.xmission_media_type <> 'HELD'
                         and ba.ba_status in ('N', 'O')
                         AND (ba.last_cycle_seq_no IN (SELECT cc.cycle_seq_no FROM bl1_cycle_control cc
                                     WHERE cc.cycle_year || LPAD(cc.cycle_instance,2,'0') <=
                                             TO_CHAR(ADD_MONTHS(TO_DATE(LPAD('$$cycle_run_month',2,'0')||'$$cycle_run_year','MMYYYY'),-1), 'YYYY') ||
                                             TO_CHAR(ADD_MONTHS(TO_DATE(LPAD('$$cycle_run_month',2,'0'), 'MM'), -1), 'MM')) OR ba.last_cycle_seq_no IS NULL)
                         and cc.cycle_code = bc.cycle_code
                         and cc.cycle_instance = $$cycle_run_month
                         and cc.cycle_year = $$cycle_run_year
                         and bc.customer_id = ba.ba_customer_no
                       union
                       select ba.ba_account_no, mi.description, ba.perm_printing_cat, bc.new_cycle, mi.consolidator, mi.consolidation_period,
                              cc.cycle_seq_no,cc.period_key,ba.ba_no, ba.ba_status, cb.l3_bill_format, md.xmission_media_type, bc.hold_ind, mi.MABEL_BILL_FORMAT,
                              nvl(md.effective_date,nvl(md.sys_update_date,md.sys_creation_date)) as mabel_eff_date, mi.mabel_id, ba.ba_customer_no,
                              ba.creation_date,ba.ba_status_date,0,'NA',to_date('01-JAN-1900','DD-MON-YYYY'),to_date('01-JAN-1900','DD-MON-YYYY'),to_date('01-JAN-1900','DD-MON-YYYY')
                       from csm_ben cb,
                            bl1_customer bc,
                            bl1_blng_arrangement ba,
                            add9_mabel_ids mi,
                            bl1_cycle_control cc,
                            mabel_destination md
                      where 1=1
                        --and l3_bill_format in ('Paper-Mabel', 'Mabel','Paper-Mabel-wPg-Brk')
                        and cb.ban = ba.ba_account_no
                        and bc.customer_id = ba.ba_customer_no
                        and ba.perm_printing_cat = mi.mabel_id
                        and mi.consolidator = md.consolidator
                        and md.xmission_media_type <> 'HELD'
                        and ba.ba_status in ('N', 'O')
                        and (ba.last_cycle_seq_no is NULL
                             and ba.sys_creation_date < to_date(substr(lpad(bc.new_cycle,4,'0'),3,2)||lpad('$$cycle_run_month',2,'0')||'$$cycle_run_year', 'DDMMYYYY'))
                        and new_cycle is not NULL
                        and new_cycle > old_cycle_code
                        and bc.new_cycle = cc.cycle_code
                        and cc.cycle_year =$$cycle_run_year
                        and cc.cycle_instance =$$cycle_run_month
                        and bc.customer_id = ba.ba_customer_no)
select mil.account_no, mil.description, mil.cycle_code, mil.cycle_seq_no, mil.l3_bill_format,
        decode(mil.xmission_media_type,'MBLS','MobilSense and Invoice Report', 'EFLE', 'MABEL and Invoice Report', 'BOTH', 'MABEL, MobilSense, and Invoice Report', 'ERROR') as media,
        decode(mil.MABEL_BILL_FORMAT,300,' 3.0',200,' 2.0') as MABEL_VERSION,
        mil.consolidator as MABEL_CONSOLIDATOR,
        il.invrpt_dest_code as INVRPT_DESTINATION,
        DECODE(cpp.status,'PC','PAYER-CHARGED','NP','NOT-PROCESSED','UN','UNIFIED-CHARGED',
                          'IN','INVOICED','BL','BILLED', 'SC','SEMI_CONFIRMED',
                          'CN','CONFIRMED','DC','BOD_CONFIRMED','ZZ') AS TOPS_STATUS,
       nvl(cpp.reject_ind,'N')as REJECT_IND,
       nvl(to_char(bi.total_invoice_amt),'NA') as TOTAL_INVOICE_AMT,
       nvl(to_char(bbs.prev_balance_amt),'NA') as PREV_BALANCE_AMT,
       nvl(TO_CHAR(bbs.total_amt_due),'NA') as TOTAL_AMT_DUE,
       decode(mil.ba_status,'O', 'OPEN', 'N', 'CANCELLED', 'C', 'CLOSED', 'T', 'TENATIVE', 'OTHER') AS ACCOUNT_STATUS,
       nvl(mil.hold_ind,'N') as hold_ind,
       decode(nvl(mil.consolidation_period,'NA'), 'EOM', 'MONTH-END', 'EOC', 'BILL-DAY','NA', 'NA','ERROR') as MABEL_PERIOD,
       decode(nvl(il.bill_method_ind,'NA'),'M','MONTH-END', 'B','BILL-DAY','NA','NA','ERROR') as INVRPT_PERIOD,
       mil.ba_no,
       mil.customer_no,
       decode(nvl(cpp3.status,'EMPTY'), 'NP', 'NOT-PROCESSED', 'DS', 'DOC-DESIGNER-SUCCESS', 'DR', 'DOC-DESIGNER-WITH-REJ', 'EMPTY', 'NO CPP3 ROW','OTHER') as amdd_status,
       nvl(cpp3.reject_ind,'N') as amdd_rj_ind,
       nvl(cpp3.error_code,0) as amdd_error_cd,
       to_char(mil.mabel_eff_date, 'DD-MON-YY') as MABEL_EFF_DATE,
       to_char(il.invrpt_eff_date, 'DD-MON-YY') as INVRPT_DATE,
       decode(irr.report_sent,'Y','SENT', 'NOT PROCESSED') as REPORT_STATUS,
       decode(ira.account_number,NULL,'NO-XML','XML-LOADED') as XML_STATUS,
       decode(il.doc_produce_ind, 'N', 'NO-DOCUMENT', 'DOCUMENT') as DOC_STATUS,
       mil.mabel_id as MABEL_ID,
       mil.xmission_media_type,
       nvl(to_char(ira.ods_last_update_date,'DD-MON-YY'),'NA') as XML_DATE,
       nvl(to_char(irr.ods_last_update_date,'DD-MON-YY'),'NA') as SENT_DATE,
       nvl(to_char(cpp.format_ext_group),'NA') FORMAT_EXT_GROUP,
       mil.creation_date,nvl(to_char(cpp.format_ext_date),'NA') FORMAT_EXT_DATE,nvl(to_char(cpp.DB_STATUS_DATE),'NA') DB_STATUS_DATE,nvl(to_char(irr.ODS_INSERT_DATE),'NA') as INV_REPORT_CREATION_DATE,il.ba_status_date,il.doc_seq_no,decode(nvl(il.production_type,'EMPTY'), 'EMPTY','BILL-NOT-GENERATED', 'DR','BILL-DROPPED','FN','FINAL-BILL','FR','FIRST-BILL','RF','REVISED-FINAL-BILL','RG','REGULAR-BILL','OTHER') PRODUCTION_TYPE,il.bill_date,il.period_cvrg_start_date,il.period_cvrg_end_date,bgn.x_ban_group_name,bgi.x_ban_group_id
from invrpt_list il,
     mabel_id_list mil,
     bl1_cyc_payer_pop cpp,
     bl1_bill_statement bbs,
     bl1_invoice bi,
     bl3_cyc_payer_pop cpp3,
     inv_rpt_rule irr,
     inv_rpt_account ira,
     table_x_ban_group_name bgn,
     table_x_ban_group_id bgi,
     table_customer tc
where mil.account_no = il.ba_account_no
  and bgi.x_group_id2group_name = bgn.objid(+)
  and tc.x_customer2ban_group_id = bgi.objid(+)
  and mil.customer_no = tc.customer_id(+)
  and mil.cycle_seq_no = il.cycle_seq_no
  and il.doc_produce_ind <> 'N'
  and mil.period_key = cpp.period_key(+)
  and mil.cycle_seq_no = cpp.cycle_seq_no(+)
  and mil.ba_no = cpp.ba_no(+)
  and cpp.cycle_seq_no = bbs.cycle_seq_no(+)
  and cpp.period_key = bbs.period_key(+)
  and cpp.ba_no = bbs.ba_no(+)
  and cpp.ba_no = bi.ba_no(+)
  and cpp.period_key = bi.period_key(+)
  and cpp.cycle_seq_no = bi.cycle_seq_no(+)
  and cpp.ba_no = cpp3.ba_no(+)
  and cpp.cycle_seq_no = cpp3.cyc_seq_no(+)
  and cpp.period_key = cpp3.period_key(+)
  and cpp.customer_key = cpp3.customer_key(+)
  and cpp3.run_mode(+) = 'PR'
  and il.ba_account_no = irr.account_number(+)
  and il.cycle_seq_no = irr.bill_seq_number(+)
  and il.cycle_code = irr.cycle_code(+)
  and il.ba_account_no = ira.account_number(+)
  and il.cycle_seq_no = ira.bill_seq_number(+)
union select il.ba_account_no, il.dest_name, il.cycle_code, il.cycle_seq_no, il.l3_bill_format,'Invoice Report',
       'NA' as MABEL_VERSION,
       'NA' as MABEL_CONSOLIDATOR, il.invrpt_dest_code,
       DECODE(cpp.status,'PC','PAYER-CHARGED','NP','NOT-PROCESSED','UN','UNIFIED-CHARGED',
                          'IN','INVOICED','BL','BILLED', 'SC','SEMI_CONFIRMED',
                          'CN','CONFIRMED','DC','BOD_CONFIRMED','ZZ') AS TOPS_STATUS,
       nvl(cpp.reject_ind,'N')as REJECT_IND,
       nvl(to_char(bi.total_invoice_amt),'NA') as TOTAL_INVOICE_AMT,
       nvl(to_char(bbs.prev_balance_amt),'NA') as PREV_BALANCE_AMT,
       nvl(TO_CHAR(bbs.total_amt_due),'NA') as TOTAL_AMT_DUE,
       decode(il.ba_status,'O', 'OPEN', 'N', 'CANCELLED', 'C', 'CLOSED', 'T', 'TENATIVE', 'OTHER') AS ACCOUNT_STATUS,
       nvl(il.hold_ind,'N') as hold_ind,
       'NA' as MABEL_PERIOD,
       decode(nvl(il.bill_method_ind,'NA'),'M','MONTH-END', 'B','BILL-DAY','NA','NA','ERROR') as INVRPT_PERIOD,
       il.ba_no,
       il.customer_no,
       decode(nvl(cpp3.status,'EMPTY'), 'NP', 'NOT-PROCESSED', 'DS', 'DOC-DESIGNER-SUCCESS', 'DR', 'DOC-DESIGNER-WITH-REJ', 'EMPTY', 'NO CPP3 ROW','OTHER') as amdd_status,
       nvl(cpp3.reject_ind,'N') as amdd_rj_ind,
       nvl(cpp3.error_code,0) as amdd_error_cd,
       'NA' as mabel_eff_date,
       to_char(il.invrpt_eff_date, 'DD-MON-YY') as invrpt_eff_date,
       decode(irr.report_sent,'Y','SENT', 'NOT PROCESSED') as REPORT_STATUS,
       decode(ira.account_number,NULL,'NO-XML','XML-LOADED') as XML_STATUS,
       decode(il.doc_produce_ind, 'N', 'NO-DOCUMENT', 'DOCUMENT') as DOC_STATUS,
       'NA' as MABEL_ID,
       'HELD' as xmission_media_type,
       nvl(to_char(ira.ods_last_update_date,'DD-MON-YY'),'NA') as XML_DATE,
       nvl(to_char(irr.ods_last_update_date,'DD-MON-YY'),'NA') as SENT_DATE,
       nvl(to_char(cpp.format_ext_group),'NA'),
       il.creation_date,nvl(to_char(cpp.format_ext_date),'NA'),nvl(to_char(cpp.DB_STATUS_DATE),'NA'),nvl(to_char(irr.ODS_INSERT_DATE),'NA') as INV_REPORT_CREATION_DATE,il.ba_status_date,il.doc_seq_no,decode(nvl(il.production_type,'EMPTY'), 'EMPTY','BILL-NOT-GENERATED', 'DR','BILL-DROPPED','FN','FINAL-BILL','FR','FIRST-BILL','RF','REVISED-FINAL-BILL','RG','REGULAR-BILL','OTHER') PRODUCTION_TYPE,il.bill_date,il.period_cvrg_start_date,il.period_cvrg_end_date,bgn.x_ban_group_name,bgi.x_ban_group_id
from invrpt_list il,
     bl1_cyc_payer_pop cpp,
     bl1_bill_statement bbs,
     bl1_invoice bi,
     bl3_cyc_payer_pop cpp3,
     inv_rpt_rule irr,
     inv_rpt_account ira,
     table_x_ban_group_name bgn,
     table_x_ban_group_id bgi,
     table_customer tc
where (il.ba_account_no, il.cycle_seq_no) in (select il.ba_account_no, il.cycle_seq_no
                                               from invrpt_list il
                                               where il.doc_produce_ind <> 'N'
                                               minus
                                               select mil.account_no, mil.cycle_seq_no
                                               from mabel_id_list mil)
  and bgi.x_group_id2group_name = bgn.objid(+)
  and tc.x_customer2ban_group_id = bgi.objid(+)
  and il.customer_no = tc.customer_id(+)
  and il.period_key = cpp.period_key(+)
  and il.cycle_seq_no = cpp.cycle_seq_no(+)
  and il.ba_no = cpp.ba_no(+)
  and cpp.cycle_seq_no = bbs.cycle_seq_no(+)
  and cpp.period_key = bbs.period_key(+)
  and cpp.ba_no = bbs.ba_no(+)
  and cpp.ba_no = bi.ba_no(+)
  and cpp.period_key = bi.period_key(+)
  and cpp.cycle_seq_no = bi.cycle_seq_no(+)
  and cpp.ba_no = cpp3.ba_no(+)
  and cpp.cycle_seq_no = cpp3.cyc_seq_no(+)
  and cpp.period_key = cpp3.period_key(+)
  and cpp.customer_key = cpp3.customer_key(+)
  and cpp3.run_mode(+) = 'PR'
  and il.ba_account_no = irr.account_number(+)
  and il.cycle_seq_no = irr.bill_seq_number(+)
  and il.cycle_code = irr.cycle_code(+)
  and il.ba_account_no = ira.account_number(+)
  and il.cycle_seq_no = ira.bill_seq_number(+)
union select mil.account_no, mil.description, mil.cycle_code, mil.cycle_seq_no, mil.l3_bill_format,
       decode(mil.xmission_media_type,'MBLS','MobilSense', 'EFLE', 'MABEL', 'BOTH', 'MABEL and MobilSense', 'ERROR'),
       decode(mil.MABEL_BILL_FORMAT,300,' 3.0',200,' 2.0') as MABEL_VERSION,
       mil.consolidator,
       'NA' as INVRPT_DEST_CODE,
       DECODE(cpp.status,'PC','PAYER-CHARGED','NP','NOT-PROCESSED','UN','UNIFIED-CHARGED',
                          'IN','INVOICED','BL','BILLED', 'SC','SEMI_CONFIRMED',
                          'CN','CONFIRMED','DC','BOD_CONFIRMED','ZZ') AS TOPS_STATUS,
       nvl(cpp.reject_ind,'N')as REJECT_IND,
       nvl(to_char(bi.total_invoice_amt),'NA') as TOTAL_INVOICE_AMT,
       nvl(to_char(bbs.prev_balance_amt),'NA') as PREV_BALANCE_AMT,
       nvl(TO_CHAR(bbs.total_amt_due),'NA') as TOTAL_AMT_DUE,
       decode(mil.ba_status,'O', 'OPEN', 'N', 'CANCELLED', 'C', 'CLOSED', 'T', 'TENATIVE', 'OTHER') AS ACCOUNT_STATUS,
       nvl(mil.hold_ind,'N') as hold_ind,
       decode(nvl(mil.consolidation_period,'NA'), 'EOM', 'MONTH-END', 'EOC', 'BILL-DAY','NA', 'NA','ERROR') as MABEL_PERIOD,
       'NA' as INVRPT_PERIOD,
       mil.ba_no,
       mil.customer_no,
       decode(nvl(cpp3.status,'EMPTY'), 'NP', 'NOT-PROCESSED', 'DS', 'DOC-DESIGNER-SUCCESS', 'DR', 'DOC-DESIGNER-WITH-REJ', 'EMPTY', 'NO CPP3 ROW','OTHER') as amdd_status,
       nvl(cpp3.reject_ind,'N') as amdd_rj_ind,
       nvl(cpp3.error_code,0) as amdd_error_cd,
       to_char(mil.mabel_eff_date,'DD-MON-YY') as MABEL_EFF_DATE,
       'NA' as INVRPT_EFF_DATE,
       'NA','NA', 'NA',mil.mabel_id,
       mil.xmission_media_type,
       'NA', 'NA',
       nvl(to_char(cpp.format_ext_group),'NA'),
       mil.creation_date,nvl(to_char(cpp.format_ext_date),'NA'),nvl(to_char(cpp.DB_STATUS_DATE),'NA'),nvl(to_char(to_date('01-JAN-1900','DD-MON-YYYY')),'NA'),mil.ba_status_date,mil.doc_seq_no,decode(nvl(mil.production_type,'EMPTY'), 'EMPTY','BILL-NOT-GENERATED', 'DR','BILL-DROPPED','FN','FINAL-BILL','FR','FIRST-BILL','RF','REVISED-FINAL-BILL','RG','REGULAR-BILL','OTHER') PRODUCTION_TYPE,mil.bill_date,mil.period_cvrg_start_date,mil.period_cvrg_end_date,
bgn.x_ban_group_name,bgi.x_ban_group_id
from mabel_id_list mil,
     bl1_cyc_payer_pop cpp,
     bl1_bill_statement bbs,
     bl1_invoice bi,
     bl3_cyc_payer_pop cpp3,
     table_x_ban_group_name bgn,
     table_x_ban_group_id bgi,
     table_customer tc
where (mil.account_no, mil.cycle_seq_no) in (select mil.account_no, mil.cycle_seq_no
                                              from mabel_id_list mil
                                              minus
                                              select il.ba_account_no, il.cycle_seq_no
                                              from invrpt_list il
                                              where il.doc_produce_ind <> 'N')
  and bgi.x_group_id2group_name = bgn.objid(+)    
  and tc.x_customer2ban_group_id = bgi.objid(+)
  and mil.customer_no = tc.customer_id(+)
  and mil.period_key = cpp.period_key(+)
  and mil.cycle_seq_no = cpp.cycle_seq_no(+)
  and mil.ba_no = cpp.ba_no(+)
  and cpp.cycle_seq_no = bbs.cycle_seq_no(+)
  and cpp.period_key = bbs.period_key(+)
  and cpp.customer_key = bbs.customer_key(+)
  and cpp.ba_no = bbs.ba_no(+)
  and cpp.ba_no = bi.ba_no(+)
  and cpp.period_key = bi.period_key(+)
  and cpp.cycle_seq_no = bi.cycle_seq_no(+)
  and cpp.customer_key = bi.customer_key(+)
  and cpp.ba_no = cpp3.ba_no(+)
  and cpp.cycle_seq_no = cpp3.cyc_seq_no(+)
  and cpp.period_key = cpp3.period_key(+)
  and cpp.customer_key = cpp3.customer_key(+)
  and cpp3.run_mode(+) = 'PR'
order by 5,2
)
) WHERE RANK = 1
/;


  my $stmt_hd2 = $dbh_ODS->prepare($documentStmnt) or die $dbh_ODS->errstr();

  my $t0 = Benchmark->new;
  $stmt_hd2->execute() or die $stmt_hd2->errstr();
  my $t1 = Benchmark->new;
  my $td = timediff($t1, $t0);
  print F "the driving query execute code took:",timestr($td),"\n";

  print "Account No\tBA_NO\tCustomer_no\tAccount_Status\tTops Create Date\tDestination Name\tcycle_code\tcycle_month\tCycle_Seq_No\t".
        "Format Ext Group\tMedia\tbill format\tInvrpt_Dest\tINVRPT_Period\t" .
        "INVRPT EFF Date\tINVRPT Status\tStaged to Send Date\tXML Status\tXML Date\tDoc Status\t".
        "MABEL ID\tMABEL_CONSCD\tMABEL_PERIOD\tMABEL Version\tMABEL Eff Date\tMABEL Status\t" .
        "MABEL Date\tTops Status\tTops Reject Ind\tAMDD Status\tAMDD RJ IND\t" .
        "HLDTBL Defects\tHLDPRD Defects\tErrors\tAMDD ERR\tTotal_Invoice_Amt\tPrev_Balance_Amt\tTotal_Amt_Due\tHold_IND\t".
                "FORMAT EXT DATE\tBILL_FORMAT\tTOPS LAST STATUS DATE\tIRR CREATE DATE\tBA_STATUS_DATE\tDOC_SEQ_NO\tPRODUCTION_TYPE\t".
                "BILL_DATE\tPERIOD_CVRG_START_DATE\tPERIOD_CVRG_END_DATE\tBILL_ARCHIVE_IND\tACC_MABEL_FILE\tMBL_ORG_FNAME\tMBL_SENT_FNAME\tBAN_GROUP_NAME\tBAN_GROUP_ID\tCYCLE_RUN_YEAR\n";




cleanupReportTable();

#get the max sequence number to insert into the table
  my $maxSeqQuery = qq/ SELECT nvl(max(sequence_number),1) FROM CNSLDTD_RPT_TBL /;
  my $maxSeqdbh = $dbh_TOPS->prepare($maxSeqQuery) or die $dbh_TOPS->errstr();
     $maxSeqdbh->execute() or die $maxSeqdbh->errstr();
  my @maxSeqArray = $maxSeqdbh->fetchrow_array();
  my $seqNumber=++$maxSeqArray[0];

my ($account_no,$destName,$cycle_code,$cycSeqNo,$billFormat,$MediaType,$mblVersion,$mabelCon,$invrptDest,$cppStatus,$cppRejectInd,
$totInvAmt,$prvBalAmt,$totAmtDue,$acctStat,$holdStatus,$mabelPeriod,$invrptPeriod,$ba_no,$customer_no,$amddStatus,$amddRJInd,
$amddERRCd,$mblEffDate,$invrptEffDate,$rptStatus,$XMLStatus,$docStatus,$MABEL_ID,$xMediaType,$XMLDate,$sentDate,$formatExtGroup,
$topsCreationDate,$formatExtDate,$cppDBStatusDate,$irrODSInsertDate,$ba_status_date,$doc_seq_no,$production_type, $bill_date,
$period_cvrg_start_date,$period_cvrg_end_date,$ban_group_name,$ban_group_id);

  $stmt_hd2->bind_columns(\$account_no,\$destName,\$cycle_code,\$cycSeqNo,\$billFormat,\$MediaType,\$mblVersion,\$mabelCon,\$invrptDest,\$cppStatus,\$cppRejectInd,\$totInvAmt,\$prvBalAmt,
  \$totAmtDue,\$acctStat,\$holdStatus,\$mabelPeriod,\$invrptPeriod,\$ba_no,\$customer_no,\$amddStatus,\$amddRJInd,\$amddERRCd,\$mblEffDate,\$invrptEffDate,\$rptStatus,\$XMLStatus,
  \$docStatus,\$MABEL_ID,\$xMediaType,\$XMLDate,\$sentDate,\$formatExtGroup,\$topsCreationDate,\$formatExtDate,\$cppDBStatusDate,\$irrODSInsertDate,\$ba_status_date,\$doc_seq_no,
  \$production_type,\$bill_date,\$period_cvrg_start_date,\$period_cvrg_end_date,\$ban_group_name,\$ban_group_id);

  $t0 = Benchmark->new;
  while ($stmt_hd2->fetchrow_arrayref)
    {
#Initialization of field not in the driving query.
           $rejectMsg=" ";
           $defectMsg="\t"; #This needs a tab because the defect message being returned has tab in it to put it into seperate columns.
           my ($acc_mabel_file1,$fileCreateDate,$file_status);
#reinitialize these variables as undefined to remove the preceding values from the last result processed.
           $mblStatus=" ";
           $mblDate=" ";
           $acc_mabel_file=" ";
           $mbl_org_fname=" ";
           $mbl_sent_fname=" ";

        if ($mabelCon ne 'NA')
          {
#this customer gets some sort of MABEL deal with it 
            #handle reseller cycles codes
            if ( $cycle_code > 1000 ) {
              $auditCycle = $cycle_code - 1000;
            } else {
              $auditCycle = $cycle_code;
            }

            my ($file_status,$fileCreateDate,$acc_mabel_file1);
            if (exists $MCHoHoHoH{$account_no}{$cycle_code}{$mabelCon}) {
               $acc_mabel_file1=$MCHoHoHoH{$account_no}{$cycle_code}{$mabelCon}{'file_name'};
               $fileCreateDate=$MCHoHoHoH{$account_no}{$cycle_code}{$mabelCon}{'file_create_date'};
               $file_status=$MCHoHoHoH{$account_no}{$cycle_code}{$mabelCon}{'file_status'};
            } else {
               #print F "Couldn't find MABEL CONTROL data on the HoHoHoH for $account_no, $cycle_code, $$cycle_run_month, $$cycle_run_year, $mabelCon, $MABEL_ID\n";
               ($acc_mabel_file1,$fileCreateDate,$file_status)=();
            }
            $acc_mabel_file=$acc_mabel_file1;

            if (defined($file_status)) # row found in mabel_control
                        {
                  if (exists $MAHoHoHoH{$account_no}{$auditCycle}{$mabelCon}) {
                     $mbl_org_fname=$MAHoHoHoH{$account_no}{$auditCycle}{$mabelCon}{'orig_file_name'};
                     $mbl_sent_fname=$MAHoHoHoH{$account_no}{$auditCycle}{$mabelCon}{'sent_file_name'};
                     $mblDate=$MAHoHoHoH{$account_no}{$auditCycle}{$mabelCon}{'sent_date'};
                  } else {
                     #print F "Couldn't find MABEL AUDIT data1 on the HoHoHoH for $account_no, $auditCycle, $$cycle_run_month, $$cycle_run_year, $mabelCon, $MABEL_ID $acc_mabel_file\n";
                     ($mbl_org_fname,$mbl_sent_fname,$mblDate)=();
                  }

                  if (defined($mblDate)) # row found in mabel_audit
                                  {
                                    $mblStatus = " MABEL Processed ";
                                  }
                  else
                  {
                    # did not find a MABEL_AUDIT file not finished processing yet
                    # add logic later to see if it is on MABEL_ERROR

                    $mblStatus = " CON File not Sent $file_status";
                    $mblDate = $fileCreateDate;


                    # check to see if this customer has defects that's causing a row to be missing on MABEL_CONTROL
                    $defectMsg = callHldTbl($account_no);
                    if ($cppRejectInd eq 'Y')
                       {
                         $rejectMsg = callCycErr(\$account_no,$cycle_run_month,$cycle_run_year);
                       }
                  }
              }
            else # did not find a row on MABEL_CONTROL
              {
                  if (exists $MAHoHoHoH{$account_no}{$auditCycle}{$mabelCon}) {
					$mbl_org_fname=$MAHoHoHoH{$account_no}{$auditCycle}{$mabelCon}{'orig_file_name'};
                    $mbl_sent_fname=$MAHoHoHoH{$account_no}{$auditCycle}{$mabelCon}{'sent_file_name'};
                    $mblDate=$MAHoHoHoH{$account_no}{$auditCycle}{$mabelCon}{'sent_date'};
                  } else {
                    #print F "Couldn't find MABEL AUDIT data2 on the HoHoHoH for $account_no, $auditCycle, $$cycle_run_month, $$cycle_run_year, $mabelCon, $MABEL_ID\n";
                    ($mbl_org_fname,$mbl_sent_fname,$mblDate)=();
                  }

                  if (defined($mblDate)) { # row found in mabel_audit
					$mblStatus = " Should not be on MABEL AUDIT";
                  } else {
                  # No row found on MABEL AUDIT this is good
                    $mblStatus = "Missing MABEL file";
                  # check to see if this customer has defects that's causing a row to be missing on MABEL_CONTROL
                    $defectMsg = callHldTbl($account_no);
                    if ($cppRejectInd eq 'Y')
                       {
                         $rejectMsg = callCycErr(\$account_no,$cycle_run_month,$cycle_run_year);
                       }
                  }
              }
       } #end of dealing with MABEL customers
     else #must be a Invoice Report Only Customer
       {
       $defectMsg = callHldTbl($account_no);
       if ($cppRejectInd eq 'Y')
         {
            $rejectMsg = callCycErr(\$account_no,$cycle_run_month,$cycle_run_year);
         }
       }

       my $bill_archive_ind;
           if (defined($doc_seq_no)) {
           #This value is not currently being using by the recipients of the report. 
           #Hardcoding the value to "NA" as this is a very expensive lookup. 
           #If this data is needed, it should be rolled into the driving query. 
           #See allCNSLDTDRPT.pl_bill_arch_ind for a potential solution.
           #$bill_archive_ind = callBILLARCH($doc_seq_no);
           #$bill_archive_ind="NA";
           }

       print "$account_no\t";
       print "$ba_no\t";
       print "$customer_no\t";
       print "$acctStat\t";
       print "$topsCreationDate\t";
       print "$destName\t";
       print "$cycle_code\t";
       print "$$cycle_run_month\t";
       print "$cycSeqNo\t";
       print "$formatExtGroup\t";
       print "$MediaType\t";
       print "$billFormat\t";
       print "$invrptDest\t";
       print "$invrptPeriod\t";
       print "$invrptEffDate\t";
       print "$rptStatus\t";
       print "$sentDate\t";
       print "$XMLStatus\t";
       print "$XMLDate\t";
       print "$docStatus\t";
       print "$MABEL_ID\t";
       print "$mabelCon\t";
       print "$mabelPeriod\t";
       print "$mblVersion\t";
       print "$mblEffDate\t";
       print "$mblStatus\t";
           if ( !defined($mblDate))
           {
             $mblDate = "NA";
           }
       print "$mblDate\t";
       print "$cppStatus\t";
       print "$cppRejectInd\t";
       print "$amddStatus\t";
       print "$amddRJInd\t";
       print "$defectMsg\t";
       print "$rejectMsg\t";
       print "$amddERRCd\t";
       print "$totInvAmt\t";
       print "$prvBalAmt\t";
       print "$totAmtDue\t";
       print "$holdStatus\t";
# below the new filed added in the report
       print "$formatExtDate\t";
       print "$billFormat\t";
       print "$cppDBStatusDate\t";
       print "$irrODSInsertDate\t";
       print "$ba_status_date\t";
       if ( !defined($doc_seq_no))
           {
             $doc_seq_no="NA";
           }
       print "$doc_seq_no\t";
       print "$production_type\t";
       if ( !defined($bill_date))
           {
             $bill_date="NA";
           }
       print "$bill_date\t";
       if ( !defined($period_cvrg_start_date))
           {
             $period_cvrg_start_date="NA";
           }
       print "$period_cvrg_start_date\t";
       if ( !defined($period_cvrg_end_date))
           {
             $period_cvrg_end_date="NA";
           }
       print "$period_cvrg_end_date\t";
       if ( !defined($bill_archive_ind))
           {
             $bill_archive_ind="NA";
           }
       print "$bill_archive_ind\t";
       if ( !defined($acc_mabel_file))
           {
             $acc_mabel_file = "NA";
           }
       print "$acc_mabel_file\t";
       if ( !defined($mbl_org_fname))
           {
             $mbl_org_fname = "NA";
           }
       print "$mbl_org_fname\t";
       if ( !defined($mbl_sent_fname))
           {
             $mbl_sent_fname = "NA";
           }
       print "$mbl_sent_fname\t";
       if ( !defined($ban_group_name))
           {
             $ban_group_name="NA";
           }
       print "$ban_group_name\t";
       if ( !defined($ban_group_id))
           {
             $ban_group_id="NA";
           }
       print "$ban_group_id\t";
       print "$$cycle_run_year\n";

      $defectMsg=substr($defectMsg,0,254);
      my $quotedString = $dbh_TOPS->quote( $destName );
      my $insertCnsldtdRpttable = qq/
         INSERT INTO CNSLDTD_RPT_TBL VALUES (
          '$account_no',
          '$ba_no',
          '$customer_no',
          '$acctStat',
          $quotedString,
          '$cycle_code',
          $$cycle_run_month,
          '$cycSeqNo',
          '$MediaType',
          '$invrptDest',
          '$invrptPeriod',
          '$invrptEffDate',
          '$rptStatus',
          '$XMLStatus',
          '$docStatus',
          '$MABEL_ID',
          '$mabelCon',
          '$mabelPeriod',
          '$mblVersion',
          '$mblEffDate',
          '$mblStatus',
          '$mblDate',
          '$cppStatus',
          '$cppRejectInd',
          '$amddStatus',
          '$amddRJInd',
          '$defectMsg',
          '$rejectMsg',
          '$amddERRCd',
          '$totInvAmt',
          '$prvBalAmt',
          '$totAmtDue',
          '$holdStatus',
          SYSDATE,
          $seqNumber,
          '$XMLDate',
          '$sentDate',
          '$formatExtGroup',
          '$topsCreationDate',
          USCCUST.CNSLDTD_RPT_SEQ.nextval,
                    '$formatExtDate',
                    '$billFormat',
                        '$cppDBStatusDate',
                        '$irrODSInsertDate',
                        '$ba_status_date',
                        '$doc_seq_no',
                        '$production_type',
                        '$bill_date',
                        '$period_cvrg_start_date',
                '$period_cvrg_end_date',
                        '$bill_archive_ind',
                '$acc_mabel_file',
                '$mbl_org_fname',
                '$mbl_sent_fname',
                '$$cycle_run_year'
          )
         /;


      my $stmt_hd3 = $dbh_TOPS->prepare($insertCnsldtdRpttable) or die $dbh_TOPS->errstr();
      $stmt_hd3->execute() or die $stmt_hd3->errstr();

    } #end while loop
  $t1 = Benchmark->new;
  $td = timediff($t1, $t0);
  print F "the driving query fetchrow_arrayref code took:",timestr($td),"\n";
} #end checkMonthFileExists



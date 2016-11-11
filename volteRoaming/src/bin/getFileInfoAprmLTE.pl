#! /usr/local/bin/perl

use DBI;

#Test parameters remove when going to production. 
# For test only.....
# my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
# my $ORACLE_SID  = "bodsprd";
# $ENV{ORACLE_HOME} = $ORACLE_HOME;
# $ENV{ORACLE_SID}  = $ORACLE_SID;
# $ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my %sqls = {};

$sqls{'LTE'} = "select /*+ PARALLEL(t1,12) */ carrier_cd, bp_start_date, count(*), sum(charge_amount), sum(charge_parameter) from prdappc.prm_rom_incol_events t1 where process_date = to_date($ARGV[1],'YYYYMMDD') and carrier_cd != 'NLDLT' group by carrier_cd, bp_start_date";

$sqls{'NLDLT'} = "select /*+ PARALLEL(t1,12) */ carrier_cd, bp_start_date, count(*), sum(charge_amount), sum(charge_parameter) from prdappc.prm_rom_incol_events t1 where process_date = to_date($ARGV[1],'YYYYMMDD') and carrier_cd = 'NLDLT' group by carrier_cd, bp_start_date";

$sqls{'DISP_RM'} = "select /*+ PARALLEL(t1,12) */ carrier_cd, bp_start_date, count(*), sum(tot_net_charge_lc), sum(charging_param) from prdappc.prm_rom_outcol_events t1 where process_date = to_date($ARGV[1],'YYYYMMDD') and carrier_cd != 'NLDLT' group by carrier_cd, bp_start_date";

my $dbconn = getAPRM();

my $sql = $sqls{$ARGV[0]};
my $sth = $dbconn->prepare($sql);

$sth->execute() or sendErr();

my $filename = $ARGV[0].$ARGV[1].'.arpm.csv';
    
open( RPT, ">$filename" ) || errorExit("Report Failed!!!!");

while (my @rows = $sth->fetchrow_array() ) {

    print RPT "$rows[0]\t$rows[1]\t$rows[2]\t$rows[3]\t$rows[4]\n";
}

close(RPT);
$dbconn->disconnect();

exit(0);

sub getAPRM {

    #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
    #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
    my $dbods = DBI->connect( "dbi:Oracle:PRDAPRM", "md1dbal1", "500#Reptar" );
    unless ( defined $dbods ) {
	sendErr();
    }
    return $dbods;
}


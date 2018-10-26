#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      ARCM_SMM1.pl
#
# Description: This script gets information from smm1_arcm_file_repository
#
# Author:      David A Smith
#
# Date:        Tue Aug 29 09:57:50 CDT 2017
#
#-------------------------------------------------------------------------------

use FileHandle;
use DBI;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush();

$user = $ENV{'USER'};
$user =~ s/ //g;

$x = "+\"%D %I:%M:%S%p\"";
chomp $x;
$time = `date $x`;
chomp($time);

print "{\"time\": \"$time\",\n";
fileStatus();
print ",\n";
errors();
print "\n}";

sub fileStatus{
  my $db = getConnectParams();
  my $sql = qq#
				--Processed file
				select file_name, sys_creation_date, file_status, file_type, 
								decode(sender,'IWB51','US_Cellular_IWB51','NLDLT','Vodafone_Netherland_NLDLT','USA6G','Nex_Tech_USA6G','USAAT','ATT_Mobility_USAAT','USABS','ATT_Mobility_USABS','USACC','ATT_Mobility_USACC','USACG','ATT_Mobility_USACG','USAMF','ATT_Mobility_USAMF','USAPB','ATT_Mobility_USAPB','USASG','Sprint_USASG','USASP','Sprint_USASP','USATM','T_Mobile_USATM','USAUD','US_Cellular_USAUD','USAVZ','Verizon_USAVZ','USAW6','T_Mobile_USAW6') as sender,
								decode(recipient,'IWB51','US_Cellular_IWB51','NLDLT','Vodafone_Netherland_NLDLT','USA6G','Nex_Tech_USA6G','USAAT','ATT_Mobility_USAAT','USABS','ATT_Mobility_USABS','USACC','ATT_Mobility_USACC','USACG','ATT_Mobility_USACG','USAMF','ATT_Mobility_USAMF','USAPB','ATT_Mobility_USAPB','USASG','Sprint_USASG','USASP','Sprint_USASP','USATM','T_Mobile_USATM','USAUD','US_Cellular_USAUD','USAVZ','Verizon_USAVZ','USAW6','T_Mobile_USAW6') as recipient,
								file_content, corresponding_file_name, events_count, round(total_value,2)
								from smm1_arcm_file_repository
								where file_type in ('CD')
								and sys_creation_date > sysdate-.05
								union
				--Back logged files
				select file_name, sys_creation_date, file_status, file_type, 
								decode(sender,'IWB51','US_Cellular_IWB51','NLDLT','Vodafone_Netherland_NLDLT','USA6G','Nex_Tech_USA6G','USAAT','ATT_Mobility_USAAT','USABS','ATT_Mobility_USABS','USACC','ATT_Mobility_USACC','USACG','ATT_Mobility_USACG','USAMF','ATT_Mobility_USAMF','USAPB','ATT_Mobility_USAPB','USASG','Sprint_USASG','USASP','Sprint_USASP','USATM','T_Mobile_USATM','USAUD','US_Cellular_USAUD','USAVZ','Verizon_USAVZ','USAW6','T_Mobile_USAW6') as sender,
								decode(recipient,'IWB51','US_Cellular_IWB51','NLDLT','Vodafone_Netherland_NLDLT','USA6G','Nex_Tech_USA6G','USAAT','ATT_Mobility_USAAT','USABS','ATT_Mobility_USABS','USACC','ATT_Mobility_USACC','USACG','ATT_Mobility_USACG','USAMF','ATT_Mobility_USAMF','USAPB','ATT_Mobility_USAPB','USASG','Sprint_USASG','USASP','Sprint_USASP','USATM','T_Mobile_USATM','USAUD','US_Cellular_USAUD','USAVZ','Verizon_USAVZ','USAW6','T_Mobile_USAW6') as recipient,
								file_content, corresponding_file_name, events_count, round(total_value,2)
								from smm1_arcm_file_repository
								where file_status = 'EXPECTED'
								and file_type in ('CD','RC')
								and sys_creation_date > sysdate-31
								union
				--Rejected files
				select file_name, sys_creation_date, file_status, file_type, 
								decode(sender,'IWB51','US_Cellular_IWB51','NLDLT','Vodafone_Netherland_NLDLT','USA6G','Nex_Tech_USA6G','USAAT','ATT_Mobility_USAAT','USABS','ATT_Mobility_USABS','USACC','ATT_Mobility_USACC','USACG','ATT_Mobility_USACG','USAMF','ATT_Mobility_USAMF','USAPB','ATT_Mobility_USAPB','USASG','Sprint_USASG','USASP','Sprint_USASP','USATM','T_Mobile_USATM','USAUD','US_Cellular_USAUD','USAVZ','Verizon_USAVZ','USAW6','T_Mobile_USAW6') as sender,
								decode(recipient,'IWB51','US_Cellular_IWB51','NLDLT','Vodafone_Netherland_NLDLT','USA6G','Nex_Tech_USA6G','USAAT','ATT_Mobility_USAAT','USABS','ATT_Mobility_USABS','USACC','ATT_Mobility_USACC','USACG','ATT_Mobility_USACG','USAMF','ATT_Mobility_USAMF','USAPB','ATT_Mobility_USAPB','USASG','Sprint_USASG','USASP','Sprint_USASP','USATM','T_Mobile_USATM','USAUD','US_Cellular_USAUD','USAVZ','Verizon_USAVZ','USAW6','T_Mobile_USAW6') as recipient,
								file_content, corresponding_file_name, events_count, round(total_value,2)
								from smm1_arcm_file_repository
								where file_type='CD' 
								and file_status not in ('DONE','EXPECTED')
								and sys_creation_date > sysdate-31              
								order by sys_creation_date desc
			#;
  my $sth = $db->prepare($sql);
  $sth->execute();
  my $rows = $sth->fetchall_arrayref();
  print "\"file_status\":[ ";
  my $first = 1;
  foreach my $row (@$rows) {
    if ($first == 0) {
      print ",\n";
    } else {
      $first=0;
    }
    print "{\"file_name\":\"" . @$row[0] . "\",\"create_date\":\"" . @$row[1] . "\",\"file_status\":\"" . @$row[2] . "\",\"file_type\":\"" . @$row[3] . "\",\"sender\":\"" . @$row[4] . "\",\"recipient\":\"" . @$row[5] . "\",\"file_content\":\"" . @$row[6] . "\",\"corresponding_file_name\":\"" . @$row[7] . "\",\"events_count\":\"" . @$row[8] . "\",\"total_value\":\"" . @$row[9] . "\"}";
  }
  print "]";
  $db->disconnect();
}

sub errors{
  print "\"errors\":[ ]";
}

sub getConnectParams(){

  my $dbPwd = "tc3prd";
  my $dbods = ( DBI->connect( "DBI:Oracle:$dbPwd",, ) );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}

exit(0);

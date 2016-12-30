#! /usr/local/bin/perl
# use strict;
use DBI;

#Test parameters remove when going to production.
# $ARGV[0] = "20161003";

# For test only.....
#my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
#$ENV{ORACLE_HOME} = $ORACLE_HOME;
#$ENV{ORACLE_SID}  = $ORACLE_SID;
#$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my @argv = split(/,/,@ARGV[0]);

my $prefix = "LTE";

if(index($argv[0],"NLDLT") >= 0)
{
    $prefix = "NLDLT";
}

my $dbconn = getBODSPRD();

my $sql = "select s_444, error_code, error_desc,cast(S_402 as decimal(19,9)) from em1_record where stream_name='INC' and record_status<>55 and s_444='$argv[0]'";

my $sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my $report = $prefix.'_'.$argv[0].'_'.$argv[7].'.err'.'.csv';
open( ERR, ">$report" ) || errorExit("Could not open error file.... Fail!!!!");

while (my @rows = $sth->fetchrow_array() ) {

    print ERR $rows[0]."\t".$rows[1]."\t".$rows[2]."\t".$rows[3]."\n";  
}

close(ERR);


$report = $prefix.'_'.$argv[0].'_'.$argv[7].'.rpt'.'.csv';

open( RPT, ">$report" ) || errorExit("Could not open error file.... Fail!!!!");


$sql = "select /*+ PARALLEL(t1,12) */  count(*), sum(charge_amount),sum(charge_parameter)  from  prm_rom_incol_events_ap t1 where tap_in_file_name = '$argv[0]'";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();
@rows = $sth->fetchrow_array();

### Test Only

my $dropped = ($argv[3] - $argv[5]) - $rows[0];

print RPT $argv[0]."\t".$argv[1]."\t".$argv[2]."\t".$argv[3]."\t".$argv[4]."\t".$rows[2]."\t".$argv[5]."\t".$argv[6]."\t".$dropped."\t".$rows[0]."\t".$rows[1]."\n";

close(RPT);

$dbconn->disconnect();


exit(0);

sub getBODSPRD {

    #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
    #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
    my $dbods = DBI->connect( "dbi:Oracle:BODSPRD", "md1dbal1", "BooG00900#" );
    unless ( defined $dbods ) {
	sendErr();
    }
    return $dbods;
}



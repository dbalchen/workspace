#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      OVP.pl
#
# Description: This script will get the number of overage protection messages created
#		and return them in JSON format to the web monitors.
#
# Author:      Steve M Roehl
#
# Date:        Tue Apr 01 13:51:48 CDT 2014 (No Joke!)
#
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Added Disclaimer and Balance
# Author        : David A Smith
# Date          : Fri Oct  3 09:52:48 CDT 2014
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
ovpCount();
print "\n}";


sub ovpCount {
  my $today = `date -d "1 days ago" "+%m-%d-%Y"`;							chomp ($yesterday);
  my $yesterday = `date -d "1 days ago" "+%d-%m-%Y"`;						chomp ($today);
  my $ovp_path = '$ABP_APR_ROOT/interfaces/output/NTF/archive/';
  my $ovp_files = `ls $ovp_path*${yesterday}*.dat | wc -l`;					chomp($ovp_files);
  print "\"files\":\"$ovp_files\",\n";
  my $ovp_recs = `cat $ovp_path*${yesterday}*.dat | wc -l`;					chomp($ovp_recs);
  print "\"recs\":\"$ovp_recs\",\n";
  my $ovp_100 = `cat $ovp_path*${yesterday}*.dat | grep '100.00' | wc -l`;	chomp($ovp_100);
  print "\"hundred\":\"$ovp_100\",\n";
  my $ovp_75 = `cat $ovp_path*${yesterday}*.dat | grep '75.00' | wc -l`;	chomp($ovp_75);
  print "\"seventyfive\":\"$ovp_75\"";
  $ovp_disc = `cat $ovp_path*$ovp_disc*${yesterday}*.dat | wc -l`;			chomp($ovp_disc);
  print "disclaimer: $ovp_disc\n";
  $ovp_blnc = `cat $ovp_path*$ovp_blnc*${yesterday}*.dat | wc -l`;			chomp($ovp_blnc);
  print "balance: $ovp_blnc\n";

}


sub getConnectParams{
  my ($connectCode) = @_;

  my $db = DBI->connect("dbi:Oracle:prdcust","PRDOPRC","con8cst8");
  $db->{LongReadLen}=1500;
  my $sql=qq# select conn_params from gn1_connect_params where connect_code=?#;
  my $sth = $db->prepare($sql);
  $sth->execute($connectCode);
  my $params = $sth->fetchrow();
  my $user = substr($params,index($params,'USER')+13,index($params,'"',index($params,'USER')+13)-index($params,'USER')-13);
  #print "user: ${user}\n";
  my $pass= substr($params,index($params,'PASSWORD')+17,index($params,'"',index($params,'PASSWORD')+17)-index($params,'PASSWORD')-17);
  #print "pass: ${pass}\n";
  my $instance= substr($params,index($params,'INSTANCE')+17,index($params,'"',index($params,'INSTANCE')+17)-index($params,'INSTANCE')-17);
  #print "instance: ${instance}\n";
  $sth->finish();
  $db->disconnect() if defined($db);
  return ($user,$pass,$instance);
}


exit(0);

#! /usr/local/bin/perl

use DBI;
use Time::Piece;
use Time::Seconds;

BEGIN {
  push( @INC, '/home/dbalchen/workspace/perl_lib/lib/perl5' );

  #push( @INC, '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/perl_lib/lib/perl5' );
}

use Spreadsheet::WriteExcel;
use MIME::Lite;

# For test only....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my $conn  = getBODSPRD();

my $sql = "select BA_NO,customer_no,account_no,doc_produce_ind, bill_date from Bl1_Document t1 where bill_date > '01-APR-2018' group by  BA_NO,customer_no,account_no,doc_produce_ind, bill_date order by BA_NO,customer_no,account_no,doc_produce_ind, bill_date desc";

my $sth = $conn->prepare($sql);
$sth->execute() or sendErr();

my $who = "";
my $flag = 0;

while ( my @rows = $sth->fetchrow_array() ) {
  my($ba_no,$customer_no,$account_no,$doc_produce_ind,$bill_date) = grep( s/\s*$//g, @rows );
  
  if(($who ne $ba_no) && $doc_produce_ind eq 'N') {$who = $ba_no; $flag = 1;}
  
  if(($who eq $ba_no) && $flag ==1 && $doc_produce_ind eq 'Y') {print "@rows\n";$flag = 0;}


}

exit(0);



sub getBODSPRD {

  #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
  #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
  my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "BooGoo900#" );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}

#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      rerate_backlog.pl
#
# Description: Created for TOPS.  This script checks the ape1_subscriber_reate
#		table to see if there is any backlog to be completed.
#
# Author:      Steven M Roehl
#
# Date:        Mon Mar 10 13:47:48 CDT 2014
#
#-------------------------------------------------------------------------------

use DBI;

$user = $ENV{'USER'};
$user =~ s/ //g;

$x = "+\"%D %I:%M:%S%p\"";
chomp $x;
$time = `date $x`;
chomp($time);

my $prev_month = `date -d"last month" +"%m"`;
chomp($prev_month);

my $curr_month = `date +"%m"`;
chomp($curr_month);

print "{\"time\": \"$time\",\n";
checkBacklog( $prev_month, $curr_month );

#print ",\n";
print "\n}";

sub checkBacklog {
	my ( $prev_month, $curr_month ) = @_;
	my @conns = (

		#		[ 'PRDUSG1', 'PRDUSG1C', 'con8usg18' ],
		#		[ 'PRDUSG2', 'PRDUSG2C', 'con8usg28' ],
		#		[ 'PRDUSG3', 'PRDUSG3C', 'con8usg38' ],
		#		[ 'PRDUSG4', 'PRDUSG4C', 'con8usg48' ]

		'TC1_SVC_BILLINGOPS', 'TC2_SVC_BILLINGOPS', 'TC3_SVC_BILLINGOPS',
		'TC4_SVC_BILLINGOPS'
	);

	my $first = 1;
	print "\"cycles\":[ ";
	my @all_rows = ();
	foreach $one_conn (@conns) {

		#		my ( $dbname, $user, $pass ) = @$one_conn;
		#		my $db = DBI->connect( "dbi:Oracle:$dbname", $user, $pass );

		my $db = ( DBI->connect( "DBI:Oracle:$one_conn",, ) );
		my $sql =
qq#select cycle_code,cycle_instance,count(*),num_of_rerate_tries from ape1_subscriber_rerate where cycle_instance in (?,?) 
group by cycle_code,cycle_instance,num_of_rerate_tries#;

		my $sth = $db->prepare($sql);
		$sth->execute( $prev_month, $curr_month );

		#my $rows=$sth->fetchall_arrayref();
		while ( my @row = $sth->fetchrow_array ) {

			#foreach my $row (@$rows){
			push( @all_rows, [@row] );
		}
		$sth->finish;
		$db->disconnect();
	}

	my @sorted_rows =
	  sort { $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1] || $a->[3] <=> $b->[3] }
	  @all_rows;

	# my $count=0;
	# my @sorted_rows=();
	# my @temp=();
	# foreach $val (@sorted_vals){
	#   push(@temp,$val);
	#   $count+=1;
	#   if($count==4){
	#     push(@sorted_rows,[@temp]);
	#     @temp=();
	#     $count=0;
	#   }
	# }

	#print "test: " . $sorted_rows[0][0] . "\n";

	#print "Looping over sorted:\n\n";

	foreach my $row (@sorted_rows) {

		#print @$row[0] . "\n";
		if ( $first == 0 ) {
			print ",\n";
		}
		else {
			$first = 0;
		}
		print "{\"cycle_code\":\""
		  . @$row[0]
		  . "\",\"cycle_instance\":\""
		  . @$row[1]
		  . "\",\"count\":\""
		  . @$row[2]
		  . "\",\"retries\":\""
		  . @$row[3] . "\"}";
	}

	print "]";
}


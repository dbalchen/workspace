#!/opt/perl5/bin/perl

=head2 PACKAGE  TP_Summary

=head3 AUTHOR

  Glenn Lockwood

=head3 SYNOPSIS

  use Monitor::TP_Summary; 
  my $check  = Monitor::TP_Summary->new(@arg_list); 
  my $result = $check->run_check();
  
  
  use Monitor::TP_Summary;
  
  my $check  = Monitor::TP_Summary->new(%arg_hash) 
  my $result = $check->run_check();

=head3 REQIREMENTS

  - Inherits the Monitor package and its instance variables.
  - Check is performed by a main method called run_check, which returns a 
    scalar containing a formatted string, which will be displayed verbatim
    by the Monitor interfaces. 

=head3 DESCRIPTION

   Gets mps average throughput for guiding,rating,main driver,collections
   as records/seconds over an interval and stores it in a central database
   maintains "hi scores" for each tuple for use in determining the backlog
   at maximum utilization

=cut

package Monitor::TP_Summary;
use Logger;
use strict;
use warnings;    


# if the program doesn't run in the directory holding the Monotor pm
# then it must be passed on the command line as MpsLib
BEGIN
{
    my %args = @_;
    push @INC, $args{MpsLib};
}

use base qw(Monitor);    # Monitor is the base (parent) class.
use Logger;
use Carp;
use USCDB;
use Time::Local;
use Data::Dumper;

=head2 METHODS

=head3 new()

  Constructor.
  Creates a new instqance
  Sets the class variables from argument pairs.
  
  Returns: a reference to the new object.

=cut

sub new()
{
    my ($class, %args) = @_;
    my $self = Monitor->new();    # inherit Monitor's instance variables.

    # Add properties passed in to the hash of instance variables.
    foreach my $key (keys(%args))
    {
        $self->{$key} = $args{$key};
    }

    bless $self, $class;
    return $self;
}

=head3 run_check()

    Performs the query on ac_processing_accounting and inserts into performance summary.
    returns undef if hunki-dori, else error message    

=cut

sub run_check
{
  my $self    = shift;
  my $message = undef;
  my $log     = $self->{LoggerRef};
  my $market  = $self->{market};
  # use support instead of production
  my $dbh     = get_db_con($log,
                           "PC1${market}",
                           "${market}appconn",
                           "${market}appconn");                                   
  
  my $pdb= get_db_con($log,
                      $self->{sum_dbsid},
                      $self->{sum_dbuser},
                      $self->{sum_dbpass});

  my $day_divisor = 86400/$self->{seconds_span};
  my $days_ago="(1/".$day_divisor.")";   
  
  my $tp_qry = $self->get_sql_query($self->{SqlLib} . $self->{sql_query});
  $tp_qry =~ s/\?/$days_ago/g;

  my $rc       = $dbh->setQuery($tp_qry);
  if (!defined $rc)
  {  
    $log->print_to_log("[$tp_qry]]\n");     
    croak "\nError in setQuery: \n", $dbh->getErrorStr(), "$tp_qry\n\n";
  }
  
  $rc = $dbh->runQuery();
  if (!defined $rc)
  {
    $log->print_to_log("[$tp_qry]]\n");
    croak "\nError in runQuery: \n", $dbh->getErrorStr(), "\n\n";
  }

  # store query returns in 2D arrays; control break utilization & sum on program
  my @tprows = ();  #throughput
  my @utrows = ();  #utilization
  my $lastapp = "";
  my $srecs=0;
  my $ssecs=0;
  my $sfile=0;

  my $program;
  my $file_alias;
  my $records;
  my $seconds;
  my $files;

  # do unit tests: no rows, one row, last row same as prev, last row !same as prev
  # this should be an idiomatic control break for DBI

  while(($program,$file_alias,$records,$seconds,$files)= $dbh->fetchResults())
  {
    #print "$program $file_alias $records $seconds $files \n";
    push(@tprows,[$program,$file_alias,$records,$seconds,$files]); 

    if( $#tprows==0 )
    {   
      $lastapp=$program;  #priming read
    }
    if( $lastapp eq $program )
    {
      $srecs += $records;
      $ssecs +=$seconds;
      $sfile +=$files;
    }
    else
    { 
      push(@utrows,[$lastapp,$srecs,$ssecs,$sfile]);
      $srecs=0;
      $ssecs=0;
      $sfile=0;
    } 
    $lastapp=$program;
  }
  # push last record if any were fetched
  if($#tprows > -1 )
  {   
    if($srecs == 0)
    {
      # last record broke the key & wasn't pushed or accumulated
      # the return list was overwritten on the last empty fetch 
      push(@utrows,[$tprows[$#tprows][0], $tprows[$#tprows][2],
                    $tprows[$#tprows][3], $tprows[$#tprows][4]]);
    }
    else
    {
      # last record didn't break and sum wasn't pushed
      push(@utrows,[$lastapp,$srecs,$ssecs,$sfile]);
    }
  }

  my $ts=get_timestamp($pdb,$log);

  # pass a hard reference to the result set arrays; time align the two sets
  save_throughput($log,$pdb,$self->{market},$self->{seconds_span},$ts,\@tprows);
  save_utilization($log,$dbh,$pdb,$self->{market},$self->{seconds_span},$ts,\@utrows);
  #keep the last results and high scores for other apps
  save_results($pdb,$log,$ts,\@tprows,\@utrows);    
  # close things in the same scope they're opened. 
  $dbh->closeConnection();
  $pdb->closeConnection();
  return $message;
}
               

sub get_sequence_no
{
  my $dbc=shift;
  my $log=shift;
  my $errmsg="\nError getting sequence key from calldump : \n";
  my $sql =  " SELECT calldump.nextval from dual ";
  my $rc = $dbc->setQuery($sql);
  if (!defined $rc)
  {
     croak $errmsg, $dbc->getErrorStr(), "\n\n";
  }

  $rc = $dbc->runQuery();
  if (!defined $rc)
  {
     croak $errmsg, $dbc->getErrorStr(), "\n\n";
  }

  my @results  = $dbc->fetchResults;
  if (!defined $results[0])
  {
     croak $errmsg, $dbc->getErrorStr(), "\n\n";
  }

  my $sequence_no = $results[0];
  return $sequence_no;
}

sub get_guiders
{
  my $dbc=shift;
  my $sql = "SELECT field_value from MAF_PROFILE where ident='NO_OF_GUIDERS' and division_code='GIM'";
  my $errmsg="\nError getting number of guiders : \n";

  my $rc = $dbc->setQuery($sql);
  if (!defined $rc)
  {
     croak $errmsg, $dbc->getErrorStr(), "\n\n";
  }

  $rc = $dbc->runQuery();
  if (!defined $rc)
  {
     croak $errmsg, $dbc->getErrorStr(), "\n\n";
  }

  my @results  = $dbc->fetchResults;
  if (!defined $results[0])
  {
     croak $errmsg, $dbc->getErrorStr(), "\n\n";
  }
  my $guiders = $results[0];
  return $guiders;
}

sub get_raters
{
  my $dbc=shift;
  my $sql = "SELECT sum(no_of_raters_in_group) from rater_config";
  my $errmsg="\nError getting number of raters : \n";

  my $rc = $dbc->setQuery($sql);
  if (!defined $rc)
  {
     croak $errmsg, $dbc->getErrorStr(), "\n\n";
  }

  $rc = $dbc->runQuery();
  if (!defined $rc)
  {
     croak $errmsg, $dbc->getErrorStr(), "\n\n";
  }

  my @results  = $dbc->fetchResults;
  if (!defined $results[0])
  {
     croak $errmsg, $dbc->getErrorStr(), "\n\n";
  }
  #print "raters $results[0]\n";
  my $raters = $results[0];
  return $raters;
}


sub get_db_con
{
my $log=shift;
my $sid=shift;
my $usr=shift;
my $pwd=shift;

my $db=USCDB->new();
my @cs=($sid,$usr,$pwd);
my $rc = $db->openConnection(@cs);
    if (!defined $rc)
    {   
        $log->print_to_log("Connect attempted using $usr/$pwd\@$sid\n");
        croak "\nCould not connect to Oracle!\n", $db->getErrorStr(), "\n\n";  
    }
   return $db;
}


#this function alters the throughput results array,prepending the date
sub save_results()
{
my $podb=shift;   # for possibly inserting highscores into database
my $log=shift;
my $ts=shift;
my $tprows=shift;
my $utrows=shift; 
my $tpfile="TP_resultset.txt";
my $tpscore="TP_hiscores.txt";
# open a file here in trunc mode to save latest results into
# it is used by the backlog monitor for context. Backlog is only collected for
# apps that have saved their throughput in this file  
open SAVELAST,">",$tpfile || croak "\n Can't open $tpfile ($@) \n";

for my $i (0 .. $#${tprows})
{
    unshift( @{$$tprows[$i]},("$ts") );
    for my $j (0 .. $#{$$tprows[$i]}) 
    {
      print SAVELAST "$$tprows[$i][$j] ";
    }
    print SAVELAST "\n";
} 
close SAVELAST;

my $hidate;
my $hitime;
my $hizone;
my $hiprog;
my $hifile;
my $hirecs;
my $hielapsed;
my $hifiles;
my @hiscores=();
my $found=0;
my $newhi=0;

if( -e $tpscore )
{
  my $i=0;
  my $j=0;
  open HISCORES,"<",$tpscore ||  croak "\n Can't open $tpscore ($@) \n";
  while( <HISCORES> )
  {
    chop;
    #the zeroeth element(timestamp) we unshifted above is 3 elements in hiscores  
    ($hidate,$hitime,$hizone,$hiprog,$hifile,$hirecs,$hielapsed,$hifiles)= split /\s+/ ;
    push(@hiscores,[$hidate,$hitime,$hizone,$hiprog,$hifile,$hirecs,$hielapsed,$hifiles]);
  }    
  close HISCORES;
}
#if a new measurement comes in that's not in the file,add it to @hiscores
#if a new hiscore is seen for an existing prg/file update it.
my $i=0;
my $j=0;
for $i (0 .. $#${tprows})
{
  #look it up in our recent found set
  $found=0;
  for $j (0.. $#hiscores)
  {
    #print "$hiscores[$j][3] $$tprows[$i][1] $hiscores[$j][4]  $$tprows[$i][2]\n";
    if($hiscores[$j][3] eq $$tprows[$i][1] && $hiscores[$j][4] eq $$tprows[$i][2])
    {
      $found++;
      my $newtp= $$tprows[$i][3]/$$tprows[$i][4];
      my $oldtp= $hiscores[$j][5]/$hiscores[$j][6];
      if( $newtp > $oldtp )
      {
        $hiscores[$j] = $$tprows[$i];
        $newhi++;
      }
      last;
    }
  }
  if(!$found)
  {
    $newhi++;
    push(@hiscores, $$tprows[$i]); 
  }
}
if( $newhi )
{
  open HISCORES,">",$tpscore ||  croak "\n Can't open $tpscore ($@) \n";
  for $i (0 .. $#{hiscores})
  {
    for $j (0 .. $#{$hiscores[$i]}) 
    {
      print HISCORES "$hiscores[$i][$j] ";
    }
    print HISCORES "\n";
  }
}

}




sub get_timestamp()
{
  my $conn=shift;
  my $sql0="SELECT to_char(systimestamp, 'YYYY-MM-DD HH24:MI:SS.FF TZR')  from dual";
  my $rc=$conn->setQuery($sql0);
  if (!defined $rc)
  {
    croak "$sql0\n", $conn->getErrorStr(), "\n\n";
  }

  $rc = $conn->runQuery();
  if (!defined $rc)
  {
     croak "$sql0\n", $conn->getErrorStr(), "\n\n";
  }

  my @results  = $conn->fetchResults;
  if (!defined $results[0])
  {
     croak $sql0, $conn->getErrorStr(), "\n\n";
  }
  return($results[0]);
}



sub save_utilization()
{
  my $log=shift;
  my $appconn=shift;
  my $conn=shift;
  my $market=shift;
  my $interval=shift;      # in seconds
  my $ts=shift;
  my $resultset=shift;     # reference to 2 dim array contains summarized throughput by app
  my $seq=0;
  my $rc=0;
  my $row;
  my $sql1=" INSERT into performance_info ".
           " VALUES (?,?,?,TIMESTAMP '$ts' ,'S',$interval) ";

  # round to the nearest second
  my $sql2=" INSERT into performance_detail ".
           " VALUES (?,?,'GA' ,?,?,null,?,round(?))";

  my $available_seconds=0;
  my $lastapp="";
  my $guiders=get_guiders($appconn);
  my $raters=get_raters($appconn);
  for my $i (0 .. $#${resultset})  #dereference to get count
  {
    $row=$resultset->[$i];         #get a reference to the slice in $row  

    #print "utilization  $row->[0] $row->[1] $row->[2] \n"; 
    if ( $row->[0] =~ /MAF2COLL|UPS2COLL|UPS2MDRV/ )
    { 
      $available_seconds = $interval * 5;
    }
    elsif ( $row->[0] =~  /mpup_100mn/  )
    { 
      $available_seconds = $interval * $raters;
    }
    elsif ( $row->[0] =~   /mpgd_100mn/ )
    {
      $available_seconds = $interval * $guiders *4;
    }
    else
    {
      croak "\nUnexpected/unsupported application name [$row->[0]]\n\n";
    }

    # insert new info record for duty cycle
    $seq=get_sequence_no($conn,$log);
    $rc=$conn->setQuery($sql1);
    if (!defined $rc)
    {
      croak "\nError in ", __FILE__ ,"  setQuery near line ", __LINE__ ,": \n", $conn->getErrorStr(), "\n\n";
    }

    $rc=$conn->runQuery($seq,$market,$row->[0]);
    if (!defined $rc)
    {
      $log->print_to_log("binds: $seq,$market,$row->[0]\n");
      croak "\nError in ",__FILE__," runQuery near line ",__LINE__,": \n", $conn->getErrorStr(), "\n\n";
    }
    # insert the detail record with hard file alias, elapsed and available
    $rc=$conn->setQuery($sql2);
    if (!defined $rc)
    {
      croak "\nError in ",__FILE__," setQuery near line ",__LINE__,": \n", $conn->getErrorStr(), "\n\n";
    }
 
    $rc=$conn->runQuery($seq,"ALL_FILES","duty_cycle","sec",$row->[3],$available_seconds);
    if (!defined $rc)
    {
      $log->print_to_log("binds: $seq,*,duty_cycle,$row->[3],$available_seconds\n");
      croak "\nError in ",__FILE__," runQuery near line ",__LINE__,": \n", $conn->getErrorStr(), "\n\n";
    }
  }
}


#
# performance_info
# record_key number(15) from sequence 'calldump'
# hostname varchar2(16)
# appname varchar2(32)
# time_created tmestamp with time zone
# time_units char(1) 'S' is for seconds
# time_interval number(10)
#
# each element of the result set has
# application name
# file_alias
# records procesed in this interval
# elapsed time to process
# file count

sub save_throughput
{
  my $log=shift;
  my $conn=shift;
  my $market=shift;
  my $interval=shift;      # in seconds
  my $ts=shift;
  my $resultset=shift;     # reference to 2 dim array     

  my $seq=0;
  my $rc=0;
  my $row;

  my $sql1=" INSERT into performance_info ".
           " VALUES (?,?,?,TIMESTAMP '$ts' ,'S',$interval) ";

  # round to the nearest second
  my $sql2=" INSERT into performance_detail ".
           " VALUES (?,?,'GA' ,?,?,null,?,round(?))";


  for my $i (0 .. $#${resultset})  #dereference to get count
  {
    $row=$resultset->[$i];         #get a reference to the slice in $row
    $seq=get_sequence_no($conn,$log);
    $rc=$conn->setQuery($sql1);
    if (!defined $rc)
    {
      croak "\nError in ", __FILE__ ,"  setQuery near line ", __LINE__ ,": \n", $conn->getErrorStr(), "\n\n";
    }

    $rc=$conn->runQuery($seq,$market,$row->[0]);
    if (!defined $rc)
    {
       $log->print_to_log("binds: $seq,$market,$ts,$row->[0]\n");
       croak "\nError in ",__FILE__," runQuery near line ",__LINE__,": \n", $conn->getErrorStr(), "\n\n";
    }
    # insert the detail record with file alias, recordcount and seconds
    $rc=$conn->setQuery($sql2);
    if (!defined $rc)
    {
      croak "\nError in ",__FILE__," setQuery near line ",__LINE__,": \n", $conn->getErrorStr(), "\n\n";
    }
 
    $rc=$conn->runQuery($seq,$row->[1],"throughput","r/s",$row->[2],$row->[3]);
    if (!defined $rc)
    {
      $log->print_to_file("binds: $seq,$row->[1],throughput, $row->[2],$row->[3] \n");
      croak "\nError in ",__FILE__," runQuery near line ",__LINE__,": \n", $conn->getErrorStr(), "\n\n";
    }
  }
}
   
1;  

#return non-success for any (oops) drop-through;
#in lieu of an explicit return the value of the last expression is returned. 
#another arcane "feature" of perl

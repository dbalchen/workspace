#! /usr/bin/perl

my $file     = $ARGV[0];
$file ="/home/dbalchen/Desktop/CIBER_CIBER_20180707013759_261985_0018.dat";

my $stdin_file = "/home/dbalchen/Desktop/hsscombo2.csv";

open( STDIN, "< $stdin_file" ) || exit(1);


while (my $buff = <STDIN>) {

  chomp($buff);

  my ($serveSid,$homeSid,$seq) = split(/\t/,$buff);

  my $hh = "cat $file " . '|';

  open( PIPE, $hh ) or exit(1);
  my $flag = 0;
  while ( my $buf = <PIPE> ) {
    
    chomp($buf);
    
    if ((substr($buf,0,2) eq '01') && (substr($buf,11,5) eq $homeSid) &&  (substr($buf,16,5) eq $serveSid) && (substr($buf,8,3) == $seq)) {
      $flag = 1;
    }

    if($flag == 1){print "$buf\n";}
	
    if ((substr($buf,0,2) eq '98') && (substr($buf,11,5) eq $homeSid) &&  (substr($buf,16,5) eq $serveSid) && (substr($buf,8,3) == $seq)) {
      close(PIPE);
      last;
      
    }
  }

}

#! /usr/local/bin/perl

my $seq = $ARGV[0];
my $serve = $ARGV[1];
my $home = $ARGV[2];


 while ($buff = <STDIN>) {

  chomp($buff);

  if(substr($buff,0,2) eq '01')
  {
      if((substr($buff,8,3) eq $seq) && (substr($buff,11,5) eq $serve) && (substr($buff,16,5) eq $home))
	{
	  print $buff."\n";
	  while ($buff = <STDIN>) {
	      print $buff."\n";
	      
	      if(substr($buff,0,2) eq '98')
	      {
		  last;
	      }
	  }
      }
  }
  
}

close(STDIN);

exit;


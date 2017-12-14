#! /usr/bin/perl
use POSIX;
use Cwd;
use File::stat;
use lib "./MIME";
use MIME::Lite;

my $fromdir = $ARGV[0];
my $todir = $ARGV[1];
my $dateStamp = strftime("%m%d%Y%H%M%S",localtime);

$BINDIR = `pwd`;

chdir($fromdir);

$hh = "find . -name ".'"S*"'." -follow -print | egrep 'DAT|FTP' | egrep -v 'gteout|gtc|gaaa|gnti|gsms|aaa1|aaas|aaa2|cares|switches|iroam|ERROR|EDIT|SPLT' |";
print "$hh\n";

if ( !open( CPLIST, "$hh" ) ) {
  print "Cannot create CPLIST: \n";
  exit(2);
}

my $Filescopied = 0;

while($cpfile = <CPLIST>)
  {

   chomp($cpfile);

   $cpfile =~ s/\.\///g;

   $tofile = $todir.'/'.$cpfile;
   $tofile2 = $tofile.'.gz';

   if (!-e $tofile && !-e $tofile2)
     {
       print "Copying the file: $cpfile to $tofile\n";

       $Filescopied++;

       $ch = "cp $cpfile  $tofile";
       print "$ch\n";
       system($ch);
     }

  }
close (CPLIST);

exit(0);

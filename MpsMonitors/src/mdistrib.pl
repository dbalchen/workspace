#!/opt/perl5/bin/perl

=head2 mdistrib.pl

=head3 AUTHOR

  Pete Chudykowski

=head3 DESCRIPTION

  mdistrib.pl is a utility script used to distribute either the monitor.xml
  configuration file or all monitor sources to all the markets and bounce
  the monitors if desired.
  The script is interactive in that at the very least (depending on how much
  information is provided in the configuration file) it will prompt user 
  for production id and password.

=head3 REQUIREMENTS

  Currently, the monitors can only be brought up via remote shell.
  As such, the script will only successfully bounce the monitors if 
  it is executed on a host and by a user, both of which have a valid 
  .rhosts entry on the monitor server hosts.

=head3 USAGE:

  mdistrib.pl [-all] [-cfg] [-c [<path>]]

  -h --help       Display this help message.
  -all            Distribute all sources.
  -cfg            Distribute the configuration file only.

                  If both are set, -all trumps -cfg
  -c              Optionally specify location of the mdistrib config file 
                  if it is not present in the current directory
  -b              Bounce the monitors after distributing.


=head3 SYNOPSIS

  mdistrib.pl -all -c ./conf/config.xml
  mdistrib.pl -cfg
  mdistrib.pl

=cut


use strict;

BEGIN
{
  unshift @INC,"/users/md1pchu1/lib/perl5/site_perl/5.8.0/";
}

use Cwd;
use Carp;
use Net::FTP::Recursive;
use IO::Socket;
use XML::Simple;
use Term::ReadKey;
use Data::Dumper;
use MonitorControl;

$| = 1;

=head3 mdistrib main

  Gather up arguments and parse the XML configuration file.
  Loop through markets defined in the config.  
    Connect to each market using FTP.  Depending on command 
    line specifications distribute all sources or the monitor
    configuration file only.
    Bounce the monitor if requested.
  End loop.

=cut

my %args = gather_args();
my $config = XML::Simple->new()->XMLin($args{-c});

foreach my $mkt (sort(keys(%$config))) 
{
    print "\n" . uc($mkt) . "\n";
    print "Initiating FTP connection.\n"; 
    my $ftp = Net::FTP::Recursive->new($config->{$mkt}->{server}, 
                                       Debug=>0);
    ($args{-login},$args{-pass}) = ftp_connect(\$ftp,$args{-login},$args{-pass});
    print "Connection Successful!\n"; 
    $ftp->binary();
 
    if(defined $args{-all})
    {
      distrib_all($ftp, $config->{$mkt}->{all});
    }
    elsif(defined $args{-cfg})
    {
      distrib_conf($ftp, $config->{$mkt}->{cfg});
    }
    else
    {
      croak "Unable to set distribution mode\n";
    }
 
    $ftp->quit();
     
    if(defined $args{-b})
    {
      print "Bouncing the " . uc($mkt) . " Monitors.\n";
      my $mon = MonitorControl->new(server=>$config->{$mkt}->{server},
                                    port=>$config->{$mkt}->{port},
                                    Cargs=>$config->{$mkt}->{args},
                                    login=>$args{-login},
                                    passwd=>$args{-pass},
                                    location=>$config->{$mkt}->{location});
      $mon->bounce();
      print "Bounce complete.\n\n";
    }
    print "Distribution to " . uc($mkt) . " complete.\n\n";
}

=head3 gather_args()
  
  Gather required arguments.
  First Check if flags are set on the command line.
  If applicable try default.
  Otherwise (or if default does not work) switch to 
  interactive mode and ask for directions.

=cut

sub gather_args
{
  
  my %args = ();
  
  # If they're asking for help, sigh ostentatiously and give it to them.
  if(grep /-h/, @ARGV or grep /--help/, @ARGV)
  {
    print "\nUSAGE: mdistrib.pl [-all] [-cfg] [-c [<path>]]\n\n";
    print "-h --help \tDisplay this help message.\n";
    print "-all \t\tDistribute all sources.\n";
    print "-cfg \t\tDistribute the configuration file only.\n";
    print "\n\t\tIf both are set, -all trumps -cfg\n";
    print "-c \t\tOptionally specify location of the mdistrib config file "
        . "if it is not present in the current directory\n";
    print "-b\t\tBounce the monitors after distributing.\n";
    print "EXAMPLES:\n";
    print "mdistrib.pl -all -c ./conf/config.xml\n";
    print "mdistrib.pl -cfg\n";
    print "mdistrib.pl\n\n";
    print "Default values are used if no arguments are provided.\n";
    print "If default is impossible to determine, the script will switch ";
    print "to interactive mode.\n\n";
    exit -1;
  }
  
  # The -c flag specifies the location of the config file.
  # If the flag is not supplied, check if 'config.xml' happens 
  # to be in the current directory.
  # If all else fails, switch to interactive mode and ask where
  # the config file is.
  if(grep /-c/, @ARGV)
  {
    # the token following the -c flag should be a path to the 
    # configuration file.
    for(my $i=0; $i<@ARGV; $i++)
    {
      if($ARGV[$i] eq "-c")
      {
        $args{-c} = $ARGV[$i+1];
        last; 
      }
    }
  }
  else
  {
    $args{-c} = undef;
  }
  # now check if the supplied file actually exists.
  unless(-e $args{-c})
  {
    if(defined $args{-c})
    {
      print $args{-c} , " does not exist.\n";
    }
    print "\nLooking for config.xml in the current directory ... ";
    if(-e "./config.xml")
    {
      print "Got it!\n\n";
      $args{-c} = "./config.xml";
    }
    else
    {
      print "no luck.\n";
      while(1)
      {
        print "\nUnable to find config.xml.  ";
        print "Enter location: ";
        $args{-c} = <STDIN>;
        chomp $args{-c};
        # again, check if the supplied file actually exists;
        last if(-e $args{-c});
      }
    } # end if-else
  } # end unless
  
  # Check for flags -all and -cfg
  # -all means that everything is to be distributed.
  # -cfg means that only the config.xml is to be distributed.
  # if both are set, -all trumps -cfg.
  if(grep /-cfg/, @ARGV)
  {
      $args{-cfg}='true';
  }
  else
  {
    $args{-cfg} = undef;
  }
  
  
  if(grep /-all/, @ARGV)
  {
    $args{-all} = 'true';
  }
  else 
  {
    $args{-all} = undef;
  }
  # if neither is defined, ask.
  if(!defined $args{-cfg} && !defined $args{-all})
  {
    while(1)
    {
      print "\nUnable to determine transfer mode.\n";
      print "Distribute all files (a) or config file only (c)? [a|c] : ";
      my $resp = <STDIN>;
      chomp $resp;
      if($resp eq "a")
      {
        $args{-all} = 'true';
        last;
      }
      elsif($resp eq "c")
      {
        $args{-cfg} = 'true';
        last;
      }
      print "\nInvalid Response.  Valid responses are 'a', or 'c'.\n";
    }
  }

  # The flag -b if set will
  if(grep /-b/, @ARGV)
  {
      $args{-b}='true';
  }
  else
  {
    $args{-b} = undef;
  }
  
  return %args;  
}


=head3 distrib_all()

  Recursively FTP the entire directory supplied in $config.

=cut

sub distrib_all
{
  my($ftp,$cfg) = @_;
  
  $ftp->cwd($cfg->{dest});
  carp "\nUnable to cd to $cfg->{dest}\n" 
     . $ftp->message() unless defined $ftp;
 
  $ftp->ascii();
  
#  print Dumper($cfg);
  
  # first determine if the local entry directory exists
  unless(-e $cfg->{dir})
  {
    croak "$cfg->{dir} does not exist!\n";
  }
  # check if it is a directory
  unless(-d $cfg->{dir})
  {
    croak "$cfg->{dir} is not a directory!\n"
  }
  
  # cd into the local entry directory.
  chdir($cfg->{dir}) 
    or croak "Unable to cd into $cfg->{dir}!\n$!\n";
  
  # create the empty destination directory if doesn't already exist.
  $ftp->mkdir($cfg->{dest});

  # change remote directory to dest
  print "Changing directory to $cfg->{dest}\n";
  $ftp->cwd($cfg->{dest});
  
  # FTP directory recursively
  print "Transferring files (this can take awhile) ... ";
  $ftp->rput();
  print "done.\n";

}

=head3 distrib_conf()

  Distribute only the monitor configuration file.

=cut

sub distrib_conf
{
  my($ftp,$cfg) = @_;
  
  $ftp->mkdir($cfg->{dest});
  $ftp->cwd($cfg->{dest})
    or croak "\nUnable to cd to $cfg->{dest}\n" 
           . $ftp->message();
 
  $ftp->ascii();
  
  unless(-e $cfg->{file})
  {
    croak $cfg->{file}, " does not exist!\n$!\n";
  }
  
  print "Transferring file ... ";
  $ftp->put($cfg->{file})
    or croak "Unable to FTP $cfg->{file}\n";
  print "done.\n";
}

=head3 ftp_connect()

  Try connecting using supplied password.
  Retry until successfull.

=cut

sub ftp_connect
{
    my($ftp,$login,$pass) = @_;
    
    unless(defined $login)
    { 
      print "\nEnter production login ID: ";
      $login = <STDIN>;
      chomp $login;
    }
    
    unless(defined $pass)
    { 
      print "\nEnter production password for $login: ";
      ReadMode('noecho');
      $pass = <STDIN>; #ReadLine(0);
      chomp $pass;
      ReadMode('normal');
    }
    eval
    {
      $$ftp->login($login, $pass)
                  or croak "\nInvalid Username or Password!\n";  
    };
    if($@)
    {
      print "\nInvalid Password.  Try again.\n";
      ftp_connect($ftp);
    }
    return ($login,$pass);
}  

=head3 TODO

  Thread the start method instead of looping to speed up the process of
  bringing up the monitors.

=cut

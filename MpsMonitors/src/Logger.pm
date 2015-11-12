#!/opt/perl5/bin/perl

=head2 PACKAGE  Logger

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

   my $log = Logger->new(log_dir  => "logDirectoryPath/",
                         log_name => "logfileName.log");
   $log->print_to_log("Log Text.") or carp "Could not write to log.";
   $log->close_log();

=head3 DESCRIPTION

    Provides a utility for logging activity with a flexibly manipulated 
    timestamp.

=cut

package Logger;

use strict;
use warnings;

use POSIX;

=head2 METHODS

=head3 new()

  Constructor.
  Creates an instance of Logger.
  Creates a FileHandle for writing.
  
  Returns: a reference to the instanciated object.

=cut

sub new()
{
    my ($class, %params) = @_;
    my $self;

    # Add properties passed in to the hash of instance variables.
    foreach my $key (keys(%params))
    {
        $self->{$key} = $params{$key};
    }

    open(LOGFILE, ">>" . $self->{log_dir} . $self->{log_name});
    $self->{log_file_handle} = \*LOGFILE;

    bless $self, $class;
    return $self;
}

=head3 close_log()

  Closes the log file.

=cut

sub close_log
{
    my $self = shift;
    close($self->{log_file_handle});
}

=head3 destroy()

  Destroys the log file.  Deletes from filesystem.

=cut

sub destroy_log
{
    my $self = shift;
    unlink $self->get_log_file();
}

=head3 print_to_log()

  Prints a timestamped message to the log.
  
  Takes:   messge string scalar.

=cut

sub print_to_log()
{
    my $self      = shift;
    my $msg       = shift;
    my $fh        = $self->{log_file_handle};
    my $timestamp = get_timestamp("%Y/%m/%d %H:%M:%S");
    chomp $msg;
    $msg =~ s/\n/\n$timestamp : /g;
    print $fh "$timestamp : $msg\n";
}

=head3 get_timestamp()

  Static method.
  Returns current timestamp.

=cut

sub get_timestamp
{
    my $format = shift;
    return strftime($format, localtime());
}

=head3 get_log_file()

  Returns logfile location and name.

=cut

sub get_log_file
{
    my $self = shift;
    return $self->{log_dir} . $self->{log_name};
}

=head3 get_handle()

  Returns logfile write handle.

=cut


sub get_handle
{
    my $self = shift;
    return $self->{log_file_handle};
}

1;

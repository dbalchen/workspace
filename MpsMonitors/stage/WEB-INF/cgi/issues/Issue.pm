#!/usr/bin/perl

package Issue;

use strict;
use warnings;

use Carp;
use XML::Simple;

# Constructor.
sub new()
{
  my($class,$id,$status,$title,$desc) = @_;
  my $self = {};
  if(defined $id && defined $status && defined $title && defined $desc)
  {
    $self = {id     => $id,
             status => $status,
             title  => $title,
             desc   => $desc};
  }
  bless $self, $class;
  return $self
}

# Accessor Methods
sub get_id
{
  my $self = shift;
  return $self->{id};
}


sub set_id
{
  my($self,$id) = @_;
  $self->{id} = $id;
  return $self->{id};
}


sub get_status
{
  my $self = shift;
  return $self->{status};
}


sub set_status
{
  my($self,$status) = @_;
  $self->{status} = $status;
  return $self->{status};
}


sub get_title
{
  my $self = shift;
  return $self->{title};
}


sub set_title
{
  my($self,$title) = @_;
  $self->{title} = $title;
  return $self->{title};
}


sub get_desc
{
  my $self = shift;
  return $self->{desc}
}


sub set_desc
{
  my($self,$desc) = @_;
  $self->{desc} = $desc;
  return $self->{desc};
}


# filesystem methods

sub read_issue
{
  my($self,$file) = @_;
  open(ISSUE_FILE, $file) 
    or croak "Unable to open file $file for reading!\n$!\n";
  
  my $issue = XML::Simple->new()->XMLin($file);
  set_id($self,$issue->{id});
  set_status($self,$issue->{status});
  set_title($self,$issue->{title});
  set_desc($self,$issue->{desc});
  
  close(ISSUE_FILE);
}


sub write_issue
{
  my($self,$file) = @_;
  open(ISSUE_FILE, ">$file")
    or croak "Unable to open file $file for writing!\n$!\n";

  my $xml_out =<<XML;
<issue>
  <id>$self->{id}</id>
  <status>$self->{status}</status>
  <title>$self->{title}</title>
  <desc>$self->{desc}</desc>
</issue>
XML

  print ISSUE_FILE $xml_out;
  
  close(ISSUE_FILE);
}

1;

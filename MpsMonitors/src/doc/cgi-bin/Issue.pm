#!/usr/bin/perl

package Issue;

use strict;
use warnings;

use Carp;
use CGI qw(:all);
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


sub show_issue
{
    my($self, $file) = @_;

    $self->read_issue($file);
    my $desc = $self->get_desc();
    $desc =~ s/[\n\r]+/<br>\n/g;

    my $issue_row;
    
    if(lc($self->get_status()) eq "open")
    {
      $issue_row .= "<tr bgcolor='#c0ffc0'>\n"
    }
    elsif(lc($self->get_status()) eq "closed")
    {
      $issue_row .= "<tr bgcolor='#ffc0c0'>\n";
    }
    else
    {
      $issue_row .= "<tr bgcolor='#ffffc0'>\n";
    }
    $issue_row .= "<td>" . $self->get_id() . "</td>\n";
    $issue_row .= "<td>" . $self->get_title() . "</td>\n";
    $issue_row .= "<td>" . $desc . "</td>\n";
    $issue_row .= "<td>" . $self->get_status() . "</td>\n";
    
    $issue_row .= "<td align='center' valign='center'>\n";
    $issue_row .= "<form action='update_issue_form.pl' method='post'>\n";
    $issue_row .= "<input type='hidden' value='" . $file . "' "
                . "name='file'>\n";
    $issue_row .= "<input type='submit' value='Update'>\n";
    $issue_row .= "</form>\n";
    $issue_row .= "</td>\n";
    
    $issue_row .= "</tr>\n";
}


sub uscc_header
{
  my($self,%args) = @_;
  
  return start_html(-title=>$args{title},
                    -BGCOLOR=>"#e6e6e6")
       . "\n"
       . table({-width=>"100%"},
               Tr({-valign=>"center"},
                  [td({-align=>"center"},
                      [
                       # table cell 1
                       img({src=>"$args{img_href}"}),
                       # table cell 2
                       h2(font({-color=>"#8080ff"},
                               $args{title}
                              ) # font
                         ) #h2
                       . br()
                       . h3(font({-color=>"#ff2080"},
                                 $args{subtitle}
                                ) #font
                           ), #h2
                       #table cell 3
                       img({src=>"$args{img_href}"})
                      ]
                     )# td
                  ]
                 )# Tr
              )# table
       . "\n" . hr() . "\n";
}

1;

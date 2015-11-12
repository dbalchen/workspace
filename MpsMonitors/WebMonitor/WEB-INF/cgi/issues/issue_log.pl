#!/usr/bin/perl

use strict;
use warnings;

use Carp;
use CGI qw(:all);

use Issue;



print header();
print uscc_start_html();

print "Open a ";
print a({-href=>'/~work/monitor_doc/issues/new_issue_form.html'},
        b("New Issue"));
print p();


display_issues();




#$desc =~ s/[\n\r]+/<br>\n/g;
#print "Description: <br><font color='purple'>\n" , $desc , "\n</font><p>\n";

print end_html();

exit;

# Display a nice heading.
sub uscc_start_html
{
  my $html = <<HTML;
<!-- Created with Bluefish http://bluefish.openoffice.nl/ -->
<HTML>
<HEAD>
<TITLE>MPS System Monitor Documentation</TITLE>
<BODY bgcolor="#e6e6e6">
  <table width="100%">
    <tr>
    <td align="left"><img src="/~work/monitor_doc/img/uscc_logo.gif"></td>
    <td>
      <center>
        <h2>
        <font color="#8080ff">MPS System Monitor Issue Log</font>
        </h2>
        <h3><font color="#ff2080">Issues Log</font></h3>
      </center>
    </td>
    <td align="right"><img src="/~work/monitor_doc/img/uscc_logo.gif"></td>
    </tr>
  </table>
  <hr align="center">
HTML
return $html;
}


sub display_issues
{
  
  print "<table width='100%' cellpadding='3'>\n";
  print "<tr bgcolor='#cccccc'>\n";
  print "<td>Issue ID</td>\n";
  print "<td>Issue Title</td>\n";
  print "<td>Description</td>\n";
  print "<td>Status</td>\n";
  print "<td>Update</td>\n";
  print "</tr>\n";
  print "<tr></tr>\n";
  
  my $issue_dir = "./";
  opendir(DIR,$issue_dir)
    or croak "Unable to open directory $issue_dir!\n$!\n";
  my @issue_files = sort(grep /xml$/, readdir(DIR));
  unless(@issue_files)
  {
    print "</table>\n<h2>No issues found</h2>\n";
    return;
  }
  
  for(my $i=$#issue_files; $i>=0; $i--)
  {
    my $issue = Issue->new();
    unless(defined $issue)
    {
      print "could not define issue";
      croak "Issue could not be defined.\n$!\n";
    }

    $issue->read_issue($issue_files[$i]);
    my $desc = $issue->get_desc();
    $desc =~ s/[\n\r]+/<br>\n/g;

    if(lc($issue->get_status()) eq "open")
    {
      print "<tr bgcolor='#c0ffc0'>\n"
    }
    elsif(lc($issue->get_status()) eq "closed")
    {
      print "<tr bgcolor='#ffc0c0'>\n";
    }
    else
    {
      print "<tr bgcolor='#ffffc0'>\n";
    }
    print "<td>" , $issue->get_id() , "</td>\n";
    print "<td>" , $issue->get_title() , "</td>\n";
    print "<td>" , $desc , "</td>\n";
    print "<td>" , $issue->get_status() , "</td>\n";
    
    print "<td align='center' valign='center'>\n";
    print "<form action='update_issue_form.pl' method='post'>\n";
    print "<input type='hidden' value='" , $issue_files[$i] , "' "
        , "name='file'>\n";
    print "<input type='submit' value='Update'>\n";
    print "</form>\n";
    print "</td>\n";
    
    print "</tr>\n";
  }
  
  print "</table>\n";
  closedir(DIR);
}
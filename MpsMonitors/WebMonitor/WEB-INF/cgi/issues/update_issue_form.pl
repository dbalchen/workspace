#!/usr/bin/perl

use strict;
use warnings;

use Carp;
use CGI qw(:all);
use Issue;
use Cwd;

my $file = param("file");
my $issue = Issue->new();
unless(defined $issue)
{
  print "<b>ERROR:</b> Unable to submit issue.\n"; 
  exit;
}
$issue->read_issue($file);

print header();
print uscc_start_html();


print p();
print start_form(-method=>'post',
                 -action=>'update_issue.pl');
print hidden(-name=>'file',
             -default=>$file);
print hidden(-name=>'id', 
             -default=>$issue->get_id);
print "Status: " , popup_menu(-name=>'status',
                              -values=>['open','closed'],
                              -default=>$issue->get_status());
print p();
print "Title: ";
print br();
print textfield(-name=>'title',
                 -value=>$issue->get_title(),
                 -size=>'80',
                 -maxlength=>'120');
print p();
print "Description :";
print br();
print textarea(-name=>'desc',
               -rows=>'16',
               -columns=>'80',
               -value=>$issue->get_desc());
print p();
print reset('Reset Form') , submit("Submit Update");
print end_form();

print start_form(-method=>'post',
                 -action=>'issue_log.pl');
print submit("Cancel");
print end_form();

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
        <h3><font color="#ff2080">Update Issue</font></h3>
      </center>
    </td>
    <td align="right"><img src="/~work/monitor_doc/img/uscc_logo.gif"></td>
    </tr>
  </table>
  <hr align="center">
HTML
return $html;
}


# determine the next issue number
sub determine_id
{
  my $issue_dir = "./";
  opendir(DIR,$issue_dir)
    or croak "Unable to open directory $issue_dir!\n$!\n";
  my @issue_files = sort(grep /xml$/, readdir(DIR));
  unless(@issue_files)
  {
    return 1;
  }
  my $id = @issue_files +1;
  closedir(DIR);
  return $id;
}
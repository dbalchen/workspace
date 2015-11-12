#!/usr/bin/perl

use strict;
use warnings;

use Carp;
use CGI qw(:all);
use Issue;
use Cwd;

my $file = param("file");
my $id = param("id");
my $status = param("status");
my $title = param("title");
my $desc = param("desc");

print header();
print uscc_start_html();

my $issue = Issue->new($id,$status,$title,$desc);
unless(defined $issue)
{
  print "<b>ERROR:</b> Unable to submit issue.\n"; 
  exit;
}

$issue->write_issue($file);

print "Your Issue has been Updated.\n";
print p();
print "<table cellpadding='4'>\n";
print "<tr>\n";
print "<td>Issue Id:</td>\n";
print "<td> $id </td>\n";
print "</tr>\n";
print "<tr>\n";
print "<td>Status:</td>\n";
print "<td> $status </td>\n";
print "</tr>\n";
print "<tr>\n";
print "<td>Issue Title: </td>\n";
print "<td> $title </td>\n";
print "</tr>\n";
print "<tr>\n";
print "<td valign='top'>Description: </td>\n";
$desc =~ s/[\n\r]+/<br>\n/g;
print "<td valign='top'> $desc </td>\n";
print "</tr>\n";
print "</table>\n";

print hr();
print p();
print "Return to <a href='issue_log.pl'>Issue Log</a>.\n";
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
        <h3><font color="#ff2080">Issue Update</font></h3>
      </center>
    </td>
    <td align="right"><img src="/~work/monitor_doc/img/uscc_logo.gif"></td>
    </tr>
  </table>
  <hr align="center">
HTML
return $html;
}


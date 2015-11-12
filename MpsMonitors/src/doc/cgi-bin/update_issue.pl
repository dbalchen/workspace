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

my $issue = Issue->new($id,$status,$title,$desc);
unless(defined $issue)
{
  print "<b>ERROR:</b> Unable to submit issue.\n"; 
  exit;
}

print header();
print $issue->uscc_header(title=>"MPS System Monitor Issue Log",
                          subtitle=>"Update Issue",
                          img_href=>"/~work/monitor_doc/img/uscc_logo.gif"
                         );

$issue->write_issue($file);

print "Your Issue has been Updated.\n";
print p();


print "<table width='100%' cellpadding='3'>\n";
print "<tr bgcolor='#cccccc'>\n";
print "<td>Issue ID</td>\n";
print "<td>Issue Title</td>\n";
print "<td>Description</td>\n";
print "<td>Status</td>\n";
print "<td>Update</td>\n";
print "</tr>\n";
print "<tr></tr>\n";

print $issue->show_issue($file);

print "</table>\n";

print hr();
print p();
print "Return to <a href='issue_log.pl'>Issue Log</a>.\n";
print end_html();

exit;



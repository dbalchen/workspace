#!/usr/bin/perl

use strict;
use warnings;

use Carp;
use CGI qw(:all);

use Issue;

my $issue = Issue->new();
unless(defined $issue)
{
  print "could not define issue";
  croak "Issue could not be defined.\n$!\n";
}

print header();
print $issue->uscc_header(title=>"MPS System Monitor Issue Log",
                          subtitle=>"New Issue Form",
                          img_href=>"/~work/monitor_doc/img/uscc_logo.gif"
                         );
print p();
print "<font size='-1'>
  Please provide a detailed description of the issue encountered
  including the name of the Audit, circumstances in which
  the issue occurred, and the exact time at which the issue was
  discovered.
  <br>
  If applicable, please paste the portion of the monitor log
  pertaining to the issue.
  </font>\n";
print p();
print start_form(-method=>'post',
                 -action=>'new_issue.pl');
print "Title:\n", br();
print textfield(-name=>'title',
                 -value=>"",
                 -size=>'80',
                 -maxlength=>'120');
print p();
print "Description:\n", br();
print textarea(-name=>'desc',
               -rows=>'16',
               -columns=>'80',
               -value=>"");
print p();
print reset('Reset Form') , submit("Submit Issue");
print end_form();

print start_form(-method=>'post',
                 -action=>'issue_log.pl');
print submit("Cancel");
print end_form();

print end_html();

exit;

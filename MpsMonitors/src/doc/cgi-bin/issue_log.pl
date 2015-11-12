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
                          subtitle=>"Issue Log",
                          img_href=>"/~work/monitor_doc/img/uscc_logo.gif"
                         );
print "Open a ";
print a({-href=>'new_issue_form.pl'},
        b("New Issue"));
print p();

display_issues($issue);

print end_html();

exit;


# Reads issue files in a specified directory and displays them in 
# reversed order.
sub display_issues
{
  my $issue = shift;
    
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
    print $issue->show_issue($issue_files[$i]) , "\n";
  }
  
  print "</table>\n";
  closedir(DIR);
}
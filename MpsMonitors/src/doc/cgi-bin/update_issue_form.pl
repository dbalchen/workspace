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
print $issue->uscc_header(title=>"MPS System Monitor Issue Log",
                          subtitle=>"Update Issue Form",
                          img_href=>"/~work/monitor_doc/img/uscc_logo.gif"
                         );


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
#!/usr/bin/perl

use strict;
use warnings;

use Carp;
use CGI qw(:all);
use Issue;
use Cwd;

my $title = param("title");
my $desc = param("desc");
my $id = determine_id();

my $issue = Issue->new($id,"open",$title,$desc);
unless(defined $issue)
{
  print "<b>ERROR:</b> Unable to submit issue.\n"; 
  exit;
}

print header();
print $issue->uscc_header(title=>"MPS System Monitor Issue Log",
                          subtitle=>"New Issue",
                          img_href=>"/~work/monitor_doc/img/uscc_logo.gif"
                         );

if($id < 100 && $id > 10)
{
  $id = "0$id";
}
if($id < 10)
{
  $id = "00$id";
}


my $file = cwd() . "/issue_" . $id . ".xml\n";
$issue->write_issue($file);

print "Your Issue has been submitted.<p>\n";

print "<table width='100%' cellpadding='3'>\n";
print "<tr bgcolor='#cccccc'>\n";
print "<td>Issue ID</td>\n";
print "<td>Issue Title</td>\n";
print "<td>Description</td>\n";
print "<td>Status</td>\n";
print "<td>Update</td>\n";
print "</tr>\n";
print "<tr></tr>\n";
print "<tr bgcolor='#c0ffc0'>\n";
print "<td>" , $id , "</td>\n";
print "<td>" , $title , "</td>\n";
$desc =~ s/[\n\r]+/<br>\n/g;
print "<td>" , $desc , "</td>\n";
print "<td>open</td>\n";
    
print "<td align='center' valign='center'>\n";
print "<form action='update_issue_form.pl' method='post'>\n";
print "<input type='hidden' value='" , $file , "' "
    , "name='file'>\n";
print "<input type='submit' value='Update'>\n";
print "</form>\n";
print "</td>\n";
    
print "</tr>\n";
print "</table>\n";

print hr();
print p();
print "Return to <a href='./issue_log.pl'>Issue Log</a>.\n";
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
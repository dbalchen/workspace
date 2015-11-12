#!/usr/bin/perl

use strict;
use warnings;

use Carp;
use XML::Simple;
use Data::Dumper;

my $issue = XML::Simple->new()->XMLin("issue_001.xml");
print Dumper($issue);

print "id     : " , $issue->{id} , "\n";
print "status : " , $issue->{status} , "\n";

my $file = "./issue_003.xml";
open(ISSUE_FILE, ">$file") 
  or croak "Unable to open file $file for writing!\n$!\n";

my $xml_out =<<XML;
<issue>
  <id>$issue->{id}</id>
  <status>$issue->{status}</status>
  <title>$issue->{title}</title>
  <desc>$issue->{desc}</desc>
</issue>
XML

  print ISSUE_FILE $xml_out;
  
  close(ISSUE_FILE);



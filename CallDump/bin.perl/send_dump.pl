#!/usr/bin/perl

###############################################################################
# script: send_dump.pl
# 
# desc: This script converts an autoplex call dump file into MS Excel format,
#       then prints the name of the created .xls file to STDOUT.
#
# args: $type - aplx or nti.
#       $dumpFile - name of the autoplex call dump file.
#       $email - email address to which to send the .xls file.
#
# returns: (none)
#
# notes: The input file is expected to have an extension '.dat', the script
#        replaces the '.dat' with '.xls' to creatd the Excel file name.
#
# usage: send_dump.pl nti file.dat email@address.com
#
# author: Pete Chudykowski - Tue Feb 24 10:17:37 CST 2004
#
###############################################################################
#Revisions:
#----------------------------------------------------------------------
#   1) Modified to fit the new format required by Subpoena & Cloning
#      for NTI and APLX records.
#       - Charlie Jamieson Thursday, January 27, 2005
#----------------------------------------------------------------------
#   2) Fixed the format for the AAA Record by making sure that we have an 
#      entry for each switch so it does not default to the NTI format.
#      David G. Balchen - 05/16/2005
#----------------------------------------------------------------------
#   3) Modified AAA format for EVDO processing.
#      David Balchen - 04/28/2006
#----------------------------------------------------------------------
#   4) Modified to handle WTXT format 
#      Charlie Jamieson - 03/07/2008
#----------------------------------------------------------------------/users/calldmp5/CallDump2.0/work/4233349992.dat2
#   5) Added the new GSM filetypes.(GNTI,GSMS,GAAA)
#      David Balchen - 07/16/2009
#----------------------------------------------------------------------
#   6) Fixed formatting problems for multiple file types.
#      Amy Schnelle - 11/2010
#----------------------------------------------------------------------
#   7) Increased field size for BSid addition to AAA.
#      Amy Schnelle - 05/2011
###############################################################################


use strict;
use lib "./Spreadsheet:WriteExcel/lib";
use Spreadsheet::WriteExcel;  # Used to create .xls files.
use lib "./MIME";  # Library where the MIME::Lite package is located
use MIME::Lite;  # For sending email.

use constant MAX_ROWS => 33000;

my %special_switches = ("AAA","aaa","MOT","sms","SMS","sms","PTX","pmg","PMG","pmg","QIS","qis","PGW","pgw","TAS","tas");

#$ARGV[0] = "TAS";
#$ARGV[1] = "/home/dbalchen/Desktop/CALLDUMP_REPORT.kpr01scdap_TAS_5154447658_20180419053748.1.dat";
#$ARGV[2] = "dave\@balchen.org";

# Get command line arguments.
my ($switch,$dumpFile,$email) = @ARGV;
unless(defined $switch &&
       defined $dumpFile &&
       defined $email){
  die "Usage: send_dump.pl switch file.dat email\@address.com\n"
}


my ($workbook, $worksheet, $formatTitle, $formatMain);
my $type;
# Prep excel file name.
my $excelFile = $dumpFile;
$excelFile =~ s/dat/xls/;

# Open the input file or die trying.
open(INPUT,$dumpFile) || die "Error while opening file $dumpFile $!";

getNewWB();

if (defined($special_switches{$switch})){
   $type = $special_switches{$switch};
} else {
   $type = "nti";
}

# Determine and validate call dump type.
if($type eq "nti"){
  processNTI();
}elsif($type eq "sms"){
  processSMS();
}elsif($type eq "qis"){
  processQIS();
}elsif($type eq "aaa"){
  processAAA();
}elsif($type eq "pmg"){
  processPMG();
}elsif($type eq "pgw"){
  processPGW();
}elsif($type eq "tas"){
  processTAS();
}
# Clean up.
$workbook->close();
close(INPUT);

# Email results.
#emailSpreadsheet($excelFile,$email);

#unlink("$excelFile");


###############################################################################
# sub: processQIS 
#
# desc: parses the autoplex call dump file and determines which records are  
#       title records and which are data records.  Processes the records 
#       according to their type.
#
# args: (none)
#
# returns: (none)
#
###############################################################################
sub processQIS  {
  # Set column widths
  setCellWidth(19,19,14,19,35,9,9,13,5,5);

  # Loop through the input file records:
  #   Detect if record is a title or a a data line.
  #   Print the record to the excel worksheet.
  # End Loop.
  for(my $row=0; my $line=<INPUT>; $row++) {
     my $col = 0;
     chomp $line;
     my @rec = split(/\s+/,$line);
     # Records beginning with any of the following strings are considered a title.
     if($rec[1] eq "Switch:" || $rec[0] eq "EVENT" ||
       $rec[0] eq "ADJ" || $rec[0] eq "PRC" ||
       $rec[1] eq "MA" || $rec[1] eq "SE" ||
       $rec[1] eq "TA" || $rec[1] eq "4" ||
       $rec[1] eq "7"|| $rec[1] eq "Time:" ||
       $rec[0] eq "\n" || substr($rec[1],1,1) eq "*") {
         $worksheet->write($row,$col,$line,$formatTitle);
     }else{
        # Everything else is considered a data record.
        # Split up the record into an array, so that individual worksheet 
        # cells may be written.
        @rec=processLineQIS ($line);
        foreach my $cell (@rec) {
           $worksheet->write_string($row,$col,$cell,$formatMain);
           $col++;
        }
     }
     #This excel module does not handle files over 7MB, so split into multi files
     if($row == MAX_ROWS){
          $workbook->close();
          emailSpreadsheet($excelFile,$email);
          unlink("$excelFile");
          getNewWB();
          setCellWidth(19,19,14,19,35,9,9,13,5,5);
          $row = 0;
     }
  }
}#end sub processQIS 


###############################################################################
# sub: processLineQIS 
#
# desc: splits an autoplex data record into a format suiable for writing to  
#       the excel worksheet.
#
# args: $line - a data record from an input call dump file.
#
# returns: @rec - formatted record in an array format.
#
###############################################################################
sub processLineQIS {
  my $line = shift;
  # Define length of each consecutive field in a data record.
  my @idx = (0,17,16,13,20,31,9,9,13,5,5);
  my @rec = ();
  my $strt_pos = 0;
  for(my $i=0; $i<$#idx; $i++){
    # Define the field starting position.
    $strt_pos += $idx[$i];
    # Extract an individual cell value from the input record.
    my $cell = substr($line, $strt_pos, $idx[$i+1]);
    $cell =~ s/\s+//;  #gets rid of any leading whitespace characters.
    push(@rec,$cell);
  }
  return @rec;
}

###############################################################################
# sub: processPGW 
#
# desc: parses the PGW call dump file and determines which records are  
#       title records and which are data records.  Processes the records 
#       according to their type.
#
# args: (none)
#
# returns: (none)
#
###############################################################################
sub processPGW {
  # Set column widths
    setCellWidth(20,17,16,13,21,8,8,14,8,23);
  # Loop through the input file records:
  #   Detect if record is a title or a a data line.
  #   Print the record to the excel worksheet.
  # End Loop.
  for(my $row=0; my $line=<INPUT>; $row++) {
     my $col = 0;
     chomp $line;
     my @rec = split(/\s+/,$line);
     # Records beginning with any of the following strings are considered a title.
     if($rec[1] eq "Switch:" || $rec[1] eq "Time:" ||
        $rec[0] eq "\n" || substr($rec[1],1,1) eq "*") {
          $worksheet->write($row,$col,$line,$formatTitle);
     }else{
       # Everything else is considered a data record.
       # Split up the record into an array, so that individual worksheet 
       # cells may be written.
       @rec=processLinePGW ($line);
       foreach my $cell (@rec) {
         $worksheet->write_string($row,$col,$cell,$formatMain);
         $col++;
       }
     }#end inner ifelse
     if($row == MAX_ROWS){
          $workbook->close();
          emailSpreadsheet($excelFile,$email);
          unlink("$excelFile");
          getNewWB();
          setCellWidth(20,17,16,13,21,8,8,14,8,23);
          $row = 0;
     }
  }#end for
}#end sub processPGW


###############################################################################
# sub: processLinePGW 
#
# desc: splits an autoplex data record into a format suiable for writing to  
#       the excel worksheet.
#
# args: $line - a data record from an input call dump file.
#
# returns: @rec - formatted record in an array format.
#
###############################################################################
sub processLinePGW {
  my $line = shift;
  # Define length of each consecutive field in a data record.
  #my @idx = (0,19,19,18,13,15,13,6,10,7,15,20);
  my @idx = (0,20,17,16,13,21,8,8,14,8,23);
  my @rec = ();
  my $strt_pos = 0;
  for(my $i=0; $i<$#idx; $i++){
    # Define the field starting position.
    $strt_pos += $idx[$i];
    # Extract an individual cell value from the input record.
    my $cell = substr($line, $strt_pos, $idx[$i+1]);
    $cell =~ s/\s+//;  #gets rid of any leading whitespace characters.
    push(@rec,$cell);
  }
  return @rec;
}

###############################################################################
# sub: processAAA 
#
# desc: parses the AAA call dump file and determines which records are  
#       title records and which are data records.  Processes the records 
#       according to their type.
#
# args: (none)
#
# returns: (none)
#
###############################################################################
sub processAAA {
  # Set column widths
  #   setCellWidth(19,19,18,13,15,13,6,10,7,15,20);
    setCellWidth(19,20,17,13,15,6,10,5,5,6,22,22);
  # Loop through the input file records:
  #   Detect if record is a title or a a data line.
  #   Print the record to the excel worksheet.
  # End Loop.
  for(my $row=0; my $line=<INPUT>; $row++) {
     my $col = 0;
     chomp $line;
     my @rec = split(/\s+/,$line);
     # Records beginning with any of the following strings are considered a title.
     if($rec[1] eq "Switch:" || $rec[1] eq "Time:" ||
        $rec[0] eq "\n" || substr($rec[1],1,1) eq "*") {
          $worksheet->write($row,$col,$line,$formatTitle);
     }else{
       # Everything else is considered a data record.
       # Split up the record into an array, so that individual worksheet 
       # cells may be written.
       @rec=processLineAAA ($line);
       foreach my $cell (@rec) {
         $worksheet->write_string($row,$col,$cell,$formatMain);
         $col++;
       }
     }#end inner ifelse
     if($row == MAX_ROWS){
          $workbook->close();
          emailSpreadsheet($excelFile,$email);
          unlink("$excelFile");
          getNewWB();
          setCellWidth(19,20,17,13,15,6,10,5,5,6,22);
          $row = 0;
     }
  }#end for
}#end sub processAAA 


###############################################################################
# sub: processLineAAA 
#
# desc: splits an autoplex data record into a format suiable for writing to  
#       the excel worksheet.
#
# args: $line - a data record from an input call dump file.
#
# returns: @rec - formatted record in an array format.
#
###############################################################################
sub processLineAAA {
  my $line = shift;
  # Define length of each consecutive field in a data record.
  #my @idx = (0,19,19,18,13,15,13,6,10,7,15,20);
  my @idx = (0,19,20,17,13,15,6,10,5,5,6,22,22);
  my @rec = ();
  my $strt_pos = 0;
  for(my $i=0; $i<$#idx; $i++){
    # Define the field starting position.
    $strt_pos += $idx[$i];
    # Extract an individual cell value from the input record.
    my $cell = substr($line, $strt_pos, $idx[$i+1]);
    $cell =~ s/\s+//;  #gets rid of any leading whitespace characters.
    push(@rec,$cell);
  }
  return @rec;
}



###############################################################################
# sub: processPMG
#
# desc: parses the AAA call dump file and determines which records are
#       title records and which are data records.  Processes the records
#       according to their type.
#
# args: (none)
#
# returns: (none)
#
###############################################################################
sub processPMG {
  # Set column widths
  setCellWidth(20,21,16,20,20,14,13,8,9,6,6,13);
  # Loop through the input file records:
  #   Detect if record is a title or a a data line.
  #   Print the record to the excel worksheet.
  # End Loop.
  for(my $row=0; my $line=<INPUT>; $row++) {
     my $col = 0;
     chomp $line;
     my @rec = split(/\s+/,$line);

     # Records beginning with any of the following strings are considered a title.
     if($rec[1] eq "Switch:" || $rec[1] eq "Time:" ||
        $rec[0] eq "\n" || substr($rec[0],0,1) eq "M") {
          $worksheet->write($row,$col,$line,$formatTitle);
     }else{
       # Everything else is considered a data record.
       # Split up the record into an array, so that individual worksheet
       # cells may be written.
       @rec=processLinePMG ($line);
       foreach my $cell (@rec) {
         $worksheet->write_string($row,$col,$cell,$formatMain);
         $col++;
       }
     }#end inner ifelse
     if($row == MAX_ROWS){
          $workbook->close();
          emailSpreadsheet($excelFile,$email);
          unlink("$excelFile");
          getNewWB();
          setCellWidth(20,21,16,20,20,14,13,8,9,6,6,13);
          $row = 0;
     }
  }#end for
}#end sub processPMG


###############################################################################
# sub: processLinePMG
#
# desc: splits an autoplex data record into a format suiable for writing to
#       the excel worksheet.
#
# args: $line - a data record from an input call dump file.
#
# returns: @rec - formatted record in an array format.
#
###############################################################################
sub processLinePMG {
  my $line = shift;
  # Define length of each consecutive field in a data record.
  my @idx = (0,20,21,16,20,20,14,13,8,9,6,6,13);
  my @rec = ();
  my $strt_pos = 0;
  for(my $i=0; $i<$#idx; $i++){
    # Define the field starting position.
    $strt_pos += $idx[$i];
    # Extract an individual cell value from the input record.
    my $cell = substr($line, $strt_pos, $idx[$i+1]);
    $cell =~ s/\s+//;  #gets rid of any leading whitespace characters.
    push(@rec,$cell);
  }
  return @rec;
}




###############################################################################
# sub: processTAS
#
# desc: parses the TAS call dump file and determines which records are  
#       title records and which are data records.  Processes the records 
#       according to their type.
#
# args: (none)
#
# returns: (none)
#
###############################################################################
sub processTAS{
  setCellWidth(11,10,8,11,17,17,3,3,3,3,3,3,20,7,32);
  # Loop through the input file records:
  #   Detect if record is a title or a a data line.
  #   Print the record to the excel worksheet.
  # End Loop.
  for(my $row=0; my $line=<INPUT>; $row++) {
     my $col = 0;
     chomp $line;
     my @rec = split(/\s+/,$line);
     # Records beginning with any of the following strings are considered a title.
     if($rec[0] eq "Switch" || $rec[0] eq "Time" ||
         $rec[0] eq "     " ||  
         $rec[0] eq "3W:"    || $rec[0] eq "CW:" || $rec[0] eq "Service" || $rec[0] eq "ARM:" ||
         $rec[0] eq "CFB:" || $rec[0] eq "ISH:" || $rec[0] eq "VMD:" ||
         index($rec[0],"AN:") eq 0 || $rec[0] eq "\n") { 
            $worksheet->write($row,$col,$line,$formatTitle);
     }else{
       # All other records are considered data records.
 
       # Split up the record into an array, so that individual worksheet 
       # cells may be written.
       @rec = processLineTAS($line);
       foreach my $cell (@rec) {
         $worksheet->write_string($row,$col,$cell,$formatMain);
         $col++;
       }#end foreach
     }#end elsif
     if($row == MAX_ROWS){
          $workbook->close();
          emailSpreadsheet($excelFile,$email);
          unlink("$excelFile");
          getNewWB();
          setCellWidth(11,10,8,11,17,17,3,3,3,3,3,3,20,7,32);
          $row = 0;
     }
  }#end for
}#end sub processTAS


###############################################################################
# sub: processLineTAS
#
# desc: splits an TAS data record into a format suiable for writing to the 
#       excel worksheet.
#
# args: $line - a data record from an input call dump file.
#
# returns: @rec - formatted record in an array format.
#
###############################################################################
sub processLineTAS {
  my $line = shift;
  # Define length of each consecutive field in a data record.
  my @idx = (0,11,10,8,11,17,17,3,3,3,3,3,3,20,7,32);
  my @rec = ();
  my $strt_pos = 0;
  for(my $i=0; $i<$#idx; $i++){
    # Define the field starting position.
    $strt_pos += $idx[$i];
    # Extract an individual cell value from the input record.
    my $cell = substr($line, $strt_pos, $idx[$i+1]);
    $cell =~ s/\s+//g;  #gets rid of any whitespace characters.
    push(@rec,$cell);
  }
  return @rec;
}



###############################################################################
# sub: processNTI
#
# desc: parses the NTI call dump file and determines which records are  
#       title records and which are data records.  Processes the records 
#       according to their type.
#
# args: (none)
#
# returns: (none)
#
###############################################################################
sub processNTI{
  # Set column widths
#  setCellWidth(11,10,9,13,12,12,18,15,5,3,3,3,3,5,5,5,5,7);
  setCellWidth(11,10,8,13,11,11,15,15,16,5,3,3,3,3,3,5,5,5,7,12);
  # Loop through the input file records:
  #   Detect if record is a title or a a data line.
  #   Print the record to the excel worksheet.
  # End Loop.
  for(my $row=0; my $line=<INPUT>; $row++) {
     my $col = 0;
     chomp $line;
     my @rec = split(/\s+/,$line);
     # Records beginning with any of the following strings are considered a title.

     if($rec[0] eq "Switch" || $rec[0] eq "Time" ||
         $rec[0] eq "     " ||  
         $rec[0] eq "3W:"    || $rec[0] eq "CW:" || $rec[0] eq "Service" || $rec[0] eq "ARM:" ||
         $rec[0] eq "CFB:" || $rec[0] eq "ISH:" || $rec[0] eq "VMD:" ||
         index($rec[0],"AN:") eq 0 || $rec[0] eq "\n") { 
            $worksheet->write($row,$col,$line,$formatTitle);
     }else{
       # All other records are considered data records.
 
       # Split up the record into an array, so that individual worksheet 
       # cells may be written.
       @rec = processLineNTI($line);
       foreach my $cell (@rec) {
         $worksheet->write_string($row,$col,$cell,$formatMain);
         $col++;
       }#end foreach
     }#end elsif
     if($row == MAX_ROWS){
          $workbook->close();
          emailSpreadsheet($excelFile,$email);
          unlink("$excelFile");
          getNewWB();
          setCellWidth(11,10,8,13,11,11,15,15,16,5,3,3,3,3,3,5,5,5,7,12);
          $row = 0;
     }
  }#end for
}#end sub processNTI


###############################################################################
# sub: processLineNTI
#
# desc: splits an NTI data record into a format suiable for writing to the 
#       excel worksheet.
#
# args: $line - a data record from an input call dump file.
#
# returns: @rec - formatted record in an array format.
#
###############################################################################
sub processLineNTI {
  my $line = shift;
  # Define length of each consecutive field in a data record.
#  my @idx = (0,11,10,8,13,11,11,17,14,5,3,3,3,3,5,5,5,7);
  my @idx = (0,11,10,8,13,11,11,15,15,16,5,3,3,3,3,3,5,5,5,7,12);
  my @rec = ();
  my $strt_pos = 0;
  for(my $i=0; $i<$#idx; $i++){
    # Define the field starting position.
    $strt_pos += $idx[$i];
    # Extract an individual cell value from the input record.
    my $cell = substr($line, $strt_pos, $idx[$i+1]);
    $cell =~ s/\s+//g;  #gets rid of any whitespace characters.
    push(@rec,$cell);
  }
  return @rec;
}

###############################################################################
# sub: processSMS
#
# desc: parses the SMS call dump file and determines which records are  
#       title records and which are data records.  Processes the records 
#       according to their type.
#
# args: (none)
#
# returns: (none)
#
###############################################################################
sub processSMS{
  # Set column widths
  setCellWidth(8,16,17,21,21,6,9);
  # Loop through the input file records:
  #   Detect if record is a title or a a data line.
  #   Print the record to the excel worksheet.
  # End Loop.
  for(my $row=0; my $line=<INPUT>; $row++) {
     my $col = 0;
     chomp $line;
     my @rec = split(/\s+/,$line);
     # Records beginning with any of the following strings are considered a title.
     if($rec[1] eq "Switch:" || $rec[0] eq "Time" ||
        $rec[1] eq "Email" || $rec[1] eq "RECORD" ||
        $rec[2] eq "Non-mobile" || $rec[2] eq "Mobile" ||
        $rec[2] eq "Receipt" || $rec[2] eq "Manual" ||
        $rec[2] eq "Multi-cast" || $rec[1] eq "MSG" ||
        $rec[1] eq "TERM" || $rec[1] eq "109C" ||
        $rec[1] eq "110C" || $rec[1] eq "111C" ||
        $rec[1] eq "112C" || $rec[1] eq "113C" ||
        $rec[1] eq "114C" ||
        $rec[0] eq "\n" || substr($rec[1],1,1) eq "*") {
          $worksheet->write($row,$col,$line,$formatTitle);
     }else{
       # All other records are considered data records.
       # Split up the record into an array, so that individual worksheet 
       # cells may be written.
       @rec = processLineSMS($line);
       foreach my $cell (@rec) {
         $worksheet->write_string($row,$col,$cell,$formatMain);
         $col++;
       }
     }
     if($row == MAX_ROWS){
          $workbook->close();
          emailSpreadsheet($excelFile,$email);
          unlink("$excelFile");
          getNewWB();
          setCellWidth(8,16,17,21,21,6,9);
          $row = 0;
     }
  }
}#end sub processSMS


###############################################################################
# sub: processLineSMS
#
# desc: splits an SMS data record into a format suiable for writing to the 
#       excel worksheet.
#
# args: $line - a data record from an input call dump file.
#
# returns: @rec - formatted record in an array format.
#
###############################################################################
sub processLineSMS {
  my $line = shift;
  # Define length of each consecutive field in a data record.
  my @idx = (0,8,16,17,21,21,6,9);
  my @rec = ();
  my $strt_pos = 0;
  for(my $i=0; $i<$#idx; $i++){
    # Define the field starting position.
    $strt_pos += $idx[$i];
    # Extract an individual cell value from the input record.
    my $cell = substr($line, $strt_pos, $idx[$i+1]);
#    $cell =~ s/\s+//;  #gets rid of any leading whitespace characters.
    push(@rec,$cell);
  }
  return @rec;
}


###############################################################################
# sub: emailSpreadsheet
#
# desc: emails a specified spreadsheet file to a specified address.
#
# args: $excelFile - name [and location] of the file to email.
#       $email - email address to which to mail the file.
#
# returns: (none)
#
###############################################################################
sub emailSpreadsheet{
   my($excelFile,$email) = @_;

   # Email basics.
   my $shortX = (split(/\//,$excelFile))[-1];
   my $subject = "$shortX";
   my $mime_type = 'multipart/mixed';
   my $message = "Attached please find the Call Dump you requested.\n";

   # Initialize the email object.
  my $mime_msg = MIME::Lite->new(To=>$email,
                                  Subject=>$subject,
                                  Type=>$mime_type) or die "Error creating " . 
                                                           "MIME body: $!\n";
   # Add a text message to the email body.
   $mime_msg->attach(Type=>'TEXT',
                     Data=>$message) or die "Error adding text message: $!\n";

   # Attach the test file.
   $mime_msg->attach(Type=>'application/octet-stream',
                     Encoding=>'base64',
                     Path=>$excelFile,
                     Filename=>$excelFile) or die "Error attaching file: $!\n";

   # Send the email.
#   $mime_msg->send();
 }

sub setCellWidth {
  my @width = @_;
  for(my $i=0; $i<@width; $i++) {
    $worksheet->set_column($i,$i,$width[$i]);
  }
}

sub getNewWB(){
   # Create a new Excel workbook.
   $workbook = Spreadsheet::WriteExcel->new($excelFile);

   # Add a worksheet.
   $worksheet = $workbook->addworksheet();

   # Add and define the title format.
   $formatTitle = $workbook->addformat(font=>'courier',
                                       color=>'blue',
                                       align=>'left'); 

   # Add and define the main format
   $formatMain = $workbook->addformat(font=>'courier');
}

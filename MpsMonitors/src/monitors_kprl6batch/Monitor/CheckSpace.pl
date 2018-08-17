#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      CheckSpace.pl
#
# Description: 
#
# Returns:     0 - if successful
#              Non Zero if unsuccessful
#
# Author:      David Balchen - 04/05/2002
#
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for TOPS 
# Author        : David A Smith
# Date          : Tue Jun 11 11:05:09 CDT 2013
#-------------------------------------------------------------------------------

@stuff = `df -h | grep 'var'`;

chomp(@stuff);
print FormatSpace(@stuff)."\n";

@stuff = `df -h | grep 'log'`;

chomp(@stuff);
print FormatSpace(@stuff)."\n";

@stuff = `df -h | grep 'tmp'`;

chomp(@stuff);
print FormatSpace(@stuff)."\n";

@stuff = `df -h | grep 'af'`;

chomp(@stuff);
print FormatSpace(@stuff)."\n";

@stuff = `df -h | grep 'JP_FS'`;

chomp(@stuff);
print FormatSpace(@stuff)."\n";

exit(0);

sub FormatSpace 
{
 local(@INFO) = @_;

 $Return = $INFO[0];
 $lret =  $INFO[1];
 
 $Return = $Return.$lret.";";
 $Return =~ s/  */;/g;
return $Return;

}

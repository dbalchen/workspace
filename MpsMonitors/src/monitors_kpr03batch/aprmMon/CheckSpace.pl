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
# Revision      : TBD
# Description   : Modified for TOPS 
# Author        : David A Smith
# Date          : Fri Aug  3 09:29:41 CDT 2012
#-------------------------------------------------------------------------------

@stuff = `df -h | grep 'user1'`;

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

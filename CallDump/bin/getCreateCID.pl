#! /usr/bin/perl
#####################################################
# script     : getCreateCID.pl
# description: Copy and create the carrier ID file
# author     : David G. Balchen - January 13, 2012
#####################################################
#Revisions:
#####################################################

chdir("/home/calldmp/CallDump2.0/bin");
#chdir($ENV{'CALL_DUMP_BIN_DIR2'});

print STDOUT "getCreateCID.pl: The Copy and Create the Carrier ID file Job\n";
$hh = "ls /cares/mpsm01b/m01/projs/up/physical/switch/gteout/ndc_carrier_id_file* | sort -r";

@output = `$hh`;
chomp(@output);

#$hh = "cp /cares/mpsm01b/m01/projs/up/physical/switch/gteout/ndc_carrier_id_file  ./";

$hh = "cp $output[0] ./ndc_carrier_id_file";
print STDOUT "$hh\n";
system($hh);

$hh = "cat ndc_carrier_id_file | sed 's/  *".'$//g'."' | cut -d".'"," -f3,4 | sort -u > carrierID.dat';
print STDOUT "$hh\n";
system($hh);

$hh = "echo '311220,USCC' >> carrierID.dat";
print STDOUT "$hh\n";
system($hh);

exit(0);

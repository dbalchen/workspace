#! /usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:  start_mps_monitor_pl.pl 
#
#   Desc: This script start the mps web monitors
#
# Author: Dave Balchen  
#         - Fri Oct 10 08:21:37 CDT 2008
#
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for APRM 
# Author        : David A Smith
# Date          : 
#-------------------------------------------------------------------------------

use Cwd;

$Market = $ENV{'TLG_MARKET'};
$abpPath = $ENV{'TLG_UP_ROOT'};
$binPath = $ENV{'TLG_BIN'};
$javaPath = $ENV{'JAVA_HOME'};

$monPath = "$abpPath/monitors";
print "monPath dir: $monPath\n";

$java = "$javaPath/java";
print "java dir   : $java\n";

$dir = cwd;
print "current dir: $dir\n";

chdir "$monPath";
$dir = cwd;
print "monitor dir: $dir\n";

$mainPgm = "com.uscc.monitor.MpsMonitor";
$classpath = "$binPath/xmlParserAPIs.jar:$monPath/MpsMonitors.jar:$monPath/xercesImpl.jar:$binPath/xerces.jar";

$xml = "$monPath/monitor.xml";
$err = "$monPath/mon.err";

$hh = "$java -classpath $classpath $mainPgm $Market $xml > $err 2>&1 &";

print "$hh\n";

exec ($hh);

exit;

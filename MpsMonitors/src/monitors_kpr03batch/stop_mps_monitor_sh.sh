#!/bin/ksh
#===============================================================================
# Name          : stop_mps_monitor_sh.sh
# Description   : haults the web monitor  
# Author        : Dan Koch
# Date          : 23-OCT-2008
#===============================================================================
# Revision      : PR270997
# Description   : Modified for TOPS 
# Author        : David A Smith
# Date          : Thu Jul 26 11:35:48 CDT 2012
#===============================================================================

ExitProcess ()
{
  case $1 in
    "0" ) echo "stop_mps_monitor: Finished successfully."
          exit 0
          ;;
    "1" ) echo " " 
          echo "stop_mps_monitor: NO PID TO KILL "
          echo " "
          exit 0 
          ;;
      * ) echo "stop_mps_monitor: failed Unknown return status."
          exit $1
          ;;
  esac
}

#-------------------------------------------------

pspid=`ps -e ax | grep monitor.xml | grep -v grep | sed 's/^[ ]*//' | cut -f1 -d ' '`

if [ $pspid ]
then
    echo $pspid
    kill -9 $pspid
    ExitProcess 0
else
    ExitProcess 1
fi

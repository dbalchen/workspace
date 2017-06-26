#!/usr/bin/ksh

set -x
MISSING_DIRECTORY="1"
MISSING_FILE="2"
MISSING_VARIABLE="3"
CANNOT_WRITE="4"
PROCESS_RUNNING="5"
CANNOT_FILTER="666"

function error_handler
{
	echo "********************************************************************************"
	case $1 in
		${MISSING_DIRECTORY})
			echo "Directory does not exist: $2" >> /m01/switch/run.log;;
		${MISSING_FILE})
			echo "File does not exist: $2" >> /m01/switch/run.log;;
		${MISSING_VARIABLE})
			echo "Variable is empty: $2" >> /m01/switch/run.log;;
		${CANNOT_WRITE})
			echo "File is not writeable: $2" >> /m01/switch/run.log;;
		${PROCESS_RUNNING})
			echo "Process is already running" >> /m01/switch/run.log;;
		*) 
			echo "any ol error" >> /m01/switch/run.log;;
	esac
	echo "********************************************************************************"
	exit $1
}

date >> /m01/switch/run.log

dt=`date --date='1 days ago' +%Y%m%d`
dt="${dt}0000"

 targets="m01-switchb m03-switchb "
#  targets="m01-switch m03-switchb"

for target in $targets
do
   market=`echo $target | cut -d'-' -f1`
   target_directory=`echo $target | cut -d'-' -f2`

   basedir="/${market}/${target_directory}"
   if [ ! -d ${basedir} ]
   then
      error_handler ${MISSING_DIRECTORY} ${basedir};
   fi

   if [ ! -f ${basedir}/switches.txt ]
   then
      error_handler ${MISSING_FILE} ${basedir}/switches.txt;
   fi

   cd ${basedir}
   . ./switches.txt
   if [ -z ${switches} ] 
   then
      error_handler ${MISSING_VARIABLE} ${switches};
   fi

   # append LTE to the list of switches
   switches="${switches} lte"

   # Check to see if the job is already running
   indicator_file="${basedir}/wedo.pull"
   if [ -f ${indicator_file} ]
   then
      rm ${indicator_file}
      error_handler ${PROCESS_RUNNING};
   else 
      touch -t${dt} ${indicator_file}
      if [ ! -f ${indicator_file} ]
      then
         error_handler ${MISSING_FILE} ${indicator_file};
      fi
   fi

   # make sure log_file is present or we could resend files
   log_file="${basedir}/to_wedo.log"
   if [ ! -f ${log_file} ]
   then
      error_handler ${MISSING_FILE} ${log_file};
   else 
      if [ -w ${log_file} ]
      then
         date >> ${log_file}
      else 
         error_handler ${CANNOT_WRITE}; 
      fi
   fi

   # Check to see if the archive is being created, if so, quit for now
   archive_indicator="${stage_dir}/archive.ind"
   if [ -f ${archive_indicator} ]
   then
      error_handler ${PROCESS_RUNNING};
   fi

   stage_dir="/m01/switch/wedo"
   if [ ! -d ${stage_dir} ]
   then
      error_handler ${MISSING_DIRECTORY} ${STAGE_DIR};
   fi
   if [ ! -w ${stage_dir} ]
   then
      error_handler ${CANNOT_WRITE} ${STAGE_DIR};
   fi
   
   for switch in $switches
   do
      filedir="${basedir}/${switch}"
   
      # make sure directory exists before trying to process it
      if [ -d ${filedir} ] 
      then

         cd ${filedir}

         files=`find . -name "*DAT*" -type f -newer ${indicator_file}`
         for file in $files
         do
            basefile=`basename ${file} .gz`
            grep ${basefile} ${log_file} > /dev/null
            rc=$?
            if [ "$rc" -ne "0" ]
            then
               echo "Processing: $basefile"
               cp ${file} ${stage_dir}
               rc=$?
               if [ "$rc" -ne "0" ]
               then
                  error_handler ${CANNOT_WRITE} ${STAGE_DIR};
               fi
            echo "Filtering: $basefile"
            /m01/switch/wedo/bin/runFilter.pl ${file}
               rc=$?
               if [ "$rc" -ne "0" ]
               then
                error_handler ${CANNOT_FILTER} ${STAGE_DIR};
               fi
#TEMP
#               cp ${file} /m01/switch/wedo_test
#TEMP
               echo ${basefile} >> ${log_file}
            else 
               echo "Skipping: $basefile"
            fi
         done
      fi
   done
   rm -f ${indicator_file}

done
   find /m01/switch/wedo/rejected -name '*' -size 0c -print0 | xargs -0 rm
exit


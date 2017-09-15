#!/usr/bin/ksh

set -x 

MISSING_DIRECTORY="1"
MISSING_FILE="2"
MISSING_VARIABLE="3"
CANNOT_WRITE="4"
PROCESS_RUNNING="5"

function error_handler
{
        echo ""
	echo "********************************************************************************"
	case $1 in
		${MISSING_DIRECTORY})
			echo "Directory does not exist: $2";;
		${MISSING_FILE})
			echo "File does not exist: $2";;
		${MISSING_VARIABLE})
			echo "Variable is empty: $2";;
		${CANNOT_WRITE})
			echo "File is not writeable: $2";;
		${PROCESS_RUNNING})
			echo "Process is already running";;
		*) 
			echo "any ol error";;
	esac
	echo "********************************************************************************"
        echo ""
	exit $1
}

dt=`date +%Y%m%d%H%M%S`
dt1=`date +%Y%m%d`
dt2=`date +%H%M%S`

stage_dir="/m01/switch/wedo"
mft_dir="/m01/switch/mft_to_stage"
archive_log="${stage_dir}/archive.log"

# Check to see if the archive is being created, if so, quit for now
archive_indicator="${stage_dir}/archive.ind"
if [ -f ${archive_indicator} ]
then
   error_handler ${PROCESS_RUNNING};
fi

if [ ! -d ${mft_dir} ]
then
   error_handler ${MISSING_DIRECTORY} ${mft_dir};
fi

if [ ! -w ${mft_dir} ]
then
   error_handler ${CANNOT_WRITE} ${mft_dir};
fi


pairs="pgw-PGW ecs-AAA tas-TAS gsmv-GSMV gsmd-GSMD voice-UFF SDIRI_FCIBER-DIRI ciberdata-DATACBR"
#pairs="SDIRI_FCIBER-DIRI"
cd ${stage_dir}

for file in `ls -1 *.gz`
do
   gunzip -v ${file}
done

for pair in $pairs
do

    tarname=`echo $pair | cut -d'-' -f1`
    filespec=`echo $pair | cut -d'-' -f2`

    archive="${tarname}_${dt}.tar"	
    files=`ls -1 *${filespec}*`
    for file in $files
    do  
    
       # gunzip file if needed
       extension=$(echo ${file}|awk -F\. '{print $3}')
       if [ "$extension" -eq "gz" ]
       then
          gunzip -v ${file}
       fi

       basefile=`basename ${file} .gz`       


       # DETERMINE DROP/BILLEABLE
       type=`head -10 ${basefile} | grep '^DR' | cut -d'|' -f5 | sort  | uniq`
       if [ "$type" -eq "0" ]
       then
          type="BILLEABLE"
       else 
          type="DROP"
       fi
       archive="${type}_${tarname}_${dt}.tar"	
    
    	if [[ $tarname = SDIRI_FCIBER* ]]
    	then
    	archive="${tarname}_${dt1}_${dt2}.tar"	
		fi
		
       gzip ${basefile}
       rc=$?
       if [ "$rc" -ne "0" ]
       then
          error_handler ${CANNOT_WRITE} ${basefile};
       fi

       if [ -f ${archive} ]
       then
          tar -rf ${archive} ${basefile}.gz
       else 
          tar -cf ${archive} ${basefile}.gz
       fi
       rc=$?
    
       if [ "$rc" -ne "0" ]
       then
          error_handler ${CANNOT_WRITE} ${archive};
       fi
       echo "Added: ${basefile} to ${archive}" >> ${archive_log}
    done

    for archive in `ls -1 *${tarname}*.tar`
    do

       if [ -f ${archive} ]
       then
          # gzip ${archive}
#	  echo "0"
#          rc=$?
#          if [ "$rc" -ne "0" ]
#          then
#             error_handler ${CANNOT_WRITE} ${archive};
#          fi
       
          cp ${archive} ${mft_dir}
          rc=$?
          if [ "$rc" -ne "0" ]
          then
             error_handler ${CANNOT_WRITE} ${archive};
          fi
          echo "Moved ${archive} to MFT staging" >> ${archive_log}
          rm -f ${archive}
       fi
    done
    rm -f *${filespec}*
done

exit


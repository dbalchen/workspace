source /apps/ebi/ebiap1/.bashrc
cd /apps/ebi/ebiap1/bin/roamRecon/
dt=`date +%Y%m%d`
/apps/ebi/ebiap1/bin/roamRecon/aprm_report.pl ${dt} 2> /dev/null
exit 0

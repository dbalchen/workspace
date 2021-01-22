source /apps/ebi/ebiap1/.bashrc
cd /apps/ebi/ebiap1/bin/roamRecon/
dt=`date --date='-1 month' +%Y%m%d`
/apps/ebi/ebiap1/bin/roamRecon/intraCompany.py  ${dt} 2> /dev/null
exit 0

'''
Created on Jan 11, 2021
@author: dbalchen
'''
# Oracle Libraries
import cx_Oracle

# libraries used for sending emails
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email.utils import formatdate
from email import encoders

# import Workbook used for writing
from openpyxl import Workbook
from openpyxl.styles import Font

from dateutil.relativedelta import relativedelta
from datetime import datetime

import sys

if __name__ == '__main__':
    pass

timeStamp = "20210115"  # sys.argv[1]

day = timeStamp[6:8]
month = timeStamp[4:6]
monthName = (timeStamp.strptime(timeStamp, '%Y%m%d')).strftime("%B")
year = timeStamp[0:4]

outTimeStamp = datetime.strptime(timeStamp, "%Y%m%d")
outTimeStamp = (outTimeStamp - relativedelta(days=1)).strftime('%Y%m%d')

title = """The Roaming Reconciliation Report for """ + monthName + """ """ + day + """, """ + year 
message = " Attached to this email is the Roaming Reconciliation Report for " + monthName + """ """ + day + """, """ + year + """\nDave"""

# Font setup   
def_font = Font(name='Arial', size=10, color='FF000000', italic=False, bold=False)
bold_font = Font(name='Arial', size=10, color='FF000000', italic=False, bold=True)

sqlDictionary = {}

sqlDictionary["SDIRI_FCIBER"] = """
select
 file_name, identifier, 
 total_records_dch, total_volume_dch, total_charges_dch,
 Total_Records, total_volume, total_charges, 
 (Total_Records - total_records_dch), (total_volume - total_volume_dch ), (total_charges - total_charges_dch),
    dropped_records, duplicates, 
    TC_SEND, rejected_count, rejected_charges, 
    dropped_tc,  dropped_aprm, dropped_aprm_charges, aprm_difference, aprm_total_records, aprm_total_charges,
    tc_send - aprm_total_records , (total_charges - aprm_total_charges),
        abs((total_records_dch - Total_Records)/total_records)*100,
    abs((total_volume_dch - Total_volume)/total_volume)*100,
    abs((total_charges_dch - Total_charges)/total_charges)*100,
    abs((TC_SEND - aprm_total_records)/TC_SEND) * 100,
    abs((total_charges_dch - aprm_total_charges)/aprm_total_charges)*100
from file_summary where usage_type = 'SDIRI_FCIBER' and process_date = to_date(""" + timeStamp + """,'YYYYMMDD')
"""

sqlDictionary["SDATACBR_FDATACBR"] = """ select FILE_NAME,IDENTIFIER, TOTAL_RECORDS_DCH, TOTAL_VOLUME_DCH,ceil(TOTAL_VOLUME_DCH/1024), ceil((TOTAL_VOLUME_DCH/1024)/1024), 
TOTAL_CHARGES_DCH,TOTAL_RECORDS,TOTAL_VOLUME, ceil(TOTAL_VOLUME/1024), ceil((TOTAL_VOLUME/1024)/1024),TOTAL_CHARGES,
 (TOTAL_RECORDS-TOTAL_RECORDS_DCH),TOTAL_VOLUME - TOTAL_VOLUME_DCH, (TOTAL_CHARGES-TOTAL_CHARGES_DCH),
DROPPED_RECORDS, DUPLICATES,TC_SEND, DROPPED_TC,REJECTED_COUNT, REJECTED_CHARGES, 
DROPPED_APRM, DROPPED_APRM_CHARGES, APRM_DIFFERENCE, APRM_TOTAL_RECORDS, APRM_TOTAL_CHARGES,
TC_SEND - APRM_TOTAL_RECORDS, (TOTAL_CHARGES) - APRM_TOTAL_CHARGES,
    abs((total_records_dch - Total_Records)/total_records)*100 ,
    abs((total_volume_dch - Total_volume)/total_volume)*100 ,
    round(abs((total_charges_dch - Total_charges)/total_charges),2)*100 ,
    abs((TC_SEND - aprm_total_records)/TC_SEND) * 100,
    abs((total_charges_dch - aprm_total_charges)/aprm_total_charges) * 100
from file_summary where usage_type = 'SDATACBR_FDATACBR' and process_date = to_date(""" + timeStamp + """,'YYYYMMDD')"""

sqlDictionary["CIBER_CIBER"] = """
  select FILE_NAME, IDENTIFIER, APRM_TOTAL_RECORDS, APRM_TOTAL_CHARGES,
   TOTAL_RECORDS, TOTAL_VOLUME, TOTAL_CHARGES,APRM_DIFFERENCE,(APRM_TOTAL_CHARGES - TOTAL_CHARGES),
   TOTAL_RECORDS_DCH,
   TOTAL_VOLUME_DCH, TOTAL_CHARGES_DCH, (TOTAL_RECORDS - TOTAL_RECORDS_DCH), (TOTAL_VOLUME - TOTAL_VOLUME_DCH),(TOTAL_CHARGES - TOTAL_CHARGES_DCH),
    abs((total_records_dch - Total_Records)/total_records) * 100,
    abs((total_volume_dch - Total_volume)/total_volume) * 100,
    round(abs((total_charges_dch - Total_charges)/total_charges),2) * 100,
    abs((TOTAL_RECORDS - aprm_total_records)/TOTAL_RECORDS) * 100,
    abs((total_charges_dch - aprm_total_charges)/aprm_total_charges) * 100
 from file_summary where usage_type = 'CIBER_CIBER' and process_date = to_date(""" + outTimeStamp + """,'YYYYMMDD')"""

sqlDictionary["DATA_CIBER"] = """
select 
RECEIVER,
APRM_TOTAL_RECORDS,
APRM_TOTAL_CHARGES,
TOTAL_RECORDS,
TOTAL_VOLUME,
TOTAL_CHARGES,
(APRM_TOTAL_RECORDS - TOTAL_RECORDS),
(APRM_TOTAL_CHARGES - TOTAL_CHARGES),
Total_records_dch,
total_volume_dch,
total_charges_dch,
(TOTAL_RECORDS - Total_records_dch),
(TOTAL_VOLUME - total_volume_dch),
(TOTAL_CHARGES - total_charges_dch),
0,
0,
0,
0,
0
from file_summary where usage_type = 'DATA_CIBER' and process_date = to_date(""" + outTimeStamp + """,'YYYYMMDD')"""

sqlDictionary["LTE"] = """
select
FILE_NAME, 
t1.IDENTIFIER, 
t1.sender,
sum(TOTAL_RECORDS_DCH),
sum(TOTAL_VOLUME_DCH),
sum(ceil(TOTAL_VOLUME_DCH/1040)),
sum(ceil((TOTAL_VOLUME_DCH/1040)/1040)) ,
sum(TOTAL_CHARGES_DCH),
sum(TOTAL_RECORDS),
sum(TOTAL_VOLUME),
sum(ceil(TOTAL_VOLUME/1040)) ,
sum(ceil((TOTAL_VOLUME/1040)/1040)) ,
sum(TOTAL_CHARGES) ,
sum(TOTAL_RECORDS_DCH) - sum(TOTAL_RECORDS),
sum(TOTAL_VOLUME_DCH) - sum(TOTAL_VOLUME),
sum(TOTAL_CHARGES_DCH) - sum(TOTAL_CHARGES),
sum(REJECTED_COUNT), 
sum(REJECTED_CHARGES),
sum(DROPPED_APRM), 
sum(DROPPED_APRM_CHARGES),
sum(APRM_TOTAL_RECORDS),
sum(APRM_TOTAL_CHARGES),
sum(TOTAL_RECORDS) - sum(APRM_TOTAL_RECORDS),
sum(TOTAL_CHARGES) - sum(APRM_TOTAL_CHARGES),
(select nvl(sum(total_records),0) from file_summary t2 where usage_type like 'LTE-H' and t2.identifier = t1.identifier and process_date = to_date(""" + timeStamp + """,'YYYYMMDD')) ,
(select nvl(sum(TOTAL_VOLUME),0)  from file_summary t2 where usage_type like 'LTE-H' and t2.identifier = t1.identifier and process_date = to_date(""" + timeStamp + """,'YYYYMMDD')),
(select nvl(sum(TOTAL_CHARGES),0) from file_summary t2 where usage_type like 'LTE-H' and t2.identifier = t1.identifier and process_date = to_date(""" + timeStamp + """,'YYYYMMDD')) ,
(select nvl(sum(total_records),0) from file_summary t2 where usage_type like 'LTE-L' and t2.identifier = t1.identifier and process_date = to_date(""" + timeStamp + """,'YYYYMMDD')) ,
(select nvl(sum(TOTAL_VOLUME),0)  from file_summary t2 where usage_type 
like 'LTE-L' and t2.identifier = t1.identifier and process_date = to_date(""" + timeStamp + """,'YYYYMMDD')) ,
(select nvl(sum(TOTAL_CHARGES),0) from file_summary t2 where usage_type like 'LTE-L' and t2.identifier = t1.identifier and process_date = to_date(""" + timeStamp + """,'YYYYMMDD')),
    abs((sum(total_records_dch) - sum(Total_Records))/NULLIF(sum(total_records),0))*100,
    abs((sum(total_volume_dch) - sum(Total_volume))/NULLIF(sum(total_volume),0))*100,
    abs((sum(total_charges_dch) - sum(Total_charges))/NULLIF(sum(total_charges),0))*100,
    abs((sum(total_records) - sum(aprm_total_records))/NULLIF(sum(total_records),0))*100,
    abs((sum(total_charges_dch) - sum(aprm_total_charges))/NULLIF(sum(aprm_total_charges),0))    *100 
from file_summary t1 
  where t1.usage_type like 'LTE%' and t1.process_date = to_date(""" + timeStamp + """,'YYYYMMDD')
group by FILE_NAME_DCH, FILE_NAME, t1.IDENTIFIER, SENDER"""

sqlDictionary["NLDLT"] = """ 
 select 
 FILE_NAME, 
 IDENTIFIER, 
 SENDER, 
 USAGE_TYPE, 
 TOTAL_RECORDS_DCH, 
 TOTAL_VOLUME_DCH,
 TOTAL_CHARGES_DCH,
 TOTAL_RECORDS,
 TOTAL_VOLUME,
 TOTAL_CHARGES,
 TOTAL_RECORDS_DCH - TOTAL_RECORDS,
 TOTAL_VOLUME_DCH - TOTAL_VOLUME,
 TOTAL_CHARGES_DCH - TOTAL_CHARGES,
 REJECTED_COUNT, 
 REJECTED_CHARGES,
 DROPPED_APRM, 
 DROPPED_APRM_CHARGES,
 APRM_TOTAL_RECORDS,
 APRM_TOTAL_CHARGES,
 TOTAL_RECORDS - APRM_TOTAL_RECORDS,
 TOTAL_CHARGES - APRM_TOTAL_CHARGES,
 0,
 0,
 0,
 0,
 0
from file_summary where usage_type like 'NLDLT%' and process_date = to_date(""" + timeStamp + """,'YYYYMMDD')"""

sqlDictionary["DISP_RM"] = """
select t1.file_name, 
t1.total_records + t2.total_records, t1.total_volume + t2.total_volume, t1.total_charges + t2.total_charges,
t3.total_records, t3.total_volume, t3.total_charges,
t1.total_records + t2.total_records + t3.total_records, t1.total_volume + t2.total_volume + t3.total_volume, t1.total_charges + t2.total_charges + t3.total_charges,
t4.total_records, t4.total_volume, t4.total_charges,
t1.total_records + t2.total_records + t3.total_records - t4.total_records,
t1.total_volume + t2.total_volume + t3.total_volume - t4.total_volume,
t1.total_charges + t2.total_charges + t3.total_charges - t4.total_charges,
abs(((t4.total_records) - (t1.total_records + t2.total_records + t3.total_records))/nullif((t1.total_records + t2.total_records + t3.total_records),0))*100,
    abs(((t4.total_volume) - (t1.total_volume + t2.total_volume + t3.total_volume))/nullif((t1.total_volume + t2.total_volume + t3.total_volume),0))*100,
    abs(((t4.total_charges) - (t1.total_charges + t2.total_charges + t3.total_charges))/nullif((t1.total_charges + t2.total_charges + t3.total_charges),0))*100,
    abs(((t1.total_records + t2.total_records  + t3.total_records) - (t1.total_records + t2.total_records + + t3.total_records))/nullif((t1.total_records + t2.total_records  + t3.total_records),0))*100,
    abs(((t1.total_charges + t2.total_charges + t3.total_charges) - (t4.total_charges))/nullif((t1.total_charges + t2.total_charges + t3.total_charges),0))*100 
from
(select file_name,nvl((select max(total_records) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-S'),0) total_records,
nvl((select max(total_volume) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-S'),0) total_volume,
nvl((select max(total_charges) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-S'),0) total_charges
from file_summary t1 where file_name in (select unique(file_name) from file_summary where  process_date = to_date(""" + outTimeStamp + """,'YYYYMMDD') and usage_type like 'DISP%')
group by file_name) t1,
(select file_name,nvl((select max(total_records) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-H'),0) total_records,
nvl((select max(total_volume) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-H'),0) total_volume,
nvl((select max(total_charges) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-H'),0) total_charges
from file_summary t1 where file_name in (select unique(file_name) from file_summary where  process_date = to_date(""" + outTimeStamp + """,'YYYYMMDD') and usage_type like 'DISP%')
group by file_name) t2,
(select file_name,nvl((select max(total_records) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-L'),0) total_records,
nvl((select max(total_volume) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-L'),0) total_volume,
nvl((select max(total_charges) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-L'),0) total_charges
from file_summary t1 where file_name in (select unique(file_name) from file_summary where  process_date = to_date(""" + outTimeStamp + """,'YYYYMMDD') and usage_type like 'DISP%')
group by file_name) t3, 
(select file_name,nvl((select max(total_records_dch) from file_summary where file_name = t1.file_name),0) total_records,
nvl((select max(total_volume_dch) from file_summary where file_name = t1.file_name ),0) total_volume,
nvl((select max(total_charges_dch) from file_summary where file_name = t1.file_name),0) total_charges
from file_summary t1 where file_name in (select unique(file_name) from file_summary where  process_date = to_date(""" + outTimeStamp + """,'YYYYMMDD') and usage_type like 'DISP%')
group by file_name) t4 
where t1.file_name = t2.file_name and t1.file_name = t3.file_name and t3.file_name = t4.file_name
"""

# sqlDictionary["REJECTED_RECORDS"] = """
# select * from rejected_records t1 where t1.file_name in 
#                     (select unique(t2.file_name) 
#                         from file_summary t2 
#                         where t2.usage_type like '""" + switch + """%' and t2.process_date = to_date(""" + timeStamp + """,'YYYYMMDD'))";
# 
# 
# """

sqlDictionary["DISP_RM_APRM"] = """
select CARRIER_CODE, BP_START_DATE, USAGE_TYPE, RECORD_COUNT, TOTAL_CHARGES, TOTAL_VOLUME from aprm  where usage_type like 'DISP_RM%' and date_processed = to_date(""" + outTimeStamp + """,'YYYYMMDD')
"""

sqlDictionary["LTE_APRM"] = """
select CARRIER_CODE, BP_START_DATE, USAGE_TYPE, RECORD_COUNT, TOTAL_CHARGES, TOTAL_VOLUME from aprm  where usage_type like 'LTE%' and date_processed = to_date(""" + timeStamp + """,'YYYYMMDD')
"""

sqlDictionary["NLDLT_APRM"] = """
select CARRIER_CODE, BP_START_DATE, USAGE_TYPE, RECORD_COUNT, TOTAL_CHARGES, TOTAL_VOLUME from aprm  where usage_type like 'NLDLT%' and date_processed = to_date(""" + timeStamp + """,'YYYYMMDD')
"""

sqlDictionary["DATA_CIBER_APRM"] = """
select CARRIER_CODE, BP_START_DATE, CLEARINGHOUSE, TOTAL_CHARGES, TOTAL_VOLUME,CEIL(TOTAL_VOLUME/1024), CEIL((TOTAL_VOLUME/1024)/1024)  from APRM where usage_type = 'DATA_CIBER' and date_processed = to_date(""" + outTimeStamp + """,'YYYYMMDD')";
"""

# Neeed to check these out one by one...

sqlDictionary["SDATACBR_FDATACBR_APRM"] = """
select CARRIER_CODE,BP_START_DATE, sum(RECORD_COUNT),sum(TOTAL_VOLUME), sum(ceil(TOTAL_VOLUME/1024)),
                 sum(ceil((TOTAL_VOLUME/1024)/1024)),sum(TOTAL_CHARGES)"
              . "       from aprm where usage_type = 'SDATACBR_FDATACBR' and date_processed = to_date(""" + timeStamp + """,'YYYYMMDD') group by  CARRIER_CODE,BP_START_DATE order by CARRIER_CODE
"""

sqlDictionary["SDATACBR_FDATACBR_APRM"] = """
select CARRIER_CODE,BP_START_DATE, sum(RECORD_COUNT),sum(TOTAL_VOLUME), sum(ceil(TOTAL_VOLUME/1024)),
                 sum(ceil((TOTAL_VOLUME/1024)/1024)),sum(TOTAL_CHARGES)"
              . "       from aprm where usage_type = 'SDATACBR_FDATACBR' and date_processed = to_date(""" + timeStamp + """,'YYYYMMDD') group by  CARRIER_CODE,BP_START_DATE order by CARRIER_CODE
"""

sqlDictionary["CIBER_CIBER_APRM"] = """
select CARRIER_CODE,MARKET_CODE, BP_START_DATE, sum(RECORD_COUNT), sum(ceil(TOTAL_VOLUME/60)),sum(TOTAL_CHARGES) from aprm where usage_type = 'CIBER_CIBER' and date_processed = to_date(""" + outTimeStamp + """,'YYYYMMDD') group by  CARRIER_CODE,MARKET_CODE, BP_START_DATE order by CARRIER_CODE";
"""

headings = {}

headings["SDIRI_FCIBER"] = [
    'File Name',
    'Identifier',
    'Total Records DCH',
    'Total Volume DCH (min)',
    'Total Charges DCH ($)',
    'Total Records',
    'Total Volume (min)',
    'Total Charges ($)',
    'Record Count Variance DCH vs. Usage File',
    'Total Volume Variance DCH vs. Usage File (min)',
    'Total Charge Variance DCH vs. Usage File ($)',
    'Dropped Records',
    'Duplicate Records',
    'Records sent to TC',
    'Rejected Record Count',
    'Total Rejected Charges ($)',
    'Dropped TC Records',
    'Dropped APRM Records',
    'Dropped APRM Charges ($)',
    'APRM Duplicates',
    'APRM Total Records',
    'APRM Total Charges ($)',
    'Record Count Variance TC Send vs. APRM',
    'Charge Variance TC Send vs. APRM ($)'
];

headings["SDATACBR_FDATACBR"] = [
    'File Name',
    'Identifier',
    'Total Records DCH',
    'Total Bytes DCH',
    'Total KB DCH',
    'Total MB DCH',
    'Total Charges DCH ($)',
    'Total Records',
    'Total Bytes',
    'Total KB',
    'Total MB',
    'Total Charges ($)',
    'Record Count Variance DCH vs. Usage File',
    'Total Volume Variance DCH vs. Usage File (bytes)',
    'Total Charge Variance DCH vs. Usage File ($)',
    'Dropped Records',
    'Duplicate Records',
    'Records sent to TC',
    'Dropped TC Records',
    'Rejected Record Count',
    'Total Rejected Charges ($)',
    'Dropped APRM Records',
    'Dropped APRM Charges ($)',
    'APRM Duplicates',
    'APRM Total Records',
    'APRM Total Charges ($)',
    'Record Count Variance TC Send vs. APRM',
    'Charge Variance TC Send vs. APRM ($)'
]

headings["CIBER_CIBER"] = [
    'File Name',
    'Identifier',
    'APRM Total Records',
    'APRM Total Charges ($)',
    'Total Records',
    'Total Volume (min)',
    'Total Charges ($)',
    'Total Record Difference (APRM vs. Usage File)',
    'Total Volume Difference (APRM vs. Usage File)',
    'Total Records DCH',
    'Total Volume DCH (min)',
    'Total Charges DCH ($)',
    'Record Count Variance Usage File vs. DCH',
    'Total Volume Variance Usage File vs. DCH ($)',
    'Total Charge Variance Usage File vs. DCH ($)'
];

headings["DATA_CIBER"] = [
    'Clearinghouse',
    'APRM Total Records',
    'APRM Total Charges ($)',
    'Total Records',
    'Total Volume (bytes)',
    'Total Charges ($)',
    'Total Record Difference (APRM vs. Usage File)',
    'Total Charges Difference (APRM vs. Usage File)',
    'Total Records DCH',
    'Total Volume DCH (bytes)',
    'Total Charges DCH ($)',
    'Record Count Variance Usage File vs. DCH',
    'Total Volume Variance Usage File vs. DCH ($)',
    'Total Charge Variance Usage File vs. DCH ($)'
];

headings["LTE"] = [
    'File Name',
    'Identifier',
    'Sender',
    'Total Records DCH',
    'Total Bytes DCH',
    'Total KB DCH',
    'Total MB DCH',
    'Total Charges DCH ($)',
    'Total Records',
    'Total Bytes',
    'Total KB',
    'Total MB',
    'Total Charges ($)',
    'Record Count Variance DCH vs. Usage File',
    'Total Volume Variance DCH vs. Usage File (bytes)',
    'Total Charge Variance DCH vs. Usage File ($)',
    'Rejected Record Count',
    'Total Rejected Charges ($)',
    'Dropped APRM Records',
    'Dropped APRM Charges ($)',
    'APRM Total Records',
    'APRM Total Charges ($)',
    'Record Count Variance TC Send vs. APRM',
    'Charge Variance TC Send vs. APRM ($)',
    'Total Data Records',
    'Total Data Volume Bytes',
    'Total Data Charges',
    'Total VoLTE Records',
    'Total VoLTE Volume Bytes',
    'Total VoLTE Charges'
];

headings["DISP_RM"] = [
    'File Name',
    'Total Data Records',
    'Total Data Volume Bytes',
    'Total Data Charges',
    'Total VoLTE Records',
    'Total VoLTE Volume Bytes',
    'Total VoLTE Charges',
    'Total Records',
    'Total Bytes',
    'Total Charges ($)',
    'Total Records DCH',
    'Total Bytes DCH',
    'Total Charges DCH ($)',
    'Record Count Variance Usage File vs. DCH',
    'Total Volume Variance Usage File vs. DCH (bytes)',
    'Total Charge Variance Usage File vs. DCH ($)'
];

headings["NLDLT"] = [
    'File Name',
    'Identifier',
    'Sender',
    'Usage Type',
    'Total Records DCH',
    'Total Volume DCH',
    'Total Charges DCH ($)',
    'Total Records',
    'Total Volume',
    'Total Charges ($)',
    'Record Count Variance DCH vs. Usage File',
    'Total Volume Variance DCH vs. Usage File',
    'Total Charge Variance DCH vs. Usage File ($)',
    'Rejected Records',
    'Rejected Charges ($)',
    'Dropped APRM Records',
    'Dropped APRM Total Charges ($)',
    'APRM Total Records',
    'APRM Total Charges ($)',
    'Record Count Variance Usage File vs. APRM',
    'Charge Variance Usage File vs. APRM ($)'
];

tab = {}

tab["SDIRI_FCIBER"] = "CDMA Voice Incollect";
tab["SDATACBR_FDATACBR"] = "CDMA Data Incollect";
tab["CIBER_CIBER"] = 'CDMA Voice Outcollect';
tab["DATA_CIBER"] = 'Data Outcollect';
tab["LTE"] = 'LTE Incollect';
tab["DISP_RM"] = 'LTE Outcollect';
tab["NLDLT"] = 'GSM (Incollect)';


def sendMail (xfile, mesg, subject, who):
    
    msg = MIMEMultipart()
    msg['From'] = "david.balchen@uscellular.com"
    msg['To'] = who
    msg['Date'] = formatdate(localtime=True)
    msg['Subject'] = subject
    msg.attach(MIMEText(mesg))

    part = MIMEBase('application', "octet-stream")
    part.set_payload(open(xfile, "rb").read())
    encoders.encode_base64(part)
    part.add_header('Content-Disposition', 'attachment; filename="' + xfile + '"')
    msg.attach(part)

    smtp = smtplib.SMTP("localhost", 25)
    smtp.sendmail("david.balchen@uscellular.com", who, msg.as_string())
    smtp.quit()
    return;


def dbConnect ():
    
#     CONN_INFO = {
#         'host': '10.176.199.19',  # info from tnsnames.ora
#         'port': 1530,  # info from tnsnames.ora
#         'user': 'md1dbal1',
#         'psw': 'Potat000#',
#         'service': 'bodsprd_adhoc'  # info from tnsnames.ora
#     }
#     CONN_STR = '{user}/{psw}@{host}:{port}/{service}'.format(**CONN_INFO)
#   
#     tconn = cx_Oracle.connect(CONN_STR)

#     tconn = cx_Oracle.connect(user='', password='', dsn="BODS_SVC_BILLINGOPS")
    
    return tconn;

excel_file = title + '.xlsx'

wb = Workbook()

# Put stuff here

wb.save(excel_file)

subject = title

# sendTo = ["david.balchen@uscellular.com"]
sendTo = ["david.balchen@uscellular.com", 'Philip.Luzod@uscellular.com', 'ISBillingOperations@uscellular.com', 'Ilham.Elgarni@uscellular.com', 'david.smith@uscellular.com', 'Miguel.Jones@uscellular.com']

for who in sendTo:
    sendMail(excel_file, message, subject, who)
    
SystemExit(0);

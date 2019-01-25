#! /usr/bin/python

# 
import cx_Oracle

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email.utils import formatdate
from email import encoders

# import Workbook used for writing
from openpyxl import Workbook

CONN_INFO = {
    'host': '10.176.199.19',  # info from tnsnames.ora
    'port': 1530,  # info from tnsnames.ora
    'user': 'md1dbal1',
    'psw': 'Bo0Go09000#',
    'service': 'bodsprd_adhoc'  # info from tnsnames.ora
}
 
CONN_STR = '{user}/{psw}@{host}:{port}/{service}'.format(**CONN_INFO)
 
conn = cx_Oracle.connect(CONN_STR)

# conn = cx_Oracle.connect(user='',password='',dsn="BODS_SVC_BILLINGOPS")

cursor = conn.cursor() 

sql = """ select to_char(start_time,'YYYYMMDD'), l9_ip_address, L9_NT_ROAMING_IND, count(*) as RECORDS, SUM(L3_VOLUME) as VOLUME 
From ape1_rated_event where L3_PAYMENT_CATEGORY = 'PRE' and l3_call_source in ('L','D') 
and (start_time >= (sysdate - 31)) and (to_char(start_time,'YYYYMMDD') <  to_char(sysdate,'YYYYMMDD')) 
group by to_char(start_time,'YYYYMMDD'),l9_ip_address, L9_NT_ROAMING_IND order by 2,1,3"""   

# cursor.execute(sql)
results = []
with open("/home/dbalchen/workspace/monitor/src/ipTest.csv", "rb") as fp:
    for i in fp.readlines():
        tmp = i.split("\t")
        try:
            results.append((tmp[0], tmp[1], tmp[2], float(tmp[3]), float(tmp[4])))
        except:pass
# results = cursor.fetchall()

for ip_number in sorted(set(map(lambda x:x[1], results))):
    ipList = [x for x in results if x[1] == ip_number]
    print(ip_number)
    
cursor.close

# connection.commit()
conn.close()

print("Good Bye\n")

SystemExit(0);

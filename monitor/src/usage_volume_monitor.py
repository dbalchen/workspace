#! /usr/bin/python

# Oracle Libraries
import cx_Oracle

# Libraries used for Statistical functions
import pandas as pd
from __builtin__ import int, str
from cx_Oracle import Date


def dbConnect ():
    
    CONN_INFO = {
        'host': '10.176.199.19',  # info from tnsnames.ora
        'port': 1530,  # info from tnsnames.ora
        'user': 'md1dbal1',
        'psw': 'Potat000#',
        'service': 'bodsprd_adhoc'  # info from tnsnames.ora
    }
    CONN_STR = '{user}/{psw}@{host}:{port}/{service}'.format(**CONN_INFO)
  
    tconn = cx_Oracle.connect(CONN_STR)

#    tconn = cx_Oracle.connect(user='', password='', dsn="BODS_SVC_BILLINGOPS")
    
    return tconn;

##############  Main Program  ###################

conn = dbConnect()
cursor = conn.cursor() 

results = []

sql = """
SELECT /*+ parallel (t1,16) */
        t1.l3_payment_category,
         TO_CHAR (TRUNC (t1.sys_creation_date), 'YYYYMMDD'),
         ROUND (SUM (t1.l3_volume / 1024 / 1024 / 1024), 8),
         t1.l9_volume_type,
         t1.event_type_id
    FROM ape1_rated_event t1
   WHERE     t1.event_type_id IN (51, 69)
         AND t1.l3_payment_category IN ('PRE', 'POST')
         AND t1.l9_volume_type IN ('2G', '3G', '4G')
         AND TRUNC (t1.sys_creation_date) BETWEEN TRUNC (SYSDATE - 90)
                                              AND TRUNC (SYSDATE - 1)
GROUP BY t1.l3_payment_category,
         TO_CHAR (TRUNC (t1.sys_creation_date), 'YYYYMMDD'),t1.l9_volume_type,
         t1.event_type_id
ORDER BY 2 ASC
"""

with open("/home/dbalchen/workspace/monitor/src/Test.csv", "rb") as fp:
    for i in fp.readlines():
        tmp = i.split("\t")
        try:
            results.append((str(tmp[0]), str(tmp[1]), float(tmp[2]), str(tmp[3]), int(tmp[4])))
        except:pass

# cursor.execute(sql)
# 
# results = cursor.fetchall()


prePay = [x for x in results if x[0] == 'PRE']

cursor.close

conn.close()

SystemExit(0);


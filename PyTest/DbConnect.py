#! /usr/bin/python

import cx_Oracle

# This is how you define a Hash Table
CONN_INFO = {
    'host': '10.176.199.19', # info from tnsnames.ora
    'port': 1530, # info from tnsnames.ora
    'user': 'md1dbal1',
    'psw': 'Bo0Go09000#',
    'service': 'bodsprd_adhoc' # info from tnsnames.ora
}
 
CONN_STR = '{user}/{psw}@{host}:{port}/{service}'.format(**CONN_INFO)
 
conn = cx_Oracle.connect(CONN_STR)

#conn = cx_Oracle.connect(user='',password='',dsn="BODS_SVC_BILLINGOPS")

cursor = conn.cursor() 

sql = "select * from file_summary where rownum < 20"

cursor.execute(sql)

results = cursor.fetchall()

for r in results:
    print(r[0])
    
cursor.close

# connection.commit()
conn.close()

print("Good Bye\n")

SystemExit(0);

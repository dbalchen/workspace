#! /usr/bin/python3

'''
Created on April 28, 2022
@author: dbalchen

'''
# Oracle Libraries
import cx_Oracle

import fileinput
import sys
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

#sendTo = ["david.balchen@uscellular.com", "Marvin.Guss@uscellular.com", "michael.joseph@uscellular.com", "xavier.lbataille@uscellular.com", "mark.foster@uscellular.com", "gabe.hedstrom@uscellular.com", "dean.schempp@uscellular.com", "Sandra.Fitts@uscellular.com", "olivia.solis@uscellular.com"]
sendTo = ["david.balchen@uscellular.com"]

# Font setup   
def_font = Font(name='Arial', size=10, color='FF000000', italic=False, bold=False)
bold_font = Font(name='Arial', size=10, color='FF000000', italic=False, bold=True)
red_font = Font(name='Arial', size=10, color='00FF0000', italic=True, bold=False)

sqlDictionary = {}


sqlDictionary["IOT_RATE_PLAN"] = """
  SELECT *
  FROM IOT_RATE_PLAN t1,
       (  SELECT t2.start_date, MIN (ABS (t2.start_date - to_date('{this_month}','YYYYMMDD'))) diff
            FROM IOT_RATE_PLAN t2
        GROUP BY t2.start_date) b
 WHERE ABS (t1.start_date - to_date('{this_month}','YYYYMMDD')) = (b.diff)
 and t1.start_date <= to_date('{this_month}','YYYYMMDD')
 and (t1.end_date >= to_date('{this_month}','YYYYMMDD') 
      or t1.end_date is NULL)
 order by TADIG, IMSI_BILLING_TYPE, PLAN_ID, t1.start_date desc
"""

sqlDictionary["IOT_PARTNER"] =  """
select unique(tadig),mvno_name from IOT_PARTNER
"""

sqlDictionary["IOT_IMSI_STATUS"] = """
    select IMSI, TADIG, ACTIVATED_DATE, DEACTIVATED_DATE  from IOT_IMSI_STATUS where ACTIVATED_DATE  >= to_date('{last_month}','YYMMDD') and (DEACTIVATED_DATE <= to_date('{this_month}','YYMMDD') or DEACTIVATED_DATE = '00:00:00')
"""

sqlDictionary["IOT_IMSI_RANGE"] = """
select * from IOT_IMSI_RANGE t1,
 (  SELECT t2.start_date, MIN (ABS (t2.start_date - to_date('{this_month}','YYYYMMDD'))) diff
            FROM IOT_IMSI_RANGE t2
        GROUP BY t2.start_date) b
 WHERE ABS (t1.start_date - to_date('{this_month}','YYYYMMDD')) = (b.diff)
 and t1.start_date <= to_date('{this_month}','YYYYMMDD')
 and (t1.end_date >= to_date('{this_month}','YYYYMMDD') 
      or t1.end_date is NULL) 
order by t1.TADIG, t1.IMSI_BILLING_TYPE, t1.start_DATE desc
"""

sqlDictionary["usage"] = """
select IMSI,TADIG,count(*), sum(TOTAL_CALL_EVENT_DURATION)/60, (sum(DATA_VOLUME_INCOMING)/1024),
       sum(DATA_VOLUME_OUTGOING/1024),sum((DATA_VOLUME_INCOMING/1024) + DATA_VOLUME_OUTGOING/1024),sum(CHARGE) 
 from  {IOT_AGGREGATOR}
 where CALL_EVENT_START_TIMESTAMP >= to_date('{last_month}','YYYYMMDD') and CALL_EVENT_START_TIMESTAMP < to_date('{this_month}','YYMMDD')
 group by IMSI,TADIG  
"""

headings = {}

headings["IoT_IMSI"] = [
"IMSI",
"Total Records",
"Total Session Duration (Minutes)",
"Incoming KB",
"Outgoing KB",
"Total Volume KB",
"Total Record Charges $",
"Plan A Charged Units KB",
"Plan B Charged Units KB"
];

tab = {}
tab["IoT_IMSI"] = "IoT {tadig} by IMSI {onOff}"; 



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
    
    CONN_INFO = {
        'host': '10.180.171.15',  # info from tnsnames.ora
        'port': 1530,  # info from tnsnames.ora
        'user': 'md1dbal1',
        'psw': 'Potat000#',
        'service': 'bodsdev_adhoc'  # info from tnsnames.ora
    }
    CONN_STR = '{user}/{psw}@{host}:{port}/{service}'.format(**CONN_INFO)
  
#    tconn = cx_Oracle.connect(CONN_STR)

    tconn = cx_Oracle.connect(user='', password='', dsn="BODS_SVC_BILLINGOPS")
    
    return tconn;


def printRow (row, font, sheet, max_row, max_col=0): 
    for i in range(0, len(row) - max_col):
        sheet.cell(row=max_row, column=(i + 1)).value = row[i] 
        sheet.cell(row=max_row, column=(i + 1)).font = font
        if i > 2: 
            sheet.cell(row=max_row, column=(i + 1)).number_format = '0.00'             
    return;


def printSheet (title, header, sheet, output, flag=0):
    sheet.title = title
    
    printRow(header, bold_font, sheet, 1)
    max_row = 2 

    for row in output:
        font = def_font

        # Modify fonts here

        printRow(row, font, sheet, max_row, (len(row) - len(header)))
        max_row = max_row + 1 
    return


######################################################################################
# 

if __name__ == '__main__':
    pass

timeStamp = "20220501" # sys.argv[1]

timeStamp = timeStamp[0:6] + "01"

this_month = timeStamp

last_month = datetime.strptime(timeStamp, "%Y%m%d")
last_month = (last_month - relativedelta(months=1)).strftime('%Y%m%d')

day = "1"
month = last_month[4:6]
monthName = (datetime.strptime(last_month, '%Y%m%d')).strftime("%B")
year = last_month[0:4]

title = """The IoT Usage Report for """ + monthName + """ """ + day + """, """ + year 
#message = " Attached to this email is the IoT FloLive Report for " + thisMonth + """ """ + day + """, """ + year + "\n\n"
message = "Attached to this email is the IoT Usage Report for " + monthName + """ """ + day + """, """ + year + "\n\n"

# Open an Excel file for output

excel_file = title + '.xlsx'
wb = Workbook()

# Database

# conn = dbConnect()
# cursor = conn.cursor()
#  
# Do FloLive

iotPartner = []
sql = sqlDictionary["IOT_PARTNER"].format(last_month=last_month, this_month=this_month)
print(sql)
 
# cursor.execute(sql)
# iotPartner = cursor.fetchall()
 
for line in fileinput.input("/home/dbalchen/Desktop/IOT_PARTNER.csv"):
    try:
        line = line.rstrip()
        iotPartner.append(tuple(line.split("\t")))
    except:pass


iot_imsi_range = []
sql = sqlDictionary["IOT_IMSI_RANGE"].format(last_month=last_month, this_month=this_month)
print(sql)
 
# cursor.execute(sql)
# iot_imsi = cursor.fetchall()

for line in fileinput.input("/home/dbalchen/Desktop/IOT_IMSI_RANGE.csv"):
    try:
        line = line.rstrip()
        iot_imsi_range.append(tuple(line.split("\t")))
    except:pass


iot_rate_plan = []
sql = sqlDictionary["IOT_RATE_PLAN"].format(last_month=last_month, this_month=this_month)
print(sql)
 
# cursor.execute(sql)
# iot_rate_plan = cursor.fetchall()

for line in fileinput.input("/home/dbalchen/Desktop/IOT_RATE_PLAN.csv"):
    try:
        line = line.rstrip()
        iot_rate_plan.append(tuple(line.split("\t")))
    except:pass


iot_imsi_status = []
sql = sqlDictionary["IOT_IMSI_STATUS"].format(last_month=last_month, this_month=this_month)
print(sql)
 
# cursor.execute(sql)
# iot_imsi = cursor.fetchall()

for line in fileinput.input("/home/dbalchen/Desktop/IOT_IMSI_STATUS.csv"):
    try:
        line = line.rstrip()
        iot_imsi_status.append(tuple(line.split("\t")))
    except:pass

# MAGIC Happens Here!!!!!!
# •    Check to see if IMSI and TADIG are valid for the month of the report.
# •    From the IoT_Rate_Plan charge the total usage by the appropriate rate plan.
# •    Repeat for each TADIG code.

output = []

usage = []
sql = sqlDictionary["usage"].format(last_month=last_month, this_month=this_month,IOT_AGGREGATOR = 'IOT_AGGREGATOR_ON_NET_USAGE')
print(sql)
 
# cursor.execute(sql)
# usage = cursor.fetchall()

for line in fileinput.input("/home/dbalchen/Desktop/IOT_AGGREGATOR_ON_NET_USAGE.csv"):
    try:
        line = line.rstrip()
        usage.append(tuple(line.split("\t")))
    except:pass



# For each row in the table {list}
# get imsi and using iot_imsi to see if valid

# need to pull TADIG from IoTPartner
# pull from list all IMSI's with that tadig
# rate and format for each imsi than add to output
# Print to output list
# Print out sheet

tadig = 'USAUF'  # example for testing
onOff = 'On Net' # example

# Print Sheet for each Tadig code for both off and onnet
printSheet(tab["IoT_IMSI"].format(tadig=tadig,onOff=onOff ), headings["IoT_IMSI"], wb.create_sheet(tab["IoT_IMSI"].format(tadig=tadig,onOff=onOff )), output, 1);
# Repeat until done


wb.save(excel_file)

# Close database connection

# cursor.close()
 
# conn.close()

#    Send report to our business partners.
for who in sendTo:
    sendMail(excel_file, message, title, who)
    
SystemExit(0);


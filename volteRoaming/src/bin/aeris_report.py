#! /usr/bin/python3

'''
Created on Jan 11, 2021
@author: dbalchen

'''
# Oracle Libraries
import cx_Oracle

import fileinput

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


sendTo = ["david.balchen@uscellular.com"]
#sendTo = ["david.balchen@uscellular.com", 'david.smith@uscellular.com']

# sys.argv[1] = '20210622';

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
        'host': '10.176.199.19',  # info from tnsnames.ora
        'port': 1530,  # info from tnsnames.ora
        'user': 'md1dbal1',
        'psw': 'Poiu#0987',
        'service': 'bodsprd_adhoc'  # info from tnsnames.ora
    }
    CONN_STR = '{user}/{psw}@{host}:{port}/{service}'.format(**CONN_INFO)
   
#    tconn = cx_Oracle.connect(CONN_STR)

    tconn = cx_Oracle.connect(user='', password='', dsn="BODS_DAV_BILLINGOPS")
    
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
        if (flag == 1 and row[0] != "") and ((float(row[len(header)]) > 3.00) or (float(row[len(header) + 1]) > 3.00) or (float(row[len(header) + 2]) > 3.00) or (float(row[len(header) + 3]) > 3.00) or (float(row[len(header) + 4]) > 3.00)):
            font = red_font            
        printRow(row, font, sheet, max_row, (len(row) - len(header)))
        max_row = max_row + 1 
    return

def sumColumn (col, rows):
        column_sum = 0
        for crow in rows:
            if crow[col] != '':
                column_sum += float(crow[col])                
        return column_sum


if __name__ == '__main__':
    pass

timeStamp = sys.argv[1]

day = timeStamp[6:8]
month = timeStamp[4:6]
monthName = (datetime.strptime(timeStamp, '%Y%m%d')).strftime("%B")
year = timeStamp[0:4]

title = """The Aeris Report for """ + monthName + """ """ + day + """, """ + year 
message = " Attached to this email is the Aeris Report for " + monthName + """ """ + day + """, """ + year + "\n\n"

# Open an Excel file for output

# Font setup   
def_font = Font(name='Arial', size=10, color='FF000000', italic=False, bold=False)
bold_font = Font(name='Arial', size=10, color='FF000000', italic=False, bold=True)
red_font = Font(name='Arial', size=10, color='00FF0000', italic=True, bold=False)

excel_file = title + '.xlsx'
wb = Workbook()

# Database
conn = dbConnect()
cursor = conn.cursor()

# Do AAA Processing378004

results = []

cursor.execute(sql)
results = cursor.fetchall()
printSheet("AAA", headings["AAA"], wb.active, results, 1)  

# Do CIBER22

for line in fileinput.input("/home/dbalchen/Desktop/test22.csv"):
    try:
        line = line.rstrip()
            
        results.append(tuple(line.split("\t")))
    except:pass
    
results = []

cursor.execute(sql)
results = cursor.fetchall()

printSheet(tab["CIBER22"], headings["CIBER22"], wb.create_sheet(tab["CIBER22"]), results, 1);

# Do CIBER32
    # Do CIBER22

for line in fileinput.input("/home/dbalchen/Desktop/test22.csv"):
    try:
        line = line.rstrip()
            
        results.append(tuple(line.split("\t")))
    except:pass

results = []

cursor.execute(sql)
results = cursor.fetchall()

printSheet(tab["CIBER32"], headings["CIBER32"], wb.create_sheet(tab["CIBER32"]), results, 1);

wb.save(excel_file)

# Close database connection
cursor.close()
conn.close()


for who in sendTo:
    sendMail(excel_file, message, title, who)
    
SystemExit(0);

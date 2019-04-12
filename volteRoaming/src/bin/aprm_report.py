#! /usr/bin/python

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

######## Argument Date SQL Setup

date = "20190405"  # sys.argv[0]

day = date[6:8]

month = date[4:6]
monthName = (datetime.strptime(date, '%Y%m%d')).strftime("%B")

year = date[0:4]

bp_start_date_LTE = (datetime.strptime(date[0:6] + "01", '%Y%m%d') - relativedelta(months=1)).strftime('%Y%m%d')
bp_start_date_CDMA = (datetime.strptime(date[0:6] + "16", '%Y%m%d') - relativedelta(months=1)).strftime('%Y%m%d')

title = ""

if day == '05':
   title = """APRM CDMA Accrual and 4G Settlement Report for """ + monthName + """ 5th """ + year 
   mess = " Attached to this email is the APRM CDMA Accrual and 4G Settlement Report for " + monthName + " 5th  " + year + ".\n The report covers the Billing Period Start Date of " + bp_start_date_LTE + " for 4G and " + bp_start_date_CDMA + " for CDMA.\n\nDave";
elif day == '22':
     title = """APRM CDMA Settlement Report for  """ + monthName + """ 22nd """ + year 
     mess = " Attached to this email is the APRM CDMA Settlement Report for " + monthName + " 22nd " + year + ".\n The report covers the Billing Period Start Date of " + bp_start_date_CDMA + ".\n\n Dave";
else:
    print("Incorrect date given\nMust be either the 5th or 22nd of the month\n")
    SystemExit(99);

# Font setup   
def_font = Font(name='Arial', size=10, color='FF000000', italic=False, bold=False)
bold_font = Font(name='Arial', size=10, color='FF000000', italic=False, bold=True)
red_font = Font(name='Arial', size=10, color='00FF0000', italic=True, bold=True)

sqlDictionary = {}

sqlDictionary["LTE"] = """
  SELECT TO_CHAR (t1.sys_creation_date, 'YYYY-MM-DD')"Creation Date",
         t1.nr_param_3_val                          "Company Code",
         rate_plan_cd,
         CASE
             WHEN rate_plan_cd LIKE '%VoLTE%' AND t1.prod_cat_id = 'OS'
             THEN
                 '5438002'
             WHEN rate_plan_cd NOT LIKE '%VoLTE%' AND t1.prod_cat_id = 'OS'
             THEN
                 '5438001'
             WHEN rate_plan_cd LIKE '%VoLTE%' AND t1.prod_cat_id = 'IS'
             THEN
                 '6008002'
             WHEN rate_plan_cd NOT LIKE '%VoLTE%' AND t1.prod_cat_id = 'IS'
             THEN
                 '6008001'
             ELSE
                 '0000000'
         END
             AS ascase,
         DECODE (carrier_cd,
                 'USAAT', 'ATT Mobility (USAAT)',
                 'USABS', 'ATT Mobility (USABS)',
                 'USACC', 'ATT Mobility (USACC)',
                 'USACG', 'ATT Mobility (USACG)',
                 'USAMF', 'ATT Mobility (USAMF)',
                 'USAPB', 'ATT Mobility (USAPB)',
                 'USAKY', 'Appalachian Wireless (USAKY)',
                 'USACM', 'C-Spire (USACM)',
                 'USA1E', 'Carolina West (USA1E)',
                 'USAXC', 'Inland (USAXC)',
                 'USAJV', 'James Valley (USAJV)',
                 'USA6G', 'Nex-Tech Wireless (USA6G)',
                 'USAPI', 'Pioneer Cellular (USAPI)',
                 'USASG', 'Sprint (USASG)',
                 'USASP', 'Sprint (USASP)',
                 'USASU', 'Sprint (USASU)',
                 'USATM', 'T-Mobile (USATM)',
                 'USAW6', 'T-Mobile (USAW6)',
                 'USAUW', 'United Wireless (USAUW)',
                 'USAVZ', 'Verizon (USAVZ)',
                 'AAZVF', 'Vodafone Malta (AAZVF)',
                 'MLTTL', 'Vodafone Malta (MLTTL)',
                 'NLDLT', 'Vodafone Netherlands (NLDLT)')
             "Carrier Code",
         t1.prod_cat_id,
         SUM ( (t1.TOT_CHRG_PARAM_VAL / 1024) / 1024)"Total Usage MB",
         SUM (t1.tot_net_usage_chrg)                "Total Charges"
    FROM IC_ACCUMULATED_USAGE t1
   WHERE     (t1.prod_cat_id = 'IS' OR t1.prod_cat_id = 'OS')
         AND t1.BP_START_DATE = TO_DATE ('""" + bp_start_date_LTE + """', 'YYYYMMDD')
GROUP BY TO_CHAR (t1.sys_creation_date, 'YYYY-MM-DD'),
         t1.nr_param_3_val,
         carrier_cd,
         rate_plan_cd,
         t1.prod_cat_id
"""

sqlDictionary["GSM"] = """
SELECT TO_CHAR (t1.sys_creation_date, 'YYYY-MM-DD')"Creation Date",
         t1.nr_param_3_val                          "Company Code",
         t1.rate_plan_CD,
         CASE
             WHEN t1.rate_plan_cd = 'RPINCGSMDATACD' THEN '6008001'
             WHEN t1.rate_plan_cd = 'RPINCGSMSMSCD' THEN '6002202'
             WHEN t1.rate_plan_cd = 'RPINCGSMVOICETOTCD' THEN '6002201'
             ELSE '0000000'
         END
             AS glcode,
         'Vodofone Netherland',
         t1.prod_cat_id,
         CASE
             WHEN t1.rate_plan_cd = 'RPINCGSMDATACD'
             THEN
                 SUM ( (t1.TOT_CHRG_PARAM_VAL / 1024) / 1024)
             ELSE
                 SUM (t1.TOT_CHRG_PARAM_VAL)
         END
             AS usage,
         SUM (t1.tot_net_usage_chrg)
    FROM IC_ACCUMULATED_USAGE t1
   WHERE     t1.prod_cat_id = 'II'
         AND t1.BP_START_DATE = TO_DATE ('""" + bp_start_date_LTE + """', 'YYYYMMDD')
         AND t1.rate_plan_CD IN
                 ('RPINCGSMDATACD', 'RPINCGSMSMSCD', 'RPINCGSMVOICETOTCD')
GROUP BY (t1.sys_creation_date, 'YYYY-MM-DD'),
         t1.nr_param_3_val,
         t1.rate_plan_CD,
         t1.prod_cat_id
ORDER BY t1.sys_creation_date, t1.nr_param_3_val
"""


sqlDictionary["CDMA"] = """

""" 
def printRow (row, font, sheet, max_row):
    
    for i in range(0, len(row)):
        sheet.cell(row=max_row, column=(i + 1)).value = row[i] 
        sheet.cell(row=max_row, column=(i + 1)).font = font 
        sheet.cell(row=max_row, column=(i + 1)).number_format = '0.00' 
    return;

    
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
        'psw': 'Potat000#',
        'service': 'bodsprd_adhoc'  # info from tnsnames.ora
    }
    CONN_STR = '{user}/{psw}@{host}:{port}/{service}'.format(**CONN_INFO)
  
    tconn = cx_Oracle.connect(CONN_STR)

#    tconn = cx_Oracle.connect(user='', password='', dsn="BODS_SVC_BILLINGOPS")
    
    return tconn;


def returnSums (incoming, gl_codes):
    
    sums = []
    
    try:
        sums.append(sum([x[6] for x in incoming]) + 0.00)
        sums.append(sum([x[7] for x in incoming]) + 0.00)
    
        for glcode in gl_codes:
            sums.append(sum([x[6] for x in incoming if x[3] == glcode]) + 0.00)
            sums.append(sum([x[7] for x in incoming if x[3] == glcode]) + 0.00)
    except: pass   
    return sums


def processTableDate (res, gl_codes):
    
    out = []
    all_dates = sorted(set(map(lambda x:x[0], res)))
    
    for date in all_dates:
    
        company_dates = [x for x in res if x[0] == date ]  
    
        all_carrier = sorted(set(map(lambda x:x[1], company_dates))) 
    
        for carrier in all_carrier:
        
            incoming = [x for x in company_dates if x[1] == carrier]
            
            sums = returnSums(incoming, gl_codes)    
               
            out.append((incoming[0][0], incoming[0][1], sums[0], sums[1], gl_codes[0], sums[3], gl_codes[1], sums[5]))
 
    return out


def processTableCarrier (res, gl_codes):
    
    out = []
    company_codes = sorted(set(map(lambda x:x[1], res)))
    
    for company_code in company_codes:
     
        all_carriers = [x for x in res if x[1] == company_code ]
             
        carrier_by_company = sorted(set(map(lambda x:x[4], all_carriers)))
             
        for carrier in carrier_by_company:
                 
            incoming = [x for x in all_carriers if x[4] == carrier]
                 
            sums = returnSums(incoming, gl_codes)
                                 
            out.append((incoming[0][1], carrier, sums[2], sums[3], sums[4], sums[5]))  
             
    return out


def processTable (res, filterby='IS', processType='sum'):
    
    ires = [x for x in res if x[5] == filterby]
    
    gl_codes = sorted(set(map(lambda x:x[3], ires)))
    
    if processType == 'sum':
        out = processTableDate (ires, gl_codes)
    
    elif processType == 'carrier':
        out = processTableCarrier (ires, gl_codes)
        
    else:
        print ("You Broke it!!!!")
        SystemExit(99);
    return out


def printSheet (title, header, sheet, output):
    sheet.title = title
    
    printRow(header, bold_font, sheet, 1)
    max_row = 2 

    for row in output:
        printRow(row, def_font, sheet, max_row)
        max_row = max_row + 1 
    return



###### Main Program  


excel_file = title + '.xlsx'
wb = Workbook()

conn = dbConnect()
cursor = conn.cursor()

results = []

with open("/home/dbalchen/Desktop/aprmTest.csv", "rb") as fp:
    for i in fp.readlines():
        tmp = i.split("\t")
        try:
            results.append((tmp[0], tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], float(tmp[6]), float(tmp[7])))
        except:pass

# cursor.execute(sqlDictionary["LTE"])
# 
# results = cursor.fetchall()

output = processTable(results, 'IS', 'sum')
printSheet('LTE Incollect Settlement', ['Creation Date', 'Carrier Code', 'Total Usage MB', 'Total Charges', 'GL Data', 'Data Charges', 'GL VoLTE', 'VoLTE Charges'], wb.active, output)

output = processTable(results, 'IS', 'carrier')
printSheet('LTE Incollect by Carrier', ['Carrier Code', 'Carrier', 'Total LTE Usage MB', 'Total LTE Charges', 'Total VoLTE Usage MB', 'Total VoLTE Charges'], wb.create_sheet("LTE Incollect by Carrier"), output)

output = processTable(results, 'OS', 'sum')
printSheet('LTE Outcollect Settlement', ['Creation Date','Carrier Code','Total Usage MB','Total Charges','GL Data','Data Charges','GL VoLTE','VoLTE Charges'], wb.create_sheet("LTE Outcollect Settlement"), output)

output = processTable(results, 'OS', 'carrier')
printSheet('LTE Outcollect by Carrier', ['Carrier Code','Carrier','Total LTE Usage MB','Total LTE Charges','Total VoLTE Usage MB','Total VoLTE Charges'], wb.create_sheet("LTE Outcollect by Carrier"), output)

cursor.close
conn.close()

wb.save(excel_file)

message = mess
subject = title
sendTo = ["david.balchen@uscellular.com"]

for who in sendTo:
    sendMail(excel_file, message, subject, who)
    
SystemExit(0);

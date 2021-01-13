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

timeStamp = sys.argv[1]

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
from file_summary where usage_type = 'SDIRI_FCIBER' and process_date = to_date(""" + timeStamp + """,'YYYYMMDD'
"""

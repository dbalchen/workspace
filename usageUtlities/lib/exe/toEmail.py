#!/usr/bin/python

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email.utils import formatdate
from email import encoders

import fileinput
import argparse

# Set-up default variables

sender = "david.balchen@uscellular.com"

email_addresses = "david.balchen@uscellular.com:david.balchen@uscellular.com"

salutation = "It appears we have an issue that needs to be looked into......\n\n\n"

subject = "It's Broke"


def sendMail (mesg, sender, subject, who, attached = None):
    
    msg = MIMEMultipart()
    msg['From'] = sender
    msg['To'] = who
    msg['Date'] = formatdate(localtime=True)
    msg['Subject'] = subject
    msg.attach(MIMEText(mesg))

    if attached != None:
            part = MIMEBase('application', "octet-stream")
            part.set_payload(open(attached, "rb").read())
            encoders.encode_base64(part)
            part.add_header('Content-Disposition', 'attachment; filename="' + attached + '"')
            msg.attach(part)
    
    
    smtp = smtplib.SMTP("localhost", 25)
    smtp.sendmail(sender, who, msg.as_string())
    smtp.quit()
    return;


# initiate the parser

parser = argparse.ArgumentParser()

parser.add_argument("--email_addresses", "-e", help="Comma delimited email list");

parser.add_argument("--salutation", "-s", help="The opening text statement");

parser.add_argument("--sender", "-se", help="Email From");

parser.add_argument("--attachments", "-a", help="comma delimited attachment list");

parser.add_argument("--subject", "-sb", help="Email Subject Line");

args = parser.parse_args()

text = ""

inp = "-"

# inp = "/home/dbalchen/Desktop/testOut.csv"

lineCount = 0

for line in fileinput.input(inp):
    try:
        text = text + line
        lineCount = lineCount + 1
    except:pass

if lineCount <= 1:
    SystemExit(0);

if args.email_addresses:
    email_addresses = args.email_addresses

if args.salutation:
    salutation = str(args.salutation)
    
if args.sender:
    sender = args.sender

    
if args.subject:
    subject = args.subject

attachments = None
if args.attachments:
    attachments = args.attachments
    
       
text = salutation + text

sendTo = email_addresses.split(':') 

for who in sendTo:
    sendMail(text, sender, subject, who, attachments)
    
print("toEmail finished\n")

SystemExit(0);

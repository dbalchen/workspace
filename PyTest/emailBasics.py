#!/usr/bin/python
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email.utils import formatdate
from email import encoders

text = "Email with attachment test"

msg = MIMEMultipart()
msg['From'] = "md1dbal1@localhost"
msg['To'] = "david.balchen@uscellular.com"
msg['Date'] = formatdate(localtime=True)
msg['Subject'] = "Howdy Hoo!!!!!"
msg.attach(MIMEText(text))

part = MIMEBase('application', "octet-stream")
part.set_payload(open("demo.xlsx", "rb").read())
encoders.encode_base64(part)
part.add_header('Content-Disposition', 'attachment; filename="demo.xlsx"')
msg.attach(part)

smtp = smtplib.SMTP("localhost", 25)
smtp.sendmail("md1dbal1@localhost", "david.balchen@uscellular.com", msg.as_string())
smtp.quit()

print("Good Bye\n")

SystemExit(0);

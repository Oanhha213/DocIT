# -*- coding: utf-8 -*-
"""
Created on Tue Jan 31 13:58:13 2023

@author: HaOanh-PC
"""
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
port = 2525 
smtp_server = "smtp.mailtrap.io"

From_email = "oanhha213@gmail.com"
To_email = "oanhha213@gmail.com"
message = MIMEMultipart("alternative")
message["Subject"] = "text/html test"
message["From"] = From_email
message["To"] = To_email
# write the text/plain part
text = """\
Hi,
This is text part testing"""
# write the HTML part
html = """\
<html>
  <body>
    <p>Hi,<br>
       This is html part testing</p>
    <p><a href="https://blog.mailtrap.io/2018/09/27/cloud-or-local-smtp-server">SMTP Server for Testing: Cloud-based or Local?</a></p>
    <p> end html</p>
  </body>
</html>
"""
# convert both parts to MIMEText objects and add them to the MIMEMultipart message
part1 = MIMEText(text, "plain")
part2 = MIMEText(html, "html")
message.attach(part1)
message.attach(part2)
# send your email
with smtplib.SMTP("smtp.mailtrap.io", 2525) as server:
    server.login('ce9313402e70f9', '031fed0dc3632a')
    server.sendmail(From_email, To_email, message.as_string())
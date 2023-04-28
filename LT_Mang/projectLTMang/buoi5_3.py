# -*- coding: utf-8 -*-
"""
Created on Tue Jan 31 14:35:32 2023

@author: HaOanh-PC
"""

import smtplib
# import the corresponding modules
from email import encoders
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

port = 2525 
smtp_server = "smtp.mailtrap.io"

subject = "Test attach file"
From_email = "oanhha213@gmail.com"
To_email = "oanhha213@gmail.com"

message = MIMEMultipart()
message["From"] = From_email
message["To"] = To_email
message["Subject"] = subject

# Add body to email
body = "Test email attach file"
message.attach(MIMEText(body, "plain"))

filename = "fileText.txt"
# Open PDF file in binary mode

# We assume that the file is in the directory where you run your Python script from
with open(filename, "rb") as attachment:
    # The content type "application/octet-stream" means that a MIME attachment is a binary file
    part = MIMEBase("application", "octet-stream")
    part.set_payload(attachment.read())

# Encode to base64
encoders.encode_base64(part)

# Add header 
part.add_header("Content-Disposition",
    f"attachment; filename= {filename}",)

# Add attachment to your message and convert it to string
message.attach(part)
text = message.as_string()

# send your email
with smtplib.SMTP("smtp.mailtrap.io", 2525) as server:
    server.login('ce9313402e70f9', '031fed0dc3632a')
    server.sendmail(From_email, To_email, text)
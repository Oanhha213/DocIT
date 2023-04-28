# -*- coding: utf-8 -*-
"""
Created on Tue Jan 31 14:54:38 2023

@author: HaOanh-PC
"""

import csv,smtplib

port = 2525 
smtp_server = "smtp.mailtrap.io"

mesage = """Subject: Multiple receivers
To: {recipient}
From: {sender}

Multiple receivers testing"""
sender = "oanhha213@gmail.com"
with smtplib.SMTP("smtp.mailtrap.io", 2525) as server:
    server.login('ce9313402e70f9', '031fed0dc3632a')
    with open("fileText.csv") as attachment:
        reader = csv.reader(file)
        next(reader)
        for name,email in reader:
            server.sendmail(sender, email,
               message.format(name=name, recipient=email, sender=sender))
           print(f'Sent to {name}')
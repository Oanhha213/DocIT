# -*- coding: utf-8 -*-
"""
Created on Tue Jan 31 13:20:14 2023

@author: HaOanh-PC
"""
import smtplib

sender = "Oanh Ha <oanhha213@gmail.com>"
receiver = "A Test User <oanhha213@gmail.com>"

message = f"""\
Subject: Test email
To: {receiver}
From: {sender}

This is a test e-mail message 123."""

with smtplib.SMTP("smtp.mailtrap.io", 2525) as server:
    server.login("ce9313402e70f9", "031fed0dc3632a")
    server.sendmail(sender, receiver, message)

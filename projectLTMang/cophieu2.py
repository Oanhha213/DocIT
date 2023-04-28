# -*- coding: utf-8 -*-
"""
Created on Tue Mar 21 14:53:34 2023

@author: Admin
"""

import socket

s=socket.socket()
s.connect(('localhost',1433))

def send_order(stock_name,status,price,quantity):
    order = f"{stock_name},{status},{price},{quantity}"
    s.send(order.encode())
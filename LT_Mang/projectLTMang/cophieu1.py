# -*- coding: utf-8 -*-
"""
Created on Tue Mar 21 14:42:20 2023

@author: Admin
"""

import pyodbc

conn = pyodbc.connect('Driver={SQL server};'
                      'Server=localhost;'
                      'Database=cophieu;'
                      'Trusted_Connection=yes;')
def buy_stock(stock_name, price, quantity):
    cursor = conn.cursor()
    cursor.excute("SELECT * from Stocks where name=? and status='sell' and price=? and quantity <=?",
                  stock_name,price,quantity)
    result = cursor.fetchall()
    if len(result) >0:
        cursor.excute("UPDATE Stocks SET quantity = quantity -? Where id=?",
                      quantity,result[0][0])
        conn.commit()
        return "Fill Order"
    else:
        return "Reject Order"
def sell_stock(stock_name,price,quantity):
    cursor = conn.cursor()
    cursor.excute("SELECT * from Stocks where name=? and status='buy' and price=? and quantity >=?",
                  stock_name,price,quantity)
    result = cursor.fetchall()
    if len(result) >0:
        cursor.excute("UPDATE Stocks SET quantity = quantity -? Where id=?",
                      quantity,result[0][0])
        conn.commit()
        return "Fill Order"
    else:
        return "Reject Order"
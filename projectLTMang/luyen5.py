# -*- coding: utf-8 -*-
"""
Created on Tue Mar 14 09:26:39 2023

@author: Admin
"""

import socket
import os
from _thread import *
sk=socket.socket()
host = '127.0.0.1'
port = 2004

sk.connect((host,port))
data=sk.recv(1024)
print(data.decode("utf-8"))
if __name__ == "__main__":
    while True:
        data = input("Enter message: ")
        sk.send(data.encode("utf-8"))
        if data == "exit":
            sk.send(data.encode("utf-8"))  
            break
        data = sk.recv(2048)
        print(data.decode("utf-8"))
    sk.close()
        
    
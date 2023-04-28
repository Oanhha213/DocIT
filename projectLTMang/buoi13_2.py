# -*- coding: utf-8 -*-
"""
Created on Tue Mar  7 13:33:11 2023

@author: Admin
"""

#client

import socket
host = 'localhost'
port = 2004
sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sk.connect((host, port))
data = sk.recv(2048)
if __name__ == "__main__":
    while True:
        data = input("Nhap lenh: ")
        sk.send(data.encode("utf-8"))
        if data == "bye":
            sk.send(data.encode("utf-8"))
            break
    sk.close()
    
    
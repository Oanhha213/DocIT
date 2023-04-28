# -*- coding: utf-8 -*-
"""
Created on Tue Mar 14 00:02:12 2023

@author: Admin
"""

import socket
if __name__ == "__main__":
    sk=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    host="127.0.0.1"
    port=9050
    sk.connect((host,port))
    with open("fileText.txt", 'rb') as f:
        data = f.read()
        sk.send(data)
        print("File has been sent successfully.")
        result = sk.recv(1024).decode("utf-8")
        print(result)
    sk.close()
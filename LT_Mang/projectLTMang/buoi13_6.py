# -*- coding: utf-8 -*-
"""
Created on Tue Mar  7 14:40:42 2023

@author: Admin
"""

import socket

if __name__=='__main__':
    sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    host = 'localhost'
    port = 2004
    sk.connect((host, port))

    while True:
        response = sk.recv(2048)
        print(response.decode('utf-8'))
        data = input("Enter message: ")
        sk.send(data.encode('utf-8'))
        if data == 'exit':
            sk.recv(2048).decode("utf-8")
            sk.close()
            break;
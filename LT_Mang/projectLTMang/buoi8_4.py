# -*- coding: utf-8 -*-
"""
Created on Thu Feb  9 17:17:28 2023

@author: HaOanh-PC
"""

import socket

if __name__=='__main__':
    host = 'localhost'
    port = 9050
    sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sk.connect((host, port))
    data = sk.recv(1024)
    print(data.decode('utf-8'))
    while True:
        data = 'Hello server'
        sk.send(data.encode('utf-8'))
        data = input("a: ")
        sk.send(data.encode('utf-8'))
        data = sk.recv(1024)
        print(data.decode('utf-8'))


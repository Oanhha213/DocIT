# -*- coding: utf-8 -*-
"""
Created on Mon Mar 13 23:02:41 2023

@author: Admin
"""

import socket
sk = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

host = "localhost"
port = 9050
sk.connect((host,port))
data = sk.recv(1024)
print(data.decode("utf-8"))
if __name__ == "__main__":
    while True:
        data = input("Enter message: ")
        sk.send(data.encode("utf-8"))
        if data == 'exit':
            sk.close()
            break
        data = sk.recv(1024)
        print(data.decode('utf-8'))
    sk.close()
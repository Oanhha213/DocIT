# -*- coding: utf-8 -*-
"""
Created on Mon Mar 13 23:53:47 2023

@author: Admin
"""

import socket
if __name__ == "__main__":
    sk=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    host = "127.0.0.1"
    port = 9050
    sk.bind((host,port))
    
    sk.listen(1)
    print("waiting...")
    client_sk,client_addr=sk.accept()
    print("Client đã kết nối:", client_addr)
    while True:
        data = client_sk.recv(1024)
        with open('fileText.txt', 'wb') as f:
            f.write(data)  
        client_sk.send(b"File received successfully!")
        break
    client_sk.close()
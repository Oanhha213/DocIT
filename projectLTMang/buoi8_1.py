# -*- coding: utf-8 -*-
"""
Created on Thu Feb  9 16:21:14 2023

@author: HaOanh-PC
"""

import socket

if __name__=='__main__':
    sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    host = 'localhost'
    port = 9050
    sk.bind((host,port))
    sk.listen(5)
    print("waiting....")
    client_sk,client_addr = sk.accept()
    data = "Hello client"
    client_sk.send(data.encode("utf-8"))
    while True:
        data = client_sk.recv(1024)
        if data.decode("utf-8") == "bye":
            print(data.decode("utf-8"))
            client_sk.close()
            break
        print(data.decode("utf-8"))
        data = input("Enter Message: ")
        client_sk.send(data.encode("utf-8"))
    sk.close()
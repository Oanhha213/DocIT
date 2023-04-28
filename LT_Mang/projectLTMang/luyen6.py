# -*- coding: utf-8 -*-
"""
Created on Tue Mar 14 09:12:10 2023

@author: Admin
"""

import socket
import os
from _thread import *

sk = socket.socket()
host="localhost"
port=9050
ThreadCount=0
try:
    sk.bind((host,port))
except socket.error as e:
    print(str(e))
print("waiting...")
sk.listen(1)

def multi_thread(client_sk):
    client_sk.send(str.encode("Server is working"))
    while True:
        data = client_sk.recv(1024)
        response = "server message: " + data.decode("utf-8")
        if not data:
            break
        client_sk.sendall(str.encode(response))
    client_sk.close()
    
while True:
    client_sk,client_addr = sk.accept()
    print("Client: " + client_addr[0]+" : "+ str(client_addr[1]))
    start_new_thread(multi_thread, (client_sk,))
    ThreadCount+=1
    print("Thread: " +str(ThreadCount))
sk.close()
        
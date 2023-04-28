# -*- coding: utf-8 -*-
"""
Created on Tue Mar  7 14:24:55 2023

@author: Admin
"""
import socket
import os
from _thread import *
sk = socket.socket()
host = '127.0.0.1'
port = 2004
ThreadCount = 0
try:
    sk.bind((host, port))
except socket.error as e:
    print(str(e))
print('Socket is listening..')
sk.listen(5)
def multi_threaded_client(client_sk):
    global ThreadCount
    count = 0
    client_sk.send(str.encode('Server is working:'))
    while True:
        data = client_sk.recv(2048)
        response = 'Server message: ' + data.decode('utf-8')
        if not data:
            break
        if data.decode('utf-8')=='bye':
            break
        count +=1
        client_sk.sendall(str.encode(response))
    print("Count-message: ", count)
    ThreadCount-=1
    print('Thread Number: ' + str(ThreadCount))
    client_sk.close()
while True:
    Client_sk, address = sk.accept()
    print('Connected to: ' + address[0] + ':' + str(address[1]))
    start_new_thread(multi_threaded_client, (Client_sk, ))
    ThreadCount += 1
    print('Thread Number: ' + str(ThreadCount))
sk.close()

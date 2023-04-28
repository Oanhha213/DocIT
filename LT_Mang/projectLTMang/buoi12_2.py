# -*- coding: utf-8 -*-
"""
Created on Tue Feb 28 14:01:51 2023

@author: Admin
"""

import socket 
import threading
import random

host = 'localhost'
port = 9050

def create_socket(host, port):
    sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sk.bind((host,port))
    sk.listen(5)
    return sk

def create_data(data):
    data = data + '\0'
    data = data.encode('utf-8')
    return data

def send_data(sk, data):
    data1 = create_data(data)
    sk.sendall(data1)
    
def recv_data(sk):
    data = bytearray()
    msg = ''
    while not msg:
        data1 = sk.recv(1024)
        if not data1:
            raise ConnectionError()
        data = data + data1
        if b'\0' in data1:
            msg = data.rstrip(b'\0')
    msg = msg.decode('utf-8')
    return msg
        
def process_client(sk, addr):
    try:
        msg = recv_data(sk)
        loto = msg.split(" ")
        if loto[0] == 'loto':
            count = int(loto[1])
        response = []
        for i in range(count):
            response.append(random.randint(0, 99))
        msg = str(response)
        print('{}:{}'.format(addr, msg))
        send_data(sk, msg)
    except ConnectionError as e:
        print("Error",e)
    finally:
        sk.close()
        
if __name__ == '__main__':
    sk1 = create_socket(host, port)
    local_address = sk1.getsockname()
    print('local address: {}'.format(local_address))
    t = []  
    while True:
        client_sk, client_address = sk1.accept()
        t.append(threading.Thread(target=process_client,args=(client_sk, client_address), daemon=True))
        t[-1].start()
        print("connect from {}".format(client_address))
    for z in t:
        z.join()
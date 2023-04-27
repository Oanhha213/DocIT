# -*- coding: utf-8 -*-
"""
Created on Tue Feb 28 13:08:05 2023

@author: Admin
"""

import socket
import threading

host = "localhost"
port = 9050

def create_socket(host, port):
    sk = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    sk.bind((host, port))
    sk.listen(5) 
    return sk

def create_data(data):
    data = data +"\0" #blank
    data = data.encode("utf-8")
    return data

def send_data(sk,data):
    data1 = create_data(data)
    sk.sendall(data1)

def handle_client(client_sk, client_addr):
    try:
        data = recv_data(client_sk)
        print("{}:{}".format(client_addr, data))
        send_data(client_sk, data)
    except ConnectionError:
        print("Error")
    finally:
        client_sk.close()

def recv_data(sk):
    data = bytearray()
    msg = ""
    while not msg:
        data1 = sk.recv(1024)
        if not data1:
            raise ConnectionError()
        data = data + data1
        if b"\0" in data1:
            msg = data.rstrip(b"\0")
    msg = msg.decode("utf-8")
    return msg

if __name__ == "__main__":
    sk1 = create_socket(host, port)
    local_addr = sk1.getsockname()
    print("Local address: {}".format(local_addr))
    while True:
        client_sk, client_addr = sk1.accept()
        print("client address: {}".format(client_addr))
        client_thread = threading.Thread(target=handle_client, args=(client_sk, client_addr), daemon=True)
        client_thread.start()
        print("connect from {}".format(client_addr))

# -*- coding: utf-8 -*-
"""
Created on Tue Feb 21 13:41:53 2023

@author: HaOanh-PC
"""

#client
import socket
host = 'localhost'
port = 9050

def create_data(data):
    data = data +"\0" #blank
    data = data.encode("utf-8")
    return data

def send_data(sk,data):
    data1 = create_data(data)
    sk.sendall(data1)
    
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

if __name__ == '__main__':
    while True:
        try:
            sk = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
            sk.connect((host,port))
            data = input("Nhap du lieu(exit de thoat): ")
            if data == "exit":
                break
            send_data(sk,data)
            print("Sent: {}".format(data))
            data = recv_data(sk)
            print("Server send: {}".format(data))
        except ConnectionError:
            print("Error")
        finally:
            sk.close()



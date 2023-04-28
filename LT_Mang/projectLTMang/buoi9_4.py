# -*- coding: utf-8 -*-
"""
Created on Tue Feb 14 14:16:05 2023

@author: HaOanh-PC
"""
#client
import socket
sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
host = "127.0.0.1"
port = 9050
if __name__ == "__main__":
    sk.connect((host, port))
    data = sk.recv(1024)
    print(data.decode("utf-8"))
    data = "Hello server"
    sk.send(data.encode("utf-8"))
    while True:
        data = input("Nhap lenh: ")
        if data == "bye":
            sk.send(data.encode("utf-8"))
            break
        sk.send(data.encode("utf-8"))
        data = sk.recv(1024)
        print(data.decode("utf-8"))
    sk.close()
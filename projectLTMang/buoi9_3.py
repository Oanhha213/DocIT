# -*- coding: utf-8 -*-
"""
Created on Tue Feb 14 14:15:58 2023

@author: HaOanh-PC
"""
#server
import socket
from time import ctime
if __name__ == "__main__":

    sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    host = "127.0.0.1"
    port = 9050
    sk.bind((host, port))
    sk.listen(1)  
    print("Server đang chờ kết nối...")
    while True:
        client_sk, client_addr = sk.accept()
        print("Client đã kết nối:", client_addr)
        data = "Hello client"
        client_sk.send(data.encode("utf-8"))
        data = client_sk.recv(1024)
        print(data.decode("utf-8"))
        while True:
            data = client_sk.recv(1024)
            if not data or data.decode("utf-8") == "bye":
                break
            if data.decode("utf-8") == "GET TIME":
                print("receive : %s"%data.decode("utf-8"))
                client_sk.send(bytes(ctime(),"utf-8"))
            else:
                print("receive : %s"%data.decode("utf-8"))
                client_sk.send(data)
        client_sk.close()
    sk.close()
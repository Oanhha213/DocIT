# -*- coding: utf-8 -*-
"""
Created on Tue Feb 14 13:21:44 2023

@author: HaOanh-PC
"""
#server
import socket

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
        data = client_sk.recv(1024)
        filename = "fileText.txt"
        file = open(filename, "rb")
        l = file.read(1024)
        while (l):
            client_sk.send(l)
            print("sent: ", repr(l))
            l= file.read(1024)
        file.close()
        print("Done")
        data = "finished"
        client_sk.send(data.encode("utf-8"))
        client_sk.close()
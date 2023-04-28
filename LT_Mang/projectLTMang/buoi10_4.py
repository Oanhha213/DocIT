# -*- coding: utf-8 -*-
"""
Created on Thu Feb 16 17:04:38 2023

@author: HaOanh-PC
"""

#client
import socket
if __name__ == '__main__':
    sk = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    data = "Hello server"
    sk.sendto(data.encode(), ("127.0.0.1", 9050))
    data, client_addr = sk.recvfrom(1024)
    print(data.decode("utf-8"))
    while True:
        data = input("Nhap lenh: ")
        if data == "bye":

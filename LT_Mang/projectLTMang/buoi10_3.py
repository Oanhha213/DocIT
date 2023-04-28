# -*- coding: utf-8 -*-
"""
Created on Thu Feb 16 16:55:09 2023

@author: HaOanh-PC
"""

#server
import socket
if __name__ == '__main__':
    sk = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sk.bind(('127.0.0.1', 9050))
    while True:
        data, client_addr = sk.recvfrom(1024)
        print(data.decode("utf-8"))
        data = "hello client"
        sk.sendto(data.encode("utf-8"), client_addr)
        if data.decode("utf-8") == "bye":
            break
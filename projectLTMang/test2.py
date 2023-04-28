# -*- coding: utf-8 -*-
"""
Created on Thu Jan  5 11:08:27 2023

@author: HaOanh-PC
"""
import socket

if __name__=='__main__':
    hostname=socket.gethostname()
    print(hostname)
    ip_addr = socket.gethostbyname(hostname)
    print(ip_addr)
    print(socket.gethostbyname_ex('www.google.com'))
    print(socket.gethostbyaddr('8.8.8.8'))
    print(socket.getfqdn('www.google.com'))
    print(socket.getaddrinfo('www.google.com', None,0,socket.SOCK_STREAM))

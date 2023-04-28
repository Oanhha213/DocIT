# -*- coding: utf-8 -*-
"""
Created on Thu Feb 16 16:06:58 2023

@author: HaOanh-PC
"""
#thêm để client gõ bye thì thoát
#client
import socket

if __name__ == '__main__':
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect(('localhost', 9050))
    data = input("Enter a string: ")
    client_socket.sendall(data.encode('utf-8'))

    result = client_socket.recv(1024)
    result = result.decode('utf-8')
    print(result)

    client_socket.close()


# -*- coding: utf-8 -*-
"""
Created on Thu Feb 16 15:55:51 2023

@author: HaOanh-PC
"""

#server
import socket

def normalize_string(s):
    s = s.strip()
    s = s.capitalize()
    s = " ".join(s.split())
    s = s.replace(" ,", ",")
    s = s.replace(" .", ".")
    return s

if __name__ == '__main__':
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind(('localhost', 9050))
    server_socket.listen(1)
    print('Server is ready to receive')

    while True:
        conn, addr = server_socket.accept()
        print(f"Connection from {addr} has been established.")

        data = conn.recv(1024)
        data = data.decode('utf-8')
        result = normalize_string(data)
        conn.sendall(result.encode('utf-8'))

        conn.close()




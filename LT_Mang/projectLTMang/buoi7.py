# -*- coding: utf-8 -*-
"""
Created on Tue Feb  7 13:25:57 2023

@author: HaOanh-PC
"""


import socket
import sys
if __name__ == "__main__":
    try:
        sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    except socket.error as e:
        print("Fail to create socket")
        print(str(e))
        sys.exit()
    print("Socket created")
    host = "www.python.org"
    port = "80"
    try:
        sk.connect((host, int(port)))
        print("Socket connect %s port %s"%(host, port))
        #sk.shutdown(1)
    except socket.error as e:
        print("Fail to connect")
        print(str(e))
        sys.exit()
    while True:
        data = "GET / HTTP/1.0\r\n\r\n"
        sk.send(data.encode("utf-8"))
        data = sk.recv(4096)
        print(data.decode("utf-8"))
    sk.close()
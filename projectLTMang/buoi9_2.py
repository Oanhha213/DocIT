# -*- coding: utf-8 -*-
"""
Created on Tue Feb 14 13:37:55 2023

@author: HaOanh-PC
"""
#client
import socket

if __name__ == "__main__":
    sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    host = "127.0.0.1"
    port = 9050
    sk.connect((host, port))
    data = "Hello server"
    sk.send(data.encode("utf-8"))
    filename = "fileText.txt"
    with open(filename,"wb") as file :
        print("file opened")
        while True:
            print("Receiving...")
            data = sk.recv(1024)
            print("data %s", (data))
            if not data:
                break
            file.write(data)
    file.close()
    data = sk.recv(1024)
    print(data.decode("utf-8"))
    sk.close()

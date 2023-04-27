# -*- coding: utf-8 -*-
"""
Created on Mon Mar 13 21:38:32 2023

@author: Admin
"""

import socket
if __name__ == "__main__":
    sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    host = 'localhost'
    port = 9050
    sk.bind((host,port))
    sk.listen(5)
    print("waiting....")
    client_sk,client_addr = sk.accept()
    data = "Hello client"
    client_sk.send(data.encode("utf-8"))
    while True:
        print("Client: {}".format(client_addr))
        data = client_sk.recv(1024)
        data = data.decode("utf-8")
        if data == "bye":
            print(data)
            client_sk.close()
            break
        result = data[::-1]
        client_sk.send(result.encode("utf-8"))
        
    client_sk.close()
    
    
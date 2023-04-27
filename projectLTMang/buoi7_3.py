# -*- coding: utf-8 -*-
"""
Created on Tue Feb  7 14:37:01 2023

@author: HaOanh-PC
"""
        
import socket
import sys
if __name__=='__main__':
    try:
        sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    except socket.error as e:
        print('Fail to create socket')
        print(str(e))
        sys.exit()
    print('Socket created')
    host = 'localhost'
    port = '9050'
    try:
        sk.connect((host, int(port)))
        print('Socket connect %s port %s'%(host, port))
        #sk.shutdown(1)
    except socket.error as e:
        print('Fail to connect')
        print(str(e))
        sys.exit()
    while True:
        
        data = sk.recv(4096)
        if not data:
            break
        print(data.decode('utf-8'))
    sk.close()
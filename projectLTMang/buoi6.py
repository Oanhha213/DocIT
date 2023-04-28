# -*- coding: utf-8 -*-
"""
Created on Thu Feb  2 16:23:54 2023

@author: HaOanh-PC
"""

import ftplib

ftp = ftplib.FTP('192.168.65.230')
ftp.login('oanh','123')
filename = 'testdowload2.txt'
ftp.encoding = 'utf-8'
#with open(filename, 'rb') as f:
with open(filename, 'wb') as f:
    #ftp.storbinary(f'STOR {filename}',f)
    res = ftp.retrlines(f'RETR {filename}', f.write)
data = []
ftp.dir(data.append)
ftp.quit()
for i in data:
    print(i)
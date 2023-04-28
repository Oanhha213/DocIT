# -*- coding: utf-8 -*-
"""
Created on Thu Jan  5 16:14:25 2023

@author: HaOanh-PC
"""

from urllib.request import urlopen

from urllib.request import Request
import gzip
if __name__=='__main__':
    # tạo đối tượng request
    req=Request('https://www.debian.org/')
    #req.add_header('Accept-Language', 'en')
    req.add_header('Accept-Encoding', 'gzip')
    r=urlopen(req)
    a=r.read()
    print(a)
    a1=gzip.decompress(a)
    print(a1)
    #print(r.read())
    #print(r.status)
    print(r.getheaders())

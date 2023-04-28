# -*- coding: utf-8 -*-
"""
Created on Tue Jan 10 20:06:11 2023

@author: HaOanh-PC
"""

from urllib.request import Request
from urllib.request import urlopen
import requests
if __name__=='__main__':
    #url = 'https://api.github.com/user'
    #url = 'https://www.gmail.com'
    query = {'q':'river','order':'popular','min_width':'800','min_heigh':'600'}
    url = 'https://www.pixabay.com/en/photos/'
    req=requests.get(url,params=query)
    #req=Request(url)
    #req ={'somekey':'somevalue'}
    #r = requests.get(url)
    #r=requests.post(url,json=req)
    #r = requests.get(url, auth=('user','pass'))
    #r=urlopen(req)
    #print(req.redirect_dict) 
    print(req.url)
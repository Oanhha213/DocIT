# -*- coding: utf-8 -*-
"""
Created on Thu Jan  5 17:09:47 2023

@author: HaOanh-PC
"""

from http.cookiejar import CookieJar
from urllib.request import build_opener, HTTPCookieProcessor
import datetime
if __name__=='__main__':
    #tạo đối tượng để lưu
    cookie_jar=CookieJar()
    #sử dụng builder để tự động lấy cookie
    opener = build_opener(HTTPCookieProcessor(cookie_jar))
    #dùng opener để tạo http request
    opener.open('http://www.github.com')
    cookies = list(cookie_jar)
    print(len(cookies))
    print(cookies)
    print(cookies[0].name)
    print(cookies[0].value)
    print(cookies[0].expires)
    print(cookies[0].domain)
    print(cookies[0].secure)
    print(datetime.datetime.fromtimestamp(cookies[0].expires))
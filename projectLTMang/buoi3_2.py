# -*- coding: utf-8 -*-
"""
Created on Tue Jan 10 20:23:59 2023

@author: HaOanh-PC
"""

from bs4 import BeautifulSoup
import requests
if __name__=='__main__':
    headers = requests.utils.default_headers()
    #url='http://example.com'
    url='https://forecast.weather.gov/MapClick.php?lat=44.12519983400006&lon=-84.19669749999997#.Y71ow3ZBxPY'
    req= requests.get(url,headers)
    s=BeautifulSoup(req.content,'html.parser')
    #print(s.prettify())
    ngay=s.find(id='seven-day-forecast')
    dubao=ngay.find_all(class_='tombstone-container')
    today = dubao[0]
    img = today.find('img')
    mota = img['title']
    print(mota)  
    tags = s.find(id='current_conditions_detail')
    tags = s.find_all('tr')
    for i in tags:
        name = i.find('b').text
        td = i.find_all('td')
        value = td[1].text
        print('{}:{}'.format(name,value)) #không biết định dạng thì dùng format
    #2 cách
    """
    d = [0,1,2,3,4,5,6,7,8]
    for i in d:
        today = dubao[i]
        period = today.find(class_='period-name').get_text()
        shortdesc = today.find(class_='short-desc').get_text()
        temp = today.find(class_='temp').get_text()
        print(period)
        print(shortdesc)
        print(temp)
    """
    d = []
    for i in range(len(dubao)-1):
        period = dubao[i].find(class_='period-name').get_text()
        shortdesc = dubao[i].find(class_='short-desc').get_text()
        temp = dubao[i].find(class_='temp').get_text()
        img = dubao[i].find('img')['title']
        d.append((period, shortdesc,temp,img))
    for i in range(len(d)-1):
        print(d[i])
    images = s.find_all('img')
    print('total image: ',len(images))
    for i in images:
        print(i['src'])
    
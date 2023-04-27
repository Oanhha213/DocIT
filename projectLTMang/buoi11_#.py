# -*- coding: utf-8 -*-
"""
Created on Tue Feb 21 14:33:22 2023

@author: HaOanh-PC
"""

import threading

def function1(n):
    print("thread 1: {}".format(n*n*n))
    
def function2(n):
    print("thread 2: {}".format(n))
    
if __name__ == "__main__":
    t1 = threading.Thread(target=function1, args=(10,))
    t2 = threading.Thread(target=function2, args=(10,))
    
    t1.start()
    t2.start()
    
    t1.join()
    t2.join()
    print("Done")
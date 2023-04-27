# -*- coding: utf-8 -*-
"""
Created on Thu Feb  9 17:17:35 2023

@author: HaOanh-PC
"""

import socket

# Tạo client socket
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client_socket.connect(('localhost', 9050))

# Gửi dữ liệu tới server
num1 = int(input("Nhập số thứ nhất: "))
num2 = int(input("Nhập số thứ hai: "))
client_socket.sendall("{} {}".format(num1, num2).encode())

# Nhận kết quả từ server
result = int(client_socket.recv(1024).decode())
print("Tổng hai số là:", result)

# Đóng kết nối
client_socket.close()

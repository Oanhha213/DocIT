--Create database DTDD1
--use DTDD1


CREATE TABLE CHUCVU(
	[MaCV] [nvarchar](20) PRIMARY KEY NOT NULL,
	[TenCV] [nvarchar](100) NOT NULL,
)

CREATE TABLE NHANVIEN(
	[MaNV] [nvarchar](20) PRIMARY KEY NOT NULL,
	[MaCV] [nvarchar](20) REFERENCES CHUCVU(MaCV) NOT NULL,
	[TenNV] [nvarchar](100)  NOT NULL,
	[SDTNV] [nvarchar](20)  NOT NULL,
	[GioiTinh] [nvarchar](20),
	[DiaChiNV] [nvarchar](200),
	[NgaySinh] [datetime],
)


CREATE TABLE USERINFO(
	[UserId] [nvarchar](20) PRIMARY KEY NOT NULL,
	[Username] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](20) NOT NULL,
	[SDTUser] [nvarchar](10),
	[DiaChiUser] [nvarchar](200),
	[Email] [nvarchar](100),
	[Role] int NOT NULL,
	[CreatedAt]  DATETIME DEFAULT (getdate()) NULL,
)

CREATE TABLE NHACUNGCAP(
	[MaNCC] [nvarchar](20) PRIMARY KEY NOT NULL,
	[TenNCC] [nvarchar](200) NOT NULL,
	[DiaChiNCC] [nvarchar](200),
	[SDTNCC] [nvarchar](10),
)


CREATE TABLE HOADONNHAP(
	[SoHDN] [nvarchar](20) PRIMARY KEY NOT NULL,
	[MaNCC] [nvarchar](20) REFERENCES NHACUNGCAP(MaNCC)NOT NULL,
	[MaNV] [nvarchar](20)  REFERENCES NHANVIEN(MaNV) NOT NULL,
	[NgayNhap] [datetime] NOT NULL,
	[TongTien] [money],
)

CREATE TABLE HANG(
	[MaHangSX] [nvarchar](20) PRIMARY KEY NOT NULL,
	[TenHangSX] [nvarchar](100) NOT NULL,
)


CREATE TABLE LOAISP
(
	[MaLoai] NVARCHAR(50) NOT NULL PRIMARY KEY, 
    [TenLoai] NVARCHAR(50) NOT NULL
)


CREATE TABLE SANPHAM
(
	[MaSP] NVARCHAR(50) NOT NULL PRIMARY KEY, 
    [TenSP] NVARCHAR(50) NOT NULL, 
	[MaLoai] NVARCHAR(50) NOT NULL,
	[MaHangSX] NVARCHAR(20) NOT NULL,
    [AnhDaiDien] VARCHAR(50) NOT NULL, 
    [SoLuong] INT NOT NULL, 
    [MieuTa] NTEXT, 
    [MauSac] NVARCHAR(50) NOT NULL, 
    [TrongLuong] FLOAT , 
    [ThoiGianBH] INT , 
    CONSTRAINT [FK_SANPHAM_LOAISP] FOREIGN KEY (MaLoai) REFERENCES [LOAISP](MaLoai),
	CONSTRAINT [FK_SANPHAM_HANG] FOREIGN KEY (MaHangSX) REFERENCES [HANG](MaHangSX)
)

CREATE TABLE CHITIETSP
(
	[MaChiTietSP] NVARCHAR(50) NOT NULL PRIMARY KEY, 
    [MaSP] NVARCHAR(50) NOT NULL, 
    [DonGiaBan] MONEY NOT NULL, 
    [DonGiaNhap] MONEY, 
    [RAM] NVARCHAR(100), 
    [ROM] NVARCHAR(100), 
    [CPU] NVARCHAR(100), 
    [DLPIN] NVARCHAR(100), 
    CONSTRAINT [FK_CHITIETSP_SANPHAM] FOREIGN KEY (MaSP) REFERENCES [SANPHAM](MaSP)
)

CREATE TABLE CHITIETANH
(
	[MaCTA] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
	[MaSP] NVARCHAR(50) NOT NULL , 
    [TenFileAnh] VARCHAR(50) NOT NULL,
    CONSTRAINT [FK_CHITIETANH_SANPHAM] FOREIGN KEY (MaSP) REFERENCES [SANPHAM](MaSP)
)

CREATE TABLE CHITIETHDN
(
	[MaSP] NVARCHAR(50) NOT NULL, 
    [SoHDN] NVARCHAR(20) NOT NULL, 
    [KhuyenMai] MONEY NOT NULL, 
    [SLNhap] INT NOT NULL, 
    CONSTRAINT [FK_CHITIETHDN_SANPHAM] FOREIGN KEY (MaSP) REFERENCES [SANPHAM](MaSP),
	CONSTRAINT [FK_CHITIETHDN_HOADONNHAP] FOREIGN KEY (SoHDN) REFERENCES [HOADONNHAP](SoHDN)
)


CREATE TABLE HOADONBAN(
	[SoHDB] [nvarchar](20) PRIMARY KEY NOT NULL,
	[MaNV] [nvarchar](20) REFERENCES NHANVIEN(MaNV) NOT NULL,
	[UserId] [nvarchar](20) REFERENCES USERINFO(UserId) NOT NULL,
	[NgayBan] [datetime] NOT NULL,
	[TongTien] [money],
)

CREATE TABLE CHITIETHDB(
	[MaSP] NVARCHAR(50) NOT NULL,
	[SoHDB] [nvarchar](20) REFERENCES HOADONBAN(SoHDB) NOT NULL,
	[KhuyenMai] [money],
	[SLBan] [int] NOT NULL,
	CONSTRAINT [FK_CHITIETHDB] FOREIGN KEY (MaSP) REFERENCES [SANPHAM](MaSP),
)


CREATE TABLE DONDATHANG
(
	[MaDH] NVARCHAR(20) NOT NULL PRIMARY KEY, 
    [MaNV] NVARCHAR(20) NOT NULL, 
    [UserId] NVARCHAR(20) NOT NULL, 
    [NgayDat] DATE NOT NULL, 
    [NgayGiao] DATE, 
    [TongTien] MONEY NOT NULL, 
    [TongThanhToan] MONEY, 
    CONSTRAINT [FK_DONDATHANG_NHANVIEN] FOREIGN KEY (MaNV) REFERENCES [NHANVIEN](MaNV), 
    CONSTRAINT [FK_DONDATHANG_USERINFO] FOREIGN KEY (UserId) REFERENCES [USERINFO](UserId)
)

CREATE TABLE CHITIETDDH
(
	[MaSP] NVARCHAR(50) NOT NULL, 
    [MaDH] NVARCHAR(20) NOT NULL, 
    [KhuyenMai] MONEY, 
    [SLDat] INT NOT NULL, 
    CONSTRAINT [FK_CHITIETDDH_SANPHAM] FOREIGN KEY (MaSP) REFERENCES [SANPHAM](MaSP), 
    CONSTRAINT [FK_CHITIETDDH_DONDATHANG] FOREIGN KEY (MaDH) REFERENCES [DONDATHANG](MaDH) 
)




insert into CHUCVU values (N'CV01', N'Cửa hàng trưởng')
insert into CHUCVU values (N'CV02', N'Kế toán')
insert into CHUCVU values (N'CV03', N'Nhân viên kho')
insert into CHUCVU values (N'CV04', N'Nhân viên kĩ thuật')
insert into CHUCVU values (N'CV05', N'Nhân viên tư vấn')
insert into CHUCVU values (N'CV06', N'Nhân viên tư vấn')
insert into CHUCVU values (N'CV07', N'Nhân viên kinh doanh')


insert into NHANVIEN values (N'NV01', N'CV01', N'Hoàng Anh Minh', N'06557522245', N'Nam', N'66/18 Dịch Vọng Hậu, Cầu Giấy, Hà Nội', N'1987-10-23 00:00:00')
insert into NHANVIEN values (N'NV02', N'CV02', N'Nguyễn Thị Châu Anh', N'09877522245', N'Nữ', N'Ngõ 12 Dịch Vọng Hậu, Cầu Giấy, Hà Nội', N'1990-11-3 00:00:00')
insert into NHANVIEN values (N'NV03', N'CV03', N'Bùi Minh Tuấn', N'05587522245', N'Nam', N'18 Dịch Vọng, Cầu Giấy, Hà Nội', N'1992-4-23 00:00:00')
insert into NHANVIEN values (N'NV04', N'CV04', N'Châu Ngọc Phát', N'03527522245', N'Nam', N'Trần Quốc Hoàn, Cầu Giấy, Hà Nội', N'1994-6-3 00:00:00')
insert into NHANVIEN values (N'NV05', N'CV05', N'Bùi Minh Nguyệt', N'0987522245', N'Nữ', N'Phạm Tuấn Tài, Cầu Giấy, Hà Nội', N'1998-7-23 00:00:00')
insert into NHANVIEN values (N'NV06', N'CV06', N'Nguyễn Hoàng Quân', N'0985522245', N'Nam', N'131 Xuân Thủy, Cầu Giấy, Hà Nội', N'1999-8-12 00:00:00')
insert into NHANVIEN values (N'NV07', N'CV07', N'Hoàng Ngọc Minh', N'0877522245', N'Nam', N'64 Dịch Vọng Hậu, Cầu Giấy, Hà Nội', N'1990-9-23 00:00:00')

insert into USERINFO(UserId,Username,Password,SDTUser,DiaChiUser,Email,Role) values (N'KH01', N'admin', N'admin123', N'098752222', N'Nguyễn Khang, Cầu Giấy, Hà Nội', N'admin123@gmail.com',1)
insert into USERINFO(UserId,Username,Password,SDTUser,DiaChiUser,Email,Role) values (N'KH02', N'hien123', N'hien123', N'098751111', N'Nguyễn Hoàng, Cầu Giấy, Hà Nội', N'hien123@gmail.com',0)
insert into USERINFO(UserId,Username,Password,SDTUser,DiaChiUser,Email,Role) values (N'KH03', N'longjay', N'long123', N'098753333', N'Quan Hoa, Cầu Giấy, Hà Nội', N'long123@gmail.com',0)
insert into USERINFO(UserId,Username,Password,SDTUser,DiaChiUser,Email,Role) values (N'KH04', N'quan', N'quan@123', N'098754444', N'Trần Quốc Hoàn, Cầu Giấy, Hà Nội', N'quan123@gmail.com',0)
insert into USERINFO(UserId,Username,Password,SDTUser,DiaChiUser,Email,Role) values (N'KH05', N'quang', N'quang123', N'098755555', N'Hồ Tùng Mậu, Cầu Giấy, Hà Nội', N'quang123@gmail.com',0)
insert into USERINFO(UserId,Username,Password,SDTUser,DiaChiUser,Email,Role) values (N'KH06', N'hoang', N'hoang123', N'098756666', N'Trần Quý Kiên, Cầu Giấy, Hà Nội', N'hoang123@gmail.com',0)
insert into USERINFO(UserId,Username,Password,SDTUser,DiaChiUser,Email,Role) values (N'KH07', N'hoa', N'hoa123', N'098757777', N'Trần Thái Tông, Cầu Giấy, Hà Nội', N'hoa123@gmail.com',0)
insert into USERINFO(UserId,Username,Password,SDTUser,DiaChiUser,Email,Role) values (N'KH08', N'oanh', N'oanh123', N'098758888', N'Nguyễn Khang, Cầu Giấy, Hà Nội', N'oanh123@gmail.com',0)
insert into USERINFO(UserId,Username,Password,SDTUser,DiaChiUser,Email,Role) values (N'KH09', N'kien', N'kien123', N'098759999', N'Nguyễn Hoang, Cầu Giấy, Hà Nội', N'kien123@gmail.com',0)
insert into USERINFO(UserId,Username,Password,SDTUser,DiaChiUser,Email,Role) values (N'KH10', N'thienthan', N'thienthan123', N'098754321', N'Nguyễn Khang, Cầu Giấy, Hà Nội', N'thienthan123@gmail.com',0)

insert into NHACUNGCAP values (N'NCC01', N'Hoàng Quân', N'Đại La, Hai Bà Trung, Hà Nội', N'0987755555')
insert into NHACUNGCAP values (N'NCC02', N'Quang Huy', N'Kim Ngưu, Hai Bà Trung, Hà Nội', N'0986866666')
insert into NHACUNGCAP values (N'NCC03', N'Thông Thái', N'Bạch Mai, Hai Bà Trung, Hà Nội', N'098383333')

insert into HOADONNHAP values(N'HDN01', N'NCC01', N'NV03', N'2023-1-15 17:00:00', 320000000)
insert into HOADONNHAP values(N'HDN02', N'NCC02', N'NV03', N'2023-1-15 17:00:00', 900000000)
insert into HOADONNHAP values(N'HDN03', N'NCC03', N'NV03', N'2023-1-15 17:00:00', 800000000)
 

insert into HANG values(N'MHSX01', N'Samsung')
insert into HANG values(N'MHSX02', N'Apple')
insert into HANG values(N'MHSX03', N'Lenovo')
insert into HANG values(N'MHSX04', N'LG')
insert into HANG values(N'MHSX05', N'Xiaomi')
insert into HANG values(N'MHSX06', N'Oppo')


insert into LOAISP values (N'LOAI01', N'Điện thoại')
insert into LOAISP values (N'LOAI02', N'Phụ kiện điện thoại')

--Insert Dien thoai
INSERT INTO SANPHAM VALUES
(N'DT01', N'Samsung Galaxy A23', N'LOAI01', N'MHSX01', N'samsung-galaxy-a23-5g-den-1.jpg', 5, N'Điện thoại sở hữu bộ vi xử lý ổn định kèm tính năng 5G hiện đại mang đến trải nghiệm mượt mà, cụm camera đem đến những bức ảnh chất lượng và viên pin lớn cho bạn thời gian trải nghiệm dài lâu.', N'Màu đen', 245 , 24)
, (N'DT02', N'Samsung ZFold 3', N'LOAI01', N'MHSX01', N'zfold3bac.jpg', 3, N'Điện thoại sở hữu bộ vi xử lý ổn định kèm tính năng 5G hiện đại mang đến trải nghiệm mượt mà, cụm camera đem đến những bức ảnh chất lượng và viên pin lớn cho bạn thời gian trải nghiệm dài lâu.', N'Màu bạc', 234 , 24)
, (N'DT03', N'Iphone 14 PRO MAX', N'LOAI01', N'MHSX02', N'iphone14.jpg', 6, N'Những chiếc điện thoại iPhone 14 2022 được gọi tên trong hàng ngũ siêu phẩm smartphone thế hệ mới bởi công nghệ hàng đầu, thiết kế hoàn hảo cùng nhiều đột phá đáng kinh ngạc. Độ hoàn hảo của thế hệ Flagship mới nhất của Apple được tạo thành từ sự thống nhất giữa các yếu tố thiết kế, màn hình, cấu hình, hệ điều hành, camera, pin và các tính năng cải tiến.', N'Màu tím', 277 , 24)
, (N'DT04', N'Iphone 13 PRO MAX', N'LOAI01', N'MHSX02', N'iphone13.jpg', 8, N'Những chiếc điện thoại iPhone 13 2021 được gọi tên trong hàng ngũ siêu phẩm smartphone thế hệ mới bởi công nghệ hàng đầu, thiết kế hoàn hảo cùng nhiều đột phá đáng kinh ngạc. Độ hoàn hảo của thế hệ Flagship mới nhất của Apple được tạo thành từ sự thống nhất giữa các yếu tố thiết kế, màn hình, cấu hình, hệ điều hành, camera, pin và các tính năng cải tiến.', N'Màu vàng', 256 , 24)
, (N'DT05', N'Lenovo Legion Y90', N'LOAI01', N'MHSX03', N'Lenovo.jpg', 4, N'Lenovo Legion Y90 sẽ được tích hợp "Dual Engine Air Cooling" - Hệ thống quạt tản nhiệt kép, nâng cấp khả năng hỗ trợ tản nhiệt khi chơi game.', N'Màu đen', 370 , 24)
, (N'DT06', N'LG V60 ThinQ 5G', N'LOAI01', N'MHSX04', N'lg.jpg', 5, N'với nhiều ưu điểm và tính năng nổi bật như sử dụng vi xử lý mạnh nhất hiện nay là Snapdragon 865, 3 camera chụp ảnh chất lượng cao, hỗ trợ quay phim 8K. Đặc biệt điện thoại LG V60 còn có pin dung lượng khủng 5000mAh cho thời gian sử dụng vượt trội.', N'Màu đen', 267 , 24)
, (N'DT07', N'Xiaomi Redmi 12C', N'LOAI01', N'MHSX05', N'xiaomiden.jpg', 4, N'là một thiết bị di động tầm trung được giới thiệu bởi Xiaomi, với cấu hình vượt trội so với các đối thủ trong cùng phân khúc, điều này nhờ trang bị con chip MediaTek Helio G85 mạnh mẽ giúp máy có thể xử lý tốt nhiều tác vụ. Hơn nữa, với bộ ống kính chất lượng 50 MP cho phép bạn chụp ảnh chất lượng, sắc nét và đẹp mắt.', N'Màu đen', 245 , 24)
, (N'DT08', N'OPPO A57', N'LOAI01', N'MHSX06', N'oppo.jpg', 4, N'Sở hữu cho mình một thiết kế trẻ trung, hiệu năng mượt mà đáp ứng tốt nhu cầu cơ bản hằng ngày.Vẻ đẹp từ sự tinh tế', N'Màu đen', 370 , 24)
, (N'DT09', N'Iphone XS MAX', N'LOAI01', N'MHSX02', N'iphonexs.jpg', 4, N'Điện thoại iPhone Xs Max sở hữu lối thiết kế vô cùng đẹp mắt với những đường cong mềm mại được thừa hưởng từ chiếc iPhone đời trước đó.', N'Màu vàng', 240 , 24)
, (N'DT10', N'Samsung ZFold 4', N'LOAI01', N'MHSX01', N'zfold3.10.jpg', 3, N'Điện thoại sở hữu bộ vi xử lý ổn định kèm tính năng 5G hiện đại mang đến trải nghiệm mượt mà, cụm camera đem đến những bức ảnh chất lượng và viên pin lớn cho bạn thời gian trải nghiệm dài lâu.', N'Màu bạc', 234 , 24)
, (N'DT11', N'Xiaomi Redmi Note 9 Pro', N'LOAI01', N'MHSX05', N'xiaomi.9.jpg', 4, N'là một thiết bị di động tầm trung được giới thiệu bởi Xiaomi, với cấu hình vượt trội so với các đối thủ trong cùng phân khúc, điều này nhờ trang bị con chip MediaTek Helio G85 mạnh mẽ giúp máy có thể xử lý tốt nhiều tác vụ. Hơn nữa, với bộ ống kính chất lượng 50 MP cho phép bạn chụp ảnh chất lượng, sắc nét và đẹp mắt.', N'Màu đen', 245 , 24)
, (N'DT12', N'Xiaomi Mi 10S', N'LOAI01', N'MHSX05', N'xiaomi.11.jpg', 4, N'là một thiết bị di động tầm trung được giới thiệu bởi Xiaomi, với cấu hình vượt trội so với các đối thủ trong cùng phân khúc, điều này nhờ trang bị con chip MediaTek Helio G85 mạnh mẽ giúp máy có thể xử lý tốt nhiều tác vụ. Hơn nữa, với bộ ống kính chất lượng 50 MP cho phép bạn chụp ảnh chất lượng, sắc nét và đẹp mắt.', N'Màu đen', 245 , 24)
, (N'DT13', N'Xiaomi Redmi Note 11 Pro', N'LOAI01', N'MHSX05', N'xiaomi.6.jpg', 4, N'là một thiết bị di động tầm trung được giới thiệu bởi Xiaomi, với cấu hình vượt trội so với các đối thủ trong cùng phân khúc, điều này nhờ trang bị con chip MediaTek Helio G85 mạnh mẽ giúp máy có thể xử lý tốt nhiều tác vụ. Hơn nữa, với bộ ống kính chất lượng 50 MP cho phép bạn chụp ảnh chất lượng, sắc nét và đẹp mắt.', N'Màu đen', 245 , 24)
, (N'DT14', N'Xiaomi Redmi 10C', N'LOAI01', N'MHSX05', N'xiaomi.1.jpg', 4, N'là một thiết bị di động tầm trung được giới thiệu bởi Xiaomi, với cấu hình vượt trội so với các đối thủ trong cùng phân khúc, điều này nhờ trang bị con chip MediaTek Helio G85 mạnh mẽ giúp máy có thể xử lý tốt nhiều tác vụ. Hơn nữa, với bộ ống kính chất lượng 50 MP cho phép bạn chụp ảnh chất lượng, sắc nét và đẹp mắt.', N'Màu đen', 245 , 24)
, (N'DT15', N'Samsung Galaxy Note 20', N'LOAI01', N'MHSX01', N'samsung.9.jpg', 3, N'Điện thoại sở hữu bộ vi xử lý ổn định kèm tính năng 5G hiện đại mang đến trải nghiệm mượt mà, cụm camera đem đến những bức ảnh chất lượng và viên pin lớn cho bạn thời gian trải nghiệm dài lâu.', N'Màu bạc', 234 , 24)
, (N'DT16', N'Samsung Galaxy A54', N'LOAI01', N'MHSX01', N'samsung.5.jpg', 3, N'Điện thoại sở hữu bộ vi xử lý ổn định kèm tính năng 5G hiện đại mang đến trải nghiệm mượt mà, cụm camera đem đến những bức ảnh chất lượng và viên pin lớn cho bạn thời gian trải nghiệm dài lâu.', N'Màu bạc', 234 , 24)
, (N'DT17', N'Samsung Galaxy A33', N'LOAI01', N'MHSX01', N'samsung.1.jpg', 3, N'Điện thoại sở hữu bộ vi xử lý ổn định kèm tính năng 5G hiện đại mang đến trải nghiệm mượt mà, cụm camera đem đến những bức ảnh chất lượng và viên pin lớn cho bạn thời gian trải nghiệm dài lâu.', N'Màu bạc', 234 , 24)
, (N'DT18', N'Iphone 14 Plus', N'LOAI01', N'MHSX02', N'iphone14.5.jpg', 6, N'Những chiếc điện thoại iPhone 14 2022 được gọi tên trong hàng ngũ siêu phẩm smartphone thế hệ mới bởi công nghệ hàng đầu, thiết kế hoàn hảo cùng nhiều đột phá đáng kinh ngạc. Độ hoàn hảo của thế hệ Flagship mới nhất của Apple được tạo thành từ sự thống nhất giữa các yếu tố thiết kế, màn hình, cấu hình, hệ điều hành, camera, pin và các tính năng cải tiến.', N'Màu tím', 277 , 24)
, (N'DT19', N'Iphone 14 128GB', N'LOAI01', N'MHSX02', N'iphone14.7.jpg', 6, N'Những chiếc điện thoại iPhone 14 2022 được gọi tên trong hàng ngũ siêu phẩm smartphone thế hệ mới bởi công nghệ hàng đầu, thiết kế hoàn hảo cùng nhiều đột phá đáng kinh ngạc. Độ hoàn hảo của thế hệ Flagship mới nhất của Apple được tạo thành từ sự thống nhất giữa các yếu tố thiết kế, màn hình, cấu hình, hệ điều hành, camera, pin và các tính năng cải tiến.', N'Màu tím', 277 , 24)
, (N'DT20', N'Iphone 14 PRO 256GB', N'LOAI01', N'MHSX02', N'iphone14.8.jpg', 6, N'Những chiếc điện thoại iPhone 14 2022 được gọi tên trong hàng ngũ siêu phẩm smartphone thế hệ mới bởi công nghệ hàng đầu, thiết kế hoàn hảo cùng nhiều đột phá đáng kinh ngạc. Độ hoàn hảo của thế hệ Flagship mới nhất của Apple được tạo thành từ sự thống nhất giữa các yếu tố thiết kế, màn hình, cấu hình, hệ điều hành, camera, pin và các tính năng cải tiến.', N'Màu tím', 277 , 24)
, (N'DT21', N'Iphone 13 128GB', N'LOAI01', N'MHSX02', N'iphone13.1.jpg', 8, N'Những chiếc điện thoại iPhone 13 2021 được gọi tên trong hàng ngũ siêu phẩm smartphone thế hệ mới bởi công nghệ hàng đầu, thiết kế hoàn hảo cùng nhiều đột phá đáng kinh ngạc. Độ hoàn hảo của thế hệ Flagship mới nhất của Apple được tạo thành từ sự thống nhất giữa các yếu tố thiết kế, màn hình, cấu hình, hệ điều hành, camera, pin và các tính năng cải tiến.', N'Màu vàng', 256 , 24)
, (N'DT22', N'Iphone 13 PLus', N'LOAI01', N'MHSX02', N'iphone13.4.jpg', 8, N'Những chiếc điện thoại iPhone 13 2021 được gọi tên trong hàng ngũ siêu phẩm smartphone thế hệ mới bởi công nghệ hàng đầu, thiết kế hoàn hảo cùng nhiều đột phá đáng kinh ngạc. Độ hoàn hảo của thế hệ Flagship mới nhất của Apple được tạo thành từ sự thống nhất giữa các yếu tố thiết kế, màn hình, cấu hình, hệ điều hành, camera, pin và các tính năng cải tiến.', N'Màu vàng', 256 , 24)
, (N'DT23', N'Iphone 13 PRO 256GB', N'LOAI01', N'MHSX02', N'iphone13.5.jpg', 8, N'Những chiếc điện thoại iPhone 13 2021 được gọi tên trong hàng ngũ siêu phẩm smartphone thế hệ mới bởi công nghệ hàng đầu, thiết kế hoàn hảo cùng nhiều đột phá đáng kinh ngạc. Độ hoàn hảo của thế hệ Flagship mới nhất của Apple được tạo thành từ sự thống nhất giữa các yếu tố thiết kế, màn hình, cấu hình, hệ điều hành, camera, pin và các tính năng cải tiến.', N'Màu vàng', 256 , 24)
, (N'DT24', N'Iphone 13 PRO 512GB', N'LOAI01', N'MHSX02', N'iphone13.6.jpg', 8, N'Những chiếc điện thoại iPhone 13 2021 được gọi tên trong hàng ngũ siêu phẩm smartphone thế hệ mới bởi công nghệ hàng đầu, thiết kế hoàn hảo cùng nhiều đột phá đáng kinh ngạc. Độ hoàn hảo của thế hệ Flagship mới nhất của Apple được tạo thành từ sự thống nhất giữa các yếu tố thiết kế, màn hình, cấu hình, hệ điều hành, camera, pin và các tính năng cải tiến.', N'Màu vàng', 256 , 24)
, (N'DT25', N'Lenovo K10 NOTE', N'LOAI01', N'MHSX03', N'Lenovo.7.jpg', 4, N'Lenovo Legion Y90 sẽ được tích hợp "Dual Engine Air Cooling" - Hệ thống quạt tản nhiệt kép, nâng cấp khả năng hỗ trợ tản nhiệt khi chơi game.', N'Màu đen', 370 , 24)
, (N'DT26', N'Lenovo Z5s', N'LOAI01', N'MHSX03', N'Lenovo.8.jpg', 4, N'Lenovo Legion Y90 sẽ được tích hợp "Dual Engine Air Cooling" - Hệ thống quạt tản nhiệt kép, nâng cấp khả năng hỗ trợ tản nhiệt khi chơi game.', N'Màu đen', 370 , 24)
, (N'DT27', N'Lenovo Z6 PRO', N'LOAI01', N'MHSX03', N'Lenovo.9.jpg', 4, N'Lenovo Legion Y90 sẽ được tích hợp "Dual Engine Air Cooling" - Hệ thống quạt tản nhiệt kép, nâng cấp khả năng hỗ trợ tản nhiệt khi chơi game.', N'Màu đen', 370 , 24)
, (N'DT28', N'LG Velvet 5G', N'LOAI01', N'MHSX04', N'lg.11.jpg', 5, N'với nhiều ưu điểm và tính năng nổi bật như sử dụng vi xử lý mạnh nhất hiện nay là Snapdragon 865, 3 camera chụp ảnh chất lượng cao, hỗ trợ quay phim 8K. Đặc biệt điện thoại LG V60 còn có pin dung lượng khủng 5000mAh cho thời gian sử dụng vượt trội.', N'Màu đen', 267 , 24)
, (N'DT29', N'LG Q51', N'LOAI01', N'MHSX04', N'lg.12.jpg', 5, N'với nhiều ưu điểm và tính năng nổi bật như sử dụng vi xử lý mạnh nhất hiện nay là Snapdragon 865, 3 camera chụp ảnh chất lượng cao, hỗ trợ quay phim 8K. Đặc biệt điện thoại LG V60 còn có pin dung lượng khủng 5000mAh cho thời gian sử dụng vượt trội.', N'Màu đen', 267 , 24)
, (N'DT30', N'LG Q60', N'LOAI01', N'MHSX04', N'lg.3.jpg', 5, N'với nhiều ưu điểm và tính năng nổi bật như sử dụng vi xử lý mạnh nhất hiện nay là Snapdragon 865, 3 camera chụp ảnh chất lượng cao, hỗ trợ quay phim 8K. Đặc biệt điện thoại LG V60 còn có pin dung lượng khủng 5000mAh cho thời gian sử dụng vượt trội.', N'Màu đen', 267 , 24)
, (N'DT31', N'OPPO Reno Z', N'LOAI01', N'MHSX06', N'oppo.9.jpg', 4, N'Sở hữu cho mình một thiết kế trẻ trung, hiệu năng mượt mà đáp ứng tốt nhu cầu cơ bản hằng ngày.Vẻ đẹp từ sự tinh tế', N'Màu đen', 370 , 24)
, (N'DT32', N'OPPO A74', N'LOAI01', N'MHSX06', N'oppo.10.jpg', 4, N'Sở hữu cho mình một thiết kế trẻ trung, hiệu năng mượt mà đáp ứng tốt nhu cầu cơ bản hằng ngày.Vẻ đẹp từ sự tinh tế', N'Màu đen', 370 , 24);


--Insert Phu kien dien thoai
INSERT INTO SANPHAM VALUES
(N'PK01', N'Củ sạc điện thoại Samsung 2 cổng', N'LOAI02', N'MHSX01', N'cusac.1.jpg', 5, N'Power Delivery đáp ứng được nhiều mức sạc khác nhau, đảm bảo mỗi thiết bị giao tiếp và xác nhận chính xác mức năng lượng mà thiết bị yêu cầu nhờ đó quá trình sạc an toàn, hạn chế chai pin', N'Màu trắng', 100 , 12),
(N'PK02', N'Củ sạc đa năng', N'LOAI02', N'MHSX01', N'cusac.2.jpg', 5, N'Power Delivery đáp ứng được nhiều mức sạc khác nhau, đảm bảo mỗi thiết bị giao tiếp và xác nhận chính xác mức năng lượng mà thiết bị yêu cầu nhờ đó quá trình sạc an toàn, hạn chế chai pin', N'Màu đen', 100 , 12),
(N'PK03', N'Củ sạc nhanh Samsung', N'LOAI02', N'MHSX01', N'cusac.3.jpg', 5, N'Power Delivery đáp ứng được nhiều mức sạc khác nhau, đảm bảo mỗi thiết bị giao tiếp và xác nhận chính xác mức năng lượng mà thiết bị yêu cầu nhờ đó quá trình sạc an toàn, hạn chế chai pin', N'Màu trắng', 100 , 12),
(N'PK04', N'Củ sạc nhanh 20W', N'LOAI02', N'MHSX01', N'cusac.6.jpg', 5, N'Power Delivery đáp ứng được nhiều mức sạc khác nhau, đảm bảo mỗi thiết bị giao tiếp và xác nhận chính xác mức năng lượng mà thiết bị yêu cầu nhờ đó quá trình sạc an toàn, hạn chế chai pin', N'Màu trắng', 100 , 12),
(N'PK05', N'Củ sạc OPPO', N'LOAI02', N'MHSX06', N'cusac.jpg', 5, N'Power Delivery đáp ứng được nhiều mức sạc khác nhau, đảm bảo mỗi thiết bị giao tiếp và xác nhận chính xác mức năng lượng mà thiết bị yêu cầu nhờ đó quá trình sạc an toàn, hạn chế chai pin', N'Màu đen', 100 , 12),
(N'PK06', N'Cáp Lightning Iphone', N'LOAI02', N'MHSX02', N'daysac.2.jpg', 5, N'Cáp dài 1m, cùng dòng sạc tối đa 2.4A, giúp bạn thuận tiện hơn trong việc sạc pin cho điện thoại', N'Màu đen', 100 , 12),
(N'PK07', N'Cáp sạc USB fast charging', N'LOAI02', N'MHSX01', N'daysac.3.jpg', 5, N'Cáp dài 1m, cùng dòng sạc tối đa 2.4A, giúp bạn thuận tiện hơn trong việc sạc pin cho điện thoại', N'Màu đen', 100 , 12),
(N'PK08', N'Cáp sạc Samsung chính hãng', N'LOAI02', N'MHSX01', N'daysac.jpg', 5, N'Cáp dài 1m, cùng dòng sạc tối đa 2.4A, giúp bạn thuận tiện hơn trong việc sạc pin cho điện thoại', N'Màu đen', 100 , 12),
(N'PK09', N'Thẻ nhớ Kingston 64GB', N'LOAI02', N'MHSX01', N'thenho.1.jpg', 5, N'Tốc độ đọc lên đến 100 MB/s, tốc độ ghi là 30 MB/s. Tương thích tốt với điện thoại, máy tính bảng, máy ảnh, laptop,...', N'Màu đen', 100 , 12),
(N'PK10', N'Thẻ nhớ Sandisk 128GB', N'LOAI02', N'MHSX01', N'thenho.5.jpg', 5, N'Tốc độ đọc lên đến 100 MB/s, tốc độ ghi là 30 MB/s. Tương thích tốt với điện thoại, máy tính bảng, máy ảnh, laptop,...', N'Màu đen', 100 , 12),
(N'PK11', N'USB Sandisk 128GB', N'LOAI02', N'MHSX01', N'thenho.4.jpg', 5, N'Tốc độ đọc lên đến 100 MB/s, tốc độ ghi là 30 MB/s. Tương thích tốt với điện thoại, máy tính bảng, máy ảnh, laptop,...', N'Màu đen', 100 , 12),
(N'PK12', N'Thẻ nhớ Mixie 32GB', N'LOAI02', N'MHSX01', N'thenho.3.jpg', 5, N'Tốc độ đọc lên đến 100 MB/s, tốc độ ghi là 30 MB/s. Tương thích tốt với điện thoại, máy tính bảng, máy ảnh, laptop,...', N'Màu đen', 100 , 12);


-- chi tiet dien thoai
insert into CHITIETSP values (N'CTSP01', N'DT01', 7000000, 5000000, N'8GB', N'128GB', N'Exynos 2100', N'5000mAh;25W')
insert into CHITIETSP values (N'CTSP02', N'DT02', 18000000, 10000000, N'16GB', N'256GB', N'Exynos 2200', N'6000mAh;25W')
insert into CHITIETSP values (N'CTSP03', N'DT03', 28000000, 20000000, N'8GB', N'256GB', N'A16 Bionic', N'4352 mAh')
insert into CHITIETSP values (N'CTSP04', N'DT04', 25000000, 18000000, N'8GB', N'128GB', N'A15 Bionic', N'4352 mAh')
insert into CHITIETSP values (N'CTSP05', N'DT05', 10000000, 8000000, N'6GB', N'64GB', N'Qualcomm SM8450 Snapdragon 8 Gen 1 ', N'Li-Po 5600mAh')
insert into CHITIETSP values (N'CTSP06', N'DT06', 4000000, 2000000, N'4GB', N'64GB', N'Snapdragon 695 5G', N'5000mAh')
insert into CHITIETSP values (N'CTSP07', N'DT07', 4000000, 2000000, N'4GB', N'64GB', N'MediaTek Helio G85', N'5000mAh;10W')
insert into CHITIETSP values (N'CTSP08', N'DT08', 7000000, 5000000, N'6GB', N'128GB',  N'MediaTek Helio G35', N'5000mAh;25W')
insert into CHITIETSP values (N'CTSP09', N'DT09', 14000000, 9000000, N'4GB', N'128GB', N'Apple A12 Bionic', N'3174mAh')
insert into CHITIETSP values (N'CTSP10', N'DT10', 21450000, 17000000, N'16GB', N'512GB', N'Exynos 2300', N'7000mAh;25W')
insert into CHITIETSP values (N'CTSP11', N'DT11', 4000000, 3400000, N'4GB', N'64GB', N'MediaTek Helio G85', N'5000mAh;10W')
insert into CHITIETSP values (N'CTSP12', N'DT12', 5450000, 4200000, N'4GB', N'128GB', N'MediaTek Helio G85', N'5000mAh;10W')
insert into CHITIETSP values (N'CTSP13', N'DT13', 6750000, 5200000, N'6GB', N'128GB', N'MediaTek Helio G85', N'5000mAh;10W')
insert into CHITIETSP values (N'CTSP14', N'DT14', 5390000, 4100000, N'6GB', N'64GB', N'MediaTek Helio G85', N'5000mAh;10W')
insert into CHITIETSP values (N'CTSP15', N'DT15', 7240000, 5900000, N'6GB', N'128GB', N'Exynos 2100', N'5000mAh;25W')
insert into CHITIETSP values (N'CTSP16', N'DT16', 5340000, 4300000, N'4GB', N'256GB', N'Exynos 2200', N'5000mAh;25W')
insert into CHITIETSP values (N'CTSP17', N'DT17', 6690000, 5200000, N'8GB', N'128GB', N'Exynos 2300', N'5000mAh;25W')
insert into CHITIETSP values (N'CTSP18', N'DT18', 25600000, 24000000, N'8GB', N'256GB', N'A16 Bionic', N'4352 mAh')
insert into CHITIETSP values (N'CTSP19', N'DT19', 24900000, 23000000, N'4GB', N'512GB', N'A16 Bionic', N'4352 mAh')
insert into CHITIETSP values (N'CTSP20', N'DT20', 26100000, 22000000, N'8GB', N'512GB', N'A16 Bionic', N'4352 mAh')
insert into CHITIETSP values (N'CTSP21', N'DT21', 19800000, 17000000, N'6GB', N'128GB', N'A15 Bionic', N'4352 mAh')
insert into CHITIETSP values (N'CTSP22', N'DT22', 18900000, 17000000, N'8GB', N'128GB', N'A15 Bionic', N'4352 mAh')
insert into CHITIETSP values (N'CTSP23', N'DT23', 20250000, 19000000, N'8GB', N'128GB', N'A15 Bionic', N'4352 mAh')
insert into CHITIETSP values (N'CTSP24', N'DT24', 17540000, 16000000, N'4GB', N'128GB', N'A15 Bionic', N'4352 mAh')
insert into CHITIETSP values (N'CTSP25', N'DT25', 11400000, 9800000, N'6GB', N'128GB', N'Qualcomm SM8450', N'Li-Po 5600mAh')
insert into CHITIETSP values (N'CTSP26', N'DT26', 10960000, 9000000, N'6GB', N'128GB', N'Qualcomm SM8450', N'Li-Po 5600mAh')
insert into CHITIETSP values (N'CTSP27', N'DT27', 11120000, 10000000, N'6GB', N'256GB', N'Qualcomm SM8450', N'Li-Po 5600mAh')
insert into CHITIETSP values (N'CTSP28', N'DT28', 5670000, 4000000, N'4GB', N'64GB', N'Snapdragon 695 5G', N'5000mAh')
insert into CHITIETSP values (N'CTSP29', N'DT29', 7200000, 6000000, N'6GB', N'128GB', N'Snapdragon 695 5G', N'5000mAh')
insert into CHITIETSP values (N'CTSP30', N'DT30', 6800000, 5000000, N'6GB', N'64GB', N'Snapdragon 695 5G', N'5000mAh')
insert into CHITIETSP values (N'CTSP31', N'DT31', 7900000, 5900000, N'8GB', N'128GB',  N'MediaTek Helio G35', N'5000mAh;25W')
insert into CHITIETSP values (N'CTSP32', N'DT32', 6400000, 5200000, N'6GB', N'128GB',  N'MediaTek Helio G35', N'5000mAh;25W')
-- chi tiet phu kien
insert into CHITIETSP values (N'CTSP33', N'PK01', 150000, 100000, null, null, null, null)
insert into CHITIETSP values (N'CTSP34', N'PK02', 190000, 120000, null, null, null, null)
insert into CHITIETSP values (N'CTSP35', N'PK03', 225000, 150000, null, null, null, null)
insert into CHITIETSP values (N'CTSP36', N'PK04', 240000, 150000, null, null, null, null)
insert into CHITIETSP values (N'CTSP37', N'PK05', 90000, 50000, null, null, null, null)
insert into CHITIETSP values (N'CTSP38', N'PK06', 150000, 110000, null, null, null, null)
insert into CHITIETSP values (N'CTSP39', N'PK07', 170000, 120000, null, null, null, null)
insert into CHITIETSP values (N'CTSP40', N'PK08', 70000, 45000, null, null, null, null)
insert into CHITIETSP values (N'CTSP41', N'PK09', 110000, 70000, null, null, null, null)
insert into CHITIETSP values (N'CTSP42', N'PK10', 345000, 250000, null, null, null, null)
insert into CHITIETSP values (N'CTSP43', N'PK11', 279000, 200000, null, null, null, null)
insert into CHITIETSP values (N'CTSP44', N'PK12', 250000, 190000, null, null, null, null)



--Chi tiet anh Dien thoai
insert into CHITIETANH(MaSP,TenFileAnh) values 
(N'DT01', N'samsung.jpg'),(N'DT01', N'samsung.1.jpg'),(N'DT01', N'samsung.2.jpg'),(N'DT01', N'samsung.3.jpg'),
(N'DT01', N'samsung.4.jpg'),(N'DT01', N'samsung.5.jpg'),(N'DT01', N'samsung.6.jpg'),
(N'DT02', N'zfold3bac.jpg'),(N'DT02', N'zfold3.1.jpg'),(N'DT02', N'zfold3.2.jpg'),(N'DT02', N'zfold3.4.jpg'),(N'DT02', N'zfold3.6.jpg'),(N'DT02', N'zfold3.7.jpg'),(N'DT02', N'zfold3.8.jpg'),
(N'DT03', N'iphone14.jpg'),(N'DT03', N'iphone14.1.jpg'),(N'DT03', N'iphone14.2.jpg'),(N'DT03', N'iphone14.3.jpg'),
(N'DT03', N'iphone14.4.jpg'),(N'DT03', N'iphone14.5.jpg'),(N'DT03', N'iphone14.6.jpg'),(N'DT03', N'iphone14.7.jpg'),(N'DT03', N'iphone14.8.jpg'),
(N'DT04', N'ip13pm.jpg'),(N'DT04', N'iphone13.jpg'),(N'DT04', N'iphone13.1.jpg'),(N'DT04', N'iphone13.2.jpg'),
(N'DT04', N'iphone13.4.jpg'),(N'DT04', N'iphone13.5.jpg'),(N'DT04', N'iphone13.6.jpg'),
(N'DT05', N'Lenovo.jpg'),(N'DT05', N'lenovo.1.jpg'),(N'DT05', N'lenovo.2.jpg'),(N'DT05', N'lenovo.3.jpg'),
(N'DT06', N'lg.jpg'),(N'DT06', N'lg.1.jpg'),(N'DT06', N'lg.2.jpg'),(N'DT06', N'lg.3.jpg'),(N'DT06', N'lg.4.jpg'),
(N'DT06', N'lg.5.jpg'),(N'DT06', N'lg.6.jpg'),(N'DT06', N'lg.7.jpg'),(N'DT06', N'lg.8.jpg'),
(N'DT07', N'xiaomi.jpg'),(N'DT07', N'xiaomi.1.jpg'),(N'DT07', N'xiaome.2.jpg'),(N'DT07', N'xiaomi.3.jpg'),
(N'DT07', N'xiaomi.4.jpg'),(N'DT07', N'xiaomi.5.jpg'),(N'DT07', N'xiaomi.6.jpg'),
(N'DT08', N'oppo.jpg') ,(N'DT08', N'oppo.1.jpg') ,(N'DT08', N'oppo.2.jpg') ,(N'DT08', N'oppo.3.jpg') ,
(N'DT08', N'oppo.4.jpg') ,(N'DT08', N'oppo.5.jpg') ,(N'DT08', N'oppo.6.jpg') ,(N'DT08', N'oppo.7.jpg') ,(N'DT08', N'oppo.8.jpg') ,
(N'DT09', N'iphonexs.jpg') ,(N'DT09', N'iphonexs.1.jpg') ,(N'DT09', N'iphonexs.2.jpg') ,
(N'DT09', N'iphonexs.3.jpg'),(N'DT09', N'iphonexs.4.jpg'),(N'DT09', N'iphonexs.5.jpg'),
(N'DT10', N'zfold3bac.jpg'),(N'DT10', N'zfold3.1.jpg'),(N'DT10', N'zfold3.2.jpg'),(N'DT10', N'zfold3.4.jpg'),
(N'DT10', N'zfold3.6.jpg'),(N'DT10', N'zfold3.7.jpg'),(N'DT10', N'zfold3.8.jpg'),(N'DT10', N'zfold3.9.jpg'),
(N'DT11', N'xiaomi.7.jpg'),(N'DT11', N'xiaomi.8.jpg'),(N'DT11', N'xiaomi.10.jpg'),(N'DT11', N'xiaomi.11.jpg'),
(N'DT12', N'xiaomi.7.jpg'),(N'DT12', N'xiaomi.8.jpg'),(N'DT12', N'xiaomi.10.jpg'),(N'DT12', N'xiaomi.11.jpg'),
(N'DT13', N'xiaomi.7.jpg'),(N'DT13', N'xiaomi.8.jpg'),(N'DT13', N'xiaomi.10.jpg'),(N'DT13', N'xiaomi.11.jpg'),
(N'DT14', N'xiaomi.7.jpg'),(N'DT14', N'xiaomi.8.jpg'),(N'DT14', N'xiaomi.10.jpg'),(N'DT14', N'xiaomi.11.jpg'),
(N'DT15', N'samsung.7.jpg'),(N'DT15', N'samsung.8.jpg'),(N'DT15', N'samsung.9.jpg'),(N'DT15', N'samsung.10.jpg'),
(N'DT16', N'samsung.1.jpg'),(N'DT16', N'samsung.2.jpg'),(N'DT16', N'samsung.3.jpg'),(N'DT16', N'samsung.4.jpg'),
(N'DT16', N'samsung.5.jpg'),(N'DT16', N'samsung.6.jpg'),
(N'DT17', N'samsung.1.jpg'),(N'DT17', N'samsung.2.jpg'),(N'DT17', N'samsung.3.jpg'),(N'DT17', N'samsung.4.jpg'),
(N'DT17', N'samsung.5.jpg'),(N'DT17', N'samsung.6.jpg'),
(N'DT18', N'iphone14.jpg'),(N'DT18', N'iphone14.1.jpg'),(N'DT18', N'iphone14.2.jpg'),(N'DT18', N'iphone14.3.jpg'),
(N'DT18', N'iphone14.4.jpg'),(N'DT18', N'iphone14.5.jpg'),(N'DT18', N'iphone14.6.jpg'),(N'DT18', N'iphone14.7.jpg'),(N'DT18', N'iphone14.8.jpg'),
(N'DT19', N'iphone14.jpg'),(N'DT19', N'iphone14.1.jpg'),(N'DT19', N'iphone14.2.jpg'),(N'DT19', N'iphone14.3.jpg'),
(N'DT19', N'iphone14.4.jpg'),(N'DT19', N'iphone14.5.jpg'),(N'DT19', N'iphone14.6.jpg'),(N'DT19', N'iphone14.7.jpg'),(N'DT19', N'iphone14.8.jpg'),
(N'DT20', N'iphone14.jpg'),(N'DT20', N'iphone14.1.jpg'),(N'DT20', N'iphone14.2.jpg'),(N'DT20', N'iphone14.3.jpg'),
(N'DT20', N'iphone14.4.jpg'),(N'DT20', N'iphone14.5.jpg'),(N'DT20', N'iphone14.6.jpg'),(N'DT20', N'iphone14.7.jpg'),(N'DT20', N'iphone14.8.jpg'),
(N'DT21', N'ip13pm.jpg'),(N'DT21', N'iphone13.jpg'),(N'DT21', N'iphone13.1.jpg'),(N'DT21', N'iphone13.2.jpg'),
(N'DT21', N'iphone13.4.jpg'),(N'DT21', N'iphone13.5.jpg'),(N'DT21', N'iphone13.6.jpg'),
(N'DT22', N'ip13pm.jpg'),(N'DT22', N'iphone13.jpg'),(N'DT22', N'iphone13.1.jpg'),(N'DT22', N'iphone13.2.jpg'),
(N'DT22', N'iphone13.4.jpg'),(N'DT22', N'iphone13.5.jpg'),(N'DT22', N'iphone13.6.jpg'),
(N'DT23', N'ip13pm.jpg'),(N'DT23', N'iphone13.jpg'),(N'DT23', N'iphone13.1.jpg'),(N'DT23', N'iphone13.2.jpg'),
(N'DT23', N'iphone13.4.jpg'),(N'DT23', N'iphone13.5.jpg'),(N'DT23', N'iphone13.6.jpg'),
(N'DT24', N'ip13pm.jpg'),(N'DT24', N'iphone13.jpg'),(N'DT24', N'iphone13.1.jpg'),(N'DT24', N'iphone13.2.jpg'),
(N'DT24', N'iphone13.4.jpg'),(N'DT24', N'iphone13.5.jpg'),(N'DT24', N'iphone13.6.jpg'),
(N'DT25', N'Lenovo.jpg'),(N'DT25', N'lenovo.7.jpg'),(N'DT25', N'lenovo.8.jpg'),(N'DT25', N'lenovo.9.jpg'),(N'DT25', N'lenovo.10.jpg'),(N'DT25', N'lenovo.6.jpg'),
(N'DT26', N'Lenovo.jpg'),(N'DT26', N'lenovo.7.jpg'),(N'DT26', N'lenovo.8.jpg'),(N'DT26', N'lenovo.9.jpg'),(N'DT26', N'lenovo.10.jpg'),(N'DT26', N'lenovo.6.jpg'),
(N'DT27', N'Lenovo.jpg'),(N'DT27', N'lenovo.7.jpg'),(N'DT27', N'lenovo.8.jpg'),(N'DT27', N'lenovo.9.jpg'),(N'DT27', N'lenovo.10.jpg'),(N'DT27', N'lenovo.6.jpg'),
(N'DT28', N'lg.5.jpg'),(N'DT28', N'lg.6.jpg'),(N'DT28', N'lg.7.jpg'),(N'DT28', N'lg.8.jpg'),(N'DT28', N'lg.10.jpg'),(N'DT28', N'lg.16.jpg'),
(N'DT29', N'lg.5.jpg'),(N'DT29', N'lg.6.jpg'),(N'DT29', N'lg.7.jpg'),(N'DT29', N'lg.8.jpg'),(N'DT29', N'lg.10.jpg'),(N'DT29', N'lg.16.jpg'),
(N'DT30', N'lg.5.jpg'),(N'DT30', N'lg.6.jpg'),(N'DT30', N'lg.7.jpg'),(N'DT30', N'lg.8.jpg'),(N'DT30', N'lg.10.jpg'),(N'DT30', N'lg.16.jpg'),
(N'DT31', N'oppo.4.jpg'),(N'DT31', N'oppo.5.jpg'),(N'DT31', N'oppo.6.jpg'),(N'DT31', N'oppo.7.jpg'),(N'DT31', N'oppo.10.jpg'),(N'DT31', N'oppo.11.jpg'),(N'DT31', N'oppo.12.jpg'),(N'DT31', N'oppo.13.jpg'),(N'DT31', N'oppo.14.jpg'),
(N'DT32', N'oppo.4.jpg'),(N'DT32', N'oppo.5.jpg'),(N'DT32', N'oppo.6.jpg'),(N'DT32', N'oppo.7.jpg'),(N'DT32', N'oppo.10.jpg'),(N'DT32', N'oppo.11.jpg'),(N'DT32', N'oppo.12.jpg'),(N'DT32', N'oppo.13.jpg'),(N'DT32', N'oppo.14.jpg');

--Chi tiet anh phu kien
insert into CHITIETANH(MaSP, TenFileAnh) values 
(N'PK01', N'cusac.4.jpg'),(N'PK01', N'cusac.1.jpg'),
(N'PK02', N'cusac.4.jpg'),(N'PK02', N'cusac.2.jpg'),
(N'PK03', N'cusac.4.jpg'),(N'PK03', N'cusac.3.jpg'),(N'PK03', N'cusac.5.jpg'),
(N'PK04', N'cusac.4.jpg'),(N'PK04', N'cusac.6.jpg'),
(N'PK05', N'cusac.4.jpg'),(N'PK05', N'cusac.jpg'),
(N'PK06', N'daysac.1.jpg'),(N'PK06', N'daysac.2.jpg'),
(N'PK07', N'daysac.1.jpg'),(N'PK07', N'daysac.3.jpg'),
(N'PK08', N'daysac.1.jpg'),(N'PK08', N'daysac.jpg'),
(N'PK09', N'thenho.6.jpg'),(N'PK09', N'thenho.1.jpg'),(N'PK09', N'thenho.jpg'),
(N'PK10', N'thenho.6.jpg'),(N'PK10', N'thenho.5.jpg'),
(N'PK11', N'thenho.6.jpg'),(N'PK11', N'thenho.4.jpg'),
(N'PK12', N'thenho.6.jpg'),(N'PK12', N'thenho.3.jpg');


insert into CHITIETHDN values (N'DT01', N'HDN01', 500000, 7)
insert into CHITIETHDN values (N'DT02', N'HDN01', 500000, 3)
insert into CHITIETHDN values (N'DT03', N'HDN01', 300000, 5)
insert into CHITIETHDN values (N'DT04', N'HDN02', 600000, 4)
insert into CHITIETHDN values (N'DT05', N'HDN02', 500000, 2)
insert into CHITIETHDN values (N'DT06', N'HDN02', 600000, 2)
insert into CHITIETHDN values (N'DT07', N'HDN03', 450000, 6)
insert into CHITIETHDN values (N'DT08', N'HDN03', 550000, 5)
insert into CHITIETHDN values (N'DT09', N'HDN03', 500000, 7)


insert into HOADONBAN values (N'HDB01', N'NV05', N'KH01', N'2022-12-1 16:30:00', 7000000)
insert into HOADONBAN values (N'HDB02', N'NV05', N'KH02', N'2022-12-3 17:30:00', 28000000)
insert into HOADONBAN values (N'HDB03', N'NV05', N'KH03', N'2022-12-4 15:30:00', 10000000)
insert into HOADONBAN values (N'HDB04', N'NV06', N'KH04', N'2022-12-5 11:30:00', 18000000)
insert into HOADONBAN values (N'HDB05', N'NV06', N'KH05', N'2022-12-6 10:00:00', 8000000)
insert into HOADONBAN values (N'HDB06', N'NV06', N'KH06', N'2022-12-7 09:30:00', 14000000)
insert into HOADONBAN values (N'HDB07', N'NV07', N'KH07', N'2022-12-8 08:30:00', 25000000)
insert into HOADONBAN values (N'HDB08', N'NV07', N'KH08', N'2022-12-9 10:15:00', 4000000)
insert into HOADONBAN values (N'HDB09', N'NV07', N'KH09', N'2022-12-10 16:30:00', 10000000)
insert into HOADONBAN values (N'HDB10', N'NV05', N'KH10', N'2022-12-11 14:30:00', 32000000)


insert into DONDATHANG values (N'DDH01', N'NV05', N'KH01', N'2022-12-1 16:30:00', N'2022-12-2 17:30:00', 7000000, 7000000)
insert into DONDATHANG values (N'DDH02', N'NV05', N'KH02', N'2022-12-3 17:30:00', N'2022-12-3 19:00:00', 28000000, 28000000)
insert into DONDATHANG values (N'DDH03', N'NV05', N'KH03', N'2022-12-4 15:30:00', N'2022-12-4 17:00:00', 10000000, 10000000)
insert into DONDATHANG values (N'DDH04', N'NV06', N'KH04', N'2022-12-5 11:30:00', N'2022-12-5 14:00:00', 18000000, 18000000)
insert into DONDATHANG values (N'DDH05', N'NV06', N'KH05', N'2022-12-6 10:00:00', N'2022-12-6 15:00:00', 8000000, 8000000)
insert into DONDATHANG values (N'DDH06', N'NV06', N'KH06', N'2022-12-7 09:30:00', N'2022-12-7 12:00:00', 14000000, 14000000)
insert into DONDATHANG values (N'DDH07', N'NV07', N'KH07', N'2022-12-8 08:30:00', N'2022-12-8 10:00:00', 25000000, 25000000)
insert into DONDATHANG values (N'DDH08', N'NV07', N'KH08', N'2022-12-9 10:15:00', N'2022-12-9 14:15:00', 4000000, 4000000)
insert into DONDATHANG values (N'DDH09', N'NV07', N'KH09', N'2022-12-10 16:30:00', N'2022-12-10 18:30:00', 10000000, 10000000)
insert into DONDATHANG values (N'DDH10', N'NV05', N'KH10', N'2022-12-11 14:30:00', N'2022-12-11 16:30:00', 32000000, 32000000)


insert into CHITIETHDB values (N'DT01', N'HDB01', 500000, 1) 
insert into CHITIETHDB values (N'DT03', N'HDB02', 300000, 1) 
insert into CHITIETHDB values (N'DT05', N'HDB03', 500000, 1) 
insert into CHITIETHDB values (N'DT02', N'HDB04', 500000, 1) 
insert into CHITIETHDB values (N'DT07', N'HDB05', 900000, 2) 
insert into CHITIETHDB values (N'DT09', N'HDB06', 500000, 1) 
insert into CHITIETHDB values (N'DT04', N'HDB07', 600000, 1) 
insert into CHITIETHDB values (N'DT07', N'HDB08', 400000, 1) 
insert into CHITIETHDB values (N'DT05', N'HDB09', 500000, 1) 
insert into CHITIETHDB values (N'DT04', N'HDB10', 600000, 1)


insert into CHITIETDDH values (N'DT01', N'DDH01', 500000, 1)
insert into CHITIETDDH values (N'DT02', N'DDH04', 500000, 1)
insert into CHITIETDDH values (N'DT03', N'DDH02', 300000, 1)
insert into CHITIETDDH values (N'DT04', N'DDH07', 600000, 1)
insert into CHITIETDDH values (N'DT05', N'DDH03', 500000, 1)
insert into CHITIETDDH values (N'DT06', N'DDH08', 500000, 1)
insert into CHITIETDDH values (N'DT09', N'DDH06', 500000, 1)
insert into CHITIETDDH values (N'DT07', N'DDH05', 800000, 2)
insert into CHITIETDDH values (N'DT05', N'DDH09', 500000, 1)
insert into CHITIETDDH values (N'DT03', N'DDH10', 500000, 1)

go
create or alter trigger TongTienTrigger on ChiTietDDH for insert, update, delete 
as
begin	
	declare @MaDH1 nvarchar(20), @TT1 money ,@MaDH2 nvarchar(20), @TT2 money
	begin tran
		begin try
			select @MaDH1 = i.MaDH , @TT1 = (i.SLDat * ctsp.DonGiaBan)
			from inserted i join SanPham sp on sp.MaSP = i.MaSP
				join CHITIETSP ctsp on ctsp.MaSP = i.MaSP

			select @MaDH1 = d.MaDH , @TT2 = (d.SLDat * ctsp.DonGiaBan)
			from deleted d join SanPham sp on sp.MaSP = d.MaSP
				join CHITIETSP ctsp on ctsp.MaSP = d.MaSP

			update DONDATHANG
			set TongTien = ISNULL(TongTien,0) + ISNULL(@TT1,0) - ISNULL(@TT2,0)
			where MaDH = isnull(@MaDH1,@MaDH2)
			commit 
		end try
		begin catch
			print 'Error:Thêm không thành công, bạn cần phải thêm số MaDH trong DonDatHang trước vì MaDH không tồn tại!';
			rollback tran
		end catch
end

update DONDATHANG
set TongTien = Banga.TT
from 
(
	select MaDH, SUM(ctsp.DonGiaBan * CHITIETDDH.SLDat) as TT
	from CHITIETDDH join SanPham on SanPham.MaSP = CHITIETDDH.MaSP
		join CHITIETSP ctsp on ctsp.MaSP = SANPHAM.MaSP
	group by MaDH
)Banga
where Banga.MaDH = DONDATHANG.MaDH

update CHITIETDDH
set SLDat = 2
where MaDH = N'DDH01'

insert into DONDATHANG values (N'DDH11', N'NV05', N'KH10', N'2022-12-11 14:30:00', N'2022-12-11 16:30:00',0,0)
insert into CHITIETDDH values (N'DT01', N'DDH11', 500000, 2)

select * from CHITIETDDH 
select * from DONDATHANG 

delete from CHITIETDDH
where CHITIETDDH.MaDH='DDH11'
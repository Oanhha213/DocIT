create database QuanLySanPham
USE QLSanPham
GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 3/6/2023 11:43:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attributes](
	[IdAttributes] [int] IDENTITY(1,1) NOT NULL,
	[GroupIdEntity] [int] NULL,
	[NameAttr] [nvarchar](50) NULL,
	isdeleted int null,
 CONSTRAINT [PK_Attributes] PRIMARY KEY CLUSTERED 
(
	[IdAttributes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Entity]    Script Date: 3/6/2023 11:43:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entity](
	[IdProduct] [int] IDENTITY(1,1) NOT NULL,
	[GroupIdEntity] [int]   NULL,
	[NameEntity] [nvarchar](50) NULL,
	[gia] decimal(19,4) null,
	[mota] nvarchar(max) null,
	[maNCC] int null,
	[soluong] int null,
	[Anh] nvarchar(max) null,
	[maGiamGia] int null,
	[daban] int null,
	isdeleted int null,
 CONSTRAINT [PK_Entity] PRIMARY KEY CLUSTERED 
(
	[IdProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ValuesEAV]    Script Date: 3/6/2023 11:43:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValuesEAV](
	[ValueId] [int] IDENTITY(1,1) NOT NULL,
	[IdEntity] [int] NULL,
	[AttrID] [int] NULL,
	[ValueAttr] [nvarchar](50) NULL,
	isdeleted int null
 CONSTRAINT [PK_ValuesEAV] PRIMARY KEY CLUSTERED 
(
	[ValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TYPE udtEntityType AS TABLE
(
   --  IdProduct INT IDENTITY(1,1) NOT NULL,
	 [GroupIdEntity] [int]   NULL,
	[NameEntity] [nvarchar](50) NULL,
	[gia] decimal(19,4) null,
	[mota] nvarchar(max) null,
	[maNCC] int null,
	[soluong] int null,
	[Anh] nvarchar(max) null,
	[maGiamGia] int null,
	[daban] int null
 --    PRIMARY KEY (IdProduct)
)
create TYPE udtEntityTypeUpdate1 AS TABLE
(
    IdProduct INT  NOT NULL,
	 [GroupIdEntity] INT,
     NameEntity VARCHAR(100) ,
	 [gia] decimal(19,4) null,
	[mota] nvarchar(max) null,
	[maNCC] int null,
	[soluong] int null,
	[Anh] nvarchar(max) null,
	[maGiamGia] int null,
	[daban] int null
     PRIMARY KEY (IdProduct)
)

CREATE TYPE udtAttributesType AS TABLE
(
    -- [IdAttributes] [int] IDENTITY(1,1) NOT NULL,
--	[GroupIdEntity] [int] NULL,
	[NameAttr] [nvarchar](50) NULL
  --   PRIMARY KEY (IdAttributes)
)
CREATE TYPE udtValuesEAVType AS TABLE
(
  --  [ValueId] [int] IDENTITY(1,1) NOT NULL,
	--[IdEntity] [int] NULL,
	--[AttrID] [int] NULL,
	[ValueAttr] [nvarchar](50) NULL
 --   PRIMARY KEY (ValueId)
)
CREATE TYPE udtAVType AS TABLE
(
    -- [IdAttributes] [int] IDENTITY(1,1) NOT NULL,
--	[GroupIdEntity] [int] NULL,
	[NameAttr] [nvarchar](50) NULL,
	[ValueAttr] [nvarchar](50) NULL
  --   PRIMARY KEY (IdAttributes)
)

CREATE or alter PROCEDURE dbo.insertProc
    @udtEntityType dbo.udtEntityType READONLY,
    @udtAttributesType dbo.udtAttributesType READONLY,
    @udtValuesEAVType dbo.udtValuesEAVType READONLY
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
 BEGIN TRANSACTION;
    -- Do something with the UDTT parameters
	declare @idGroup int =(select [GroupIdEntity] from @udtEntityType)
    insert into Entity 
	select GroupIdEntity,NameEntity,gia,mota,maNCC,soluong,anh,maGiamGia,daban,1 from @udtEntityType
	declare @idEntity int =(SELECT SCOPE_IDENTITY())

	DECLARE @insertedIds TABLE (id int );
	insert into Attributes 
	OUTPUT  inserted.IdAttributes INTO @insertedIds
	select @idGroup,NameAttr,1 from @udtAttributesType

	DECLARE @subtableA TABLE (id int IDENTITY(1,1),idattr int );
	insert into @subtableA 
	select id from @insertedIds

	DECLARE @subtableV TABLE (id int IDENTITY(1,1),ValueAttr nvarchar(100) );
	insert into @subtableV 
	select ValueAttr from @udtValuesEAVType

	insert into ValuesEAV 
	select @idEntity,a.idattr ,ValueAttr,1  from @subtableA a join @subtableV b
	on a.id=b.id
	Commit TRANSACTION;
END
TRY  
BEGIN CATCH  
 IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  
END

DECLARE @AttributesType AS udtAttributesType
DECLARE @ValuesEAVType AS udtValuesEAVType
DECLARE @EntityType AS udtEntityType

--GroupIdEntity,NameEntity,gia,mota,maNCC,soluong,anh,maGiamGia,daban,
INSERT INTO @EntityType
values(3,'sach lt','10000','kien thuc can ban','2','100','dsfs ','1','123')
INSERT INTO @AttributesType
VALUES ('tac gia '),
       ('so trang')
       
INSERT INTO @ValuesEAVType
VALUES ('manh quang'),
       ('800')
      

EXEC insertProc @udtEntityType = @EntityType, @udtAttributesType = @AttributesType,
@udtValuesEAVType=@ValuesEAVType



CREATE or alter PROCEDURE dbo.insertOldProc
    @udtEntityType dbo.udtEntityType READONLY,
    @udtValuesEAVType dbo.udtValuesEAVType READONLY
AS
begin 
set nocount on
BEGIN TRY
begin transaction
    -- Do something with the UDTT parameters
	declare @idGroup int =(select [GroupIdEntity] from @udtEntityType)
	insert into Entity 
	select GroupIdEntity,NameEntity,gia,mota,maNCC,soluong,anh,maGiamGia,daban,1 from @udtEntityType
	declare @idEntity int =(SELECT SCOPE_IDENTITY())
	
	DECLARE @subtableA TABLE (id int IDENTITY(1,1),idattr int );
	insert into @subtableA 
	select IdAttributes from Attributes where GroupIdEntity =@idGroup

	DECLARE @subtableV TABLE (id int IDENTITY(1,1),ValueAttr nvarchar(100) )
	insert into @subtableV 
	select ValueAttr from @udtValuesEAVType

	insert into ValuesEAV 
	select @idEntity,a.idattr ,ValueAttr,1  from @subtableA a join @subtableV b
	on a.id=b.id
	 commit transaction
END
TRY  
BEGIN CATCH  
 IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  
end

DECLARE @ValuesEAVType AS udtValuesEAVType
DECLARE @EntityType AS udtEntityType

--GroupIdEntity,NameEntity,gia,mota,maNCC,soluong,anh,maGiamGia,daban,
INSERT INTO @EntityType
values(2,'socola nguyen chat','10000','100% nguyen chat','2','100','dsfs ','1','123')       
INSERT INTO @ValuesEAVType
VALUES ('dang'),
       (' nau')

EXEC insertOldProc @udtEntityType = @EntityType,@udtValuesEAVType=@ValuesEAVType


CREATE or alter PROCEDURE dbo.updateProc
    @udtEntityTypeUpdate dbo.udtEntityTypeUpdate1 READONLY,
    @udtValuesEAVType dbo.udtValuesEAVType READONLY
AS
begin 
set nocount on
BEGIN TRY
begin transaction
    -- Do something with the UDTT parameters
	declare @idEntity int =(select IdProduct from @udtEntityTypeUpdate)
	declare @idGroup int =(select GroupIdEntity from @udtEntityTypeUpdate)

	update Entity 
	set NameEntity=(select NameEntity from @udtEntityTypeUpdate),
	gia=(select gia from @udtEntityTypeUpdate),
	mota=(select mota from @udtEntityTypeUpdate),
	maNCC=(select maNCC from @udtEntityTypeUpdate),
	soluong=(select soluong from @udtEntityTypeUpdate),
	anh=(select anh from @udtEntityTypeUpdate),
	maGiamGia=(select maGiamGia from @udtEntityTypeUpdate),
	daban=(select daban from @udtEntityTypeUpdate)
	where IdProduct=@idEntity

	delete ValuesEAV
	where [IdEntity]=@idEntity

	DECLARE @subtableA TABLE (id int IDENTITY(1,1),idattr int );
	insert into @subtableA 
	select IdAttributes from Attributes where GroupIdEntity =@idGroup

	DECLARE @subtableV TABLE (id int IDENTITY(1,1),ValueAttr nvarchar(100) );
	insert into @subtableV 
	select ValueAttr from @udtValuesEAVType

	insert into ValuesEAV 
	select @idEntity,a.idattr ,ValueAttr,1  from @subtableA a join @subtableV b
	on a.id=b.id	
	commit transaction
END
TRY  
BEGIN CATCH  
   IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH; 
end

DECLARE @ValuesEAVType AS udtValuesEAVType
DECLARE @EntityType AS udtEntityTypeUpdate1

INSERT INTO @EntityType
values(1,1,'hoa hong')
INSERT INTO @ValuesEAVType
VALUES ('10'),
       ('tuoi,thom'),
       ('19')
EXEC updateProc @udtEntityTypeUpdate = @EntityType,@udtValuesEAVType=@ValuesEAVType

CREATE or alter PROCEDURE dbo.InsertAttrProc
    @udtAttributesType dbo.udtAttributesType READONLY,
	@idgroup int
    
AS
begin 
set nocount on
BEGIN TRY
begin transaction
    -- Do something with the UDTT parameters
	insert into Attributes
	select @idgroup,nameAttr,1 from @udtAttributesType
	
	commit transaction
END
TRY  
BEGIN CATCH  
   IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH; 
end


CREATE or alter PROCEDURE dbo.deleteProc
    @masp int 
AS
begin 
set nocount on
BEGIN TRY
begin transaction
    -- Do something with the UDTT parameters
	update Entity set isdeleted=0 where  IdProduct=@masp
	update ValuesEAV set isdeleted=0 where  [IdEntity]=@masp

	--delete Entity where IdProduct=@masp
	--delete ValuesEAV where [IdEntity]=@masp
	commit transaction
END
TRY  
BEGIN CATCH  
    IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  
end 

CREATE or alter PROCEDURE dbo.deleteMutilProc
    @listMasp nvarchar(max) 
AS
begin 
set nocount on
BEGIN TRY
begin transaction
    -- Do something with the UDTT parameters
	declare @sql1 nvarchar(max) = 'update Entity set isdeleted=0 where  IdProduct in ('+@listMasp+')'
	declare @sql2 nvarchar(max) = 'update ValuesEAV set isdeleted=0 where  [IdEntity] in ('+@listMasp+')'
	EXEC sp_executesql @sql1;
	EXEC sp_executesql @sql2;
	--update ValuesEAV set isdeleted=0 where  [IdEntity]=@masp

	--delete Entity where IdProduct=@masp
	--delete ValuesEAV where [IdEntity]=@masp
	commit transaction
END
TRY  
BEGIN CATCH  
    IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  
end 

EXEC deleteMutilProc '5,6'

create or alter View GetAll
as
select a.IdProduct as IdProduct,a.GroupIdEntity as GroupIdEntity,NameEntity,gia,mota,maNCC,soluong,anh,maGiamGia,daban,NameAttr,ValueAttr,
a.isdeleted as isdeleted from Entity a join ValuesEAV b on a.IdProduct=b.[IdEntity]
join Attributes c on c.IdAttributes=b.AttrID where a.isdeleted=1


--CREATE or alter PROCEDURE GetEAVData
--    @idgroup int
--AS
--begin 
--set nocount on
--BEGIN TRY
--begin transaction
--    DECLARE @Attributes NVARCHAR(MAX);
--    DECLARE @PivotQuery NVARCHAR(MAX);

--    -- Build a comma-separated list of attributes
--    SELECT @Attributes = COALESCE(@Attributes + ', ', '') + QUOTENAME(NameAttr)
--    FROM Attributes
--    WHERE GroupIdEntity=@idgroup

--    -- Build the pivot query dynamically
--    SET @PivotQuery = N'
--        SELECT IdProduct,GroupIdEntity,NameEntity,gia,mota,maNCC,soluong,anh,maGiamGia,daban, ' + @Attributes + '
--        FROM (
--            SELECT IdProduct,GroupIdEntity,NameEntity,gia,mota,maNCC,soluong,anh,maGiamGia,daban, NameAttr, ValueAttr
--            FROM GetAll
--            WHERE GroupIdEntity= @idgroup and isdeleted=1
--        ) AS SourceTable
--        PIVOT (
--            Max(ValueAttr)
--            FOR NameAttr IN (' + @Attributes + ')
--        ) AS PivotTable;
--    '

--    EXEC sp_executesql @PivotQuery,N'@idgroup INT',@idgroup ;
--	commit transaction
--END
--TRY  
--BEGIN CATCH
--    IF @@TRANCOUNT > 0
--            ROLLBACK TRANSACTION
--    SELECT  
--        ERROR_NUMBER() AS ErrorNumber  
--        ,ERROR_SEVERITY() AS ErrorSeverity  
--        ,ERROR_STATE() AS ErrorState  
--        ,ERROR_PROCEDURE() AS ErrorProcedure  
--        ,ERROR_LINE() AS ErrorLine  
--        ,ERROR_MESSAGE() AS ErrorMessage;  
--END CATCH
--end

EXEc GetEAVDataID 1

CREATE or alter PROCEDURE GetEAVDataID
   -- @udtAVType udtAVType READONLY,
	@masp int
AS
begin 
set nocount on
BEGIN TRY
begin transaction
    DECLARE @Attributes NVARCHAR(MAX);
    DECLARE @PivotQuery NVARCHAR(MAX);

     SELECT @Attributes = COALESCE(@Attributes + ', ', '') + QUOTENAME(NameAttr)
    FROM GetAll
    WHERE IdProduct=@masp

    -- Build the pivot query dynamically
    SET @PivotQuery = N'
        SELECT IdProduct,GroupIdEntity,NameEntity,gia,mota,maNCC,soluong,anh,maGiamGia,daban, ' + @Attributes + '
        FROM (
            SELECT IdProduct,GroupIdEntity,NameEntity,gia,mota,maNCC,soluong,anh,maGiamGia,daban, NameAttr, ValueAttr
            FROM GetAll
            WHERE IdProduct=@masp and isdeleted=1
        ) AS SourceTable
        PIVOT (
            Max(ValueAttr)
            FOR NameAttr IN (' + @Attributes + ')
        ) AS PivotTable;
    '

    EXEC sp_executesql @PivotQuery,N'@masp INT',@masp ;
	commit transaction
END
TRY  
BEGIN CATCH  
    IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH
end

create or alter View GetListData
as
select idProduct  ,groupIdEntity,nameEntity,gia,mota,maNCC,soluong,anh,maGiamGia,daban
from Entity where isdeleted=1



exec GetListProduct 2,3

CREATE or alter PROCEDURE dbo.deleteLastOneYearUser
AS
begin 
set nocount on
BEGIN TRY
begin transaction

	delete taikhoan where isdeleted=0 and DATEDIFF(day,dayupdate,getdate())>365
	--delete ValuesEAV where [IdEntity]=@masp
	commit transaction
END
TRY  
BEGIN CATCH  
    IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  
end 


CREATE or alter PROCEDURE [dbo].[spPhanTrang_Table] (
 @PageNumber int,
 @PageSize int
)
AS
 DECLARE @Start int, @End int
 BEGIN TRANSACTION GetDataSet
 SET @Start = (((@PageNumber - 1) * @PageSize) + 1)
 IF @@ERROR <> 0
  GOTO ErrorHandler
 SET @End = (@Start + @PageSize - 1)
 IF @@ERROR <> 0
  GOTO ErrorHandler
 CREATE TABLE #TemporaryTable (
  [IdProduct] [int]  NOT NULL,
	[GroupIdEntity] [int]   NULL,
	[NameEntity] [nvarchar](50) NULL,
	[gia] decimal(19,4) null,
	[mota] nvarchar(max) null,
	[maNCC] int null,
	[soluong] int null,
	[Anh] nvarchar(max) null,
	[maGiamGia] int null,
	[daban] int null,
	PRIMARY KEY (IdProduct)
 )
 IF @@ERROR <> 0
   GOTO ErrorHandler
 INSERT INTO #TemporaryTable
  SELECT *
    FROM GetListData  
 IF @@ERROR <> 0
  GOTO ErrorHandler
 SELECT *  
  FROM #TemporaryTable
  WHERE (IdProduct >= @Start) AND (IdProduct <= @End)
 IF @@ERROR <> 0
  GOTO ErrorHandler
 DROP TABLE #TemporaryTable
 COMMIT TRANSACTION GetDataSet
 RETURN 0
ErrorHandler:
ROLLBACK TRANSACTION GetDataSet
RETURN @@ERROR

exec [spPhanTrang_Table] 1,3



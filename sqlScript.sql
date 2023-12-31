USE [master]
GO
/****** Object:  Database [ECommerce]    Script Date: 27-10-2023 18:39:10 ******/
CREATE DATABASE [ECommerce]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ECommerce', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ECommerce.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ECommerce_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ECommerce_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ECommerce] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ECommerce].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ECommerce] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ECommerce] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ECommerce] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ECommerce] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ECommerce] SET ARITHABORT OFF 
GO
ALTER DATABASE [ECommerce] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ECommerce] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ECommerce] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ECommerce] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ECommerce] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ECommerce] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ECommerce] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ECommerce] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ECommerce] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ECommerce] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ECommerce] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ECommerce] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ECommerce] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ECommerce] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ECommerce] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ECommerce] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ECommerce] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ECommerce] SET RECOVERY FULL 
GO
ALTER DATABASE [ECommerce] SET  MULTI_USER 
GO
ALTER DATABASE [ECommerce] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ECommerce] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ECommerce] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ECommerce] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ECommerce] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ECommerce] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ECommerce', N'ON'
GO
ALTER DATABASE [ECommerce] SET QUERY_STORE = ON
GO
ALTER DATABASE [ECommerce] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ECommerce]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 27-10-2023 18:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Category] [nvarchar](50) NULL,
	[Model] [nvarchar](50) NULL,
	[Brand] [nvarchar](50) NULL,
	[Manufacturer] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductDetail]    Script Date: 27-10-2023 18:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[Size] [nvarchar](10) NULL,
	[Variant] [nvarchar](50) NULL,
	[Color] [nvarchar](20) NULL,
	[Description] [nvarchar](100) NULL,
	[CostPrice] [decimal](7, 2) NULL,
	[SalePrice] [decimal](7, 2) NULL,
	[Images] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductDetail]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
/****** Object:  StoredProcedure [dbo].[PR_Product_Delete]    Script Date: 27-10-2023 18:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[PR_Product_Delete]
	@id int
as
	DELETE FROM Product
	where Id = @id
GO
/****** Object:  StoredProcedure [dbo].[PR_Product_Insert]    Script Date: 27-10-2023 18:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PR_Product_Insert]
	@name nvarchar(50),
	@model	nvarchar(50),
	@category	nvarchar(50),
	@brand	nvarchar(50),
	@manufacturer	nvarchar(50),
	@size nvarchar(10),
	@variant nvarchar(50),
	@color nvarchar(20),
	@description nvarchar(100),
	@costprice decimal(7,2),
	@saleprice decimal(7,2),
	@Images nvarchar(100)
as
DECLARE @insertedId as int
INSERT INTO Product (Name,Category,Model,Brand,Manufacturer) 
Values
(@name,@category,@model,@brand,@manufacturer)
set @insertedId = SCOPE_IDENTITY()
INSERT INTO ProductDetail(ProductId,Size,Variant,Color,Description,CostPrice, SalePrice,Images)
VALUES(@insertedId,@size,@variant,@color,@description,@costprice,@saleprice,@Images)
GO
/****** Object:  StoredProcedure [dbo].[PR_Product_SelectAll]    Script Date: 27-10-2023 18:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PR_Product_SelectAll]
as
select Product.Id,Name, Brand, SalePrice , Category ,Images from Product
inner join ProductDetail
ON Product.Id = ProductDetail.ProductId
GO
/****** Object:  StoredProcedure [dbo].[PR_Product_SelectByPK]    Script Date: 27-10-2023 18:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PR_Product_SelectByPK]
	@id int
as
select Product.Id,Name,Category,Model,Brand,Manufacturer,Size,Variant,Color,Description,CostPrice,SalePrice,Images from Product
INNER JOIN ProductDetail
ON Product.Id = ProductDetail.ProductId
where Product.Id = @id
GO
/****** Object:  StoredProcedure [dbo].[PR_Product_Update]    Script Date: 27-10-2023 18:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PR_Product_Update]
	@id int,
	@name nvarchar(50),
	@model	nvarchar(50),
	@category	nvarchar(50),
	@brand	nvarchar(50),
	@manufacturer	nvarchar(50),
	@size nvarchar(10),
	@variant nvarchar(50),
	@color nvarchar(20),
	@description nvarchar(100),
	@costprice decimal(7,2),
	@saleprice decimal(7,2),
	@images nvarchar(100)
as
UPDATE Product 
SET Name = @name, 
Category = @category,
Model = @model,
Brand = @brand,
Manufacturer = @manufacturer
WHERE Id = @id
UPDATE ProductDetail
SET Size = @size,
Variant = @variant,
Color = @color,
Description = @description,
CostPrice = @costprice,
SalePrice = @saleprice,
Images = @images
where ProductId = @id
GO
/****** Object:  StoredProcedure [dbo].[PR_ProductDetail_Delete]    Script Date: 27-10-2023 18:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[PR_ProductDetail_Delete]
	@id int
as
	DELETE FROM ProductDetail
	where Id = @id
GO
/****** Object:  StoredProcedure [dbo].[PR_ProductDetail_Insert]    Script Date: 27-10-2023 18:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[PR_ProductDetail_Insert]
	@size	nvarchar(10),
	@variant	nvarchar(50),
	@color	nvarchar(20),
	@description	nvarchar(100),
	@costprice	decimal(7,2),
	@saleprice	decimal(7,2),
	@images	nvarchar(100)
as
	INSERT INTO ProductDetail(Size,Variant,Color,Description,CostPrice,SalePrice,Images)
	VALUES
	(@size,	@variant,@color,@description,@costprice,@saleprice,@images)
GO
/****** Object:  StoredProcedure [dbo].[PR_ProductDetail_SelectAll]    Script Date: 27-10-2023 18:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[PR_ProductDetail_SelectAll]
as
select ProductId, Size, Variant , Color, Description,CostPrice , SalePrice , Images from ProductDetail
GO
/****** Object:  StoredProcedure [dbo].[PR_ProductDetail_Update]    Script Date: 27-10-2023 18:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[PR_ProductDetail_Update]
	@productid int,
	@size	nvarchar(10),
	@variant	nvarchar(50),
	@color	nvarchar(20),
	@description	nvarchar(100),
	@costprice	decimal(7,2),
	@saleprice	decimal(7,2),
	@images	nvarchar(100)
as
	UPDATE ProductDetail
	SET 
	Size = @size,
	Variant = @variant,
	Color = @color,
	Description = @description,
	CostPrice = @costprice,
	SalePrice = @saleprice,
	Images = @images
	where ProductId = @productid
GO
/****** Object:  StoredProcedure [dbo].[PR_ProductDetails_SelectByPk]    Script Date: 27-10-2023 18:39:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PR_ProductDetails_SelectByPk]
	@id int
as
select ProductId , Name , Category , Model , Brand , Manufacturer , Size , Variant , Color , Description  , 
SalePrice , Images FROM Product
INNER JOIN ProductDetail
ON Product.Id = ProductDetail.ProductId
WHERE Product.Id = @id
GO
USE [master]
GO
ALTER DATABASE [ECommerce] SET  READ_WRITE 
GO

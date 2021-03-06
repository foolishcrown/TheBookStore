USE [master]
GO
/****** Object:  Database [BookShopDB]    Script Date: 11/28/2019 7:15:09 PM ******/
CREATE DATABASE [BookShopDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookShopDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\BookShopDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BookShopDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\BookShopDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [BookShopDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookShopDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookShopDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookShopDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookShopDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookShopDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookShopDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookShopDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BookShopDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookShopDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookShopDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookShopDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookShopDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookShopDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookShopDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookShopDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookShopDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BookShopDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookShopDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookShopDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookShopDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookShopDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookShopDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookShopDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookShopDB] SET RECOVERY FULL 
GO
ALTER DATABASE [BookShopDB] SET  MULTI_USER 
GO
ALTER DATABASE [BookShopDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookShopDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookShopDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookShopDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BookShopDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BookShopDB', N'ON'
GO
ALTER DATABASE [BookShopDB] SET QUERY_STORE = OFF
GO
USE [BookShopDB]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 11/28/2019 7:15:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserID] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NULL,
	[Role] [int] NULL,
	[Username] [nvarchar](50) NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 11/28/2019 7:15:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[BookID] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Image] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Price] [float] NULL,
	[Author] [nvarchar](50) NULL,
	[Category] [int] NULL,
	[Status] [bit] NULL,
	[Stock] [int] NULL,
	[ImportDate] [datetime] NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 11/28/2019 7:15:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CateID] [int] NOT NULL,
	[CateName] [nvarchar](20) NULL,
	[CateCODE] [nvarchar](10) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 11/28/2019 7:15:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[DiscountCode] [nvarchar](50) NOT NULL,
	[Value] [float] NULL,
	[userID] [nvarchar](50) NULL,
 CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED 
(
	[DiscountCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 11/28/2019 7:15:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [nvarchar](50) NULL,
	[SubTotal] [float] NULL,
	[OrderDate] [datetime] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 11/28/2019 7:15:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderID] [int] NOT NULL,
	[BookID] [nvarchar](50) NOT NULL,
	[BookName] [nvarchar](100) NULL,
	[Amount] [int] NULL,
	[Price] [float] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 11/28/2019 7:15:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] NOT NULL,
	[Description] [nvarchar](10) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([UserID], [Password], [Role], [Username]) VALUES (N'customer', N'123', 1, N'Ngo Van Sang')
INSERT [dbo].[Account] ([UserID], [Password], [Role], [Username]) VALUES (N'halama', N'123', 1, N'halama')
INSERT [dbo].[Account] ([UserID], [Password], [Role], [Username]) VALUES (N'quankun', N'123', 0, N'bolero')
INSERT [dbo].[Account] ([UserID], [Password], [Role], [Username]) VALUES (N'sang', N'123', 0, N'Ngo Van Sang')
INSERT [dbo].[Book] ([BookID], [Title], [Image], [Description], [Price], [Author], [Category], [Status], [Stock], [ImportDate]) VALUES (N'COMIC-0', N'Avenger Infinity War', N'sachtoan.jpg', N'aaaa', 30000, N'Ensteint', 2, 1, 55, CAST(N'2019-11-28T13:15:43.700' AS DateTime))
INSERT [dbo].[Book] ([BookID], [Title], [Image], [Description], [Price], [Author], [Category], [Status], [Stock], [ImportDate]) VALUES (N'EDU-1', N'Tren Duong Bang', N'trenduongbang.jpg', N'Hoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahah', 34250, N'Nguyen Tan Dung', 1, 1, 50, CAST(N'2019-11-24T22:28:28.497' AS DateTime))
INSERT [dbo].[Book] ([BookID], [Title], [Image], [Description], [Price], [Author], [Category], [Status], [Stock], [ImportDate]) VALUES (N'EDU-2', N'Tuoi Tre Dang Gia Bao Nhieu', N'tuoitrdanggiabaonhieu.jpg', N'Hoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahahHoa huyen voi nhung kien thuc don gian va de hieu hahaahahahahah', 300000, N'Nguyen Tan Dung', 5, 1, 50, CAST(N'2019-11-25T11:51:51.953' AS DateTime))
INSERT [dbo].[Book] ([BookID], [Title], [Image], [Description], [Price], [Author], [Category], [Status], [Stock], [ImportDate]) VALUES (N'EDU-3', N'Dac Nhan Tam', N'dacnhantam.jpg', N'Troi dat dung hoa, van vat sinh soi', 45000, N'Truong Tan Sang', 1, 1, 50, CAST(N'2019-11-27T23:13:31.913' AS DateTime))
INSERT [dbo].[Book] ([BookID], [Title], [Image], [Description], [Price], [Author], [Category], [Status], [Stock], [ImportDate]) VALUES (N'EDU-4', N'Nha Gia Kim', N'nhagiakim.jpg', N'Nha gia kim', 60000, N'Nguyen Tan Dung', 1, 1, 100, CAST(N'2019-11-28T10:06:16.713' AS DateTime))
INSERT [dbo].[Book] ([BookID], [Title], [Image], [Description], [Price], [Author], [Category], [Status], [Stock], [ImportDate]) VALUES (N'FUN-0', N'Mat Biec', N'matbiec.jpg', N'Hahahahahahahah', 35000, N'Nguyen Nhat Anh', 5, 1, 66, CAST(N'2019-11-28T10:10:52.780' AS DateTime))
INSERT [dbo].[Book] ([BookID], [Title], [Image], [Description], [Price], [Author], [Category], [Status], [Stock], [ImportDate]) VALUES (N'FUN-1', N'Doi Ngan Lam, Dung Ngu Dai', N'doingandungngudai.jpg', N'Cau chuyen ke ve 1 cau be, ngay xua ngay xua, co 1 cau be rat thich ngu nuong, mot hom...', 45000, N'Havala Madakha', 5, 1, 10, CAST(N'2019-11-28T13:13:50.080' AS DateTime))
INSERT [dbo].[Category] ([CateID], [CateName], [CateCODE]) VALUES (1, N'Education', N'EDU')
INSERT [dbo].[Category] ([CateID], [CateName], [CateCODE]) VALUES (2, N'Comic', N'COMIC')
INSERT [dbo].[Category] ([CateID], [CateName], [CateCODE]) VALUES (3, N'Horror', N'HRR')
INSERT [dbo].[Category] ([CateID], [CateName], [CateCODE]) VALUES (4, N'Comedy', N'FUN')
INSERT [dbo].[Category] ([CateID], [CateName], [CateCODE]) VALUES (5, N'Novel', N'NOV')
INSERT [dbo].[Category] ([CateID], [CateName], [CateCODE]) VALUES (6, N'Fairy Tail', N'FAR')
INSERT [dbo].[Discount] ([DiscountCode], [Value], [userID]) VALUES (N'BAKA01', 0.89999997615814209, NULL)
INSERT [dbo].[Discount] ([DiscountCode], [Value], [userID]) VALUES (N'HAHAHA', 0.5, NULL)
INSERT [dbo].[Discount] ([DiscountCode], [Value], [userID]) VALUES (N'SALE20', 0.2, N'customer')
INSERT [dbo].[Discount] ([DiscountCode], [Value], [userID]) VALUES (N'SALE30', 0.3, N'customer')
INSERT [dbo].[Discount] ([DiscountCode], [Value], [userID]) VALUES (N'SALE50', 0.5, NULL)
INSERT [dbo].[Discount] ([DiscountCode], [Value], [userID]) VALUES (N'SALE70', 0.7, NULL)
INSERT [dbo].[Discount] ([DiscountCode], [Value], [userID]) VALUES (N'SANGCUTE', 0.8, NULL)
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [UserID], [SubTotal], [OrderDate]) VALUES (13, N'customer', 0, CAST(N'2019-11-28T14:21:57.717' AS DateTime))
INSERT [dbo].[Order] ([OrderID], [UserID], [SubTotal], [OrderDate]) VALUES (14, N'customer', 364250, CAST(N'2019-11-28T15:42:17.457' AS DateTime))
INSERT [dbo].[Order] ([OrderID], [UserID], [SubTotal], [OrderDate]) VALUES (15, N'customer', 119000, CAST(N'2019-11-28T18:15:48.827' AS DateTime))
SET IDENTITY_INSERT [dbo].[Order] OFF
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [BookName], [Amount], [Price]) VALUES (14, N'COMIC-0', N'Avenger Infinity War', 1, 30000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [BookName], [Amount], [Price]) VALUES (14, N'EDU-1', N'Tren Duong Bang', 1, 34250)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [BookName], [Amount], [Price]) VALUES (14, N'EDU-2', N'Tuoi Tre Dang Gia Bao Nhieu', 1, 300000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [BookName], [Amount], [Price]) VALUES (15, N'COMIC-0', N'Avenger Infinity War', 3, 30000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [BookName], [Amount], [Price]) VALUES (15, N'EDU-3', N'Dac Nhan Tam', 1, 45000)
INSERT [dbo].[OrderDetail] ([OrderID], [BookID], [BookName], [Amount], [Price]) VALUES (15, N'FUN-0', N'Mat Biec', 1, 35000)
INSERT [dbo].[Role] ([RoleID], [Description]) VALUES (0, N'ADMIN')
INSERT [dbo].[Role] ([RoleID], [Description]) VALUES (1, N'CUSTOMER')
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Category]    Script Date: 11/28/2019 7:15:09 PM ******/
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [IX_Category] UNIQUE NONCLUSTERED 
(
	[CateName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Category_1]    Script Date: 11/28/2019 7:15:09 PM ******/
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [IX_Category_1] UNIQUE NONCLUSTERED 
(
	[CateCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF_Book_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF_Book_ImportDate]  DEFAULT (getdate()) FOR [ImportDate]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_OrderDate]  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Role] FOREIGN KEY([Role])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Role]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Category] FOREIGN KEY([Category])
REFERENCES [dbo].[Category] ([CateID])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Category]
GO
ALTER TABLE [dbo].[Discount]  WITH CHECK ADD  CONSTRAINT [FK_Discount_Account] FOREIGN KEY([userID])
REFERENCES [dbo].[Account] ([UserID])
GO
ALTER TABLE [dbo].[Discount] CHECK CONSTRAINT [FK_Discount_Account]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Account] FOREIGN KEY([UserID])
REFERENCES [dbo].[Account] ([UserID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Account]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Book] FOREIGN KEY([BookID])
REFERENCES [dbo].[Book] ([BookID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Book]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
USE [master]
GO
ALTER DATABASE [BookShopDB] SET  READ_WRITE 
GO

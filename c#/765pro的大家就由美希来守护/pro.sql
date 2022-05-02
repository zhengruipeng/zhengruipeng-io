USE [pro4]
GO
/****** Object:  Table [dbo].[tbl_user]    Script Date: 07/06/2021 13:58:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_user](
	[username] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL
) ON [PRIMARY]
GO
INSERT INTO tbl_user VALUES('1234','1234')
/****** Object:  Table [dbo].[tbl_typeMNG]    Script Date: 07/06/2021 13:58:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_typeMNG](
	[id] [nvarchar](50) NOT NULL,
	[typename] [nvarchar](50) NULL,
	[area] [int] NULL,
	[bathroom] [int] NULL,
	[furniture] [int] NULL,
	[drink] [int] NULL,
	[meal] [int] NULL,
	[price] [nchar](10) NULL,
 CONSTRAINT [PK_tbl_typeMNG] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT INTO tbl_typeMNG VALUES(1,'普通单人间',10,0,0,0,0,10)
INSERT INTO tbl_typeMNG VALUES(2,'豪华单人间',20,0,0,0,0,20)
INSERT INTO tbl_typeMNG VALUES(3,'普通双人间',30,0,0,0,0,30)
INSERT INTO tbl_typeMNG VALUES(4,'豪华双人间',100,0,0,0,0,100)
/****** Object:  Table [dbo].[tbl_roomMNG]    Script Date: 07/06/2021 13:58:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_roomMNG](
	[rno] [int] NOT NULL,
	[floor] [int] NOT NULL,
	[room] [int] NOT NULL,
	[type] [nvarchar](50) NULL,
	[livein] [int] NULL,
 CONSTRAINT [PK_tbl_room] PRIMARY KEY CLUSTERED 
(
	[rno] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT INTO tbl_roomMNG VALUES(101,1,1,'普通单人间',1)
INSERT INTO tbl_roomMNG VALUES(102,1,2,'普通单人间',1)
INSERT INTO tbl_roomMNG VALUES(103,1,3,'普通单人间',1)
INSERT INTO tbl_roomMNG VALUES(104,1,4,'普通单人间',1)
INSERT INTO tbl_roomMNG VALUES(105,1,5,'普通单人间',0)
INSERT INTO tbl_roomMNG VALUES(201,2,1,'普通单人间',0)
INSERT INTO tbl_roomMNG VALUES(202,2,2,'普通单人间',0)
INSERT INTO tbl_roomMNG VALUES(203,2,3,'普通单人间',0)
INSERT INTO tbl_roomMNG VALUES(204,2,4,'普通单人间',0)
INSERT INTO tbl_roomMNG VALUES(205,2,5,'普通单人间',0)
INSERT INTO tbl_roomMNG VALUES(301,3,1,'普通单人间',0)
INSERT INTO tbl_roomMNG VALUES(302,3,2,'普通单人间',0)
INSERT INTO tbl_roomMNG VALUES(303,3,3,'普通单人间',0)
INSERT INTO tbl_roomMNG VALUES(304,3,4,'普通单人间',0)
INSERT INTO tbl_roomMNG VALUES(305,3,5,'普通单人间',0)
/****** Object:  Table [dbo].[tbl_customer]    Script Date: 07/06/2021 13:58:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_customer](
	[id] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[gender] [nvarchar](10) NOT NULL,
	[age] [int] NULL,
	[start] [date] NULL,
	[room] [nvarchar](50) NULL,
	[deposit] [int] NULL,
 CONSTRAINT [PK_tbl_customer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT INTO tbl_customer VALUES(1001,'马克思','男',30,'2020-3-4',101,111)
INSERT INTO tbl_customer VALUES(1002,'恩格斯','男',30,'2021-3-4',102,111)
INSERT INTO tbl_customer VALUES(1003,'列宁','男',30,'2021-3-4',103,111)
INSERT INTO tbl_customer VALUES(1004,'笛卡尔','男',30,'2021-3-4',104,111)
/****** Object:  Table [dbo].[tbl_blackList]    Script Date: 07/06/2021 13:58:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_blackList](
	[id] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_blackList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT INTO tbl_blackList VALUES('4444',NULL)
/****** Object:  Check [CK_tbl_customer]    Script Date: 07/06/2021 13:58:46 ******/
ALTER TABLE [dbo].[tbl_customer]  WITH CHECK ADD  CONSTRAINT [CK_tbl_customer] CHECK  (([gender]='男' OR [gender]='女'))
GO
ALTER TABLE [dbo].[tbl_customer] CHECK CONSTRAINT [CK_tbl_customer]
GO

USE [master]
GO
/****** Object:  Database [Pt]    Script Date: 11/10/2024 15:13:25 ******/
CREATE DATABASE [Pt]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Pt', FILENAME = N'[RUTA]\Pt.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Pt_log', FILENAME = N'[RUTA]\Pt_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 COLLATE SQL_Latin1_General_CP1_CI_AS
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Pt] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Pt].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Pt] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Pt] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Pt] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Pt] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Pt] SET ARITHABORT OFF 
GO
ALTER DATABASE [Pt] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Pt] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Pt] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Pt] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Pt] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Pt] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Pt] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Pt] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Pt] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Pt] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Pt] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Pt] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Pt] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Pt] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Pt] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Pt] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Pt] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Pt] SET RECOVERY FULL 
GO
ALTER DATABASE [Pt] SET  MULTI_USER 
GO
ALTER DATABASE [Pt] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Pt] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Pt] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Pt] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Pt] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Pt] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Pt', N'ON'
GO
ALTER DATABASE [Pt] SET QUERY_STORE = ON
GO
ALTER DATABASE [Pt] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Pt]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 11/10/2024 15:13:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[ClienteID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[ClienteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnvioDetalles]    Script Date: 11/10/2024 15:13:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnvioDetalles](
	[EnvioDetalleID] [int] IDENTITY(1,1) NOT NULL,
	[EnvioID] [int] NOT NULL,
	[DescripcionBulto] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Peso] [decimal](10, 2) NOT NULL,
	[Dimensiones] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_EnvioDetalles] PRIMARY KEY CLUSTERED 
(
	[EnvioDetalleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Envios]    Script Date: 11/10/2024 15:13:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Envios](
	[EnvioID] [int] IDENTITY(1,1) NOT NULL,
	[ClienteID] [int] NOT NULL,
	[DireccionDestino] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProvinciaID] [int] NOT NULL,
	[ProveedorPaqueteria] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EstadoEnvio] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FechaEnvio] [datetime] NOT NULL,
	[CodigoSeguimiento] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Envios] PRIMARY KEY CLUSTERED 
(
	[EnvioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provincias]    Script Date: 11/10/2024 15:13:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincias](
	[ProvinciaID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Provincias] PRIMARY KEY CLUSTERED 
(
	[ProvinciaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Clientes] ON 

INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (81, N'Cliente 1')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (82, N'Cliente 2')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (83, N'Cliente 3')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (84, N'Cliente 4')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (85, N'Cliente 5')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (86, N'Cliente 6')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (87, N'Cliente 7')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (88, N'Cliente 8')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (89, N'Cliente 9')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (90, N'Cliente 10')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (91, N'Cliente 11')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (92, N'Cliente 12')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (93, N'Cliente 13')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (94, N'Cliente 14')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (95, N'Cliente 15')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (96, N'Cliente 16')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (97, N'Cliente 17')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (98, N'Cliente 18')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (99, N'Cliente 19')
INSERT [dbo].[Clientes] ([ClienteID], [Nombre]) VALUES (100, N'Cliente 20')
SET IDENTITY_INSERT [dbo].[Clientes] OFF
GO
SET IDENTITY_INSERT [dbo].[EnvioDetalles] ON 

INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (1, 102, N'Descripcion 1', CAST(1.45 AS Decimal(10, 2)), N'Dimensiones 1')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (2, 103, N'Descripcion 2', CAST(2.45 AS Decimal(10, 2)), N'Dimensiones 2')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (3, 101, N'Descripcion 3', CAST(3.45 AS Decimal(10, 2)), N'Dimensiones 3')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (4, 102, N'Descripcion 4', CAST(4.45 AS Decimal(10, 2)), N'Dimensiones 4')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (5, 103, N'Descripcion 5', CAST(5.45 AS Decimal(10, 2)), N'Dimensiones 5')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (6, 101, N'Descripcion 6', CAST(6.45 AS Decimal(10, 2)), N'Dimensiones 6')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (7, 102, N'Descripcion 7', CAST(7.45 AS Decimal(10, 2)), N'Dimensiones 7')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (8, 103, N'Descripcion 8', CAST(8.45 AS Decimal(10, 2)), N'Dimensiones 8')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (9, 101, N'Descripcion 9', CAST(9.45 AS Decimal(10, 2)), N'Dimensiones 9')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (10, 102, N'Descripcion 10', CAST(10.45 AS Decimal(10, 2)), N'Dimensiones 0')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (11, 103, N'Descripcion 11', CAST(11.45 AS Decimal(10, 2)), N'Dimensiones 1')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (12, 101, N'Descripcion 12', CAST(12.45 AS Decimal(10, 2)), N'Dimensiones 2')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (13, 102, N'Descripcion 13', CAST(13.45 AS Decimal(10, 2)), N'Dimensiones 3')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (14, 103, N'Descripcion 144', CAST(14.45 AS Decimal(10, 2)), N'Dimensiones 4')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (15, 101, N'Descripcion 15', CAST(15.45 AS Decimal(10, 2)), N'Dimensiones 5')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (16, 102, N'Descripcion 16', CAST(16.45 AS Decimal(10, 2)), N'Dimensiones 6')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (17, 103, N'Descripcion 17', CAST(17.45 AS Decimal(10, 2)), N'Dimensiones 7')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (18, 101, N'Descripcion 18', CAST(18.45 AS Decimal(10, 2)), N'Dimensiones 8')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (19, 102, N'Descripcion 19', CAST(19.45 AS Decimal(10, 2)), N'Dimensiones 9')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (20, 103, N'Descripcion 20', CAST(20.45 AS Decimal(10, 2)), N'Dimensiones 0')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (25, 109, N'asdas', CAST(3.00 AS Decimal(10, 2)), N'asdasdas')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (26, 109, N'asdas', CAST(2343.00 AS Decimal(10, 2)), N'4234')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (27, 124, N'dd', CAST(3.00 AS Decimal(10, 2)), N'dd')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (28, 124, N'ww', CAST(4.00 AS Decimal(10, 2)), N'ww')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (29, 124, N'tt', CAST(2.01 AS Decimal(10, 2)), N'tt')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (30, 125, N'gg', CAST(6.00 AS Decimal(10, 2)), N'gg')
INSERT [dbo].[EnvioDetalles] ([EnvioDetalleID], [EnvioID], [DescripcionBulto], [Peso], [Dimensiones]) VALUES (31, 125, N'44', CAST(5.00 AS Decimal(10, 2)), N'gtg')
SET IDENTITY_INSERT [dbo].[EnvioDetalles] OFF
GO
SET IDENTITY_INSERT [dbo].[Envios] ON 

INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (101, 82, N'Dirección 1', 12, N'ProveedorPaqueteria 1', N'En tránsito', CAST(N'2024-10-10T01:53:18.553' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (102, 83, N'Dirección 2', 13, N'ProveedorPaqueteria 2', N'Pendiente', CAST(N'2024-10-10T01:53:18.553' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (103, 84, N'Dirección 3', 14, N'ProveedorPaqueteria 3', N'En tránsito', CAST(N'2024-10-10T01:53:18.553' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (104, 85, N'Dirección 4', 15, N'ProveedorPaqueteria 4', N'Pendiente', CAST(N'2024-10-10T01:53:18.553' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (105, 86, N'Dirección 5', 16, N'ProveedorPaqueteria 5', N'En tránsito', CAST(N'2024-10-10T01:53:18.553' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (106, 87, N'Dirección 6', 17, N'ProveedorPaqueteria 6', N'Pendiente', CAST(N'2024-10-10T01:53:18.553' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (107, 88, N'Dirección 7', 18, N'ProveedorPaqueteria 7', N'En tránsito', CAST(N'2024-10-10T01:53:18.553' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (108, 89, N'Dirección 8', 19, N'ProveedorPaqueteria 8', N'Pendiente', CAST(N'2024-10-10T01:53:18.553' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (109, 90, N'Dirección 9', 20, N'ProveedorPaqueteria 9', N'En tránsito', CAST(N'2024-12-28T01:53:18.553' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (112, 83, N'Dirección 12', 13, N'ProveedorPaqueteria 2', N'Pendiente', CAST(N'2024-10-10T01:53:18.553' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (113, 84, N'Dirección 13', 14, N'ProveedorPaqueteria 3', N'En tránsito', CAST(N'2024-10-10T01:53:18.553' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (114, 85, N'Dirección 14', 15, N'ProveedorPaqueteria 4', N'Pendiente', CAST(N'2024-10-10T01:53:18.553' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (117, 88, N'Dirección 17', 18, N'ProveedorPaqueteria 7', N'En tránsito', CAST(N'2024-10-10T01:53:18.553' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (118, 89, N'Dirección 18', 19, N'ProveedorPaqueteria 8', N'En tránsito', CAST(N'2024-10-10T01:53:18.553' AS DateTime), N'b8cc3a49-dbc0-4c73-bb74-e4da2899e6f1')
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (119, 90, N'Dirección 19', 20, N'ProveedorPaqueteria 9', N'En tránsito', CAST(N'2024-10-10T01:53:18.553' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (121, 90, N'as', 11, N'sdaff', N'Pendiente', CAST(N'2024-10-10T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (122, 90, N'saasas', 11, N'ddd', N'Pendiente', CAST(N'2024-10-07T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (123, 81, N'aaa', 20, N'dsds', N'En tránsito', CAST(N'2024-10-01T00:00:00.000' AS DateTime), N'86e7486e-12af-4388-a5d1-752879d454d2')
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (124, 90, N'sss', 11, N'ddd', N'Pendiente', CAST(N'2024-10-11T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Envios] ([EnvioID], [ClienteID], [DireccionDestino], [ProvinciaID], [ProveedorPaqueteria], [EstadoEnvio], [FechaEnvio], [CodigoSeguimiento]) VALUES (125, 89, N'123', 12, N'eeeee', N'En tránsito', CAST(N'2024-10-05T00:00:00.000' AS DateTime), N'427c8781-e41c-468e-a04e-94f93892adf4')
SET IDENTITY_INSERT [dbo].[Envios] OFF
GO
SET IDENTITY_INSERT [dbo].[Provincias] ON 

INSERT [dbo].[Provincias] ([ProvinciaID], [Nombre]) VALUES (11, N'Provincia 1')
INSERT [dbo].[Provincias] ([ProvinciaID], [Nombre]) VALUES (12, N'Provincia 2')
INSERT [dbo].[Provincias] ([ProvinciaID], [Nombre]) VALUES (13, N'Provincia 3')
INSERT [dbo].[Provincias] ([ProvinciaID], [Nombre]) VALUES (14, N'Provincia 4')
INSERT [dbo].[Provincias] ([ProvinciaID], [Nombre]) VALUES (15, N'Provincia 5')
INSERT [dbo].[Provincias] ([ProvinciaID], [Nombre]) VALUES (16, N'Provincia 6')
INSERT [dbo].[Provincias] ([ProvinciaID], [Nombre]) VALUES (17, N'Provincia 7')
INSERT [dbo].[Provincias] ([ProvinciaID], [Nombre]) VALUES (18, N'Provincia 8')
INSERT [dbo].[Provincias] ([ProvinciaID], [Nombre]) VALUES (19, N'Provincia 9')
INSERT [dbo].[Provincias] ([ProvinciaID], [Nombre]) VALUES (20, N'Provincia 10')
SET IDENTITY_INSERT [dbo].[Provincias] OFF
GO
ALTER TABLE [dbo].[EnvioDetalles]  WITH CHECK ADD  CONSTRAINT [FK_EnvioDetalles_Envios] FOREIGN KEY([EnvioID])
REFERENCES [dbo].[Envios] ([EnvioID])
GO
ALTER TABLE [dbo].[EnvioDetalles] CHECK CONSTRAINT [FK_EnvioDetalles_Envios]
GO
ALTER TABLE [dbo].[Envios]  WITH CHECK ADD  CONSTRAINT [FK_Envios_Clientes] FOREIGN KEY([ClienteID])
REFERENCES [dbo].[Clientes] ([ClienteID])
GO
ALTER TABLE [dbo].[Envios] CHECK CONSTRAINT [FK_Envios_Clientes]
GO
ALTER TABLE [dbo].[Envios]  WITH CHECK ADD  CONSTRAINT [FK_Envios_Provincias] FOREIGN KEY([ProvinciaID])
REFERENCES [dbo].[Provincias] ([ProvinciaID])
GO
ALTER TABLE [dbo].[Envios] CHECK CONSTRAINT [FK_Envios_Provincias]
GO
USE [master]
GO
ALTER DATABASE [Pt] SET  READ_WRITE 
GO

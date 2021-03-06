USE [master]
GO
/****** Object:  Database [NegozioDischi]    Script Date: 16/07/2021 15:03:33 ******/
CREATE DATABASE [NegozioDischi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NegozioDischi', FILENAME = N'C:\Users\Laura Martines\NegozioDischi.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'NegozioDischi_log', FILENAME = N'C:\Users\Laura Martines\NegozioDischi_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [NegozioDischi] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NegozioDischi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NegozioDischi] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NegozioDischi] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NegozioDischi] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NegozioDischi] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NegozioDischi] SET ARITHABORT OFF 
GO
ALTER DATABASE [NegozioDischi] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NegozioDischi] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NegozioDischi] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NegozioDischi] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NegozioDischi] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NegozioDischi] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NegozioDischi] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NegozioDischi] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NegozioDischi] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NegozioDischi] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NegozioDischi] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NegozioDischi] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NegozioDischi] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NegozioDischi] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NegozioDischi] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NegozioDischi] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NegozioDischi] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NegozioDischi] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NegozioDischi] SET  MULTI_USER 
GO
ALTER DATABASE [NegozioDischi] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NegozioDischi] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NegozioDischi] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NegozioDischi] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NegozioDischi] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [NegozioDischi] SET QUERY_STORE = OFF
GO
USE [NegozioDischi]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [NegozioDischi]
GO
/****** Object:  Table [dbo].[Album]    Script Date: 16/07/2021 15:03:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Album](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Titolo] [nvarchar](50) NOT NULL,
	[AnnoUscita] [int] NOT NULL,
	[CasaDiscografica] [nvarchar](50) NOT NULL,
	[Genere] [nvarchar](10) NOT NULL,
	[Supporto] [nvarchar](10) NOT NULL,
	[BandID] [int] NOT NULL,
 CONSTRAINT [PK_Album] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UNQ_Album] UNIQUE NONCLUSTERED 
(
	[Titolo] ASC,
	[AnnoUscita] ASC,
	[CasaDiscografica] ASC,
	[Genere] ASC,
	[Supporto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ufnAlbumPerGenere]    Script Date: 16/07/2021 15:03:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ufnAlbumPerGenere]
(
	-- Add the parameters for the function here
	@Genere nvarchar(10)
)
RETURNS TABLE
AS
	
	RETURN (SELECT
				a.Genere AS [Genere Album],
				Count(DISTINCT a.Titolo) AS [Numero Album]
			FROM Album a
			WHERE a.Genere = 'Pop'
			GROUP BY a.Genere)
GO
/****** Object:  Table [dbo].[Brano]    Script Date: 16/07/2021 15:03:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brano](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Titolo] [nvarchar](50) NOT NULL,
	[Durata] [smallint] NOT NULL,
 CONSTRAINT [PK_Brano] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Band]    Script Date: 16/07/2021 15:03:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Band](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](50) NOT NULL,
	[NumeroComponenti] [smallint] NOT NULL,
 CONSTRAINT [PK_Band] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlbumBrano]    Script Date: 16/07/2021 15:03:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlbumBrano](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AlbumID] [int] NOT NULL,
	[BranoID] [int] NOT NULL,
 CONSTRAINT [PK_AlbumBrano] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DatiAlbum]    Script Date: 16/07/2021 15:03:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DatiAlbum] AS
SELECT 	
	a.Titolo as [Titolo Album],
	a.AnnoUscita, 
	a.CasaDiscografica,
	a.Genere,
	a.Supporto,
	b.Nome as [Nome Band],
	b.NumeroComponenti, 
	br.Titolo as [Titolo Brano],
	br.Durata
FROM Album a
INNER JOIN Band b
ON a.BandID=b.ID
	INNER JOIN AlbumBrano ab
	ON a.ID=ab.AlbumID
		INNER JOIN Brano br
		ON ab.BranoID = br.ID
GO
ALTER TABLE [dbo].[Album]  WITH CHECK ADD  CONSTRAINT [FK_Album_Band] FOREIGN KEY([BandID])
REFERENCES [dbo].[Band] ([ID])
GO
ALTER TABLE [dbo].[Album] CHECK CONSTRAINT [FK_Album_Band]
GO
ALTER TABLE [dbo].[AlbumBrano]  WITH CHECK ADD  CONSTRAINT [FK_AlbumBrano_Album] FOREIGN KEY([AlbumID])
REFERENCES [dbo].[Album] ([ID])
GO
ALTER TABLE [dbo].[AlbumBrano] CHECK CONSTRAINT [FK_AlbumBrano_Album]
GO
ALTER TABLE [dbo].[AlbumBrano]  WITH CHECK ADD  CONSTRAINT [FK_AlbumBrano_Brano] FOREIGN KEY([BranoID])
REFERENCES [dbo].[Brano] ([ID])
GO
ALTER TABLE [dbo].[AlbumBrano] CHECK CONSTRAINT [FK_AlbumBrano_Brano]
GO
ALTER TABLE [dbo].[Album]  WITH CHECK ADD  CONSTRAINT [CK_Genere] CHECK  (([Genere]='Metal' OR [Genere]='Rock' OR [Genere]='Pop' OR [Genere]='Jazz' OR [Genere]='Classico'))
GO
ALTER TABLE [dbo].[Album] CHECK CONSTRAINT [CK_Genere]
GO
ALTER TABLE [dbo].[Album]  WITH CHECK ADD  CONSTRAINT [CK_Supporto] CHECK  (([Supporto]='Streaming' OR [Supporto]='Vinile' OR [Supporto]='CD'))
GO
ALTER TABLE [dbo].[Album] CHECK CONSTRAINT [CK_Supporto]
GO
/****** Object:  StoredProcedure [dbo].[sp_AlbumPerBand]    Script Date: 16/07/2021 15:03:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AlbumPerBand]
	-- Add the parameters for the stored procedure here
	@NomeBand nvarchar(50)
AS
BEGIN
	SELECT DISTINCT a.Titolo AS [Titolo album]
	FROM Album a
	INNER JOIN Band b
	ON b.ID=a.BandID
	WHERE b.Nome = @NomeBand;
	RETURN 0;
END
GO
USE [master]
GO
ALTER DATABASE [NegozioDischi] SET  READ_WRITE 
GO

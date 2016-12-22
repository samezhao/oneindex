/***********************************************************************
Copyright 2016, @Sam Zhao- 
MIT License, http://www.opensource.org/licenses/mit-license.php
Object:  StoredProcedure[]   Script Date: 9/12/2016
***********************************************************************/


USE [yourdatabasename]
GO

/****** Object:  Table [dbo].[temptbl_dba_tableratio]    Script Date: 12/06/2016 12:38:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temptbl_dba_tableratio]') AND type in (N'U'))
DROP TABLE [dbo].[temptbl_dba_tableratio]
GO


/****** Object:  Table [dbo].[temptbl_dba_tableratio]    Script Date: 12/06/2016 12:38:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[temptbl_dba_tableratio](
	[utable_name] [nvarchar](128) NULL,
	[reads] [bigint] NULL,
	[writes] [bigint] NULL,
	[ratios] [bigint] NULL,
	[get_datetime] [varchar](10) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[temptbl_dba_tableinfo]    Script Date: 12/06/2016 12:38:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temptbl_dba_tableinfo]') AND type in (N'U'))
DROP TABLE [dbo].[temptbl_dba_tableinfo]
GO


/****** Object:  Table [dbo].[temptbl_dba_tableinfo]    Script Date: 12/06/2016 12:38:37 ******/
SET ANSI_NULLS ON
GO



SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[temptbl_dba_tableinfo](
	[utable_name] [varchar](128) NULL,
	[rows] [bigint] NULL,
	[reserved_gb] [numeric](7, 5) NULL,
	[index_gb] [numeric](7, 5) NULL,
	[unused_kb] [numeric](7, 0) NULL,
	[avgRow_kb] [numeric](7, 5) NULL,
	[get_datetime] [varchar](10) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



/****** Object:  Table [dbo].[temptbl_dba_indexusage]    Script Date: 12/06/2016 12:38:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temptbl_dba_indexusage]') AND type in (N'U'))
DROP TABLE [dbo].[temptbl_dba_indexusage]
GO


/****** Object:  Table [dbo].[temptbl_dba_indexusage]    Script Date: 12/06/2016 12:38:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[temptbl_dba_indexusage](
	[utable_name] [nvarchar](128) NULL,
	[uindex_name] [sysname] NULL,
	[user_seeks] [bigint] NOT NULL,
	[user_scans] [bigint] NOT NULL,
	[user_lookups] [bigint] NOT NULL,
	[user_updates] [bigint] NOT NULL,
	[user_reads] [bigint] NULL,
	[user_writes] [bigint] NOT NULL,
	[last_user_scan] [datetime] NULL,
	[last_user_update] [datetime] NULL,
	[row_count] [bigint] NULL,
	[get_datetime] [varchar](10) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO




/****** Object:  Table [dbo].[temptbl_dba_indexupdate]    Script Date: 12/06/2016 12:38:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temptbl_dba_indexupdate]') AND type in (N'U'))
DROP TABLE [dbo].[temptbl_dba_indexupdate]
GO



/****** Object:  Table [dbo].[temptbl_dba_indexupdate]    Script Date: 12/06/2016 12:38:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[temptbl_dba_indexupdate](
	[utable_name] [varchar](128) NULL,
	[uindex_name] [varchar](128) NULL,
	[partition] [int] NOT NULL,
	[Index_ID] [int] NOT NULL,
	[index_type] [nvarchar](60) NULL,
	[update_percent] [decimal](10, 7) NULL,
	[get_datetime] [varchar](10) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO




/****** Object:  Table [dbo].[temptbl_dba_indexfrag]    Script Date: 12/06/2016 12:38:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temptbl_dba_indexfrag]') AND type in (N'U'))
DROP TABLE [dbo].[temptbl_dba_indexfrag]
GO


/****** Object:  Table [dbo].[temptbl_dba_indexfrag]    Script Date: 12/06/2016 12:38:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[temptbl_dba_indexfrag](
	[utable_name] [nvarchar](128) NULL,
	[uindex_name] [nvarchar](128) NULL,
	[index_type_desc] [nvarchar](60) NULL,
	[partition_number] [int] NULL,
	[alloc_unit_type_desc] [nvarchar](60) NULL,
	[index_depth] [tinyint] NULL,
	[index_level] [tinyint] NULL,
	[avg_frag_percent] [smallint] NULL,
	[avg_frag_size_in_pages] [smallint] NULL,
	[fragment_count] [bigint] NULL,
	[page_count] [bigint] NULL,
	[get_datetime] [varchar](10) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



/****** Object:  Table [dbo].[temptbl_dba_indexcolumns]    Script Date: 12/06/2016 12:38:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[temptbl_dba_indexcolumns]') AND type in (N'U'))
DROP TABLE [dbo].[temptbl_dba_indexcolumns]
GO



/****** Object:  Table [dbo].[temptbl_dba_indexcolumns]    Script Date: 12/06/2016 12:38:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[temptbl_dba_indexcolumns](
	[utable_name] [varchar](128) NOT NULL,
	[uindex_name] [varchar](128) NULL,
	[index_tyoe] [nvarchar](60) NULL,
	[index_keys] [varchar](max) NULL,
	[included_columns] [varchar](max) NULL,
	[partition_keys] [varchar](max) NULL,
	[is_Primary_key] [bit] NULL,
	[is_unique] [bit] NULL,
	[is_unique_constraint] [bit] NULL,
	[is_Filtered_index] [bit] NULL,
	[FilterDefinition] [nvarchar](max) NULL,
	[get_datetime] [varchar](10) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



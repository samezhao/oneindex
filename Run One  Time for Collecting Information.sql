/***********************************************************************
Copyright 2016, @Sam Zhao- 
MIT License, http://www.opensource.org/licenses/mit-license.php
Object:  StoredProcedure[]   Script Date: 29/12/2016
***********************************************************************/





 
--/***************************************************************************************************

--/***************************************************************************************************

--/*********************************创建收集信息的临时表**********************************************

--/***************************************************************************************************

--/***************************************************************************************************

--/***************************************************************************************************



USE [tracereport]
GO

 

/****** Object:  Table [dbo].[#temptbl_dba_tableratio]    Script Date: 12/06/2016 12:38:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'#temptbl_dba_tableratio') AND type in (N'U'))
DROP TABLE [dbo].[#temptbl_dba_tableratio]
GO



CREATE TABLE [dbo].[#temptbl_dba_tableratio](
	[utable_name] [nvarchar](128) NULL,
	[reads] [bigint] NULL,
	[writes] [bigint] NULL,
	[ratios] [bigint] NULL,
	[get_datetime] [varchar](10) NULL
) ON [PRIMARY]

GO

 

/****** Object:  Table [dbo].[#temptbl_dba_tableinfo]    Script Date: 12/06/2016 12:38:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[#temptbl_dba_tableinfo]') AND type in (N'U'))
DROP TABLE [dbo].[#temptbl_dba_tableinfo]
GO

 
 

CREATE TABLE [dbo].[#temptbl_dba_tableinfo](
	[utable_name] [varchar](128) NULL,
	[rows] [bigint] NULL,
	[reserved_gb] [numeric](7, 5) NULL,
	[index_gb] [numeric](7, 5) NULL,
	[unused_kb] [numeric](7, 0) NULL,
	[avgRow_kb] [numeric](7, 5) NULL,
	[get_datetime] [varchar](10) NULL
) ON [PRIMARY]

GO
 



/****** Object:  Table [dbo].[#temptbl_dba_indexusage]    Script Date: 12/06/2016 12:38:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[#temptbl_dba_indexusage]') AND type in (N'U'))
DROP TABLE [dbo].[#temptbl_dba_indexusage]
GO

CREATE TABLE [dbo].[#temptbl_dba_indexusage](
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



/****** Object:  Table [dbo].[#temptbl_dba_indexupdate]    Script Date: 12/06/2016 12:38:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[#temptbl_dba_indexupdate]') AND type in (N'U'))
DROP TABLE [dbo].[#temptbl_dba_indexupdate]
GO

CREATE TABLE [dbo].[#temptbl_dba_indexupdate](
	[utable_name] [varchar](128) NULL,
	[uindex_name] [varchar](128) NULL,
	[partition] [int] NOT NULL,
	[Index_ID] [int] NOT NULL,
	[index_type] [nvarchar](60) NULL,
	[update_percent] [decimal](10, 7) NULL,
	[get_datetime] [varchar](10) NULL
) ON [PRIMARY]

GO




/****** Object:  Table [dbo].[#temptbl_dba_indexfrag]    Script Date: 12/06/2016 12:38:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[#temptbl_dba_indexfrag]') AND type in (N'U'))
DROP TABLE [dbo].[#temptbl_dba_indexfrag]
GO

CREATE TABLE [dbo].[#temptbl_dba_indexfrag](
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

/****** Object:  Table [dbo].[#temptbl_dba_indexcolumns]    Script Date: 12/06/2016 12:38:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[#temptbl_dba_indexcolumns]') AND type in (N'U'))
DROP TABLE [dbo].[#temptbl_dba_indexcolumns]
GO                  


CREATE TABLE [dbo].[#temptbl_dba_indexcolumns](
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
	[is_disabled] [nchar](10) NULL,
	[fill_factor] [nchar](10) NULL,
	[get_datetime] [varchar](10) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


GO

--/***************************************************************************************************

--/***************************************************************************************************

--/*********************************创建收集信息的存储过程********************************************

--/***************************************************************************************************

--/***************************************************************************************************

--/***************************************************************************************************





/****** Object:  StoredProcedure [dbo].[dba_sp_IndexUpdate]    Script Date: 12/06/2016 12:40:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dba_sp_IndexUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dba_sp_IndexUpdate]
GO



--////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[dba_sp_IndexUpdate]

AS
BEGIN

  SET NOCOUNT ON;
 
 
 INSERT INTO [dbo].[#temptbl_dba_indexupdate]
           ([utable_name]
           ,[uindex_name]
           ,[partition]
           ,[Index_ID]
           ,[index_type]
           ,[update_percent]
           ,[get_datetime])

SELECT o.name AS [utable_name], x.name AS [uindex_name],
       i.partition_number AS [partition],
       i.index_id AS [Index_ID], x.type_desc AS [index_type],
       CONVERT(decimal(10,7), i.leaf_update_count * 100.0 /
           (i.range_scan_count + i.leaf_insert_count
            + i.leaf_delete_count + i.leaf_update_count
            + i.leaf_page_merge_count + i.singleton_lookup_count)
           ) AS [update_percent] ,CONVERT(varchar(10), GETDATE(), 120) as 'getdatetime'
           --into temptbl_dba_indexupdate
FROM sys.dm_db_index_operational_stats (db_id(), NULL, NULL, NULL) i
JOIN sys.objects o ON o.object_id = i.object_id
JOIN sys.indexes x ON x.object_id = i.object_id AND x.index_id = i.index_id
WHERE (i.range_scan_count + i.leaf_insert_count
       + i.leaf_delete_count + leaf_update_count
       + i.leaf_page_merge_count + i.singleton_lookup_count) > 0
       and i.leaf_update_count * 100.0 /
           (i.range_scan_count + i.leaf_insert_count
            + i.leaf_delete_count + i.leaf_update_count
            + i.leaf_page_merge_count + i.singleton_lookup_count
           )>0.0000001
AND objectproperty(i.object_id,'IsUserTable') = 1
ORDER BY [update_percent] desc
 
END



GO


/****** Object:  StoredProcedure [dbo].[dba_sp_IndexFrag]    Script Date: 12/06/2016 12:40:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dba_sp_IndexFrag]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dba_sp_IndexFrag]
GO


--////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[dba_sp_IndexFrag]

AS
BEGIN

  SET NOCOUNT ON;
 
 
           
INSERT INTO [dbo].[#temptbl_dba_indexfrag]
           ([utable_name]
           ,[uindex_name]
           ,[index_type_desc]
           ,[partition_number]
           ,[alloc_unit_type_desc]
           ,[index_depth]
           ,[index_level]
           ,[avg_frag_percent]
           ,[avg_frag_size_in_pages]
           ,[fragment_count]
           ,[page_count]
           ,[get_datetime])

SELECT OBJECT_NAME(ddips.[object_id], DB_ID())  AS [utable_name],
       i.[name] AS [uindex_name],
       ddips.[index_type_desc],
       ddips.[partition_number],
       ddips.[alloc_unit_type_desc],
       ddips.[index_depth],
       ddips.[index_level],
       CAST(ddips.[avg_fragmentation_in_percent] AS SMALLINT) AS [avg_frag_percent],
       CAST(ddips.[avg_fragment_size_in_pages] AS SMALLINT) AS [avg_frag_size_in_pages],
       ddips.[fragment_count],
       ddips.[page_count] ,
       CONVERT(varchar(10),getdate(),120) as get_datetime --into temptbl_dba_indexfrag
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'limited') ddips
INNER JOIN sys.[indexes] i ON ddips.[object_id] = i.[object_id]
AND ddips.[index_id] = i.[index_id]
WHERE ddips.[avg_fragmentation_in_percent] > 15
  AND ddips.[page_count] > 500
ORDER BY ddips.[avg_fragmentation_in_percent],
         OBJECT_NAME(ddips.[object_id], DB_ID()),
         i.[name]
 
END



GO

/****** Object:  StoredProcedure [dbo].[dba_sp_IndexColumn]    Script Date: 12/06/2016 12:40:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dba_sp_IndexColumn]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dba_sp_IndexColumn]
GO


--////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[dba_sp_IndexColumn]

AS
BEGIN

  SET NOCOUNT ON;
          

WITH indexCTE AS
(
    SELECT st.object_id                                                                         AS objectID
        , st.name                                                                               AS tableName
        , si.index_id                                                                           AS indexID
        , si.name                                                                               AS indexName
        , si.type_desc                                                                          AS indexType
        , sc.column_id                                                                          AS columnID
        , sc.name + CASE WHEN sic.is_descending_key = 1 THEN ' DESC' ELSE '' END                AS columnName
        , sic.key_ordinal                                                                       AS ordinalPosition
        , CASE WHEN sic.is_included_column = 0 AND key_ordinal > 0 THEN sc.name ELSE NULL END   AS indexKeys
        , CASE WHEN sic.is_included_column = 1 THEN sc.name ELSE NULL END                       AS includedColumns
        , sic.partition_ordinal                                                                 AS partitionOrdinal
        , CASE WHEN sic.partition_ordinal > 0 THEN sc.name ELSE NULL END                        AS partitionColumns
        , si.is_primary_key                                                                     AS isPrimaryKey
        , si.is_unique                                                                          AS isUnique
        , si.is_unique_constraint                                                               AS isUniqueConstraint
        , si.has_filter                                                                        AS isFilteredIndex
        , COALESCE(si.filter_definition, '')                                                    AS filterDefinition
        ,si.is_disabled AS  is_disabled
        ,si.fill_factor  AS fill_factor
         
    FROM sys.tables                         AS st
    INNER JOIN sys.indexes                  AS si 
        ON si.object_id =   st.object_id
    INNER JOIN sys.index_columns            AS sic 
	    ON sic.object_id=si.object_id
        AND sic.index_id=si.index_id 
    INNER JOIN sys.columns                  AS sc 
	    ON sc.object_id = sic.object_id 
	    and sc.column_id = sic.column_id
) 
 INSERT INTO [dbo].[#temptbl_dba_indexcolumns]
           ([utable_name]
           ,[uindex_name]
           ,[index_tyoe]
           ,[index_keys]
           ,[included_columns]
           ,[partition_keys]
           ,[is_Primary_key]
           ,[is_unique]
           ,[is_unique_constraint]
           ,[is_Filtered_index]
           ,[FilterDefinition]
           ,[is_disabled]  
           ,[fill_factor]
           ,[get_datetime])
SELECT DISTINCT 
      --@@SERVERNAME                                      AS ServerName
   -- , DB_NAME()   ,                                       AS DatabaseName
    tableName as table_name
    , indexName as index_name
    , indexType as index_tyoe
    , STUFF((
            SELECT ', ' + indexKeys
                FROM indexCTE
            WHERE objectID = cte.objectID
                AND indexID = cte.indexID
                AND indexKeys IS NOT NULL 
            ORDER BY ordinalPosition
                FOR XML PATH(''), 
      TYPE).value('.','varchar(max)'),1,1,'')           AS index_keys
    , COALESCE(STUFF((
            SELECT ', ' + includedColumns
                FROM indexCTE
            WHERE objectID = cte.objectID
                AND indexID = cte.indexID
                AND includedColumns IS NOT NULL 
            ORDER BY columnID
                FOR XML PATH(''), 
      TYPE).value('.','varchar(max)'),1,1,''), '')      AS included_columns
    , COALESCE(STUFF((
            SELECT ', ' + partitionColumns
                FROM indexCTE
            WHERE objectID = cte.objectID
                AND indexID = cte.indexID
                AND partitionColumns IS NOT NULL 
            ORDER BY partitionOrdinal
                FOR XML PATH(''), 
      TYPE).value('.','varchar(max)'),1,1,''), '')      AS partition_keys
    , isPrimaryKey as  is_Primary_key
    , isUnique as  is_unique
    , isUniqueConstraint as is_unique_constraint
    , isFilteredIndex AS  is_Filtered_index
    , FilterDefinition
    , is_disabled as is_disabled
    , fill_factor as fill_factor
    , CONVERT(varchar(10),GETDATE(),120) as get_datetime
   -- into temptbl_indexcolumnsinfo
FROM indexCTE AS cte
--WHERE tableName = @tablename
ORDER BY tableName
    , indexName;
 
END
 

/****** Object:  StoredProcedure [dbo].[dba_sp_IndexUsage]    Script Date: 12/06/2016 12:42:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dba_sp_IndexUsage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dba_sp_IndexUsage]
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[dba_sp_IndexUsage]

AS
BEGIN

  SET NOCOUNT ON;
 
INSERT INTO [dbo].[#temptbl_dba_indexusage]
           ([utable_name]
           ,[uindex_name]
           ,[user_seeks]
           ,[user_scans]
           ,[user_lookups]
           ,[user_updates]
           ,[user_reads]
           ,[user_writes]
           ,[last_user_scan]
           ,[last_user_update]
           ,[row_count]
           ,[get_datetime])
           
--查看索引使用情况
SELECT 
       a.*,t.row_count,CONVERT(varchar(10),getdate(),120) AS get_datetime --into  temptbl_indexusageinfo
FROM
  (SELECT --OBJECT_SCHEMA_NAME(i.object_id) AS SchemaName ,
          OBJECT_NAME(i.object_id) AS table_name ,
          i.name as index_name,
          ius.user_seeks ,
          ius.user_scans ,
          ius.user_lookups ,
          ius.user_updates,
          ius.user_seeks + ius.user_scans + ius.user_lookups AS user_reads ,
                                            ius.user_updates AS user_writes ,                                        
                                            ius.last_user_scan ,
                                            ius.last_user_update
   FROM sys.dm_db_index_usage_stats AS ius
   JOIN sys.indexes AS i ON i.index_id = ius.index_id
   WHERE ius.database_id = DB_ID()
     AND i.object_id = ius.object_id
     --AND OBJECT_NAME(i.object_id) =@tablename
     AND i.is_disabled = 0 ) a
   LEFT JOIN
  ( SELECT B.name,
           A.row_count
    FROM sys.dm_db_partition_stats AS A,
        sys.all_objects AS B
    WHERE A.object_id = B.object_id
     AND B.type != 'S'
     AND ROW_COUNT>10000
     AND A.ROW_COUNT IS NOT NULL
    GROUP BY name,ROW_COUNT ) t ON a.table_name =t.name 

ORDER BY table_name,name;
 
END



GO



/****** Object:  StoredProcedure [dbo].[dba_sp_TableInfo]    Script Date: 12/06/2016 12:42:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dba_sp_TableInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dba_sp_TableInfo]
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[dba_sp_TableInfo]

AS
BEGIN

  SET NOCOUNT ON;
  DECLARE @Databases1 VARCHAR(255);  


CREATE TABLE #tablespaceinfo
    (
      nameinfo VARCHAR(500) ,
      rowsinfo BIGINT ,
      reserved VARCHAR(20) ,
      datainfo VARCHAR(20) ,
      index_size VARCHAR(20) ,
      unused VARCHAR(20)
    )  
 
DECLARE @tablename VARCHAR(255);  

DECLARE Info_cursor CURSOR
FOR
    SELECT  '[' + [name] + ']'
    FROM    sys.tables
    WHERE   type = 'U';  
 
OPEN Info_cursor  
FETCH NEXT FROM Info_cursor INTO @tablename  
 
WHILE @@FETCH_STATUS = 0
    BEGIN 
        INSERT  INTO #tablespaceinfo
                EXEC sp_spaceused @tablename  
        FETCH NEXT FROM Info_cursor  
    INTO @tablename  
    END 
 
CLOSE Info_cursor  
DEALLOCATE Info_cursor  
 
--创建临时表
CREATE TABLE [#tmptb]
    (
      TableName VARCHAR(50) ,
      DataInfo BIGINT ,
      RowsInfo BIGINT ,
      Spaceperrow  AS ( CASE RowsInfo
                         WHEN 0 THEN 0
                         ELSE CAST(DataInfo AS decimal(18,2))/CAST(RowsInfo AS decimal(18,2))
                       END ) PERSISTED
    )




--插入数据到临时表
INSERT  INTO [#tmptb]
        ( [TableName] ,
          [DataInfo] ,
          [RowsInfo]
        )
        SELECT  [nameinfo] ,
                CAST(REPLACE([datainfo], 'KB', '') AS BIGINT) AS 'datainfo' ,
                --[datainfo] AS 'datainfo' ,
                [rowsinfo]
        FROM    #tablespaceinfo WHERE [RowsInfo]>9999
        ORDER BY CAST(REPLACE(reserved, 'KB', '') AS INT) DESC  


--汇总记录

--INSERT INTO dbo.#temptbl_dba_tableinfo
--    (	   [utable_name]
--		   ,[rows]
--           ,[reserved_gb]
--           ,[index_gb]
--           ,[unused_kb]
--           ,[avgRow_kb]
--           ,[get_datetime])

SELECT  [tbspinfo].nameinfo
, [tbspinfo].rowsinfo 
,CAST(ROUND(CAST(REPLACE([reserved], 'KB', '') AS INT)/1024.0/1024.0,5) AS numeric(7,5)) AS  'reserved(GB)'
,CAST(ROUND(CAST(REPLACE([index_size], 'KB', '') AS INT)/1024.0/1024.0,5) AS numeric(7,5)) AS  'index(GB)'
,CAST(ROUND(CAST(REPLACE(unused, 'KB', '') AS INT),5) AS numeric(7)) AS  'unused(KB)'
,CAST(ROUND([tmptb].[Spaceperrow],5) AS numeric(7,5)) AS 'avgRow(KB)',CONVERT(varchar(10), GETDATE(), 120) as 'getdatetime'
--Into master.dbo.dba_usetable_datainfo
FROM    [#tablespaceinfo] AS tbspinfo ,
        [#tmptb] AS tmptb
WHERE   [tbspinfo].[nameinfo] = [tmptb].[TableName]
ORDER BY CAST(REPLACE([tbspinfo].[reserved], 'KB', '') AS INT) DESC  
 
DROP TABLE [#tablespaceinfo]
DROP TABLE [#tmptb]
END

GO


/****** Object:  StoredProcedure [dbo].[dba_sp_TableRatio]    Script Date: 12/06/2016 12:43:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dba_sp_TableRatio]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dba_sp_TableRatio]
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE [dbo].[dba_sp_TableRatio]

AS
BEGIN

  SET NOCOUNT ON;
 
 
INSERT INTO [dbo].[#temptbl_dba_tableratio]
           ([utable_name]
           ,[reads]
           ,[writes]
           ,[ratios]
           ,[get_datetime]) 
 
SELECT table_name = object_name(s.object_id),
       reads = SUM(user_seeks + user_scans + user_lookups), 
       writes = SUM(user_updates),       
       ratios=CONVERT(BIGINT,SUM(user_seeks + user_scans + user_lookups))*100/( SUM(user_updates)+SUM(user_seeks + user_scans + user_lookups))
       ,CONVERT(varchar(10),GETDATE(),120) as get_datetime
       --into select *from temptbl_dba_tableratio
FROM sys.dm_db_index_usage_stats AS s
INNER JOIN sys.indexes AS i
ON s.object_id = i.object_id
AND i.index_id = s.index_id
WHERE objectproperty(s.object_id,'IsUserTable') = 1
 and user_updates>1
--AND s.database_id = @dbid
--AND object_name(s.object_id)=''
GROUP BY object_name(s.object_id)

ORDER BY writes DESC
 
END




GO




--/***************************************************************************************************

--/***************************************************************************************************

--/*********************************查询汇总后的信息**************************************************

--/***************************************************************************************************

--/***************************************************************************************************

--/***************************************************************************************************





--////////////////////////////////////////////////////////////////////////////////////////////////////////
SELECT    dbo.#temptbl_dba_indexcolumns.utable_name as '表名'			
		, dbo.#temptbl_dba_tableratio.ratios as '表读写比'	
	    , dbo.#temptbl_dba_tableratio.reads  as '表读次数'		
		, dbo.#temptbl_dba_tableratio.writes as '表写次数'	
		, dbo.#temptbl_dba_tableinfo.reserved_gb as '表大小(GB)'	
		, dbo.#temptbl_dba_tableinfo.rows as '表行数'	
		--, dbo.#temptbl_dba_tableinfo.unused_kb	
		, dbo.#temptbl_dba_indexcolumns.uindex_name as '索引名称' 
		, dbo.#temptbl_dba_indexcolumns.is_disabled as '是否可用' 	
		, dbo.#temptbl_dba_tableinfo.index_gb	as '索引大小(MB)'
		, dbo.#temptbl_dba_indexcolumns.fill_factor	as '填充因子'
		, dbo.#temptbl_dba_indexfrag.avg_frag_percent as '索引碎片%'	
		, dbo.#temptbl_dba_indexfrag.index_type_desc as '索引类型' 	
		, dbo.#temptbl_dba_indexupdate.update_percent as '索引更新比率%'	
		, dbo.#temptbl_dba_indexfrag.index_depth '索引深度'	
		, dbo.#temptbl_dba_indexfrag.page_count '索引包含页数'	
	    , dbo.#temptbl_dba_indexcolumns.index_keys as '索引字段'		
		, dbo.#temptbl_dba_indexcolumns.included_columns as '索引包含字段' 	
		, dbo.#temptbl_dba_indexcolumns.is_Primary_key as '是否主键'	
		, dbo.#temptbl_dba_indexcolumns.is_unique as '是否唯一'	
		--, dbo.#temptbl_dba_indexcolumns.is_unique_constraint	
			
		, dbo.#temptbl_dba_indexusage.user_seeks	 as'被Seek次数'
		, dbo.#temptbl_dba_indexusage.user_scans	 as'被Scan次数'
		, dbo.#temptbl_dba_indexusage.user_lookups	 as'被书签查找次数'
		, dbo.#temptbl_dba_indexusage.user_updates	 as'被更新次数'
		, dbo.#temptbl_dba_indexusage.user_reads	 as'被读取次数'
		, dbo.#temptbl_dba_indexusage.user_writes	 as'被写人次数'
		, dbo.#temptbl_dba_indexusage.last_user_scan	 as'最后被Scan时间'
		, dbo.#temptbl_dba_indexusage.last_user_update	as '索引最后被更新时间'
		, dbo.#temptbl_dba_indexusage.get_datetime     as '抓取数据时间' 	
			
           	
FROM  dbo.#temptbl_dba_indexcolumns			
LEFT JOIN   dbo.#temptbl_dba_tableinfo   ON dbo.#temptbl_dba_tableinfo.utable_name = dbo.#temptbl_dba_indexcolumns.utable_name    AND dbo.#temptbl_dba_tableinfo.get_datetime  = dbo.#temptbl_dba_indexcolumns.get_datetime                   			
LEFT JOIN   dbo.#temptbl_dba_tableratio  ON dbo.#temptbl_dba_tableratio.utable_name = dbo.#temptbl_dba_indexcolumns.utable_name   AND dbo.#temptbl_dba_tableratio.get_datetime = dbo.#temptbl_dba_indexcolumns.get_datetime			
LEFT JOIN   dbo.#temptbl_dba_indexusage  ON dbo.#temptbl_dba_indexusage.uindex_name = dbo.#temptbl_dba_indexcolumns.uindex_name   AND dbo.#temptbl_dba_indexusage.get_datetime = dbo.#temptbl_dba_indexcolumns.get_datetime			
LEFT JOIN   dbo.#temptbl_dba_indexupdate ON     dbo.#temptbl_dba_indexupdate.uindex_name = dbo.#temptbl_dba_indexcolumns.uindex_name  AND dbo.#temptbl_dba_indexupdate.get_datetime = dbo.#temptbl_dba_indexcolumns.get_datetime			
LEFT JOIN   dbo.#temptbl_dba_indexfrag   ON dbo.#temptbl_dba_indexfrag.uindex_name = dbo.#temptbl_dba_indexcolumns.uindex_name  AND dbo.#temptbl_dba_indexfrag.get_datetime = dbo.#temptbl_dba_indexcolumns.get_datetime                			
                      			
--WHERE (dbo.#temptbl_dba_indexcolumns.get_datetime = '')			
			
ORDER BY dbo.#temptbl_dba_indexcolumns.utable_name  	




		

---清除产生的对象
   drop table  #temptbl_dba_tableinfo 
   drop table #temptbl_dba_indexupdate
   drop table #temptbl_dba_tableratio
   drop table #temptbl_dba_indexusage
   drop table #temptbl_dba_indexfrag
   drop table #temptbl_dba_indexcolumns
   drop PROCEDURE [dbo].[dba_sp_IndexFrag]   
   drop PROCEDURE [dbo].[dba_sp_IndexUpdate]   
   drop PROCEDURE [dbo].[dba_sp_IndexUsage]   
   drop PROCEDURE [dbo].[dba_sp_TableInfo]  
   drop PROCEDURE [dbo].[dba_sp_TableRatio]
   drop PROCEDURE [dbo].[dba_sp_IndexColumn]
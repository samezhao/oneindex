/****** Object:  StoredProcedure[]   Script Date: 9/9/2016-12 ******/
--////////////////////////////////////////////////////////////////////////////////////////////////////////
SELECT    dbo.temptbl_dba_indexcolumns.utable_name as '表名'			
		, dbo.temptbl_dba_tableratio.ratios as '表读写比'	
	    , dbo.temptbl_dba_tableratio.reads  as '表读次数'		
		, dbo.temptbl_dba_tableratio.writes as '表写次数'	
		, dbo.temptbl_dba_tableinfo.reserved_gb as '表大小(GB)'	
		, dbo.temptbl_dba_tableinfo.rows as '表行数'	
		--, dbo.temptbl_dba_tableinfo.unused_kb	
		, dbo.temptbl_dba_indexcolumns.uindex_name as '索引名称' 
		, dbo.temptbl_dba_indexcolumns.is_disabled as '是否可用' 	
		, dbo.temptbl_dba_tableinfo.index_gb	as '索引大小(MB)'
		, dbo.temptbl_dba_indexcolumns.fill_factor	as '填充因子'
		, dbo.temptbl_dba_indexfrag.avg_frag_percent as '索引碎片%'	
		, dbo.temptbl_dba_indexfrag.index_type_desc as '索引类型' 	
		, dbo.temptbl_dba_indexupdate.update_percent as '索引更新比率%'	
		, dbo.temptbl_dba_indexfrag.index_depth '索引深度'	
		, dbo.temptbl_dba_indexfrag.page_count '索引包含页数'	
	    , dbo.temptbl_dba_indexcolumns.index_keys as '索引字段'		
		, dbo.temptbl_dba_indexcolumns.included_columns as '索引包含字段' 	
		, dbo.temptbl_dba_indexcolumns.is_Primary_key as '是否主键'	
		, dbo.temptbl_dba_indexcolumns.is_unique as '是否唯一'	
		--, dbo.temptbl_dba_indexcolumns.is_unique_constraint	
			
		, dbo.temptbl_dba_indexusage.user_seeks	 as'被Seek次数'
		, dbo.temptbl_dba_indexusage.user_scans	 as'被Scan次数'
		, dbo.temptbl_dba_indexusage.user_lookups	 as'被书签查找次数'
		, dbo.temptbl_dba_indexusage.user_updates	 as'被更新次数'
		, dbo.temptbl_dba_indexusage.user_reads	 as'被读取次数'
		, dbo.temptbl_dba_indexusage.user_writes	 as'被写人次数'
		, dbo.temptbl_dba_indexusage.last_user_scan	 as'最后被Scan时间'
		, dbo.temptbl_dba_indexusage.last_user_update	as '索引最后被更新时间'
		, dbo.temptbl_dba_indexusage.get_datetime     as '抓取数据时间' 	
			
           	
FROM  dbo.temptbl_dba_indexcolumns			
LEFT JOIN   dbo.temptbl_dba_tableinfo   ON dbo.temptbl_dba_tableinfo.utable_name = dbo.temptbl_dba_indexcolumns.utable_name    AND dbo.temptbl_dba_tableinfo.get_datetime  = dbo.temptbl_dba_indexcolumns.get_datetime                   			
LEFT JOIN   dbo.temptbl_dba_tableratio  ON dbo.temptbl_dba_tableratio.utable_name = dbo.temptbl_dba_indexcolumns.utable_name   AND dbo.temptbl_dba_tableratio.get_datetime = dbo.temptbl_dba_indexcolumns.get_datetime			
LEFT JOIN   dbo.temptbl_dba_indexusage  ON dbo.temptbl_dba_indexusage.uindex_name = dbo.temptbl_dba_indexcolumns.uindex_name   AND dbo.temptbl_dba_indexusage.get_datetime = dbo.temptbl_dba_indexcolumns.get_datetime			
LEFT JOIN   dbo.temptbl_dba_indexupdate ON     dbo.temptbl_dba_indexupdate.uindex_name = dbo.temptbl_dba_indexcolumns.uindex_name  AND dbo.temptbl_dba_indexupdate.get_datetime = dbo.temptbl_dba_indexcolumns.get_datetime			
LEFT JOIN   dbo.temptbl_dba_indexfrag   ON dbo.temptbl_dba_indexfrag.uindex_name = dbo.temptbl_dba_indexcolumns.uindex_name  AND dbo.temptbl_dba_indexfrag.get_datetime = dbo.temptbl_dba_indexcolumns.get_datetime                			
                      			
WHERE (dbo.temptbl_dba_indexcolumns.get_datetime = '2016-12-10')			
			
ORDER BY dbo.temptbl_dba_indexcolumns.utable_name  			


 
/****** Object:  StoredProcedure[]   Script Date: 9/9/2016-12 ******/
--////////////////////////////////////////////////////////////////////////////////////////////////////////
SELECT    dbo.temptbl_dba_indexcolumns.utable_name as '����'			
		, dbo.temptbl_dba_tableratio.ratios as '���д��'	
	    , dbo.temptbl_dba_tableratio.reads  as '�������'		
		, dbo.temptbl_dba_tableratio.writes as '��д����'	
		, dbo.temptbl_dba_tableinfo.reserved_gb as '���С(GB)'	
		, dbo.temptbl_dba_tableinfo.rows as '������'	
		--, dbo.temptbl_dba_tableinfo.unused_kb	
		, dbo.temptbl_dba_indexcolumns.uindex_name as '��������' 
		, dbo.temptbl_dba_indexcolumns.is_disabled as '�Ƿ����' 	
		, dbo.temptbl_dba_tableinfo.index_gb	as '������С(MB)'
		, dbo.temptbl_dba_indexcolumns.fill_factor	as '�������'
		, dbo.temptbl_dba_indexfrag.avg_frag_percent as '������Ƭ%'	
		, dbo.temptbl_dba_indexfrag.index_type_desc as '��������' 	
		, dbo.temptbl_dba_indexupdate.update_percent as '�������±���%'	
		, dbo.temptbl_dba_indexfrag.index_depth '�������'	
		, dbo.temptbl_dba_indexfrag.page_count '��������ҳ��'	
	    , dbo.temptbl_dba_indexcolumns.index_keys as '�����ֶ�'		
		, dbo.temptbl_dba_indexcolumns.included_columns as '���������ֶ�' 	
		, dbo.temptbl_dba_indexcolumns.is_Primary_key as '�Ƿ�����'	
		, dbo.temptbl_dba_indexcolumns.is_unique as '�Ƿ�Ψһ'	
		--, dbo.temptbl_dba_indexcolumns.is_unique_constraint	
			
		, dbo.temptbl_dba_indexusage.user_seeks	 as'��Seek����'
		, dbo.temptbl_dba_indexusage.user_scans	 as'��Scan����'
		, dbo.temptbl_dba_indexusage.user_lookups	 as'����ǩ���Ҵ���'
		, dbo.temptbl_dba_indexusage.user_updates	 as'�����´���'
		, dbo.temptbl_dba_indexusage.user_reads	 as'����ȡ����'
		, dbo.temptbl_dba_indexusage.user_writes	 as'��д�˴���'
		, dbo.temptbl_dba_indexusage.last_user_scan	 as'���Scanʱ��'
		, dbo.temptbl_dba_indexusage.last_user_update	as '������󱻸���ʱ��'
		, dbo.temptbl_dba_indexusage.get_datetime     as 'ץȡ����ʱ��' 	
			
           	
FROM  dbo.temptbl_dba_indexcolumns			
LEFT JOIN   dbo.temptbl_dba_tableinfo   ON dbo.temptbl_dba_tableinfo.utable_name = dbo.temptbl_dba_indexcolumns.utable_name    AND dbo.temptbl_dba_tableinfo.get_datetime  = dbo.temptbl_dba_indexcolumns.get_datetime                   			
LEFT JOIN   dbo.temptbl_dba_tableratio  ON dbo.temptbl_dba_tableratio.utable_name = dbo.temptbl_dba_indexcolumns.utable_name   AND dbo.temptbl_dba_tableratio.get_datetime = dbo.temptbl_dba_indexcolumns.get_datetime			
LEFT JOIN   dbo.temptbl_dba_indexusage  ON dbo.temptbl_dba_indexusage.uindex_name = dbo.temptbl_dba_indexcolumns.uindex_name   AND dbo.temptbl_dba_indexusage.get_datetime = dbo.temptbl_dba_indexcolumns.get_datetime			
LEFT JOIN   dbo.temptbl_dba_indexupdate ON     dbo.temptbl_dba_indexupdate.uindex_name = dbo.temptbl_dba_indexcolumns.uindex_name  AND dbo.temptbl_dba_indexupdate.get_datetime = dbo.temptbl_dba_indexcolumns.get_datetime			
LEFT JOIN   dbo.temptbl_dba_indexfrag   ON dbo.temptbl_dba_indexfrag.uindex_name = dbo.temptbl_dba_indexcolumns.uindex_name  AND dbo.temptbl_dba_indexfrag.get_datetime = dbo.temptbl_dba_indexcolumns.get_datetime                			
                      			
WHERE (dbo.temptbl_dba_indexcolumns.get_datetime = '2016-12-10')			
			
ORDER BY dbo.temptbl_dba_indexcolumns.utable_name  			


 
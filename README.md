# oneindex
A small tool to collect more index informations for performance tuning.
this project help dba or database support people to collect index related information, including  

a. 表信息 table information
表名	表读写比%	表读次数	表写次数	表大小(GB)	表行数

b. 索引基本信息 index basic infomation
索引名称	索引大小(MB)	索引碎片率%	索引类型	索引更比率%	索引深度	索引包含页数	索引字段	索引包含字段	是否主键	是否唯一	填充因子

c. 索引使用信息 index usage info
user_seeks	user_scans	user_lookups

d. 索引维护信息index maintence info
user_updates	user_reads	user_writes	last_user_scan	last_user_update

all the information will help us to troubleshooting the database performance issue, and finallly find the better solution.
currently oneindex just face to SQL Server 2005 or above.

operation introduction,
setup1, 
open ssms tools and execute the script "oneindex_Setup1_Create Table.sql", to create related tables used in storing collect infornation.
setup2, 
continue to execute the script "oneindex_Setup2_Create Procdure.sql", to create related produrces used in collecting infornation.
setup3, 
continue to execute the script "oneindex_Setup3__Create Job.sql", to create related Jobs used in collecting data schedlue.
setup4, 
Finanlly, execute the script "oneindex_Setup4_Query Result.sql", to query the result.

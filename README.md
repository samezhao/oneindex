# oneindex
A small tool to collect more index informations for performance tuning.
this project help dba or database support people to collect index related information, including  


///////////////////////////////////////////////

a. table information

table_name

table_read_write_ratios

table_reads

table_writes

table_size(GB)

table_rows

///////////////////////////////////////////////

b. index basic infomation

index_name

index_size(MB)

index_frag%

index_type

index_update%

index_including_page

included_columns

is_Primary_key

is_unique

///////////////////////////////////////////////

c. index usage info

user_seeks	
user_scans	
user_lookups

///////////////////////////////////////////////

d. index maintence information

user_updates	
user_reads	
user_writes	
last_user_scan	
last_user_update

///////////////////////////////////////////////

all the information will help us to troubleshooting the database performance issue, and finallly find the better solution.
currently oneindex just face to SQL Server 2005 or above.



///////////////////////////////////////////////

1. open ssms tools and execute the script "oneindex_Setup1_Create Table.sql", to create related tables used in storing collect infornation.

2. continue to execute the script "oneindex_Setup2_Create Procdure.sql", to create related produrces used in collecting infornation.

3. continue to execute the script "oneindex_Setup3__Create Job.sql", to create related Jobs used in collecting data schedlue.

4. Finanlly, execute the script "oneindex_Setup4_Query Result.sql", to query the result.


<end>

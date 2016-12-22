/***********************************************************************
Copyright 2016, @Sam Zhao- 
MIT License, http://www.opensource.org/licenses/mit-license.php
Object:  StoredProcedure[]   Script Date: 9/12/2016
***********************************************************************/


USE [msdb]
GO

/****** Object:  Job [Maintenance-CollectData]    Script Date: 12/06/2016 12:43:57 ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Maintenance-CollectData')
EXEC msdb.dbo.sp_delete_job @job_id=N'e0c87396-20a2-4175-a3ab-2442a495de7a', @delete_unused_schedule=1
GO

USE [msdb]
GO

/****** Object:  Job [Maintenance-CollectData]    Script Date: 12/06/2016 12:43:57 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 12/06/2016 12:43:57 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Maintenance-CollectData', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'ÎÞÃèÊö¡£', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [collect table datainfo]    Script Date: 12/06/2016 12:43:58 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'collect table datainfo', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d  tyyl_sqlserver -Q "EXECUTE [dbo].[dba_sp_TableInfo]" -b', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [collect table read write ratio]    Script Date: 12/06/2016 12:43:58 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'collect table read write ratio', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d  tyyl_sqlserver -Q "EXECUTE [dbo].[dba_sp_Tableratio]" -b', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [collect Index Usage]    Script Date: 12/06/2016 12:43:58 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'collect Index Usage', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d  tyyl_sqlserver -Q "EXECUTE [dbo].[dba_sp_IndexUsage]" -b', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [collect Index Update]    Script Date: 12/06/2016 12:43:58 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'collect Index Update', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d  tyyl_sqlserver -Q "EXECUTE [dbo].[dba_sp_IndexUpdate]" -b', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [collect Index Columns]    Script Date: 12/06/2016 12:43:58 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'collect Index Columns', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d  tyyl_sqlserver -Q "EXECUTE [dbo].[dba_sp_IndexColumn]" -b', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [collect Index Frag]    Script Date: 12/06/2016 12:43:58 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'collect Index Frag', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d  tyyl_sqlserver -Q "EXECUTE [dbo].[dba_sp_IndexFrag]" -b', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'everyday2400', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=64, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20161122, 
		@active_end_date=99991231, 
		@active_start_time=10000, 
		@active_end_time=235959, 
		@schedule_uid=N'cc5329bc-8553-4e93-b232-4ef2ee407c5d'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO



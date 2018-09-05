CREATE OR REPLACE PACKAGE pk_util_log AUTHID DEFINER AS

    --Statuses of log_entries
    --'C' - completed, means that the action specified by the logging entry completed without throwing exception
    --'R' - running, means that the action specified by the logging entry is still running
    --          (ex. you executed "pk_util_log.open_next_level" at the begining of some
    --          function/procedure and it still did not reach corresponding "pk_util_log.close_level" call at its end).
    --'F' - failed, means that the action specified by the logging entry failed (i.e. action threw exception)
    g_status_completed CONSTANT VARCHAR2(1) := 'C';
    g_status_running   CONSTANT VARCHAR2(1) := 'R';
    g_status_failed    CONSTANT VARCHAR2(1) := 'F';

    --Procedure clears session logging variables, so that the next logging attempt will be made into the new logging hierarchy
    PROCEDURE start_logging(p_log_instance_name_in IN tech_log_instances.log_instance_name%type);

    procedure stop_log_success;

    procedure stop_log_fail;

    --procedure initializes logging context in case you created a separate session (for ex. via dbms_scheduler)
    --and you want this session to write into the same logging hierarchy instance
    PROCEDURE resume_logging(p_parent_log_id IN tech_log_table.parent_log_id%TYPE);

    --Get root log_id of hierarchy instance
    FUNCTION get_start_log_id RETURN tech_log_instances.start_log_id%TYPE;

    --Procedure creates next level of the logging hierarchy.
    --It creates new instance of logging hierarchy if it does not exist
    PROCEDURE open_next_level(p_action_name_in IN tech_log_table.action_name%TYPE
                             ,p_comments_in  IN tech_log_table.comments%TYPE DEFAULT NULL
                             ,p_clob_text_in IN tech_log_table.clob_text%TYPE DEFAULT NULL);

    --Logs a single record
    PROCEDURE log_record(p_action_name_in IN tech_log_table.action_name%TYPE
                        ,p_comments_in  IN tech_log_table.comments%TYPE DEFAULT NULL
                        ,p_clob_text_in IN tech_log_table.clob_text%TYPE DEFAULT NULL
                        ,p_status_in    IN tech_log_table.status%TYPE
                        ,p_row_count_in IN tech_log_table.row_count%TYPE DEFAULT NULL);

    --Get current log_id for the session
    FUNCTION get_current_log_id RETURN tech_log_table.log_id%TYPE;

    --Close level successfully
    PROCEDURE close_level_success(p_row_count_in IN tech_log_table.row_count%TYPE DEFAULT NULL);

    --Close level with failure
    PROCEDURE close_level_fail(p_row_count_in IN tech_log_table.row_count%TYPE DEFAULT NULL);

    PROCEDURE add_clob_text(p_clob_text_in IN tech_log_table.clob_text%TYPE);

    procedure log_and_execute_dml (p_action_name_in IN varchar2
                                    , p_sql_in IN clob
                                    , p_rowcount_out OUT number
                                    , p_commit_after_dml_in IN boolean default false
                                    , p_raise_if_dml_failed_in IN boolean default true);

    procedure log_and_execute_ddl (p_action_name_in IN varchar2
                                    , p_sql_in IN clob
                                    , p_raise_if_ddl_failed_in IN boolean default true);

END pk_util_log;

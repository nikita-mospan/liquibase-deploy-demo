insert into valid_rules_config_s (rule_code, validated_table, rule_description, validation_check)
select 'RULE_1' as rule_code,
    'COMPANY_M' as validated_table,
    'SEGMENT field must be uppercase' as rule_description,
    'segment = upper(segment)' as validation_check from dual;

commit;

begin
    pk_util_log.start_logging(p_log_instance_name_in => 'Load VALID_RULES_CONFIG_M');
    dbms_output.put_line(pk_util_log.get_start_log_id); 
    pk_etl.load_master_table(p_master_table_in => 'VALID_RULES_CONFIG_M', p_x_vstart_in => systimestamp);
    pk_util_log.stop_log_success;
exception
	when others then
		pk_util_log.stop_log_fail;
		raise;
end; 
/

begin
    pk_util_log.start_logging(p_log_instance_name_in => 'Validate COMPANY_M');
    dbms_output.put_line(pk_util_log.get_start_log_id); 
    pk_validate.do_validate(p_validated_table_in => 'COMPANY_M',
                            p_val_error_table_m_in => 'COMPANY_ERR_M',
                            p_x_vstart_in => systimestamp);
    pk_util_log.stop_log_success;
exception
	when others then
		pk_util_log.stop_log_fail;
		raise;
end; 
/

SELECT
    LPAD (' ', 2* (LEVEL- 1)) || l.action_name as action_name,
    l.status,
    l.start_ts,
    l.end_ts,
    l.end_ts - l.start_ts AS elapsed,
    l.row_count,
    l.comments,
    l.exception_message,
    l.clob_text,
    l.sid,
    l.username
FROM
    tech_log_table l
START WITH l.log_id = &start_log_id
CONNECT BY
    l.parent_log_id = PRIOR l.log_id
ORDER SIBLINGS BY
	l.log_id ASC; 


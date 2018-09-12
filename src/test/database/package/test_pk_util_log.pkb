CREATE OR REPLACE PACKAGE BODY test_pk_util_log AS
    
    g_log_entry_creation_log_id tech_log_instances.start_log_id%type;

	procedure test_log_entry_creation is
        v_log_instance_name tech_log_instances.log_instance_name%type := 'test_log_entry_creation';
        v_actual pls_integer;
    begin
        pk_util_log.start_logging(v_log_instance_name);
        g_log_entry_creation_log_id := pk_util_log.get_start_log_id;
        pk_util_log.stop_log_success;
        
        select count(*) into v_actual from tech_log_instances t where t.start_log_id = g_log_entry_creation_log_id;
        
        ut.expect(v_actual).to_equal(1);
    end; 
    
    procedure after_log_entry_creation is
        PRAGMA AUTONOMOUS_TRANSACTION; 
    begin
        dbms_output.put_line('g_log_entry_creation_actual: ' || g_log_entry_creation_log_id); 
        delete from tech_log_instances where start_log_id = g_log_entry_creation_log_id;
        commit;
    end; 
    
    
END test_pk_util_log;
/

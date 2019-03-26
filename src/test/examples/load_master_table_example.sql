drop table company_s;

create table company_s (
    company_id number
    , name varchar2(100)
    , segment varchar2(50)
    , constraint company_s_pk primary key (company_id, name)
);

truncate table company_s;

insert into company_s (company_id, name, segment) values (1, 'Sberbank', 'Big');
insert into company_s (company_id, name, segment) values (2, 'VTB', 'Medium');

commit;

begin
    pk_util_log.start_logging(p_log_instance_name_in => 'Populate COMPANY_M');
    dbms_output.put_line(pk_util_log.get_start_log_id); 
    
    pk_etl.load_master_table(p_master_table_in => 'COMPANY_M', p_x_vstart_in => systimestamp);
    
    pk_util_log.stop_log_success;
exception
    when others then
        pk_util_log.stop_log_fail;
        raise;
end; 
/

select * from company_m ; 

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

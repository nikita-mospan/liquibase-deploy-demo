create table log_instances (
    start_log_id number(16) not null
    , log_instance_name varchar2(100) not null
    , start_ts timestamp(6) not null
    , end_ts timestamp(6)
    , status varchar2(1) not null
    , log_date date not null
    , constraint log_instances_pk primary key(start_log_id));
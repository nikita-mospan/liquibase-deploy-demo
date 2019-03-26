--liquibase formatted sql
--changeset mospan.nn@phystech.edu:parallel_tasks-create runOnChange: false endDelimiter:/
create table parallel_tasks (
    task_prefix varchar2(18) not null
    , task_name varchar2(128)
    , comments varchar2(4000)
    , creation_date date default sysdate
    , status varchar2(1)
    , parallel_level integer not null
    , timeout_seconds number(16) not null
    , start_of_execution date
    , duration interval day (1) to second (0)
    , constraint c_parallel_task_name_pk primary key (task_name)
    , constraint c_parallel_task_status_chck check (status in ('N', 'R', 'C', 'F'))
    , constraint c_timeout_seconds_chck check (timeout_seconds >= 0 )
)
/
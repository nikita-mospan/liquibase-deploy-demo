--liquibase formatted sql
--changeset mospan.nn@phystech.edu:parallel_task_items-create runOnChange: false endDelimiter:/
create table parallel_task_items (
    item_id number(16)
    , chunk_id number
    , task_name varchar2(128) not null
    , log_id NUMBER(16)
    , plsql_block CLOB
    , status varchar2(1)
    , creation_date date default sysdate
    , constraint c_parallel_item_id_pk primary key (item_id)
    , constraint c_parallel_task_name_fk foreign key (task_name) references parallel_tasks (task_name)
    , constraint c_parallel_item_status_chck check (status in ('N', 'R', 'C', 'F'))
)
/
--liquibase formatted sql
--changeset mospan.nn@phystech.edu:log_instances-create runOnChange: false endDelimiter:/
create table log_instances (
  start_log_id number(16) not null
  , log_instance_name varchar2(100) not null
  , start_ts timestamp(6) not null
  , end_ts timestamp(6)
  , status varchar2(1) not null
  , log_date date not null
  , constraint log_instances_pk primary key(start_log_id))
/

create index log_instances_name_idx on log_instances(log_instance_name)
/

grant select on log_instances to public
/

create or replace public synonym tech_log_instances for log_instances
/
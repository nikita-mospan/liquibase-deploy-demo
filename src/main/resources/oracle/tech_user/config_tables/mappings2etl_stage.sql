--liquibase formatted sql
--changeset mospan.nn@phystech.edu:mappings2etl_stage-create runOnChange: false endDelimiter:/
create table mappings2etl_stage (
    mapping_name varchar2(100),
    mapping_sql  clob ,
    constraint c_mappings2master_pk primary key (mapping_name) )
/
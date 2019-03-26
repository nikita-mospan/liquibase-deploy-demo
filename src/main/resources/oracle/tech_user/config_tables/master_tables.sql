--liquibase formatted sql
--changeset mospan.nn@phystech.edu:master_tables-create runOnChange: false endDelimiter:/
create table master_tables (
  master_table varchar2(23),
  auxillary_table as (substr(master_table, 1, length(master_table) - 1) || 'A'),
  staging_table as (substr(master_table, 1, length(master_table) - 1) || 'S'),
  constraint c_master_table_pk primary key(master_table)
)
/
--liquibase formatted sql
--changeset mospan.nn@phystech.edu:sources-create runOnChange: false endDelimiter:/
create table sources (
    source_id number not null,
    source_name varchar2(30) not null,
    constraint c_sources_pk primary key (source_id)
)
/
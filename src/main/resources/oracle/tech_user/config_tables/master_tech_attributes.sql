--liquibase formatted sql
--changeset mospan.nn@phystech.edu:master_tech_attributes-create runOnChange: false endDelimiter:/
create table master_tech_attributes (
    attribute_name varchar2(30) not null,
    attribute_type varchar2(100) not null,
    description    varchar2(4000),
    constraint c_master_tech_attributes_pk primary key (attribute_name))
/
--liquibase formatted sql
--changeset mospan.nn@phystech.edu:master_tables_attributes-create runOnChange: false endDelimiter:/
create table master_tables_attributes (
    master_table varchar2(23) not null,
    attribute_name varchar2(30) not null,
    attribute_type varchar2(100) not null,
    is_part_of_business_key varchar2(1) check (is_part_of_business_key in ('Y', 'N')),
    is_part_of_business_delta varchar2(1) check (is_part_of_business_delta in ('Y', 'N')),
    business_key_order number,
    constraint c_master_tables_attributes_pk primary key (master_table, attribute_name),
    constraint c_master_tables_attributes_fk foreign key (master_table) references master_tables
)
/
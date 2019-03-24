--liquibase formatted sql
--changeset mospan.nn@phystech.edu:seq_log_table-create runOnChange: false endDelimiter:/
CREATE SEQUENCE SEQ_LOG_TABLE
    START WITH 1
    MAXVALUE 999999999999999999999999999
    MINVALUE 1
    NOCYCLE
    CACHE 100
    NOORDER
/

grant select on  SEQ_LOG_TABLE to public
/

create or replace public synonym tech_seq_log_table for seq_log_table
/

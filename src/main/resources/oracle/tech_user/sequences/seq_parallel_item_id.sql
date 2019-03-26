--liquibase formatted sql
--changeset mospan.nn@phystech.edu:seq_parallel_item_id-create runOnChange: false endDelimiter:/
CREATE SEQUENCE seq_parallel_item_id
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 100
  NOORDER
/
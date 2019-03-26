--liquibase formatted sql
--changeset mospan.nn@phystech.edu:t_number_list-create runOnChange: false endDelimiter:/

create  type t_number_list is table of number
/

grant execute on  t_number_list to public
/

create or replace public synonym t_number_list for t_number_list
/
--liquibase formatted sql
--changeset mospan.nn@phystech.edu:t_string_list-create runOnChange: false endDelimiter:/

create  type t_string_list is table of number
/

grant execute on  t_string_list to public
/

create or replace public synonym t_string_list for t_string_list
/
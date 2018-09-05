create table log_table (
    action_name varchar2(64) not null,
    log_id  NUMBER(16) not null,
    parent_log_id NUMBER(16),
    start_ts timestamp(6) not null,
    end_ts timestamp(6),
    sid NUMBER not null,
    username varchar2(30) not null,
    status varchar2(1) not null,
    row_count number(12),
    comments varchar2(4000),
    exception_message varchar2(4000),
    clob_text CLOB,
    log_date date not null,
    constraint log_table_status_chck check (status in ('C'/*completed*/, 'R'/*running*/, 'F'/*failed*/))
)
partition by range (log_date)
interval(NUMTODSINTERVAL(7,'day'))
(partition p_fst_day_of_week values less than (date '2018-07-09'))
;
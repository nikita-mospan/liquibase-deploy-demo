--liquibase formatted sql
--changeset mospan.nn@phystech.edu:config_tables_dml runOnChange: true endDelimiter:/

truncate table master_tables_attributes
/

truncate table mappings2etl_stage
/

truncate table master_tables
/

truncate table master_tech_attributes
/

truncate table sources
/

insert into sources (source_id, source_name)
    select 1 as source_id, 'DEFAULT' as source_name from dual
/

insert into master_tables(master_table)
select 'COMPANY_M' as master_table from dual
union all
select 'VALID_RULES_CONFIG_M' from dual
union all
select 'COMPANY_ERR_M' from dual
union all
select 'DATE_TIMESTAMP_BK_TST_M' from dual
/

insert into master_tables_attributes (
        master_table,   attribute_name,     attribute_type,     is_part_of_business_key, is_part_of_business_delta, business_key_order)
select 'COMPANY_M',     'COMPANY_ID',       'NUMBER NOT NULL',           'Y',                     'N',                 1          from dual union all
select 'COMPANY_M',     'NAME',             'VARCHAR2(100) NOT NULL',    'Y',                     'N',                 2           from dual union all
select 'COMPANY_M',     'SOURCE_ID',        'NUMBER NOT NULL',           'Y',                     'N',                 3           from dual union all
select 'COMPANY_M',     'SEGMENT',          'VARCHAR2(50) NOT NULL',     'N',                     'Y',                 NULL           from dual union all
select 'VALID_RULES_CONFIG_M',     'RULE_CODE', 'VARCHAR2(30) NOT NULL', 'Y',                     'N',                 1           from dual union all
select 'VALID_RULES_CONFIG_M',     'VALIDATED_TABLE', 'VARCHAR2(30) NOT NULL', 'N',               'Y',                  NULL          from dual union all
select 'VALID_RULES_CONFIG_M',     'RULE_DESCRIPTION', 'VARCHAR2(4000) NOT NULL', 'N',            'Y',                  NULL          from dual union all
select 'VALID_RULES_CONFIG_M',     'VALIDATION_CHECK', 'VARCHAR2(4000) NOT NULL', 'N',            'Y',                  NULL          from dual union all
select 'COMPANY_ERR_M', 'RULE_CODE', 'VARCHAR2(30) NOT NULL', 'Y', 'N', 1 from dual union all
select 'COMPANY_ERR_M', 'SOURCE_X_BUSINESS_HKEY', 'VARCHAR2(32) NOT NULL', 'Y', 'N', 2 from dual union all
select 'COMPANY_ERR_M', 'SOURCE_X_VSTART', 'TIMESTAMP(6) NOT NULL', 'Y', 'N', 3 from dual union all
select 'DATE_TIMESTAMP_BK_TST_M',     'DATE_ID',       'DATE NOT NULL',           'Y',                     'N',                 1          from dual union all
select 'DATE_TIMESTAMP_BK_TST_M',     'TIMESTAMP_ID',       'TIMESTAMP(6) NOT NULL',           'Y',                     'N',                 2          from dual
/

insert into master_tech_attributes (
        attribute_name,         attribute_type )
select  'X_BUSINESS_HKEY',      'VARCHAR2(32) NOT NULL'      from dual union all
select  'X_DELTA_HKEY',         'VARCHAR2(32) NOT NULL'      from dual union all
select  'X_VERSION_STATUS',     'VARCHAR2(50) NOT NULL'      from dual union all
select  'X_VSTART',             'TIMESTAMP(6) NOT NULL'         from dual union all
select  'X_VEND',               'TIMESTAMP(6) NOT NULL'         from dual
/

insert into mappings2etl_stage (
        mapping_name,    mapping_sql)
select  'DUMMY_COMPANY',    q'{insert into company_s (company_id,name,source_id,segment)
                                select 123 as company_id, 'Sberbank' as name, 1 as source_id, 'Big' as segment from dual}' from dual union all
select  'DUMMY_COMPANY2',    q'{insert into company_s (company_id,name,source_id,segment)
                                select 1234 as company_id, 'VTB' as name, 2 as source_id, 'Big' as segment from dual}' from dual union all
select  'POPULATE_VALID_RULES_CONFIG',        
                                q'{insert into valid_rules_config_s (rule_code,validated_table,rule_description, validation_check)
                                   select 'RULE_1' as rule_code,
                                            'COMPANY_M' as validated_table,
                                            'SEGMENT field must be uppercase' as rule_description,
                                            'segment = upper(segment) ' as validation_check from dual}' from dual union all
select 'POPULATE_DATE_TIMESTAMP_BK_TST_M', q'{insert into DATE_TIMESTAMP_BK_TST_S (DATE_ID, TIMESTAMP_ID) values (sysdate, systimestamp)}' from dual
/

commit
/

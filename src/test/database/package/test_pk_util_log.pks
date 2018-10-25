create or replace package test_pk_util_log as
    --%suite(Test package for pk_util_log)
    
    --%test(Check that entry is created in tech_log_instances table)
    --%aftertest(after_log_entry_creation)
    procedure test_log_entry_creation;    
    
    procedure after_log_entry_creation;
end;

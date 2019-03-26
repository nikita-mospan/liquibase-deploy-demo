CREATE OR REPLACE PACKAGE pk_constants AUTHID CURRENT_USER AS
   
    c_x_vend constant timestamp := to_timestamp('31.12.9999', 'dd.mm.yyyy');
    c_x_vend_partition constant varchar2(30) := 'p_' || to_char(c_x_vend, 'YYYYmmDDhh24MIssFF');
    eol constant varchar2(3) := chr(13) || chr(10);
   
END pk_constants;
/

set heading on 
set verify off
set echo on
set feedback off

spool f:test.txt

prompt
describe customer;
prompt 
describe product;
prompt
describe warehouse;
prompt 
describe sorder;
prompt 
describe inventory;
prompt
describe counter;
prompt
select * from customer;
prompt 
select * from product;
prompt
select * from warehouse;
prompt 
select * from sorder;
prompt 
select * from inventory;
prompt 
select * from counter;

spool off
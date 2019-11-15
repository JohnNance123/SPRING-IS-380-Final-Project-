set heading off
set feedback off
set echo off
set verify off

spool f:shortship.txt

prompt 
prompt ******** SHORT SHIP REPORT ********
prompt 
select 'Today''s Date: ', to_char(sysdate, 'mm/dd/yyyy') from dual;

prompt 
prompt 

set heading on

column Wnum heading 'Warehouse' format a10
column CityState heading 'City, State' format a20
column SS heading 'Number of|Short Ship|Orders' format 99,999
column SQ heading 'Total|Short Ship|Qty' format 99,999

select SORDER.Wnum, WAREHOUSE.CityState, count(*) SS, sum(SORDER.OrdQty - SORDER.ShipQty) SQ
	from WAREHOUSE, SORDER
	where SORDER.Wnum = WAREHOUSE.Wnum and SORDER.OrdQty > SORDER.ShipQty
	group by SORDER.Wnum, WAREHOUSE.CityState
	order by SQ desc;

set heading off

prompt 

spool off
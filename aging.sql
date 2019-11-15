set heading off
set feedback off
set echo off
set verify off

prompt 

spool f:aging.txt

prompt ****** AGING REPORT ******

select 'Today''s Date: ', to_char(sysdate, 'mm/dd/yyyy') from dual;

prompt
prompt
prompt 

column Onum heading 'Order|Number' format a6
column OD heading 'Order|Date' format a10
column OrderStatus heading 'Order|Status' format a6
column Pnum heading 'Prod|Num' format a4
column Pname heading 'Product|Description' format a16
column OrdQty heading 'Order|Qty' format 9,999
column UnitPrice heading 'Unit|Price' format 9,999.99
column OrderAmt heading 'Order|Amount' format 9,999.99
column dayOpen heading 'Days|Open' format 999

set heading on

select Onum, to_char(OrderDate, 'mm/dd/yyyy') OD, OrderStatus, SORDER.Pnum, Pname, OrdQty , SORDER.UnitPrice, 
	OrderAmt, sysdate-OrderDate dayOpen
	from SORDER, PRODUCT 
	where SORDER.Pnum = PRODUCT.Pnum and OrderStatus = 'OPEN'
	group by Onum, OrderDate, OrderStatus, SORDER.Pnum, Pname, OrdQty, SORDER.UnitPrice, OrderAmt 
	order by dayOpen desc;

set heading off


prompt

spool off
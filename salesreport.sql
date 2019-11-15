set heading off
set feedback off
set echo off
set verify off

spool f:salesreport.txt

prompt 
prompt ******** SALES REPORT ********

set heading on

column Pnum heading 'Prod|No' format a6
column Pname heading 'Product|Name' format a20
column SalesDate heading 'Order|Month' format a10
column NO heading 'No of|Orders' format 99999
column OQ heading 'Total|Qty' format 99999
column OA heading 'Total|Amount' format $999,999.99

select SORDER.Pnum, Pname, to_char(OrderDate, 'mm/yyyy') SalesDate, 
	count(SORDER.Pnum) NO, sum(OrdQty) OQ, sum(OrderAmt) OA
	from SORDER, PRODUCT 
	where SORDER.Pnum = PRODUCT.Pnum
	group by SORDER.Pnum, Pname, to_char(OrderDate, 'mm/yyyy')
	order by Pnum;

set heading off

prompt 

spool off
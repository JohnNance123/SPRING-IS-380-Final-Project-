set heading off
set feedback off
set echo off 
set verify off

spool f:open.txt

prompt 
prompt **************** OPEN AN ORDER ******************

select 'Today''s Date: ', sysdate from dual;
prompt
accept vCnum prompt 'Enter the Customer Number: ';

select '  Customer Name: ', Lname||', '||Fname 
	from CUSTOMER 
	where Cnum = '&vCnum';
select '  Shipping Address: ', Address 
	from CUSTOMER 
	where Cnum = '&vCnum';
select '  City, State Zip: ', City||', '||State||' '||Zip 
	from CUSTOMER 
	where Cnum = '&vCnum';
select '  Phone: ', '('||substr(Phone, 1, 3)||') '||substr(Phone, 4, 3)||'-'|| substr(Phone, 7) 
	from CUSTOMER 
	where Cnum = '&vCnum';
prompt
prompt

accept vPnum prompt 'Enter the Item Number: ';

select '  Item Number: ', Pnum 
	from PRODUCT where Pnum = initcap('&vPnum');
select '  Item Description: ', Pname 
	from PRODUCT where Pnum = initcap('&vPnum');
select '  Unit Price: ', rtrim(to_char(UnitPrice, '$9,999.99'))
	from PRODUCT where Pnum = initcap('&vPnum');

prompt 
prompt

accept vOrdQty prompt 'Enter the quantity ordered: ';


select '   Amount Ordered: ', rtrim(to_char(UnitPrice*&vOrdQty, '$9,999.99'))
	from PRODUCT
	where Pnum = initcap('&vPnum');   

prompt
prompt


set heading on

column Wnum heading 'Warehouse' format a10
column CityState heading 'City, State' format a25
column Zip heading 'Zip Code' format a20
column InvQty heading 'Inventory' format 9999

prompt Please choose from the following warehouse:

select WAREHOUSE.Wnum, CityState, Zip, InvQty
	from INVENTORY, WAREHOUSE
	where INVENTORY.Pnum = initcap('&vPnum')
	and INVENTORY.Wnum = WAREHOUSE.Wnum
	and InvQty > &vOrdQty;
	
prompt

set heading off

accept vWnum prompt 'Enter warehouse code: ';

prompt 


prompt ***** Order Status: OPEN

select '***** Order number is ---->', maxnum from COUNTER; 

insert into SORDER (Onum, OrderDate, OrderStatus, Cnum, Pnum, Wnum, OrdQty, UnitPrice, OrderAmt)
	select maxnum, sysdate, 'OPEN', '&vCnum', initcap('&vPnum'), '&vWnum', &vOrdQty, UnitPrice, 
	&vOrdQty*(select UnitPrice from PRODUCT where Pnum = initcap('&vPnum')) from COUNTER, PRODUCT 
	where PRODUCT.Pnum = initcap('&vPnum'); 

update COUNTER set maxnum = maxnum+1;

commit;

prompt
prompt


spool off
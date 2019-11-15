set heading off
set feedback off
set echo off 
set verify off

spool f:show.txt
prompt
prompt *************** SHOW ORDER DETAIL ****************
prompt

accept vOnum prompt "Please enter the Order Number: ";
prompt

select 'Order Number: ', Onum 
	from SORDER 
	where Onum = '&vOnum';
select 'Order Status: ', OrderStatus 
	from SORDER
	where Onum = '&vOnum';
prompt

select 'Customer Number: ', Cnum
	from SORDER 
	where Onum = '&vOnum';
select '   ', Lname||', '||Fname 
	from CUSTOMER, SORDER
	where Onum = '&vOnum'
	and CUSTOMER.Cnum = SORDER.Cnum;
select '   ', Address
	from CUSTOMER, SORDER
	where Onum = '&vOnum'
	and CUSTOMER.Cnum = SORDER.Cnum;
select '   ', City||', '||State||' '||Zip 
	from CUSTOMER, SORDER
	where Onum = '&vOnum'
	and CUSTOMER.Cnum = SORDER.Cnum;
select '   ', '('||substr(Phone, 1, 3)||') '||substr(Phone, 4, 3)||'-'|| substr(Phone, 7) 
	from CUSTOMER, SORDER
	where Onum = '&vOnum'
	and CUSTOMER.Cnum = SORDER.Cnum;

prompt 

select 'Item Number: ', Pnum
	from CUSTOMER, SORDER
	where Onum = '&vOnum'	
	and CUSTOMER.Cnum = SORDER.Cnum;
select '  Item Description: ', Pname
	from CUSTOMER, SORDER, PRODUCT
	where Onum = '&vOnum'
	and CUSTOMER.Cnum = SORDER.Cnum
	and PRODUCT.Pnum = SORDER.Pnum;
select '  Unit Price:', rtrim(to_char(SORDER.UnitPrice, '$9,999.99'))
	from CUSTOMER, SORDER, PRODUCT
	where Onum = '&vOnum'
	and CUSTOMER.Cnum = SORDER.Cnum
	and PRODUCT.Pnum = SORDER.Pnum;

prompt 

select 'Order Date: ', OrderDate
	from SORDER
	where Onum = '&vOnum';
select 'Shipping Date: ', ShipDate
	from SORDER
	where Onum = '&vOnum';

prompt

select 'Quantity Ordered:', rtrim(OrdQty)
	from SORDER
	where Onum = '&vOnum';
select 'Amount Ordered:', rtrim(to_char(OrderAmt, '$9,999.99'))
	from SORDER
	where Onum = '&vOnum';
select 'Quantity Shipped:', rtrim(ShipQty)
	from SORDER
	where Onum = '&vOnum';
select 'Amount Shipped:', rtrim(to_char(ShipAmt, '$9,999.99'))
	from SORDER
	where Onum = '&vOnum';

prompt 

select 'Shipping Warehouse: ', Wnum
	from SORDER	
	where Onum = '&vOnum';
select '   ', Address
	from WAREHOUSE, SORDER
	where Onum = '&vOnum'
	and WAREHOUSE.Wnum = SORDER.Wnum;
select '   ', CityState||' '||Zip 
	from SORDER, WAREHOUSE
	where Onum = '&vOnum'
	and WAREHOUSE.Wnum = SORDER.Wnum;
select '   ', '('||substr(Phone, 1, 3)||') '||substr(Phone, 4, 3)||'-'|| substr(Phone, 7) 
	from SORDER, WAREHOUSE
	where Onum = '&vOnum'
	and WAREHOUSE.Wnum = SORDER.Wnum;

prompt

spool off


	
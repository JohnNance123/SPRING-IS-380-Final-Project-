set echo off
set heading off
set feedback off
set verify off

spool f:ship.txt

prompt
prompt ****** UPDATE SHIPPING ******
prompt 

select 'Today''s Date: ', sysdate from dual;
prompt 
prompt

accept vOnum prompt 'Please enter Order Number: ';

select 'Order Number: ', Onum
	from SORDER 
	where Onum = '&vOnum';
select 'Order Date: ', OrderDate
	from SORDER 
	where Onum = '&vOnum';
select 'Customer Number: ', Cnum
	from SORDER 
	where Onum = '&vOnum';
select '     ', Lname||', '||Fname 
	from CUSTOMER, SORDER 
	where Onum = '&vOnum'
	and SORDER.Cnum = CUSTOMER.Cnum;
select '     ', Address
	from CUSTOMER, SORDER
	where Onum = '&vOnum'
	and SORDER.Cnum = CUSTOMER.Cnum;
select '     ', City||', '||State||' '||Zip
	from CUSTOMER, SORDER
	where Onum = '&vOnum'
	and SORDER.Cnum = CUSTOMER.Cnum;
select '     ', '('||substr(Phone, 1, 3)||') '||substr(Phone, 4, 3)||'-'||substr(Phone, 7)
	from CUSTOMER, SORDER
	where Onum = '&vOnum'
	and SORDER.Cnum = CUSTOMER.Cnum;

select 'Item Number: ', Pnum
	from SORDER 
	where Onum = '&vOnum';
select '      Item Description: ', Pname
	from PRODUCT, SORDER
	where Onum = '&vOnum'
	and SORDER.Pnum = PRODUCT.Pnum;
select '      Unit Price: ', rtrim(to_char(SORDER.UnitPrice, '$9,999.99'))
	from PRODUCT, SORDER
	where Onum = '&vOnum'
	and SORDER.Pnum = PRODUCT.Pnum;
select 'Quantity Ordered: ', rtrim(OrdQty)
	from SORDER
	where Onum = '&vOnum';
select 'Amount Ordered: ', rtrim(to_char(OrderAmt, '$9,999.99'))
	from SORDER
	where Onum = '&vOnum';

prompt

select 'Shipping Warehouse: ', Wnum
	from SORDER
	where Onum = '&vOnum';
select '     ', Address
	from WAREHOUSE, SORDER
	where Onum = '&vOnum'
	and WAREHOUSE.Wnum = SORDER.Wnum;
select '     ', CityState||' '||Zip
	from WAREHOUSE, SORDER 
	where Onum = '&vOnum'
	and WAREHOUSE.Wnum = SORDER.Wnum;
select '     ', '('||substr(Phone, 1, 3)||') '||substr(Phone, 4, 3)||'-'||substr(Phone, 7)
	from WAREHOUSE, SORDER
	where Onum = '&vOnum'
	and WAREHOUSE.Wnum = SORDER.Wnum;
prompt 


accept vShipQty prompt 'Please enter quantity shipped: ';
prompt 
prompt ********************************************

prompt Order is now ---> SHIPPED

select 'Date Shipped: ', sysdate 
	from dual;
select 'Quantity Shipped: ', rtrim(&vShipQty)
	from SORDER
	where Onum = '&vOnum';
select 'Amount Shipped: ', to_char(&vShipQty*SORDER.UNITPRICE, '$9,999.99')
	from SORDER 
	where Onum = '&vOnum';
prompt 

update SORDER set ShipDate = sysdate, OrderStatus = 'SHIPPED', ShipQty = &vShipQty, 
	ShipAmt = &vShipQty*SORDER.UNITPRICE 
	where Onum in (select Onum from SORDER where Onum = '&vOnum');

update INVENTORY set InvQty = InvQty - &vShipQty
	where Wnum = (select Wnum from SORDER where Onum = '&vOnum')
	and Pnum = (select Pnum from SORDER where Onum = '&vOnum');
prompt

commit; 

spool off 
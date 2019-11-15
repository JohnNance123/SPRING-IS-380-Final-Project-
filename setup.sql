set echo on 
set heading on

spool f:setup.txt

drop table COUNTER;
drop table INVENTORY;
drop table SORDER;
drop table CUSTOMER;
drop table PRODUCT;
drop table WAREHOUSE;



create table CUSTOMER (Cnum varchar2(9) primary key, Lname varchar2(20), Fname varchar2(20), 
	Address varchar2(30), City varchar2(15), State varchar2(2), Zip varchar2(5), Phone varchar2(11));

create table PRODUCT (Pnum varchar2(2) primary key, Pname varchar2(20), UnitPrice number(4,2));

create table WAREHOUSE (Wnum varchar2(2) primary key, Address varchar2(20), CityState varchar2(25), 
	Zip varchar2(5), Phone varchar2(11));

create table SORDER (Onum varchar2(4) primary key, OrderDate date, OrderStatus varchar2(10), Cnum varchar2(9), Pnum varchar2(10),
	Wnum varchar2(2), OrdQty number(4), UnitPrice number(4,2), OrderAmt number(6,2), ShipDate date, ShipQty number(4), ShipAmt number(6,2), 
	constraint fkp# foreign key (Pnum) references PRODUCT(Pnum),
	constraint fkc# foreign key (Cnum) references CUSTOMER(Cnum),
	constraint fkw# foreign key (Wnum) references WAREHOUSE(Wnum));

create table INVENTORY (Pnum varchar2(2), Wnum varchar2(2), InvQty number(4),
	primary key (Pnum, Wnum),
	constraint fkpinvent foreign key (Pnum) references PRODUCT(Pnum),
	constraint fkwinvent foreign key (Wnum) references WAREHOUSE(Wnum));

create table COUNTER (maxnum number(5));


insert into CUSTOMER values('101', 'Barker', 'Nigel', '4128 N Prospect Ave', 'Redondo Beach', 'CA', '90503', 3105468544);
insert into CUSTOMER values('102', 'Banks', 'Tyra', '58215 Overhill Dr', 'Los Angeles', 'CA', '90056', 3238184444);
insert into CUSTOMER values('103', 'Knowles', 'Solange', '78453 Woodrow Wilson Dr', 'Los Angeles', 'CA', '90049', 8184585666);
insert into CUSTOMER values('104', 'Chen', 'Julie', '5861 Long Valley Rd', 'Hidden Hills', 'CA', '91302', 7474552544);
insert into CUSTOMER values('105', 'Grier', 'Pam', '78120  Pacific Coast HWY', 'Santa Monica', 'CA', '90405', 3107474888);
insert into CUSTOMER values('106', 'Downey', 'Robert', '8041 E Valley Blvd', 'Alhambra', 'CA', '91801', 9495885125);

insert into PRODUCT values('P1', '35mm Kodak Film', 3.50);
insert into PRODUCT values('P2', '25mm Mink Lashes', 1.50);
insert into PRODUCT values('P3', 'Uni Straw Hat', 15.00);
insert into PRODUCT values('P4', 'CBS BB Key', 5.00);
insert into PRODUCT values('P5', '40X20 WHT Canvas', 13.50);
insert into PRODUCT values('P6', '140 Vol Bleach', 8.00);
insert into PRODUCT values('P7', 'Pot Ledom Shirts', 17.00);

insert into WAREHOUSE values('W1', '70825 Parkway Rd', 'Mission Viejo, CA', '92691', 8185647555);
insert into WAREHOUSE values('W2', '51458 Runder St', 'Commerce, CA', '90040', 6255856455);
insert into WAREHOUSE values('W3', '78240 S Figueroa St', 'Carson, CA', '90746', 3234855588);
insert into WAREHOUSE values('W4', '540 120th St', 'Hawthorne, CA', '90250', 3105854522);

insert into SORDER values('1001', '11-Jan-2019', 'Shipped', '103', 'P3', 'W2', 50, 15.00, 750.00, '13-Jan-2019', 50, 750.00);
insert into SORDER values('1002', '11-Jan-2019', 'Shipped', '102', 'P2', 'W2', 500, 1.50, 750.00, '25-Jan-2019', 500, 750.00);
insert into SORDER values('1003', '12-Jan-2019', 'Shipped', '101', 'P1', 'W4', 150, 3.50, 525.00, '01-Feb-2019', 150, 525.00);
insert into SORDER values('1004', '01-Feb-2019', 'Shipped', '104', 'P4', 'W4', 20, 5.00, 100.00, '10-Mar-2019', 20, 100.00);
insert into SORDER values('1005', '15-April-2019', 'Shipped', '101', 'P7', 'W1', 100, 17.00, 1700.00, '25-April-2019', 100, 1700.00);
insert into SORDER values('1006', '20-Mar-2019', 'Shipped', '105', 'P5', 'W3', 25, 13.50, 337.50, '23-Mar-2019', 25, 337.50);
insert into SORDER values('1007', '31-Mar-2019', 'Shipped', '106', 'P6', 'W2', 100, 8.00, 800.00, '05-April-2019', 100, 800.00);

insert into INVENTORY values('P1', 'W1', 300);
insert into INVENTORY values('P1', 'W2', 108);
insert into INVENTORY values('P2', 'W3', 500);
insert into INVENTORY values('P2', 'W4', 180);
insert into INVENTORY values('P3', 'W2', 437);
insert into INVENTORY values('P3', 'W3', 367);
insert into INVENTORY values('P4', 'W4', 380);
insert into INVENTORY values('P4', 'W1', 199);
insert into INVENTORY values('P4', 'W2', 637);
insert into INVENTORY values('P5', 'W3', 281);
insert into INVENTORY values('P5', 'W4', 199);
insert into INVENTORY values('P6', 'W2', 105);
insert into INVENTORY values('P6', 'W3', 750);
insert into INVENTORY values('P6', 'W1', 453);
insert into INVENTORY values('P7', 'W1', 127);
insert into INVENTORY values('P7', 'W2', 200);

insert into COUNTER values(1009);

select * from CUSTOMER;
select * from PRODUCT;
select * from WAREHOUSE;
select * from SORDER;
select * from INVENTORY;
select * from COUNTER;

spool off




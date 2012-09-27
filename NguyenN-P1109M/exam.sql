#Create table, insert information
create database marketdb;
use marketdb;
create table tblproducts(
    pro_code char(5) not null primary key,
    pro_name varchar(250),
    pro_cost int,
    pro_quantity int,
    pro_date date,
    sup_id int
    );
insert into tblproducts values ('HC631', 'Compaq nx 6310', '750', '150', '2006-10-12', '1');
insert into tblproducts values ('HC415', 'Pavilion 4105TX', '680', '1000', '2008-08-21', '1');
insert into tblproducts values ('DR071', 'Inspiron 17R', '908', '520', '2009-03-15', '2');
insert into tblproducts values ('AS255', 'Aspire One D255', '325', '1650', '2008-11-20', '3');
insert into tblproducts values ('IB060', 'ThikPad T60', '415', '1200', '2009-03-28', '4');
    
create table tblmarkets(
    mar_id int not null primary key auto_increment,
    mar_name varchar(200),
    mar_pro_quantity int,
    pro_code char(5),
    mar_price_plus float
    );
insert into tblmarkets values ('1', 'Maxi', '50', 'HC631', '12');
insert into tblmarkets values ('2', '7-Eleven', '200', 'DR017', '18');
insert into tblmarkets values ('3', 'Migros', '1000', 'AS255', '15');
insert into tblmarkets values ('4', 'Costco', '430', 'AS255', '12');
insert into tblmarkets values ('5', 'Coop Norden', '950', 'IB060', '14');
    
create table tblsupplies(
    sup_id int primary key not null auto_increment,
    sup_name varchar(100),
    sup_address varchar(350)
    );
insert into tblsupplies values ('1', 'HP', '1145 Compaq Center Drive, Houston, Texas, 770770 USA');
insert into tblsupplies values ('2', 'DELL', 'Dell Way Round Rock, Texas 78682 USA');
insert into tblsupplies values ('3', 'ACER', '8F, No. 88, Section 1, Hsin Tai Wu Road., Hsichih 221, Taipei Hsien, Taiwan');
insert into tblsupplies values ('4', 'IBM', 'Kevin O\'Malley Houes, Earlsfort Center, Earlsfort Terrace, Dublin 2, Ireland');


#view
drop view if exists vselect;
create view vselect as
select pro_name, pro_cost as pro_price, sup_name, mar_name from tblproducts, tblmarkets, tblsupplies
where tblproducts.sup_id = tblsupplies.sup_id and tblproducts.pro_code = tblmarkets.pro_code

drop view if exists vexbihited;
create view vexbihited (pro_name, mar_name, mar_pro_quantity, sup_name ) as
select pro_name, mar_name, mar_pro_quantity, sup_name 
from tblmarkets as a inner join tblproducts as b on a.pro_code=b.pro_code
inner join tblsupplies as c on c.sup_id=b.sup_id
where a.mar_pro_quantity = ( select a.mar_pro_quantity) from tblmarkets as a);


create VIEW view35(pro_name, pro_code,pro_quantity,sup_name) as
select pro_name, pro_code, pro_quantity, sup_name 
from tblproducts as a inner join tblsupplies as b on a.sup_id=b.sup_id
where a.pro_cost = (select MIN(a.pro_cost) from tblproducts as a);



#procedure
delimiter //
create procedure p_mostquantity()
begin
drop view if exists v_mostquantity ;
create view v_mostquantity  as
select max(pro_quantity) as most_quantity
from tblproducts
limit 1;
select pro_name, pro_code, sup_name, pro_quantity
from tblproducts, tblsupplies, v_mostquantity
where tblproducts.sup_id = tblsupplies.sup_id and pro_quantity = (select most_quantily from v_mostquantity );
end //

delimiter //
create procedure p_maxcost()
begin
drop view if exists v_maxcost;
create view v_maxcost as
select max(pro_cost) as maxcost
from tblproducts
limit 1;
select pro_name, pro_code, pro_date
from tblproducts, v_maxcost
where pro_cost = (select max_cost from v_maxcost);
end //

delimiter //
create procedure p_mostsold()
begin
drop view if exists v_mostsold;
create view v_mostsold as
select count(mar_id) as mostsold, pro_code as maxcost
from tblmarkets
where 1 = 1
group by pro_code
order by mostsold desc
limit 1;
select pro_name, tblproducts.pro_code, mar_name
from tblproducts, tblmarkets
where tblproducts.pro_code = tblmarkets.pro_code and tblproducts.pro_code = (select maxcost from v_mostsold);
end //
    
#trigger
drop trigger if exists tblproductsdel;
create trigger tblproductsdel
after delete
on tblproducts
for each row
begin
    set @del_pro_name = old.pro_name;
    set @del_pro_cost = old.pro_cost;
    set @del_pro_quantity = old.pro_quantity;
    set @del_pro_date = old.pro_date;
    
    update current_tblproducts
    set pro_cost = pro



    
# 4 Create procedure
#4.a

CREATE PROCEDURE tig_promostquanity_select()
begin
drop view if exists view_pro_max_quantily ;
create view view_pro_max_quantily  as
select max(Pro_quanity) as max_quantily
from tblProducts
limit 1;
select Pro_name, Pro_code, Sup_name, Pro_quanity
from tblProducts, tblSupplies, view_pro_max_quantily
where tblProducts.Sup_id = tblSupplies.Sup_id and Pro_quanity = (select max_quantily from view_pro_max_quantily );
end
 
#4.b

CREATE PROCEDURE tig_promaxcost_select()
begin
drop view if exists view_pro_max_cost;
create view view_pro_max_cost as
select max(Pro_cost) as max_cost
from tblProducts
limit 1;
select Pro_name, Pro_code, Pro_date
from tblProducts, view_pro_max_cost
where Pro_cost = (select max_cost from view_pro_max_cost);
end


#4.c

CREATE PROCEDURE tig_promostsold_select()
begin
drop view if exists view_pro_most_sold;
create view view_pro_most_sold as
select count(Mar_id) as most_sold, Pro_code as pro_max_code
from tblmarkets
where 1 = 1
group by Pro_code
order by most_sold desc
limit 1;
select Pro_name, tblProducts.Pro_code, mar_name
from tblProducts, tblMarkets
where tblProducts.Pro_code = tblMarkets.Pro_code and tblProducts.Pro_code = (select pro_max_code from view_pro_most_sold);
end 

CREATE PROCEDURE marketdb_product_b()
BEGIN
CREATE VIEW marketdb_productMax_cost as
SELECT MAX(pro_cost) AS pro_max_cost
FROM tblproducts limit 1;
SELECT pro_name, pro_code, pro_date
FROM tblproducts INNER JOIN marketdb_productMax_cost
WHERE pro_cost = (SELECT pro_max_cost FROM marketdb_productMax_cost);
END;
 //
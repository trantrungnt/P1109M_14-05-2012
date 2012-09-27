CREATE VIEW marketdb_product2 AS 
SELECT pro_name, pro_code, pro_cost, pro_quantity
FROM tblproducts
WHERE pro_code NOT IN (SELECT pro_code FROM tblmarkets);
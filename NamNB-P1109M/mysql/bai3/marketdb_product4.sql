CREATE VIEW marketdb_product4 AS
SELECT pro_name,mar_name,mar_pro_quantity,sup_name
FROM tblproducts INNER JOIN tblmarkets INNER JOIN tblsupplies
ON tblproducts.pro_code=tblmarkets.pro_code 
AND tblproducts.sup_id=tblsupplies.sup_id
WHERE tblmarkets.mar_pro_quantity=
(SELECT MAX(tblmarkets.mar_pro_quantity) FROM tblmarkets);
CREATE VIEW marketdb_product1 AS
SELECT pro_name,pro_cost,sup_name,mar_name
FROM tblsupplies INNER JOIN tblproducts INNER JOIN tblmarkets
WHERE tblproducts.sup_id=tblsupplies.sup_id AND tblproducts.pro_code=tblmarkets.pro_code;
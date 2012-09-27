CREATE VIEW marketdb_product5 AS
SELECT pro_name,pro_code,pro_quantity,sup_name
FROM tblproducts INNER JOIN tblsupplies
ON tblproducts.sup_id=tblsupplies.sup_id
WHERE tblproducts.pro_cost=
(SELECT MIN(tblproducts.pro_cost) FROM tblproducts);
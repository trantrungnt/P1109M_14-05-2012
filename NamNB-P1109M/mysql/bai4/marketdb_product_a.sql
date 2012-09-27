CREATE PROCEDURE marketdb_product_a()
BEGIN
CREATE VIEW marketdb_productMax_quantity AS
SELECT max(pro_quanity) as pro_max_quantily
FROM tblproducts LIMIT 1;
SELECT pro_name, pro_code, sup_name, pro_quanity
FROM tblproducts INNER JOIN tblsupplies INNER JOIN marketdb_productMax_quantity
WHERE tblproducts.sup_id = tblsupplies.sup_id AND pro_quanity = 
(SELECT pro_max_quantily FROM marketdb_productMax_quantity );
END;
 //
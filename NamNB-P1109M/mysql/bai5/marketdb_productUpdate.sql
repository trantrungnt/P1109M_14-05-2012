CREATE TRIGGER marketdb_productUpdate
AFTER UPDATE ON tblproducts
FOR EACH ROW
BEGIN
	INSERT INTO tblbk_product(pro_code,pro_name,pro_cost,pro_quantity,pro_date,sup_id)
	VALUES(old.pro_code,old.pro_name,old.pro_cost,old.pro_quantity,old.pro_date,old.sup_id);
END;
//

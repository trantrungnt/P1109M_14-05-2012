CREATE PROCEDURE marketdb_product_c()
begin
CREATE VIEW marketdb_productMost_sold AS
SELECT COUNT(mar_id) AS pro_most_sold, pro_code AS pro_max_code
FROM tblmarkets
WHERE 1 = 1
GROUP BY pro_code
ORDER BY most_sold DESC;
SELECT pro_name, tblproducts.pro_code, mar_name
FROM tblproducts INNER JOIN tblmarkets
WHERE tblproducts.pro_code = tblmarkets.pro_code AND tblproducts.pro_code = 
(SELECT pro_max_code FROM marketdb_productMost_sold);
END;
 //
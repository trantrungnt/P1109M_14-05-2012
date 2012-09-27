#Create view  3.1
CREATE VIEW view1(Pro_name, Pro_cost, Sup_name, Mar_name) AS
    SELECT Pro_name, Pro_cost, Sup_name, Mar_name 
    FROM tblMarkets  INNER JOIN tblProducts  ON tblMarkets.Pro_code=tblProducts.Pro_code
        INNER JOIN tblSupplies  ON tblSupplies.Sup_id=tblProducts.Sup_id;


#Create view  3.2
CREATE VIEW view2(Pro_code, Pro_name, Pro_price, Pro_quantity) AS
    SELECT tblProducts.Pro_code, tblProducts.Pro_name, tblProducts.Pro_cost, tblProducts.Pro_quantity 
        FROM tblProducts  INNER JOIN tblMarkets  ON  tblProducts.Pro_code==tblMarkets.Pro_code;


#Create view  3.3



#Create view  3.4
CREATE VIEW view4(Pro_name, Mar_name, Mar_pro_quantity, Sup_name ) AS
    SELECT Pro_name, Mar_name, Mar_pro_quantity, Sup_name 
        FROM tblMarkets  INNER JOIN tblProducts  ON tblMarkets.Pro_code=tblProducts.Pro_code
                                                            INNER JOIN tblSupplies  ON tblSupplies.Sup_id=tblProducts.Sup_id
                WHERE tblMarkets.Mar_pro_quantity = ( SELECT MAX(tblMarkets.Mar_pro_quantity) FROM tblMarkets);

#Create view  3.5

CREATE VIEW view5(Pro_name, Pro_code,Pro_quantity,Sup_name) AS
    SELECT Pro_name, Pro_code, Pro_quantity, Sup_name 
        FROM tblProducts  INNER JOIN tblSupplies  ON tblProducts.Sup_id=tblSupplies.Sup_id
            WHERE tblProducts.Pro_cost = (SELECT MIN(tblProducts.Pro_cost) FROM tblProducts);

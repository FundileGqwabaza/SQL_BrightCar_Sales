--To check all columns name & datatype
SELECT *
FROM CAR_SALES_DATASET;
-----------------------------------------
--To check categorical columns
SELECT DISTINCT VIN
FROM CAR_SALES_DATASET;
------------------------------------------------
--To check Car model
SELECT DISTINCT model 
FROM CAR_SALES_DATASET;
------------------------------------------------
--To check Car body
SELECT DISTINCT body
FROM CAR_SALES_DATASET;
------------------------------------------------
--To check  car transmission
SELECT DISTINCT transmission
FROM CAR_SALES_DATASET;
----------------------------------------------------
--To check  car trim
SELECT DISTINCT trim
FROM CAR_SALES_DATASET;
----------------------------------------------------
--To check different sellers
SELECT DISTINCT seller
FROM CAR_SALES_DATASET;
----------------------------------------------------
--Revenue calculation based on time and day
SELECT
    TRY_TO_TIMESTAMP_NTZ(saledate, 'DY MON DD YYYY HH24:MI:SS') AS sale_timestamp,
    DAYNAME(TRY_TO_TIMESTAMP_NTZ(saledate, 'DY MON DD YYYY HH24:MI:SS')) AS day_name,
    CAST(TRY_TO_TIMESTAMP_NTZ(saledate, 'DY MON DD YYYY HH24:MI:SS') AS DATE) AS sale_date,
    TO_CHAR(TRY_TO_TIMESTAMP_NTZ(saledate, 'DY MON DD YYYY HH24:MI:SS')::TIME) AS sale_time,
    'year', model, trim, body, transmission, vin, STATE, condition, odometer, color, interior, seller, mmr, sellingprice,
    SUM(sellingprice) AS total_revenue,
    AVG(sellingprice) AS avg_selling_price,
    COALESCE(Make, 'Make not provided') AS Make,
    COALESCE(model, 'model not provided') AS model,
    COALESCE(transmission, 'transmission type not provided') AS transmission,
    COALESCE(NULLIF(TRIM(REPLACE(color, '—', '')), ''), 'color not provided') AS color,
    FROM car_sales_dataset
  GROUP BY TRY_TO_TIMESTAMP_NTZ(saledate, 'DY MON DD YYYY HH24:MI:SS'),
         DAYNAME(TRY_TO_TIMESTAMP_NTZ(saledate, 'DY MON DD YYYY HH24:MI:SS')),
         CAST(TRY_TO_TIMESTAMP_NTZ(saledate, 'DY MON DD YYYY HH24:MI:SS') AS DATE),
         year,make, model, trim,body, transmission, vin, STATE, condition, odometer, color, interior, seller, mmr, sellingprice;

--Question 1
-- Query: Split comma-separated Products into atomic rows using JSON_TABLE()
SELECT
  OrderID,
  CustomerName,
  TRIM(j.Product) AS Product
FROM
  ProductDetail
  JOIN JSON_TABLE(
    CONCAT('["', REPLACE(Products, ', ', '","'), '"]'),
    '$[*]' COLUMNS (
      Product VARCHAR(100) PATH '$'
    )
  ) AS j;

-- Question 2
-- Step 1: Create Orders table (removes partial dependency)
CREATE TABLE Orders AS
SELECT DISTINCT
  OrderID,
  CustomerName
FROM OrderDetails1NF;

-- Step 2: Create OrderItems table (purely dependent on full key)
CREATE TABLE OrderItems AS
SELECT
  OrderID,
  Product,
  Quantity
FROM OrderDetails1NF;


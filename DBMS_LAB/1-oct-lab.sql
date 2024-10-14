#CUSTOMER DATABASE QUERIES

#Q1.
SELECT c.Cust_id, c.Cust_name, COUNT(o.Ord_id) AS OrderCount
FROM Customer c
JOIN Orders o ON c.Cust_id = o.Cust_id
GROUP BY c.Cust_id, c.Cust_name
HAVING COUNT(o.Ord_id) > 2;

#Q2.
SELECT c.Cust_id, c.Cust_name, SUM(o.Ttl_amt) AS TotalSpent
FROM Customer c
JOIN Orders o ON c.Cust_id = o.Cust_id
WHERE o.Ord_date >= '2022-04-01' AND o.Ord_date < '2022-05-01'
GROUP BY c.Cust_id, c.Cust_name;

#Q3.
SELECT p.Prod_id,p.Prod_name,p.Unit_price
FROM product p
WHERE p.Unit_price>=50 AND p.Unit_price<=400
ORDER BY p.Unit_price;

#Q4.
SELECT c.Cust_id, c.Cust_name
FROM Customer c
JOIN Orders o ON c.Cust_id = o.Cust_id
WHERE o.Ord_date >= '2022-04-01' AND o.Ord_date < '2022-06-01'
GROUP BY c.Cust_id, c.Cust_name
HAVING COUNT(DISTINCT CASE 
                         WHEN o.Ord_date >= '2022-04-01' AND o.Ord_date < '2022-05-01' THEN 'April' 
                         WHEN o.Ord_date >= '2022-05-01' AND o.Ord_date < '2022-06-01' THEN 'May' 
                       END) = 2;

SELECT c.Cust_id, c.Cust_name, SUM(o.Ord_date) AS Ordersdate
FROM Customer c
JOIN Orders o ON c.Cust_id = o.Cust_id
GROUP BY c.Cust_id, c.Cust_name
WHERE o.Ord_date >= '2022-04-01' AND o.Ord_date <= '2022-05-31';

CREATE TABLE Customer(
Cust_id INT,
Cust_name VARCHAR(20),
email VARCHAR(20),
Join_date DATE,
PRIMARY KEY(Cust_id)
);

INSERT INTO Customer VALUES
(1, 'Sam', 'sam@gmail.com', '2022-01-15'),
(2, 'Kim', 'kim@gmail.com', '2022-02-20'),
(3, 'Kane', 'kane@gmail.com', '2022-03-25'),
(4, 'Dave', 'Dave@gmail.com', '2022-04-10');

CREATE TABLE Orders (
Ord_id INT,
Cust_id INT,
Ord_date DATE,
Ttl_amt DOUBLE(10,2),
PRIMARY KEY(Ord_id),
FOREIGN KEY(Cust_id) REFERENCES Customer(Cust_id)
);
INSERT INTO Orders VALUES
(101, 1, '2022-04-01', 100.00),
(102, 2, '2022-04-05', 75.00),
(103, 1, '2022-04-10', 45.25),
(104, 3, '2022-05-02', 150.75),
(105, 2, '2022-05-05', 65.00),
(106, 4, '2022-05-10', 200.50),
(107, 2, '2022-05-13', 100.00),
(108, 3, '2022-05-15', 89.25),
(109, 4, '2022-05-18', 90.00),
(110, 3, '2022-05-20', 100.00);


CREATE TABLE Product(
Prod_id INT,
Prod_name VARCHAR(20),
Unit_price DOUBLE(10,2),
PRIMARY KEY(Prod_id)
);

INSERT INTO Product VALUES
(1,'laptop', 800.00),
(2,'Phone', 400.00),
(3,'Tablet',300.00),
(4,'HeadPhones',50.00),
(5,'Mouse',15.00),
(6,'Keyboard',30.00);

#1
SELECT Cust_id,COUNT(Cust_id)
FROM Orders
GROUP BY Cust_id
HAVING COUNT(Cust_id)>2;

#2
SELECT T.Cust_id,SUM(T.Ttl_amt) AS Total_Amount_in_2022
FROM (SELECT * FROM Orders WHERE YEAR(Ord_date)=2022 AND MONTH(Ord_date)=4) AS T
GROUP BY T.Cust_id;

#3
SELECT * FROM Product WHERE Unit_price BETWEEN 50.00 AND 400.00;

#4
SELECT Cust_id
FROM Orders
WHERE YEAR(Ord_date)=2022 AND MONTH(Ord_date)=4
INTERSECT
SELECT Cust_id
FROM Orders
WHERE YEAR(Ord_date)=2022 AND MONTH(Ord_date)=5;

#5
SELECT T.Cust_id, SUM(T.Ttl_amt)
FROM (SELECT * FROM Orders WHERE Ord_date>=DATE_SUB('2022-10-01', INTERVAL 6 MONTH)) AS T
GROUP BY T.Cust_id
ORDER BY SUM(T.Ttl_amt) DESC
LIMIT 0,5;
#select DATE_SUB('2024-10-01', INTERVAL 6 MONTH) as X;

#8
SELECT (((SELECT COUNT(*) AS X
FROM (SELECT Cust_id
FROM Orders
GROUP BY Cust_id
HAVING COUNT(Ord_id)>1) AS a)) / (SELECT COUNT(DISTINCT cust_id) AS X
FROM Orders))*100 AS percentage;

#9

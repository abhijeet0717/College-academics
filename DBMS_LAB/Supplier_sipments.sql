CREATE TABLE Suppliers(
SupplierNumber CHAR(2) PRIMARY KEY,
SupplierName VARCHAR(255),
SupplierStatus INT,
City VARCHAR(255)
);
CREATE TABLE Parts(
PartNumber CHAR(2) PRIMARY KEY,
ProjectName VARCHAR(255),
Color VARCHAR(255),
Weight DECIMAL,
City VARCHAR(255)
 );
CREATE TABLE Projects(
ProjectNumber CHAR(2) PRIMARY KEY,
ProjectName VARCHAR(255),
City VARCHAR(255)
);
INSERT  INTO SUPPLIERS VALUES
("S1",'Sarala',20,'Bombay'),
("S2",'Uma',10,'Chennai'),
("S3",'Nehru',30,'Chennai'),
("S4",'Priya',20,'Bombay'),
("S5",'Anand',30,'Delhi');

INSERT  INTO Parts VALUES
("P1",'Nut','Red',12.0,'Bombay'),
("P2",'Bolt','Green',17.0,'Chennai'),
("P3",'Screw','Blue',17.0,'Bangalore'),
("P4",'Screw','Red',14.0,'Bombay'),
("P5",'Cam','Blue',12.0,'Chennai'),
("P6",'Cog','Red',19.0,'Bombay');

INSERT  INTO Projects VALUES
("J1",'Sorter','Chennai'),
("J2",'Display','Nellai'),
("J3",'OCR','Delhi'),
("J4",'Console','Delhi'),projects
("J5",'RAID','Bombay'),
("J6",'EDS','Bangalore'),
("J7",'Tape','Bombay');

CREATE TABLE Sipments(
SupplierNumber CHAR(2),
PartNumber CHAR(2),
ProjectNumber CHAR(2),
City VARCHAR(255),
Quantity INT
);

ALTER TABLE Sipments DROP City;
INSERT INTO Sipments VALUES
("S1","P1","J1",200),
("S1","P1","J4",700),
("S2","P3","J1",400),
("S2","P3","J2",200),
("S2","P3","J3",200),
("S2","P3","J4",500),
("S2","P3","J5",600),
("S2","P3","J6",400),
("S2","P3","J7",800),
("S3","P3","J1",200),
("S3","P4","J2",500),
("S4","P6","J3",300),
("S4","P6","J7",300),
("S5","P2","J2",200),
("S5","P2","J4",100),
("S5","P5","J5",500),
("S5","P5","J7",100),
("S5","P6","J2",200),
("S5","P1","J4",100),
("S5","P3","J4",200),
("S5","P4","J4",800),
("S5","P5","J4",400),
("S5","P6","J4",500);

SELECT * FROM Projects;
SELECT * FROM Projects WHERE City='Bombay';

SELECT sup.SupplierName
FROM Suppliers sup, Sipments sh
WHERE (sup.SupplierNumber= sh.SupplierNumber && sh.ProjectNumber='J1');

SELECT * FROM Sipments WHERE Quantity>300 && Quantity<750;

SELECT Color, City FROM Parts;

SELECT sup.SupplierNumber,pn.PartNumber, pjn.ProjectNumber
FROM Suppliers sup, Parts pn, Projects pjn
WHERE sup.City=pn.city && sup.City=pjn.City;

SELECT sup.SupplierNumber,pn.PartNumber, pjn.ProjectNumber
FROM Suppliers sup, Parts pn, Projects pjn
WHERE sup.City!=pn.city || sup.City!=pjn.City || pn.City!=pjn.City;


SELECT sup.SupplierNumber,pn.PartNumber, pjn.ProjectNumber
FROM Suppliers sup, Parts pn, Projects pjn
WHERE sup.City!=pn.city && sup.City!=pjn.City && pn.City!=pjn.City;

SELECT  DISTINCT pn.*
FROM Suppliers, Parts pn, Sipments
WHERE Suppliers.City="Bombay" && Suppliers.SupplierNumber=Sipments.SupplierNumber && pn.PartNumber=Sipments.PartNumber;

SELECT PartNumber FROM Sipments WHERE SupplierNumber='S1' || SupplierNumber='S4';

SELECT  DISTINCT pn.PartNumber
FROM Suppliers, Parts pn, Sipments,Projects
WHERE Suppliers.City="Bombay" && Projects.City="Bombay" && Projects.ProjectNumber=Sipments.ProjectNumber && Suppliers.SupplierNumber=Sipments.SupplierNumber && pn.PartNumber=Sipments.PartNumber;

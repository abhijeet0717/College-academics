#-------------------------------------LAB 2-----------------------------------------------------------------------------------------------

CREATE TABLE SUPPLIERS(
	SUPPLIER_NUMBER CHAR(2),
	SUPPLIER_NAME CHAR(20),
	STATUS INT,
	CTIY CHAR(20)

);

INSERT INTO SUPPLIERS VALUES
	("S1","Sarala",20,"Bombay"),
	("S2","Uma",10,"Chennai"),
	("S3","Nehru",30,"Chennai"),
	("S4","Priya",20,"Bombay"),
	("S5","Anand",30,"Delhi");
	
CREATE TABLE PARTS(
	PART_NUMBER CHAR(2),
	PROJECT_NAME CHAR(20),
	COLOR CHAR(20),
	WEIGHT DECIMAL,
	CITY CHAR(20),
	PRIMARY KEY(PART_NUMBER)
);

INSERT INTO PARTS VALUES
	("P1","Nut","Red",12.0,"Bombay"),
	("P2","Bolt","Green",17.0,"Chennai"),
	("P3","Screw","Blue",17.0,"Bangalore"),
	("P4","Screw","Red",14.0,"Bombay"),
	("P5","Cam","Blue",12.0,"Chennai"),
	("P6","Cog","Red",19.0,"Bombay");
	
CREATE TABLE PROJECTS(
	PROJECT_NUMBER CHAR(2),
	PROJECT_NAME CHAR(20),
	CITY CHAR(20),
	PRIMARY KEY(PROJECT_NUMBER)
);

DROP FROM projects;
INSERT INTO PROJECTS VALUES
	("J1","Sorter","Chennai"),
	("J2","Display","Nellai"),
	("J3","OCR","Delhi"),
	("J4","Console","Delhi"),
	("J5","RAID","Bomabay"),
	("J6","EDS","Bangalore"),
	("J7","Tape","Bombay");

CREATE TABLE SHIPMENTS(
	SUPPLIER_NUMEBER CHAR(2),
	PART_NUMBER CHAR(2),
	PROJECT_NUMBER CHAR(2),
	QUANTITY INT
);

INSERT INTO SHIPMENTS VALUES
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
	
UPDATE projects SET city="Bombay" WHERE city="Bomabay";
#1	
SELECT * FROM projects;
#2
SELECT * FROM projects WHERE city='Bombay';
#3
SELECT sup.SUPPLIER_NAME
FROM suppliers sup,shipments sh
WHERE (sh.SUPPLIER_NUMBER = sup.SUPPLIER_NUMBER && sh.PROJECT_NUMBER='J1');
#4
SELECT * FROM shipments WHERE quantity BETWEEN 300 AND 700;
#5
SELECT DISTINCT s.color,p.city
FROM parts s,parts p;

ALTER TABLE suppliers RENAME COLUMN CTIY TO CITY;
#6
SELECT S.SUPPLIER_NUMBER, P.PART_NUMBER, PJ.PROJECT_NUMBER 
FROM suppliers S,parts P,projects PJ
WHERE S.CITY=P.CITY && P.CITY=PJ.CITY;
#7
SELECT DISTINCT S.SUPPLIER_NUMBER, P.PART_NUMBER, PJ.PROJECT_NUMBER 
FROM suppliers S,parts P,projects PJ
WHERE S.CITY!=P.CITY || P.CITY!=PJ.CITY || S.CITY!=PJ.CITY; 
#8
SELECT S.SUPPLIER_NUMBER, P.PART_NUMBER, PJ.PROJECT_NUMBER 
FROM suppliers S,parts P,projects PJ
WHERE S.CITY!=P.CITY && P.CITY!=PJ.CITY && S.CITY!=PJ.CITY; 
#9
SELECT DISTINCT p.*
FROM parts p ,shipments sh ,suppliers s
WHERE (p.PART_NUMBER = sh.PART_NUMBER && sh.SUPPLIER_NUMBER = s.SUPPLIER_NUMBER && s.CITY = "Bombay");
#10
SELECT sh.PART_NUMBER
FROM shipments sh, suppliers s, projects p
WHERE (sh.SUPPLIER_NUMBER = s.SUPPLIER_NUMBER && s.CITY="Bombay" && sh.PROJECT_NUMBER=p.PROJECT_NUMBER && p.CITY="Bombay");


#<------------------------------------------------------- LAB 3--------------------------------------------------------------->|

#1 
SELECT s.CITY, p.CITY
FROM shipments AS sp, suppliers AS s, projects AS p
WHERE sp.SUPPLIER_NUMBER = s.SUPPLIER_NUMBER && sp.PROJECT_NUMBER = p.PROJECT_NUMBER && s.CITY != p.CITY;	

#2 
SELECT DISTINCT sp.PROJECT_NUMBER
FROM shipments AS sp, projects AS p
WHERE sp.PROJECT_NUMBER = p.PROJECT_NUMBER && EXISTS(SELECT s.CITY
							FROM shipments AS sp1 ,suppliers AS s
							WHERE sp1.SUPPLIER_NUMBER = s.SUPPLIER_NUMBER && p.PROJECT_NUMBER = sp1.PROJECT_NUMBER && p.CITY != s.CITY);

#3
SELECT DISTINCT s1.PART_NUMBER,s2.PART_NUMBER
FROM shipments AS s1, shipments AS s2
WHERE s1.SUPPLIER_NUMBER = s2.SUPPLIER_NUMBER && s1.PART_NUMBER != s2.PART_NUMBER;

#4
SELECT COUNT(DISTINCT shipments.PROJECT_NUMBER)
FROM shipments 
WHERE shipments.SUPPLIER_NUMBER = 'S1';

#5
SELECT DISTINCT p.COLOR
FROM shipments AS sp, parts AS p
WHERE sp.SUPPLIER_NUMBER = 'S1' && sp.PART_NUMBER = p.PART_NUMBER;

#6
SELECT SUM(QUANTITY)
FROM shipments
WHERE SUPPLIER_NUMBER = 'S1' && PART_NUMBER='P1';
						
#7
SELECT DISTINCT sp.PART_NUMBER, sp.PROJECT_NUMBER , (SELECT SUM(QUANTITY)
				    FROM shipments
					    WHERE PART_NUMBER=sp.PART_NUMBER && PROJECT_NUMBER=sp.PROJECT_NUMBER) AS total_quanitiy
FROM shipments AS sp
ORDER BY sp.PROJECT_NUMBER;


#<------------------------------------------------------Lab 4----------------------------------------------------------->|

#1
SELECT DISTINCT PART_NUMBER
FROM shipments AS SP
WHERE (SELECT AVG(QUANTITY)
	FROM shipments AS SP2
	WHERE SP.PART_NUMBER = SP2.PART_NUMBER) > 350; 

#2
SELECT PART_NUMBER
FROM shipments AS SP
WHERE SP.PROJECT_NUMBER IN (SELECT PROJECT_NUMBER
		          FROM projects 
		          WHERE CITY = 'Bombay');
		        
#3 
SELECT DISTINCT SUPPLIER_NUMBER
FROM shipments AS SP1
WHERE PART_NUMBER IN (SELECT PART_NUMBER 
		      FROM SHIPMENTS 
		      WHERE SUPPLIER_NUMBER IN (SELECT SUPPLIER_NUMBER 
						FROM shipments 
						WHERE PART_NUMBER IN (SELECT PART_NUMBER 
									FROM parts 
									WHERE COLOR = 'Red')));
#4
SELECT SUPPLIER_NUMBER
FROM suppliers
WHERE STATUS < (SELECT STATUS
		FROM suppliers
		WHERE SUPPLIER_NUMBER = 'S1');
		
#5

SELECT DISTINCT PROJECT_NUMBER
FROM shipments AS SP
WHERE  (SELECT AVG(QUANTITY)
	FROM shipments 
	WHERE PROJECT_NUMBER = SP.PROJECT_NUMBER && SP.PART_NUMBER = 'P1') > (SELECT MAX(QUANTITY)
										FROM shipments
										WHERE PROJECT_NUMBER = 'J1');
										
#6
SELECT SUPPLIER_NUMBER
FROM shipments AS SP
WHERE PART_NUMBER = 'P1' && QUANTITY > (SELECT AVG(QUANTITY)
					FROM shipments 
					WHERE PROJECT_NUMBER = SP.PROJECT_NUMBER && PART_NUMBER = 'P1');

#7
SELECT PROJECT_NUMBER#, CITY 
FROM PROJECTS AS P
WHERE CITY = (SELECT CITY
		FROM PROJECTS 
		WHERE SUBSTRING(CITY,1,1) = SUBSTRING(P.CITY,1,1)
		ORDER BY CITY
		LIMIT 1);

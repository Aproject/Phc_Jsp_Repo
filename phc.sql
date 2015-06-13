 INSERT INTO 
	tb (number, sales, MONTH)
VALUES 
	('A103', 101, 4), ('A102', 54, 5), ('A104', 181, 4), ('A101', 184, 4), ('A103', 17, 5), ('A101', 300, 5),
	('A102', 205, 6),('A104', 93, 5),('A103', 12, 6),('A107', 87, 6);
	
SELECT sales*10000 AS '판매량(원)', number AS 코드번호  FROM tb;

SELECT COUNT(*) FROM tb;

SELECT CHARSET('as');

SELECT CONCAT(number, sales, '이다') FROM tb;

SELECT SUBSTRING(number, 2, 2) FROM tb1;

SELECT REPEAT('=', months) FROM tb;

SELECT REVERSE(number) FROM tb;

CREATE TABLE rightnow (a INT AUTO_INCREMENT PRIMARY KEY, b DATETIME);

INSERT INTO rightnow (b) VALUES (NOW());

SELECT * FROM rightnow;

SELECT * FROM tb LIMIT 3;

SELECT * FROM tb WHERE months IN (5, 6);

SELECT * FROM tb1;

SELECT * FROM tb1 WHERE `name` NOT LIKE '강%';

INSERT INTO tb1 (NAME) VALUES ('이름만');

SELECT * FROM tb;
SELECT * FROM tb1 WHERE age IS NULL;

SELECT * FROM tb WHERE number LIKE '%1' AND months = 4;

SELECT * FROM tb WHERE sales<50 OR sales>200;

SELECT * FROM tb WHERE (sales >=200 OR number LIKE '%1') AND months=4;

SELECT number, sales,
CASE
	WHEN sales>=100 THEN '많음'
	WHEN sales>=50 THEN '중간'
	ELSE '적음'
END AS assert
FROM tb;

SELECT * FROM tb ORDER BY months ASC LIMIT 5;

SELECT * FROM tb ORDER BY sales DESC LIMIT 2 OFFSET 3;

SELECT * FROM tb GROUP BY number;

SELECT number, COUNT(*) AS '총건수' FROM tb GROUP BY number;

SELECT
   number, SUM(sales) AS 평균
FROM tb
   GROUP BY number;
   
SELECT
   number, AVG(sales)
FROM tb
   GROUP BY number
ORDER BY AVG(sales)
   DESC;

ALTER TABLE tb ADD note VARCHAR(100);

UPDATE tb SET note = '특이사항 없음';

SELECT * FROM tb_2to5;

UPDATE tb SET note='우수' WHERE sales >=100;

UPDATE tb SET note='쫌 잘해라~!' ORDER BY sales LIMIT 3;

ALTER TABLE tb DROP note;

CREATE TABLE tb_A101 SELECT * FROM tb WHERE number LIKE 'A101';

CREATE TABLE tb_2to5
	SELECT *
	FROM tb
	ORDER BY sales
	DESC LIMIT 4
	OFFSET 1;
	
DROP DATABASE db1;

CREATE DATABASE DB1;



DROP TABLE tb;

USE db1;

SHOW TABLES;

CREATE TABLE TB (number VARCHAR(10), sales INT, MONTH INT);

DESC tb;

INSERT INTO tb 
 
SELECT * FROM tb;

CREATE TABLE tb1 (number VARCHAR(10), NAME VARCHAR(10), age INT);

DESC tb1;

INSERT INTO tb1 (number, NAME, age) 
VALUES
('A101', '강신우', 40), ('A102', '김기덕', 28), ('A103', '김민호', 20), ('A104', '문소리', 23), ('A105', '박문수', 35);

CREATE TABLE tb2 (number VARCHAR(10), NAME VARCHAR(10), age INT);

INSERT INTO tb2 (number, NAME, age) 
VALUES
('A106', '권명철', 26), ('A107', '김우진', 24), ('A108', '남수현', 23), ('A109', '박지수', 25), ('A110', '서연재', 27);

CREATE TABLE tb3 (number VARCHAR(10), CITY VARCHAR(10));

INSERT INTO tb3 (number, city)
VALUES
	('A101','서울'),('A102','부산'),('A103','대구'),('A104','대전'),('A105','인천');
	
SELECT *
FROM TB1
UNION
SELECT *
FROM TB2;

(SELECT * FROM TB WHERE NUMBER='A102')
UNION
(SELECT * FROM TB WHERE NUMBER='A103')
UNION
(SELECT * FROM TB WHERE NUMBER='A104')
UNION
(SELECT * FROM TB WHERE NUMBER='A107');

SELECT *
FROM TB
WHERE NUMBER NOT IN('A101');

(SELECT NUMBER FROM TB WHERE SALES>=200)
UNION ALL
(SELECT NUMBER FROM TB1 WHERE AGE>=35);

SELECT * FROM tb JOIN tb1 ON tb.number = tb1.number;

SELECT tb.number, tb1.name, tb.sales FROM tb JOIN tb1 ON tb.number = tb1.number;

SELECT * FROM tb AS X;

SELECT x.number, y.name, x.sales FROM tb AS X JOIN tb1 AS Y ON x.number=y.number;

SELECT tb.number AS 사원번호, tb1.name AS 이름, tb.sales AS 매출 FROM tb JOIN tb1 USING(number)
WHERE tb.sales >=100;

SELECT tb.number, tb.sales, tb1.name, tb3.city
FROM tb JOIN tb1 USING(number) JOIN tb3 USING(number);

SELECT 
    tb.number, tb1.name
FROM
    tb
RIGHT JOIN
    tb1 
USING(number);

SELECT *
    FROM tb1
    AS a
    JOIN tb1
    AS b;

-- 순위 구하기 --
SELECT a.name, a.age, COUNT(*) AS rank
FROM tb1 AS a JOIN tb1 AS b
WHERE a.age<=b.age
GROUP BY a.number ORDER BY rank ;

SELECT * FROM tb
WHERE sales IN(SELECT MAX(sales) FROM tb);

SELECT * FROM tb1
WHERE age >= (SELECT AVG(age) FROM tb1);

SELECT * FROM tb1
WHERE  number
IN (SELECT number FROM tb WHERE sales>=200);

SELECT * FROM tb1 WHERE number = (SELECT number FROM tb ORDER BY sales LIMIT 1);

SELECT * FROM tb1 WHERE NOT EXISTS (SELECT * FROM tb WHERE tb.number = tb1.number);

CREATE  TABLE tb_rank LIKE tb;

ALTER TABLE tb_rank ADD rank INT AUTO_INCREMENT PRIMARY KEY;

INSERT INTO tb_rank(number, sales, MONTH) (SELECT number, sales, MONTH FROM tb ORDER BY sales DESC);

SELECT * FROM tb_rank;



CREATE VIEW v1
AS
SELECT NAME, age FROM tb1;

SELECT * FROM tb1;

UPDATE v1 SET NAME='주임 강신우' WHERE NAME='강신우';

CREATE VIEW v2
AS
SELECT tb.number, tb1.name, tb.sales 
FROM tb
JOIN tb1
USING(number)
WHERE tb.sales >= 100;

SELECT * FROM v2;

UPDATE tb SET sales=777 WHERE sales=54;
UPDATE tb SET sales=54 WHERE sales=777;
\
SHOW TABLES;
DESC v1;


SHOW CREATE VIEW v1;

INSERT INTO v1 VALUES('임시직 이정희', 18);
SELECT * FROM v1;

SELECT * FROM tb1;

CREATE VIEW v3
AS
SELECT number, sales
FROM tb
WHERE sales>=100;

SELECT * FROM v3;

INSERT INTO v3 VALUES('테스트', 50);

SELECT number, sales FROM tb;

CREATE VIEW v4
AS
SELECT number, sales
FROM tb
WHERE sales>100
WITH CHECK OPTION;

INSERT INTO v4 VALUES('테스트', 50);

CREATE OR REPLACE VIEW v1
AS 
SELECT NOW();

SELECT * FROM v1;

ALTER VIEW v1
AS
SELECT NAME, age
FROM tb1;

DROP VIEW IF EXISTS v1;

DELIMITER //
CREATE PROCEDURE pr1()
BEGIN
SELECT * FROM tb;
SELECT * FROM tb1;
END
//
DELIMITER ;

CALL pr1;

DELIMITER //
CREATE PROCEDURE pr2(d INT)
BEGIN
SELECT * FROM tb WHERE sales>=d;
END
//
delimeter ;

CALL pr2(100);

SHOW CREATE PROCEDURE pr1;

DROP PROCEDURE pr1;

DELIMITER //
CREATE FUNCTION fu1(height INT) RETURNS DOUBLE
BEGIN
RETURN height * height * 22 / 10000;
END
//

DELIMITER ;

SELECT fu1(177);

DELIMITER //
CREATE FUNCTION fu2() RETURNS DOUBLE
BEGIN
DECLARE r DOUBLE;
SELECT AVG(sales) INTO r FROM tb;
RETURN r;
END
//

DELIMITER ;

SELECT fu2();

DROP FUNCTION fu2;

CREATE TABLE tb1m LIKE tb1;

DELIMITER //
CREATE TRIGGER tr1 BEFORE DELETE ON tb1 FOR EACH ROW
BEGIN
INSERT INTO tb1m VALUES( old.number, old.name, old.age);
END
//

DELIMITER ;

DELETE FROM tb1;

SELECT *FROM tb1;

INSERT INTO tb1 SELECT * FROM tb1m;

SHOW TRIGGERS;

DROP TRIGGER tr1;
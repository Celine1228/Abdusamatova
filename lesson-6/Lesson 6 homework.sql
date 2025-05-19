--Lesson 6
CREATE TABLE InputTbl (
    col1 VARCHAR(10),
    col2 VARCHAR(10)
);
    INSERT INTO InputTbl (col1, col2) VALUES 
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm');
--Puzzle 1
select distinct 
least(col1, col2) as col1,
GREATEST(col1, col2) as col2
from InputTbl

--Puzzle 2 
CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

select * from TestMultipleZero
where A<>0 OR B<>0 OR C<>0 OR D<>0

--Puzzle 3

create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')
--Puzzle 3
select * from section1
where id%2=1

--Puzzle 4
SELECT* FROM section1
where id=(select min(id) from section1)
--Puzzle 5
SELECT* FROM section1
where id=(select max(id) from section1)
--Puzzle 6
SELECT* FROM section1
where name like ('B%')

CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');
select *from ProductCodes

--Puzzle 7
select *from ProductCodes
where Code like ('%/_%') escape '/'
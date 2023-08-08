create database sql_exercise_10;

use sql_exercise_10;

create table people (
	id int,
    name char
);

describe people;

INSERT INTO PEOPLE VALUES(1, "A");
INSERT INTO PEOPLE VALUES(2, "B");
INSERT INTO PEOPLE VALUES(3, "C");
INSERT INTO PEOPLE VALUES(4, "D");

create table address (
	id int,
    address varchar(15),
    updatedate date
);

drop table address;

INSERT INTO ADDRESS VALUES(1, "address-1-1", "2016-01-01");
INSERT INTO ADDRESS VALUES(1, "address-1-2", "2016-09-02");
INSERT INTO ADDRESS VALUES(2, "address-2-1", "2015-11-01");
INSERT INTO ADDRESS VALUES(3, "address-3-1", "2016-12-01");
INSERT INTO ADDRESS VALUES(3, "address-3-2", "2014-09-11");
INSERT INTO ADDRESS VALUES(3, "address-3-3", "2015-01-01");
INSERT INTO ADDRESS VALUES(4, "address-4-1", "2010-05-21");
INSERT INTO ADDRESS VALUES(4, "address-4-2", "2012-02-11");
INSERT INTO ADDRESS VALUES(4, "address-4-3", "2015-04-27");
INSERT INTO ADDRESS VALUES(4, "address-4-4", "2014-01-01");

select * from people;

truncate table address;

select * from address;

-- 1 Join table PEOPLE and ADDRESS, but keep only one address information for each person 
-- (we don't mind which record we take for each person). 
-- i.e., the joined table should have the same number of rows as table PEOPLE

select * from 
people join 
(
SELECT id, MAX(address) as address 
FROM ADDRESS
GROUP BY id
) temp on
people.id = temp.id;


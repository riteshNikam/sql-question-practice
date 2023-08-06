create database sql_exercise_3;

use sql_exercise_3;

create table warehouses (
	code int primary key,
    location varchar(225) not null,
    capacity int not null
);

describe warehouses;

create table boxes (
	code varchar(4) primary key,
    contents varchar(225) not null,
    value decimal not null,
    warehouse int not null,
    foreign key(warehouse) references warehouses(code)
);

describe boxes;

INSERT INTO Warehouses(Code,Location,Capacity) VALUES(1,'Chicago',3);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(2,'Chicago',4);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(3,'New York',7);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(4,'Los Angeles',2);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(5,'San Francisco',8);

select * from warehouses;

INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('0MN7','Rocks',180,3);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4H8P','Rocks',250,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4RT3','Scissors',190,4);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('7G3H','Rocks',200,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8JN6','Papers',75,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8Y6U','Papers',50,3);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('9J6F','Papers',175,2);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('LL08','Rocks',140,4);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P0H6','Scissors',125,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P2T6','Scissors',150,2);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('TU55','Papers',90,5);

select * from boxes;

-- 1 Select all warehouses.

select * from warehouses;

-- 2 Select all boxes with a value larger than $150.

select * from boxes where value > 150;

-- 3 Select all distinct contents in all the boxes.

select distinct contents from boxes;

-- 4 Select the average value of all the boxes.

select avg(value) from boxes;

-- 5 Select the warehouse code and the average value of the boxes in each warehouse.

select warehouse, avg(value) from boxes group by warehouse;

-- 6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.

select warehouse, avg(value) from boxes group by warehouse having avg(value) > 150;

-- 7 Select the code of each box, along with the name of the city the box is located in.

select b.code, w.location from
boxes as b, warehouses as w
where b.warehouse = w.code;

select b.code, w.location from
boxes as b join warehouses as w
on b.warehouse = w.code;

-- 8 Select the warehouse codes, along with the number of boxes in each warehouse. 
-- Optionally, take into account that some warehouses are empty 
-- (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).

select warehouse, count(*) as number_of_boxes from boxes group by warehouse;

-- 9 Select the codes of all warehouses that are saturated 
-- (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).

select Code
from warehouses join (select warehouse temp_a, count(*) temp_b from boxes group by warehouse) temp
on (warehouses.code = temp.temp_a)
where warehouses.Capacity<temp.temp_b;

-- 10 Select the codes of all the boxes located in Chicago.
select * from warehouses;

select code from boxes 
where warehouse in (
	select code from warehouses 
    where location = 'Chicago'
);

-- 11 Create a new warehouse in New York with a capacity for 3 boxes.

insert into warehouses value (6, 'New York', 3);

-- 12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, 
-- and located in warehouse 2.

insert into boxes value ('H5RT', 'Papers', 200, 2);

-- 13 Reduce the value of all boxes by 15%.

update boxes
set value = value*0.85;

-- 14 Remove all boxes with a value lower than $100.

delete from boxes
where value < 100;

-- 15 Remove all boxes from saturated warehouses.

create view number_of_boxes_per_warehouse as
(
	select warehouse, count(*) as number_of_boxes from boxes group by warehouse
);

select number_of_boxes_per_warehouse.warehouse, 
number_of_boxes_per_warehouse.number_of_boxes,
warehouses.capacity from
number_of_boxes_per_warehouse join warehouses
on number_of_boxes_per_warehouse.warehouse = warehouses.code
where number_of_boxes > capacity;

-- 3.16 Add Index for column "Warehouse" in table "boxes"
-- !!!NOTE!!!: index should NOT be used on small tables in practice

CREATE INDEX INDEX_WAREHOUSE ON Boxes (warehouse);

select * from boxes;
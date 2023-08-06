create database sql_exercise_1;

use sql_exercise_1;

create table manufacturers (
	code int primary key,
    name varchar(225)
);

create table products (
	code int primary key,
    name varchar(225) not null,
    price decimal not null,
    manufacturer int,
    foreign key (manufacturer) references manufacturers(code)
);

INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');

select * from manufacturers;

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);

select * from products;

-- 1 Select the names of all the products in the store.

select name from products;

-- 2 Select the names and the prices of all the products in the store.

select name, price from products;

-- 3 Select the name of the products with a price less than or equal to $200.

select name from products
where price <= 200;

-- 4 Select all the products with a price between $60 and $120.

select name from products 
where price <= 200 and price >= 60;

-- 5 Select the name and price in cents (i.e., the price must be multiplied by 100).

select name, (price * 100) as price_in_cents from products;

-- 6 Compute the average price of all the products.

select avg(price) as average_price from products;

-- 7 Compute the average price of all products with manufacturer code equal to 2.

select avg(price) as average_price from products
where manufacturer = 2;

-- 8 Compute the number of products with a price larger than or equal to $180.

select count(*)as product_count from products
where price >= 180;

-- 9 Select the name and price of all products with a price larger than or equal to $180, 
-- and sort first by price (in descending order), and then by name (in ascending order).

select name, price from products
where price >= 180
order by price desc;

select name, price from products
where price >= 180
order by name asc;

-- 10 Select all the data from the products, including all the data for each product's manufacturer.

select p.*, m.name from 
products as p join manufacturers as m
on p.manufacturer = m.code
order by code asc;

-- 11 Select the product name, price, and manufacturer name of all the products.

select p.name, p.price, m.name 
from products as p join manufacturers as m
on p.manufacturer = m.code;

-- 12 Select the average price of each manufacturer's products, showing only the manufacturer's code.

select manufacturer, avg(price) as average_price from products 
group by manufacturer; 

-- 13 Select the average price of each manufacturer's products, showing the manufacturer's name.

select m.name, avg(p.price) as average_price from
products as p join manufacturers as m
on p.manufacturer = m.code
group by m.name;

-- 14 Select the names of manufacturer whose products have an average price larger than or equal to $150.

select m.name from
products as p join manufacturers as m
on p.manufacturer = m.code
group by m.name
having avg(p.price) >= 150;

-- 15 Select the name and price of the cheapest product.

select name, price from products
order by price asc limit 1;

-- 16 Select the name of each manufacturer along with the name and price of its most expensive product.

create view max_price_mapping as
(
	select m.name, max(p.price) as price
	from products as p, manufacturers as m
	where p.manufacturer = m.code
	group by m.name
);

create view products_with_manu_name as
(
	select p.*, m.name as manu_name
    from products as p join manufacturers as m
    where p.manufacturer = m.code
);

select * from max_price_mapping;

select * from products_with_manu_name;

select max_price_mapping.name as manufacturer_name, products_with_manu_name.name as product_name, max_price_mapping.price from 
max_price_mapping join products_with_manu_name
on max_price_mapping.name = products_with_manu_name.manu_name 
and max_price_mapping.price = products_with_manu_name.price;

-- 16 Select the name of each manufacturer along with the name and price of its most expensive product.

with v as 
(
	select m.name as manufacturer_name , p.name as product_name, p.price, 
    rank() over (partition by manufacturer order by price desc) as most_expensive
    from products as p join manufacturers as m
    on p.manufacturer = m.code
) select v.manufacturer_name, v.product_name, v.price from v
where v.most_expensive = 1;

-- 17 Add a new product: Loudspeakers, $70, manufacturer 2.

insert into products value (11, 'Loudspeakers', 70, 2);

-- 18 Update the name of product 8 to "Laser Printer".

select * from products 
where code = 8;

update products
set name = 'Laser Printer'
where code = 8;

-- 19 Apply a 10% discount to all products.

update products
set price = price - price * 0.10;

select * from products;

-- 20 Apply a 10% discount to all products with a price larger than or equal to $120.

update products 
set price = price*0.90
where price >= 120;

select * from products;

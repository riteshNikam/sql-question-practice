create database sql_exercise_5;

use sql_exercise_5;

create table pieces (
	code int,
    name varchar(225) not null,
    primary key(code)
);

describe pieces;

create table providers (
	code varchar(40),
    name varchar(225) not null,
    primary key(code)
);

describe providers;

create table provides (
	piece int,
    provider varchar(225),
    price int not null,
    foreign key(piece) references pieces(code),
    foreign key(provider) references providers(code),
    primary key(piece, provider)
);

describe provides;

INSERT INTO Providers(Code, Name) VALUES('HAL','Clarke Enterprises');
INSERT INTO Providers(Code, Name) VALUES('RBT','Susan Calvin Corp.');
INSERT INTO Providers(Code, Name) VALUES('TNBC','Skellington Supplies');

select * from providers;

INSERT INTO Pieces(Code, Name) VALUES(1,'Sprocket');
INSERT INTO Pieces(Code, Name) VALUES(2,'Screw');
INSERT INTO Pieces(Code, Name) VALUES(3,'Nut');
INSERT INTO Pieces(Code, Name) VALUES(4,'Bolt');

select * from pieces;

INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'HAL',10);
INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'HAL',20);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'TNBC',14);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'RBT',50);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'TNBC',45);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'HAL',5);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'RBT',7);

select * from provides;

-- 1 Select the name of all the pieces.

select name from pieces;

-- 2  Select all the providers' data.

select * from providers;

-- 3 Obtain the average price of each piece (show only the piece code and the average price).

select piece, avg(price) from provides group by piece;

-- 4  Obtain the names of all providers who supply piece 1.

select name from providers
where code in (
	select provider from provides
    where piece = 1
);

-- 5 Select the name of pieces provided by provider with code "HAL".

select name from pieces
where code in (
	select piece from provides
    where provider = 'HAL'
);

-- 6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------

create view temp as
(
	select provides.*, providers.name as provider_name, pieces.name as pieces_name from 
	provides join providers
	on provides.provider = providers.code
	join pieces 
	on provides.piece = pieces.code
);

select * from temp;

select pieces_name, provider_name, price from 
(
	select *,
	rank() over (partition by piece order by price desc) as price_rank
	from temp
) as temp_1 where temp_1.price_rank = 1;

-- 7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") 
-- will provide sprockets (code "1") for 7 cents each.

insert into provides value (1, 'TNBC', 7);

-- 8 Increase all prices by one cent.

update provides 
set price = price + 1;

-- 9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).

DELETE FROM Provides WHERE provider = 'RBT' AND Piece = 4;
create database sql_exercise_9;

use sql_exercise_9;

show tables;

-- 1 give the total number of recordings in this table

select count(*) from cran_logs;

-- 2 the number of packages listed in this table?

select count(distinct package) from cran_logs;

-- 3 How many times the package "Rcpp" was downloaded?

select package, count(*) as number_of_downloads 
from cran_logs
group by package
having package = 'Rcpp';

select package, count(*) as number_of_downloads from cran_logs
where package = 'Rcpp';

-- 4 How many recordings are from China ("CN")?

select country, count(*) as number_of_records
from cran_logs
where country = 'CN';

-- 5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.

select package, 
count(*) as number_of_downloads
from cran_logs
group by package
order by 2 desc;

-- 6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM

alter table cran_logs change column text date date;

describe cran_logs;

select * from cran_logs;

alter table cran_logs change column test time time;

describe cran_logs;

select package, 
count(*) as number_of_downloads
from cran_logs
where time > '09:00:00' and time < '11:00:00'
group by package
order by number_of_downloads desc;

-- 7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?

select country, count(*) as number_of_recordings from cran_logs
group by country
having country in ('CN', 'JP', 'SG');

-- 8 Print the countries whose downloaded are more than the downloads from China ("CN")

select temp.country, temp.number_of_recordings from 
(
	select country, count(*) as number_of_recordings from cran_logs
	group by country
) as temp where temp.number_of_recordings > (select count(*) from cran_logs where country = 'CN');

-- 9 Print the average length of the package name of all the UNIQUE packages

select avg(length(package)) as avg_length from (
select distinct package from cran_logs)as temp;

select avg(length(package))as avg_length from cran_logs;

-- 10 Get the package whose downloading count ranks 2nd (print package name and it's download count).

select * from (
	select *, rank() over (order by number_of_downloads desc) as rank_download_numbers from (
		select package, count(*) as number_of_downloads from cran_logs
		group by package
	) temp
) temp_2 where temp_2.rank_download_numbers = 2;

-- 11 Print the name of the package whose download count is bigger than 1000.

select country, count(*) as number_of_recordings from cran_logs
group by country 
having count(*) > 1000;

-- 12 The field "r_os" is the operating system of the users.
-- 	Here we would like to know what main system we have (ignore version number), 
-- the relevant counts, and the proportion (in percentage).

select *, round((number_of_os / (select sum(number_of_os) from temp) * 100), 2) as precentage from 
(
	select regexp_substr(r_os, '[^0-9]+') as OS,
	count(*) as number_of_os
	from cran_logs
	group by regexp_substr(r_os, '[^0-9]+')
) temp;

 

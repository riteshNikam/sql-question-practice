create database sql_exercise_6;

use sql_exercise_6;

create table scientists (
	ssn int,
    name varchar(225)not null,
	primary key(ssn)
);

describe scientists;

create table projects (
	code varchar(10),
    name varchar(225) not null,
    hours int,
    primary key(code)
);

describe projects;

create table assigned_to (
	scientist int,
    project varchar(10),
    foreign key(scientist) references scientists(ssn),
    foreign key(project) references projects(code),
    primary key(scientist, project)
);

describe assigned_to;

INSERT INTO Scientists(SSN,Name) VALUES
(123234877,'Michael Rogers'),
(152934485,'Anand Manikutty'),
(222364883, 'Carol Smith'),
(326587417,'Joe Stevens'),
(332154719,'Mary-Anne Foster'),	
(332569843,'George ODonnell'),
(546523478,'John Doe'),
(631231482,'David Smith'),
(654873219,'Zacary Efron'),
(745685214,'Eric Goldsmith'),
(845657245,'Elizabeth Doe'),
(845657246,'Kumar Swamy');

select * from scientists;

INSERT INTO Projects (Code,Name,Hours) VALUES 
('AeH1','Winds: Studying Bernoullis Principle', 156),
('AeH2','Aerodynamics and Bridge Design',189),
('AeH3','Aerodynamics and Gas Mileage', 256),
('AeH4','Aerodynamics and Ice Hockey', 789),
('AeH5','Aerodynamics of a Football', 98),
('AeH6','Aerodynamics of Air Hockey',89),
('Ast1','A Matter of Time',112),
('Ast2','A Puzzling Parallax', 299),
('Ast3','Build Your Own Telescope', 6546),
('Bte1','Juicy: Extracting Apple Juice with Pectinase', 321),
('Bte2','A Magnetic Primer Designer', 9684),
('Bte3','Bacterial Transformation Efficiency', 321),
('Che1','A Silver-Cleaning Battery', 545),
('Che2','A Soluble Separation Solution', 778);

select * from projects;

 INSERT INTO assigned_to ( Scientist, Project) VALUES 
(123234877,'AeH1'),
(152934485,'AeH3'),
(222364883,'Ast3'),	   
(326587417,'Ast3'),
(332154719,'Bte1'),
(546523478,'Che1'),
(631231482,'Ast3'),
(654873219,'Che1'),
(745685214,'AeH3'),
(845657245,'Ast1'),
(845657246,'Ast2'),
(332569843,'AeH4');

select * from assigned_to;

create view temp as (
	select scientists.ssn, 
	scientists.name as scientist_name, 
	projects.code as project_code, 
	projects.name as project_name, projects.hours from
	assigned_to 
    join 
    projects
	on assigned_to.project = projects.code
	join
	scientists
	on assigned_to.scientist = scientists.ssn
);

-- 1 List all the scientists' names, their projects' names, 
-- and the hours worked by that scientist on each project, 
-- in alphabetical order of project name, then scientist name.

select scientist_name, project_name, hours from temp order by project_name, scientist_name;

-- 2 Select the project names which are not assigned yet

select name 
from projects 
where code not in (
	select project from assigned_to
);
create database sql_exercise_8;

use sql_exercise_8;

create table physician (
	employeeID int primary key,
    name varchar(30) not null,
    position varchar(30) not null,
    ssn int not null
);

describe physician;

create table department (
	departmentID int primary key,
    name varchar(225) not null,
    head int,
    foreign key(head) references physician(employeeID)
);

describe department;

create table affiliated_with (
	physician int,
    department int,
    primaryAffiliation bool not null,
    foreign key(physician) references physician(employeeID),
    foreign key(department) references department(departmentID),
    primary key(physician, department)
);

describe affiliated_with;

create table procedures (
	code int primary key,
    name varchar(225),
    cost int
);

describe procedures;

create table trained_in (
	physician int,
    treatment int,
    certificationDate date,
    certificationExpires date,
    foreign key(physician) references physician(employeeID),
    foreign key(treatment) references procedures(code),
    primary key(physician, treatment)
);

describe trained_in;

create table patient (
	ssn int primary key,
    name varchar(225) not null,
    adress varchar(225) not null,
    phone varchar(30) not null,
    insuraanceID int not null,
    pcp integer,
    foreign key(pcp) references physician(employeeID)
);

describe patient;

create table nurse (
	employeeID int primary key,
    name varchar(225) not null,
    position varchar(225) not null,
    registered bool,
    ssn int not null
);

describe nurse;

create table appointment (
	appointmentID int primary key,
    patient int not null,
    prepNurse int,
    physician int not null,
    start date,
    end date,
    examinationRoom varchar(225) not null,
    foreign key(patient) references patient(ssn),
    foreign key(physician) references physician(employeeID),
    foreign key(prepNurse) references nurse(employeeID)
);


describe appointment;

create table medication (
	code int primary key,
    name varchar(225) not null,
    brand varchar(225) not null,
    description varchar(225) not null
);

describe medication;

create table prescribes (
	physician int,
    patient int,
    medication int,
    date date,
    appointment int,
    dose varchar(225),
    foreign key(physician) references physician(employeeID),
    foreign key(patient) references patient(ssn),
    foreign key(medication) references medication(code),
    foreign key(appointment) references appointment(appointmentID),
    primary key(physician, patient, medication, date)
);

describe prescribes;

create table block (
	BlockFloor int,
    BlockCode int,
    primary key(BlockFloor, BlockCode)
);

drop table block;

create table room (
	number int primary key,
    type varchar(225) not null,
    blockFloor int not null,
    blockCode int not null,
    unavailable bool,
    FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block(BlockFloor, BlockCode)
);

describe room;

create table on_call (
	nurse int,
    BlockFloor int,
    BlockCode int,
    start date,
    end date,
    primary key(nurse, BlockFloor, BlockCode, start, end),
    foreign key(nurse) references nurse(employeeID),
    foreign key(BlockFloor, BlockCode) references block(BlockFloor, BlockCode)
);

describe on_call;

create table stay (
	stayID int primary key,
    patient int,
    room int,
    start date,
    end date,
    foreign key(patient) references patient(ssn),
    foreign key(room) references room(number)
);

describe stay;

create table undergoes (
	patient int,
    procedures int,
    stay int,
    date date,
    physician int,
    assistingNurse int,
    primary key(patient, procedures, stay, date),
    foreign key(patient) references patient(ssn),
    foreign key(procedures) references procedures(code),
    foreign key(stay) references stay(stayID),
    foreign key(physician) references physician(employeeID),
    foreign key(assistingNurse) references nurse(employeeID)
);

describe undergoes;

INSERT INTO Physician VALUES(1,'John Dorian','Staff Internist',111111111);
INSERT INTO Physician VALUES(2,'Elliot Reid','Attending Physician',222222222);
INSERT INTO Physician VALUES(3,'Christopher Turk','Surgical Attending Physician',333333333);
INSERT INTO Physician VALUES(4,'Percival Cox','Senior Attending Physician',444444444);
INSERT INTO Physician VALUES(5,'Bob Kelso','Head Chief of Medicine',555555555);
INSERT INTO Physician VALUES(6,'Todd Quinlan','Surgical Attending Physician',666666666);
INSERT INTO Physician VALUES(7,'John Wen','Surgical Attending Physician',777777777);
INSERT INTO Physician VALUES(8,'Keith Dudemeister','MD Resident',888888888);
INSERT INTO Physician VALUES(9,'Molly Clock','Attending Psychiatrist',999999999);

select * from physician;

INSERT INTO Department VALUES(1,'General Medicine',4);
INSERT INTO Department VALUES(2,'Surgery',7);
INSERT INTO Department VALUES(3,'Psychiatry',9);

select * from department;

INSERT INTO Affiliated_With VALUES(1,1,1);
INSERT INTO Affiliated_With VALUES(2,1,1);
INSERT INTO Affiliated_With VALUES(3,1,0);
INSERT INTO Affiliated_With VALUES(3,2,1);
INSERT INTO Affiliated_With VALUES(4,1,1);
INSERT INTO Affiliated_With VALUES(5,1,1);
INSERT INTO Affiliated_With VALUES(6,2,1);
INSERT INTO Affiliated_With VALUES(7,1,0);
INSERT INTO Affiliated_With VALUES(7,2,1);
INSERT INTO Affiliated_With VALUES(8,1,1);
INSERT INTO Affiliated_With VALUES(9,3,1);

select * from affiliated_with;

INSERT INTO Procedures VALUES(1,'Reverse Rhinopodoplasty',1500.0);
INSERT INTO Procedures VALUES(2,'Obtuse Pyloric Recombobulation',3750.0);
INSERT INTO Procedures VALUES(3,'Folded Demiophtalmectomy',4500.0);
INSERT INTO Procedures VALUES(4,'Complete Walletectomy',10000.0);
INSERT INTO Procedures VALUES(5,'Obfuscated Dermogastrotomy',4899.0);
INSERT INTO Procedures VALUES(6,'Reversible Pancreomyoplasty',5600.0);
INSERT INTO Procedures VALUES(7,'Follicular Demiectomy',25.0);

select * from procedures;

INSERT INTO Patient VALUES(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1);
INSERT INTO Patient VALUES(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2);
INSERT INTO Patient VALUES(100000003,'Random J. Patient','101 Omgbbq Street','555-1204',65465421,2);
INSERT INTO Patient VALUES(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);

select * from patient;

INSERT INTO Nurse VALUES(101,'Carla Espinosa','Head Nurse',1,111111110);
INSERT INTO Nurse VALUES(102,'Laverne Roberts','Nurse',1,222222220);
INSERT INTO Nurse VALUES(103,'Paul Flowers','Nurse',0,333333330);

select * from nurse;

INSERT INTO Appointment VALUES(13216584,100000001,101,1,'2008-04-24','2008-04-24','A');
INSERT INTO Appointment VALUES(26548913,100000002,101,2,'2008-04-24','2008-04-24','B');
INSERT INTO Appointment VALUES(36549879,100000001,102,1,'2008-04-25','2008-04-25','A');
INSERT INTO Appointment VALUES(46846589,100000004,103,4,'2008-04-25','2008-04-25','B');
INSERT INTO Appointment VALUES(59871321,100000004,NULL,4,'2008-04-26','2008-04-26','C');
INSERT INTO Appointment VALUES(69879231,100000003,103,2,'2008-04-26','2008-04-26','C');
INSERT INTO Appointment VALUES(76983231,100000001,NULL,3,'2008-04-26','2008-04-26','C');
INSERT INTO Appointment VALUES(86213939,100000004,102,9,'2008-04-27','2008-04-21','A');
INSERT INTO Appointment VALUES(93216548,100000002,101,2,'2008-04-27','2008-04-27','B');

select * from appointment;

INSERT INTO Medication VALUES(1,'Procrastin-X','X','N/A');
INSERT INTO Medication VALUES(2,'Thesisin','Foo Labs','N/A');
INSERT INTO Medication VALUES(3,'Awakin','Bar Laboratories','N/A');
INSERT INTO Medication VALUES(4,'Crescavitin','Baz Industries','N/A');
INSERT INTO Medication VALUES(5,'Melioraurin','Snafu Pharmaceuticals','N/A');

select * from medication;

INSERT INTO Block VALUES(1,1);
INSERT INTO Block VALUES(1,2);
INSERT INTO Block VALUES(1,3);
INSERT INTO Block VALUES(2,1);
INSERT INTO Block VALUES(2,2);
INSERT INTO Block VALUES(2,3);
INSERT INTO Block VALUES(3,1);
INSERT INTO Block VALUES(3,2);
INSERT INTO Block VALUES(3,3);
INSERT INTO Block VALUES(4,1);
INSERT INTO Block VALUES(4,2);
INSERT INTO Block VALUES(4,3);

select * from block;

INSERT INTO Room VALUES(101,'Single',1,1,0);
INSERT INTO Room VALUES(102,'Single',1,1,0);
INSERT INTO Room VALUES(103,'Single',1,1,0);
INSERT INTO Room VALUES(111,'Single',1,2,0);
INSERT INTO Room VALUES(112,'Single',1,2,1);
INSERT INTO Room VALUES(113,'Single',1,2,0);
INSERT INTO Room VALUES(121,'Single',1,3,0);
INSERT INTO Room VALUES(122,'Single',1,3,0);
INSERT INTO Room VALUES(123,'Single',1,3,0);
INSERT INTO Room VALUES(201,'Single',2,1,1);
INSERT INTO Room VALUES(202,'Single',2,1,0);
INSERT INTO Room VALUES(203,'Single',2,1,0);
INSERT INTO Room VALUES(211,'Single',2,2,0);
INSERT INTO Room VALUES(212,'Single',2,2,0);
INSERT INTO Room VALUES(213,'Single',2,2,1);
INSERT INTO Room VALUES(221,'Single',2,3,0);
INSERT INTO Room VALUES(222,'Single',2,3,0);
INSERT INTO Room VALUES(223,'Single',2,3,0);
INSERT INTO Room VALUES(301,'Single',3,1,0);
INSERT INTO Room VALUES(302,'Single',3,1,1);
INSERT INTO Room VALUES(303,'Single',3,1,0);
INSERT INTO Room VALUES(311,'Single',3,2,0);
INSERT INTO Room VALUES(312,'Single',3,2,0);
INSERT INTO Room VALUES(313,'Single',3,2,0);
INSERT INTO Room VALUES(321,'Single',3,3,1);
INSERT INTO Room VALUES(322,'Single',3,3,0);
INSERT INTO Room VALUES(323,'Single',3,3,0);
INSERT INTO Room VALUES(401,'Single',4,1,0);
INSERT INTO Room VALUES(402,'Single',4,1,1);
INSERT INTO Room VALUES(403,'Single',4,1,0);
INSERT INTO Room VALUES(411,'Single',4,2,0);
INSERT INTO Room VALUES(412,'Single',4,2,0);
INSERT INTO Room VALUES(413,'Single',4,2,0);
INSERT INTO Room VALUES(421,'Single',4,3,1);
INSERT INTO Room VALUES(422,'Single',4,3,0);
INSERT INTO Room VALUES(423,'Single',4,3,0);

select * from room;

INSERT INTO On_Call VALUES(101,1,1,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(101,1,2,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(102,1,3,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(103,1,1,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,2,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,3,'2008-11-04 19:00','2008-11-05 03:00');

select * from on_call;

INSERT INTO Stay VALUES(3215,100000001,111,'2008-05-01','2008-05-04');
INSERT INTO Stay VALUES(3216,100000003,123,'2008-05-03','2008-05-14');
INSERT INTO Stay VALUES(3217,100000004,112,'2008-05-02','2008-05-03');

select * from stay;

INSERT INTO Undergoes VALUES(100000001,6,3215,'2008-05-02',3,101);
INSERT INTO Undergoes VALUES(100000001,2,3215,'2008-05-03',7,101);
INSERT INTO Undergoes VALUES(100000004,1,3217,'2008-05-07',3,102);
INSERT INTO Undergoes VALUES(100000004,5,3217,'2008-05-09',6,NULL);
INSERT INTO Undergoes VALUES(100000001,7,3217,'2008-05-10',7,101);
INSERT INTO Undergoes VALUES(100000004,4,3217,'2008-05-13',3,103);

select * from undergoes;

INSERT INTO Trained_In VALUES(3,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,7,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,5,'2007-01-01','2007-12-31');
INSERT INTO Trained_In VALUES(6,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,3,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,4,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,7,'2008-01-01','2008-12-31');

select * from trained_in;

-- 1 Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.

-- select physician from undergoes where physician not in (select physician from trained_in
-- where physician = undergoes.physician and procedures = trained_in.treatment);

select name from physician 
where employeeID in (
	select physician from undergoes where physician not in (select physician from trained_in
	where physician = undergoes.physician and procedures = trained_in.treatment)
);

-- 2 Same as the previous query, but include the following information in the results: 
-- Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.

select name from physician where employeeID = 3;
select * from trained_in where physician = 3;

select * from undergoes;

select physician_name, name as procedure_name, date, patient_name from
(
	select undergoes.*, patient.name as patient_name,
	physician.name as physician_name,
	procedures.name
	from undergoes 
	join 
	physician on
	undergoes.physician = physician.employeeID
	join patient
	on undergoes.patient = patient.ssn
	join procedures
	on undergoes.procedures = procedures.code
) as temp
where procedures not in (
	select procedures from undergoes, trained_in 
	where procedures = trained_in.treatment and undergoes.physician = trained_in.physician
);

-- 3 Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, 
-- but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired 
-- (Trained_In.CertificationExpires).

select physician.name as physician_name from undergoes
join physician on
undergoes.physician = physician.employeeID
join trained_in on
undergoes.procedures = trained_in.treatment and undergoes.physician = trained_in.physician
where date > certificationExpires;

-- 4 Same as the previous query, but include the following information in the results: 
-- Physician name, name of procedure, date when the procedure was carried out,
-- name of the patient the procedure was carried out on, and date when the certification expired.

select physician.name as physician_name,
procedures.name as procedure_name,
undergoes.date,
patient.name as patient_name,
trained_in.certificationExpires as cert_expiry_date
from undergoes 
join 
physician on
undergoes.physician = physician.employeeID
join patient
on undergoes.patient = patient.ssn
join procedures
on undergoes.procedures = procedures.code
join trained_in on
undergoes.procedures = trained_in.treatment and undergoes.physician = trained_in.physician
where date > trained_in.certificationExpires;

-- 5 Obtain the information for appointments where a patient met with a physician other 
-- than his/her primary care physician. Show the following information: 
-- Patient name, physician name, nurse name (if any), start and end time of appointment, 
-- examination room, and the name of the patient's primary care physician.

with temp as 
(
	select p.name as patient_name, 
    ph.name as physician_name,
    n.name as nurse_name,
	start,
	end,
	a.examinationRoom,
	p.pcp
	from appointment as a
	left join patient as p
	on a.patient = p.ssn
	left join physician as ph
	on a.physician = ph.employeeID
	left join nurse as n
	on a.prepNurse = n.employeeID
	where a.physician != p.pcp
) select patient_name, physician_name, nurse_name, start, end, examinationRoom, p.name from temp join physician as p
on temp.pcp = p.employeeID;

-- 6 The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. 
-- There are no constraints in force to prevent inconsistencies between these two tables.
-- More specifically, the Undergoes table may include a row where the patient ID does not 
-- match the one we would obtain from the Stay table through the Undergoes.Stay foreign key. 
-- Select all rows from Undergoes that exhibit this inconsistency.

select * from undergoes;
select * from stay;

select 	* from undergoes as u
where patient != ( select patient from stay s where u.stay = s.stayID );

-- 7 Obtain the names of all the nurses who have ever been on call for room 123.

select name from nurse where employeeID in (
	select nurse from on_call as o join
	room as r on o.BlockFloor = r.blockFloor and o.BlockCode = r.blockCode
	where number = 123
);

-- 8 The hospital has several examination rooms where appointments take place. 
-- Obtain the number of appointments that have taken place in each examination room.

select examinationRoom, count(*) as number_of_appointments 
from appointment group by examinationRoom;

-- 9 Obtain the names of all patients 
-- (also include, for each patient, the name of the patient's primary care physician),
-- such that \emph{all} the following are true:
-- The patient has been prescribed some medication by his/her primary care physician.
-- The patient has undergone a procedure with a cost larger that $5,000
-- The patient has had at least two appointment where the nurse who prepped the appointment 
-- was a registered nurse.
-- The patient's primary care physician is not the head of any department.

select p.ssn as patientID,
p.name as patient_name, 
p.pcp as physicianID,
ph.name as physicain_name
from patient as p, physician as ph
where p.pcp = ph.employeeID;

select name from patient where ssn in (
	select u.patient from undergoes as u,
	procedures as p where
	u.procedures = p.code and p.cost > 5000
);

select name from patient where ssn in
(
	select patient from 
    (
		select patient, 
		count(temp.appointmentID)over (partition by patient) as number_of_appointents
		from
		(
			select *
			from appointment as a, nurse as n
			where a.prepNurse = n.employeeID
		) as temp where temp.registered = 1
    ) as temp_2 where temp_2.number_of_appointents = 2
);


select name from patient where pcp not in (
	select head from department
);
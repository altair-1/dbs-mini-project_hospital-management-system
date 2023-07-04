
  SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
  START TRANSACTION;
  SET time_zone = "+00:00";


  /*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
  /*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
  /*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
  /*!40101 SET NAMES utf8mb4 */;

  --
  -- Database: `hms`
  --

  -- --------------------------------------------------------

CREATE DATABASE HMS;
USE HMS;

CREATE TABLE Patient(
email varchar(50) PRIMARY KEY,
password varchar(30) NOT NULL,
name varchar(50) NOT NULL,
address varchar(60) NOT NULL,
gender VARCHAR(20) NOT NULL
);

CREATE TABLE MedicalHistory(
id int PRIMARY KEY,
date DATE NOT NULL,
conditions VARCHAR(100) NOT NULL, 
surgeries VARCHAR(100) NOT NULL, 
medication VARCHAR(100) NOT NULL
);

CREATE TABLE Doctor(
email varchar(50) PRIMARY KEY,
gender varchar(20) NOT NULL,
password varchar(30) NOT NULL,
name varchar(50) NOT NULL
);

CREATE TABLE Appointment(
id int PRIMARY KEY,
date DATE NOT NULL,
starttime TIME NOT NULL,
endtime TIME NOT NULL,
status varchar(15) NOT NULL
);

CREATE TABLE PatientsAttendAppointments(
patient varchar(50) NOT NULL,
appt int NOT NULL,
concerns varchar(40) NOT NULL,
symptoms varchar(40) NOT NULL,
FOREIGN KEY (patient) REFERENCES Patient (email) ON DELETE CASCADE,
FOREIGN KEY (appt) REFERENCES Appointment (id) ON DELETE CASCADE,
PRIMARY KEY (patient, appt)
);

CREATE TABLE Schedule(
id int NOT NULL,
starttime TIME NOT NULL,
endtime TIME NOT NULL,
breaktime TIME NOT NULL,
day varchar(20) NOT NULL,
PRIMARY KEY (id, starttime, endtime, breaktime, day)
);

CREATE TABLE PatientsFillHistory(
patient varchar(50) NOT NULL,
history int NOT NULL,
FOREIGN KEY (patient) REFERENCES Patient (email) ON DELETE CASCADE,
FOREIGN KEY (history) REFERENCES MedicalHistory (id) ON DELETE CASCADE,
PRIMARY KEY (history)
);

CREATE TABLE Diagnose(
appt int NOT NULL,
doctor varchar(50) NOT NULL,
diagnosis varchar(40) NOT NULL,
prescription varchar(50) NOT NULL,
FOREIGN KEY (appt) REFERENCES Appointment (id) ON DELETE CASCADE,
FOREIGN KEY (doctor) REFERENCES Doctor (email) ON DELETE CASCADE,
PRIMARY KEY (appt, doctor)
);

CREATE TABLE DocsHaveSchedules(
sched int NOT NULL,
doctor varchar(50) NOT NULL,
FOREIGN KEY (sched) REFERENCES Schedule (id) ON DELETE CASCADE,
FOREIGN KEY (doctor) REFERENCES Doctor (email) ON DELETE CASCADE,
PRIMARY KEY (sched, doctor)
);

CREATE TABLE DoctorViewsHistory(
history int NOT NULL,
doctor varchar(50) NOT NULL,
FOREIGN KEY (doctor) REFERENCES Doctor (email) ON DELETE CASCADE,
FOREIGN KEY (history) REFERENCES MedicalHistory (id) ON DELETE CASCADE,
PRIMARY KEY (history, doctor)
);

INSERT INTO Patient(email,password,name,address,gender)
VALUES
('ramesh@gmail.com','hrishikesh13','Ramesh','Tamil Nadu', 'male'),
('suresh@gmail.com','hrishikesh13','Suresh','Karnataka', 'male'),
('rakesh@gmail.com','hrishikesh13','Rakesh','Gujarat', 'male')
;

INSERT INTO MedicalHistory(id,date,conditions,surgeries,medication)
VALUES
(1,'19-01-14','Pain in abdomen','Heart Surgery','Crocin'),
(2,'19-01-14','Frequent Indigestion','none','none'),
(3,'19-01-14','Body Pain','none','Iodex')
;

INSERT INTO Doctor(email, gender, password, name)
VALUES
('hathalye7@gmail.com', 'male', 'hrishikesh13', 'Hrishikesh Athalye'),
('hathalye8@gmail.com', 'male', 'hrishikesh13', 'Hrishikesh Athalye')
;

INSERT INTO Appointment(id,date,starttime,endtime,status)
VALUES
(1, '19-01-15', '09:00', '10:00', 'Done'),
(2, '19-01-16', '10:00', '11:00', 'Done'),
(3, '19-01-18', '14:00', '15:00', 'Done')
;

INSERT INTO PatientsAttendAppointments(patient,appt,concerns,symptoms)
VALUES
('ramesh@gmail.com',1, 'none', 'itchy throat'),
('suresh@gmail.com',2, 'infection', 'fever'),
('rakesh@gmail.com',3, 'nausea', 'fever')
;

INSERT INTO Schedule(id,starttime,endtime,breaktime,day)
VALUES
(001,'09:00','17:00','12:00','Tuesday'),
(001,'09:00','17:00','12:00','Friday'),
(001,'09:00','17:00','12:00','Saturday'),
(001,'09:00','17:00','12:00','Sunday'),
(002,'09:00','17:00','12:00','Wednesday'),
(002,'09:00','17:00','12:00','Friday')
;

INSERT INTO PatientsFillHistory(patient,history)
VALUES
('ramesh@gmail.com', 1),
('suresh@gmail.com', 2),
('rakesh@gmail.com', 3)
;

INSERT INTO Diagnose(appt,doctor,diagnosis,prescription)
VALUES
(1,'hathalye7@gmail.com', 'Bloating', 'Ibuprofen as needed'),
(2,'hathalye8@gmail.com', 'Muscle soreness', 'Stretch morning/night'),
(3,'hathalye8@gmail.com', 'Vitamin Deficiency', 'Good Diet')
;

INSERT INTO DocsHaveSchedules(sched,doctor)
VALUES
(001,'hathalye7@gmail.com'),
(002,'hathalye8@gmail.com')
;

INSERT INTO DoctorViewsHistory(history,doctor)
VALUES
(1,'hathalye7@gmail.com'),
(2,'hathalye8@gmail.com'),
(3,'hathalye8@gmail.com')
;

  --
  -- Table structure for table `doctors`
  --

  CREATE TABLE `doctors` (
    `did` int(11) NOT NULL,
    `email` varchar(50) NOT NULL,
    `doctorname` varchar(50) NOT NULL,
    `dept` varchar(100) NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

  --
  -- Dumping data for table `doctors`
  --

  INSERT INTO `doctors` (`did`, `email`, `doctorname`, `dept`) VALUES
  (1, 'anees@gmail.com', 'anees', 'Cardiologists'),
  (2, 'amrutha@gmail.com', 'amrutha bhatta', 'Dermatologists'),
  (3, 'aadithyaa@gmail.com', 'aadithyaa', 'Anesthesiologists'),
  (4, 'anees@gmail', 'anees', 'Endocrinologists'),
  (5, 'aneeqah@gmail.com', 'aneekha', 'corona');

  -- --------------------------------------------------------

  --
  -- Table structure for table `patients`
  --

  CREATE TABLE `patients` (
    `pid` int(11) NOT NULL,
    `email` varchar(50) NOT NULL,
    `name` varchar(50) NOT NULL,
    `gender` varchar(50) NOT NULL,
    `slot` varchar(50) NOT NULL,
    `disease` varchar(50) NOT NULL,
    `time` time NOT NULL,
    `date` date NOT NULL,
    `dept` varchar(50) NOT NULL,
    `number` varchar(12) NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

  --
  -- Dumping data for table `patients`
  --

  INSERT INTO `patients` (`pid`, `email`, `name`, `gender`, `slot`, `disease`, `time`, `date`, `dept`, `number`) VALUES
  (2, 'anees1@gmail.com', 'anees1 rehman khan', 'Male1', 'evening1', 'cold1', '21:20:00', '2020-02-02', 'ortho11predict', '9874561110'),
  (5, 'patient@gmail.com', 'patien', 'Male', 'morning', 'fevr', '18:06:00', '2020-11-18', 'Cardiologists', '9874563210'),
  (7, 'patient@gmail.com', 'anees', 'Male', 'evening', 'cold', '22:18:00', '2020-11-05', 'Dermatologists', '9874563210'),
  (8, 'patient@gmail.com', 'anees', 'Male', 'evening', 'cold', '22:18:00', '2020-11-05', 'Dermatologists', '9874563210'),
  (9, 'aneesurrehman423@gmail.com', 'anees', 'Male', 'morning', 'cold', '17:27:00', '2020-11-26', 'Anesthesiologists', '9874563210'),
  (10, 'anees@gmail.com', 'anees', 'Male', 'evening', 'fever', '16:25:00', '2020-12-09', 'Cardiologists', '9874589654'),
  (15, 'khushi@gmail.com', 'khushi', 'Female', 'morning', 'corona', '20:42:00', '2021-01-23', 'Anesthesiologists', '9874563210'),
  (16, 'khushi@gmail.com', 'khushi', 'Female', 'evening', 'fever', '15:46:00', '2021-01-31', 'Endocrinologists', '9874587496'),
  (17, 'aneeqah@gmail.com', 'aneeqah', 'Female', 'evening', 'fever', '15:48:00', '2021-01-23', 'Endocrinologists', '9874563210');

  --
  -- Triggers `patients`
  --
  DELIMITER $$
  CREATE TRIGGER `PatientDelete` BEFORE DELETE ON `patients` FOR EACH ROW INSERT INTO trigr VALUES(null,OLD.pid,OLD.email,OLD.name,'PATIENT DELETED',NOW())
  $$
  DELIMITER ;
  DELIMITER $$
  CREATE TRIGGER `PatientUpdate` AFTER UPDATE ON `patients` FOR EACH ROW INSERT INTO trigr VALUES(null,NEW.pid,NEW.email,NEW.name,'PATIENT UPDATED',NOW())
  $$
  DELIMITER ;
  DELIMITER $$
  CREATE TRIGGER `patientinsertion` AFTER INSERT ON `patients` FOR EACH ROW INSERT INTO trigr VALUES(null,NEW.pid,NEW.email,NEW.name,'PATIENT INSERTED',NOW())
  $$
  DELIMITER ;

  -- --------------------------------------------------------

  --
  -- Table structure for table `test`
  --

  CREATE TABLE `test` (
    `id` int(11) NOT NULL,
    `name` varchar(20) NOT NULL,
    `email` varchar(20) NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

  --
  -- Dumping data for table `test`
  --

  INSERT INTO `test` (`id`, `name`, `email`) VALUES
  (1, 'ANEES', 'ARK@GMAIL.COM'),
  (2, 'test', 'test@gmail.com');

  -- --------------------------------------------------------

  --
  -- Table structure for table `trigr`
  --

  CREATE TABLE `trigr` (
    `tid` int(11) NOT NULL,
    `pid` int(11) NOT NULL,
    `email` varchar(50) NOT NULL,
    `name` varchar(50) NOT NULL,
    `action` varchar(50) NOT NULL,
    `timestamp` datetime NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

  --
  -- Dumping data for table `trigr`
  --

  INSERT INTO `trigr` (`tid`, `pid`, `email`, `name`, `action`, `timestamp`) VALUES
  (1, 12, 'anees@gmail.com', 'ANEES', 'PATIENT INSERTED', '2020-12-02 16:35:10'),
  (2, 11, 'anees@gmail.com', 'anees', 'PATIENT INSERTED', '2020-12-02 16:37:34'),
  (3, 10, 'anees@gmail.com', 'anees', 'PATIENT UPDATED', '2020-12-02 16:38:27'),
  (4, 11, 'anees@gmail.com', 'anees', 'PATIENT UPDATED', '2020-12-02 16:38:33'),
  (5, 12, 'anees@gmail.com', 'ANEES', 'Patient Deleted', '2020-12-02 16:40:40'),
  (6, 11, 'anees@gmail.com', 'anees', 'PATIENT DELETED', '2020-12-02 16:41:10'),
  (7, 13, 'testing@gmail.com', 'testing', 'PATIENT INSERTED', '2020-12-02 16:50:21'),
  (8, 13, 'testing@gmail.com', 'testing', 'PATIENT UPDATED', '2020-12-02 16:50:32'),
  (9, 13, 'testing@gmail.com', 'testing', 'PATIENT DELETED', '2020-12-02 16:50:57'),
  (10, 14, 'aneeqah@gmail.com', 'aneeqah', 'PATIENT INSERTED', '2021-01-22 15:18:09'),
  (11, 14, 'aneeqah@gmail.com', 'aneeqah', 'PATIENT UPDATED', '2021-01-22 15:18:29'),
  (12, 14, 'aneeqah@gmail.com', 'aneeqah', 'PATIENT DELETED', '2021-01-22 15:41:48'),
  (13, 15, 'khushi@gmail.com', 'khushi', 'PATIENT INSERTED', '2021-01-22 15:43:02'),
  (14, 15, 'khushi@gmail.com', 'khushi', 'PATIENT UPDATED', '2021-01-22 15:43:11'),
  (15, 16, 'khushi@gmail.com', 'khushi', 'PATIENT INSERTED', '2021-01-22 15:43:37'),
  (16, 16, 'khushi@gmail.com', 'khushi', 'PATIENT UPDATED', '2021-01-22 15:43:49'),
  (17, 17, 'aneeqah@gmail.com', 'aneeqah', 'PATIENT INSERTED', '2021-01-22 15:44:41'),
  (18, 17, 'aneeqah@gmail.com', 'aneeqah', 'PATIENT UPDATED', '2021-01-22 15:44:52'),
  (19, 17, 'aneeqah@gmail.com', 'aneeqah', 'PATIENT UPDATED', '2021-01-22 15:44:59');

  -- --------------------------------------------------------

  --
  -- Table structure for table `user`
  --

  CREATE TABLE `user` (
    `id` int(11) NOT NULL,
    `username` varchar(50) NOT NULL,
    `usertype` varchar(50) NOT NULL,
    `email` varchar(50) NOT NULL,
    `password` varchar(1000) NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

  --
  -- Dumping data for table `user`
  --

  INSERT INTO `user` (`id`, `username`, `usertype`, `email`, `password`) VALUES
  (13, 'anees', 'Doctor', 'anees@gmail.com', 'pbkdf2:sha256:150000$xAKZCiJG$4c7a7e704708f86659d730565ff92e8327b01be5c49a6b1ef8afdf1c531fa5c3'),
  (14, 'aneeqah', 'Patient', 'aneeqah@gmail.com', 'pbkdf2:sha256:150000$Yf51ilDC$028cff81a536ed9d477f9e45efcd9e53a9717d0ab5171d75334c397716d581b8'),
  (15, 'khushi', 'Patient', 'khushi@gmail.com', 'pbkdf2:sha256:150000$BeSHeRKV$a8b27379ce9b2499d4caef21d9d387260b3e4ba9f7311168b6e180a00db91f22');

  --
  -- Indexes for dumped tables
  --

  --
  -- Indexes for table `doctors`
  --
  ALTER TABLE `doctors`
    ADD PRIMARY KEY (`did`);

  --
  -- Indexes for table `patients`
  --
  ALTER TABLE `patients`
    ADD PRIMARY KEY (`pid`);

  --
  -- Indexes for table `test`
  --
  ALTER TABLE `test`
    ADD PRIMARY KEY (`id`);

  --
  -- Indexes for table `trigr`
  --
  ALTER TABLE `trigr`
    ADD PRIMARY KEY (`tid`);

  --
  -- Indexes for table `user`
  --
  ALTER TABLE `user`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `email` (`email`);

  --
  -- AUTO_INCREMENT for dumped tables
  --

  --
  -- AUTO_INCREMENT for table `doctors`
  --
  ALTER TABLE `doctors`
    MODIFY `did` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

  --
  -- AUTO_INCREMENT for table `patients`
  --
  ALTER TABLE `patients`
    MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

  --
  -- AUTO_INCREMENT for table `test`
  --
  ALTER TABLE `test`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

  --
  -- AUTO_INCREMENT for table `trigr`
  --
  ALTER TABLE `trigr`
    MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

  --
  -- AUTO_INCREMENT for table `user`
  --
  ALTER TABLE `user`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
  COMMIT;

  /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
  /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
  /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


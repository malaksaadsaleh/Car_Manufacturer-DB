CREATE DATABASE IF NOT EXISTS Car_Manufacturer;
USE car_manufacturer;
SHOW DATABASES;

CREATE TABLE IF NOT EXISTS Company(
	company_ID Int primary Key NOT NULL,
	company_Name Varchar(60) UNIQUE NOT NULL,
    tax_id VARCHAR(20) UNIQUE NOT NULL,
    founding_date DATE NOT NULL,
    website VARCHAR(100),
    location VARCHAR(100)
);

INSERT INTO Company(company_ID, company_Name, tax_id, founding_date, website, location)
VALUES (20122, 'HMA', '45-3829176', '1999-08-13', 'www.HMA.com', '427 Maple Ridge Drive Springdale, CA 94582');

SELECT * FROM Company ;

CREATE TABLE IF NOT EXISTS participants (
	participants_Id INT(50) AUTO_INCREMENT PRIMARY KEY NOT NULL,
    national_id BIGINT UNIQUE NOT Null,
	participants_email VARCHAR(80) UNIQUE NOT NULL,
    First_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
   participance_percentage  DECIMAL(5,2) NOT NULL,
   return_investments DECIMAL(12,2) NOT NULL,
   Investment_date DATE Not NULL,
   Investment_amount DECIMAL(12,2) Not NULL,
   Investment_status ENUM('active','inactive','exited'),
   Company_ID INT,
   FOREIGN KEY(Company_ID) REFERENCES Company (Company_ID)
   ON UPDATE CASCADE
   ON DELETE SET NULL
);

INSERT INTO participants(national_id, participants_email, First_name, last_name, participance_percentage, return_investments, Investment_date, Investment_amount, Investment_status, Company_ID)
VALUES
    (1234567890, 'ahmed.ali@example.com', 'Ahmed', 'Ali', 25.50, 450.00, '2025-11-15', 5000.00, 'active', 20122),
    (0987654321, 'fatma.mohamed@example.com', 'Fatma', 'Mohamed', 30.00, 750.00, '2025-10-20', 8000.00, 'active', 20122),
    (1122334455, 'khaled.salem@example.com', 'Khaled', 'Salem', 15.75, 225.00, '2025-09-10', 3000.00, 'inactive', 20122),
    (5566778899, 'noura.omar@example.com', 'Noura', 'Omar', 40.25, 1200.00, '2025-11-25', 15000.00, 'active', 20122);
    
SELECT * FROM participants ;

SELECT 
    Co.company_Name,
    Co.website,
    Pa.first_name,
    Pa.last_name,
    Pa.participants_email,
    Pa.participance_percentage 
FROM Company Co
INNER JOIN participants Pa
    ON Co.company_ID = Pa.Company_ID;

CREATE TABLE IF NOT EXISTS Branches(
	branch_id INT PRIMARY KEY NOT NULL,
    location VARCHAR(100),
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    branch_email VARCHAR(100) UNIQUE NOT NULL,
    opening_date DATE NOT NULL,
    branch_status ENUM('active', 'inactive', 'under_renovation'),
    Company_ID INT ,
    FOREIGN KEY (Company_ID) REFERENCES Company (Company_ID)
    ON UPDATE CASCADE
   ON DELETE SET NULL
);

INSERT INTO Branches (branch_id, location, phone_number, branch_email, opening_date, branch_status, Company_ID)
VALUES 
    (1782537, 'Cairo Downtown, Egypt', '2025550123', 'cairo@company.com', '2025-01-15', 'active', 20122),
    (2612701, 'Alexandria Port, Egypt', '2036660234', 'alex@company.com', '2025-02-20', 'active', 20122),
    (3926345, 'Giza Pyramids Area, Egypt', '2027770345', 'giza@company.com', '2025-03-10', 'under_renovation', 20122),
    (4782534, 'Luxor City Center, Egypt', '2095880456', 'luxor@company.com', '2024-11-05', 'inactive', 20122);
    
SELECT * FROM Branches ;

SELECT Co.Company_name,
        B.location ,
        B.phone_number ,
        B.branch_email ,
        B.branch_status
FROM Company Co
RIGHT JOIN Branches B 
ON 
Co.company_ID = B.Company_ID;

CREATE TABLE IF NOT EXISTS Department(
	Department_ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Department_Name VARCHAR(30) UNIQUE NOT NUll,
    Number_of_Employees INT NOT NULL,
    Department_description VARCHAR(100) NOT NULL
);

INSERT INTO Department (Department_Name, Number_of_Employees, Department_description)
VALUES 
    ('Finance', 22, 'Financial management and accounting services'),
    ('Law', 12, 'Legal compliance and corporate counsel'),
    ('HR', 28, 'Human resources and employee management'),
    ('Marketing', 35, 'Marketing and brand promotion activities'),
    ('BD', 18, 'Business development and partnerships'),
    ('Designing', 15, 'Graphic design and creative services'),
    ('R&D', 40, 'Research and product development'),
    ('Crisis & Disaster management', 10, 'Emergency response and risk management'),
    ('Quality & Testing', 25, 'Quality assurance and product testing');
    
SELECT * FROM Department ;


CREATE TABLE IF NOT EXISTS Working_Force (
	working_Id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    national_id BIGINT UNIQUE NOT NULL,
    working_email VARCHAR(80) UNIQUE NOT NULL,
    First_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL,
    phone_no VARCHAR(15) UNIQUE NOT NULL,
    address VARCHAR(100),
    salary DECIMAL(10,2) NOT NULL,
    DOE DATE NOT NULL,
    field_name VARCHAR(100),
    Department_ID INT,
    company_Id INT,
    FOREIGN KEY (Department_ID) REFERENCES Department (Department_ID),
	FOREIGN KEY (company_Id) REFERENCES company (company_Id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO Working_Force (national_id, working_email, First_name, last_name, position, phone_no, address, salary, field_name, DOE, Department_ID, company_Id)
VALUES 
    (1234567891, 'ahmed.ali@company.com', 'Ahmed', 'Ali', 'Senior Accountant', '2012345678', 'Cairo, Egypt', 45000.00, 'Programmers', '2025-01-15', 1, 20122),
    (0987654322, 'fatma.mohamed@company.com', 'Fatma', 'Mohamed', 'Legal Advisor', '2023456789', 'Alexandria, Egypt', 55000.00, 'Managers', '2025-02-10', 2, 20122),
    (1122334456, 'khaled.salem@company.com', 'Khaled', 'Salem', 'HR Manager', '2034567890', 'Giza, Egypt', 48000.00, 'Electricians', '2024-11-20', 3, 20122),
    (5566778898, 'noura.omar@company.com', 'Noura', 'Omar', 'Marketing Director', '2045678901', 'Luxor, Egypt', 52000.00, 'Sponsors', '2025-03-05', 4, 20122),
    (6677889900, 'mohamed.hassan@company.com', 'Mohamed', 'Hassan', 'Business Developer', '2056789012', 'Cairo, Egypt', 42000.00, 'Mechanicals', '2025-01-25', 5, 20122),
    (123456789012345, 'ahmed.elmasry@example.com', 'Ahmed', 'Elmasry', 'Engineer', '10000000001', '15 El-Nasr St, Cairo', 8500.00, 'Employee', '2023-05-10', 7, 20122),
    (234567890123456, 'mona.hassan@example.com', 'Mona', 'Hassan', 'HR Specialist', '10000000002', '22 Tahrir Sq, Cairo', 9200.00, 'Lawyers', '2022-11-15', 3, 20122),
    (345678901234567, 'yousef.khaled@example.com', 'Yousef', 'Khaled', 'Finance Analyst', '10000000003', '58 Ramses St, Cairo', 7800.00, 'Supervisors', '2024-01-20', 1, 20122),
    (456789012345678, 'sara.naguib@example.com', 'Sara', 'Naguib', 'Quality Tester', '10000000004', '10 Zamalek, Cairo', 8000.00, 'Designer', '2023-08-01', 9, 20122),
    (567890123456789, 'mohamed.farid@example.com', 'Mohamed', 'Farid', 'Marketing Manager', '10000000005', '32 Heliopolis, Cairo', 9500.00, 'Quality & Testing engineer', '2021-12-05', 4, 20122);
    
SELECT * FROM Working_Force ;

SELECT D.Department_ID ,
	   D.Department_Name ,
       WF.* 
FROM Department D
JOIN Working_Force WF
ON 
D.Department_ID = WF.Department_ID;

ALTER TABLE Working_Force
DROP COLUMN address ;

CREATE TABLE IF NOT EXISTS Supplier(
	Supplier_ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    First_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) not Null,
    email VARCHAR(80) UNIQUE NOT NULL,
    supplier_phone_number VARCHAR(15) UNIQUE NOT NULL,
    supplier_national_id BIGINT UNIQUE NOT NULL,
     company_Id INT,
	FOREIGN KEY (company_Id) REFERENCES company (company_Id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO Supplier (First_name, last_name, email, supplier_phone_number, supplier_national_id, company_Id)
VALUES
    ('Khaled', 'Abdullah', 'khaled.abdullah@supplyco.com', '2012345678', 123456789012346, 20122),
    ('Fatma', 'Mahmoud', 'fatma.mahmoud@techsuppliers.eg', '2023456789', 234567890123457, 20122),
    ('Omar', 'Salem', 'omar.salem@electrohub.com', '2034567890', 345678901234568, 20122),
    ('Nadia', 'Ibrahim', 'nadia.ibrahim@mechparts.net', '2045678901', 456789012345679, 20122),
    ('Hassan', 'Reda', 'hassan.reda@qualitysupplies.com', '2056789012', 567890123456780, 20122);
    
SELECT * FROM Supplier ;

SELECT C.Company_name ,
	   S.*
FROM Company C 
JOIN Supplier S 
ON
C.Company_id = S.Company_id ;

CREATE TABLE IF NOT EXISTS Contract (
	Contract_ID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Contract_Description VARCHAR(100),
    contract_start_date DATE,
    Contract_end_date DATE,
    contract_value DECIMAL(12,2) NOT NULL,
    Provided_parts VARCHAR(100) NOT NULL,
    Payment_terms VARCHAR(200) NOT NULL,
    percentage DECIMAL(5,2),
    Contract_Type ENUM('External','Internal'),
    Supplier_ID INT,
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier (Supplier_ID)
	ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO Contract (Contract_Description, contract_start_date, Contract_end_date, contract_value, Provided_parts, Payment_terms, percentage, Contract_Type, Supplier_ID) 
VALUES
    ('Electrical components supply agreement', '2025-01-15', '2025-12-31', 125000.00, 'Wires, cables, transformers', '30% advance, 70% on delivery', 5.00, 'External', 1),
    ('Mechanical parts procurement contract', '2025-02-01', '2026-01-31', 95000.00, 'Gears, bearings, shafts', 'Net 60 days', 3.00, 'External', 2),
    ('Electronic components bulk order', '2025-03-10', '2025-09-30', 180000.00, 'Resistors, capacitors, ICs', '50% advance, balance monthly', 8.00, 'External', 3),
    ('Quality testing equipment supply', '2025-04-20', '2026-04-19', 75000.00, 'Multimeters, oscilloscopes', 'Net 30 days', 2.00, 'External', 4),
    ('Office equipment maintenance contract', '2025-01-01', '2025-12-31', 45000.00, 'Printers, scanners, furniture', 'Quarterly payments', 1.00, 'Internal', 5);
    
 SELECT * FROM contract ;
 
SELECT S.Supplier_ID ,
		S.First_name ,
        S.last_name ,
        S.email ,
        CON.*
FROM Supplier S 
JOIN Contract CON 
ON 
S.Supplier_ID = CON.Supplier_ID ;

CREATE TABLE IF NOT EXISTS Manufactuer(
	Manufactuerer_ID Int PRIMARY KEY NOT NULL,
	mugactured_car_type  ENUM('gasoline', 'hybrid'),
    location VARCHAR(100) NOT NULL,  
    manufactured_car_quantity INT NOT NULL,
    company_Id INT,
	FOREIGN KEY (company_Id) REFERENCES company (company_Id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO Manufactuer (Manufactuerer_ID, mugactured_car_type, location, manufactured_car_quantity, company_Id)
VALUES
    (1001, 'gasoline', '6th of October City, Giza', 25000, 20122),
    (1002, 'hybrid', 'Nasr City, Cairo', 12000, 20122),
    (1003, 'gasoline', '10th of Ramadan City', 35000, 20122),
    (1004, 'hybrid', 'Suez Industrial Zone', 8000, 20122),
    (1005, 'gasoline', 'Helwan Industrial Area', 18000, 20122);

SELECT * FROM Manufactuer ;

SELECT C.Company_name ,
		MAN.*
FROM Company C
JOIN Manufactuer MAN 
ON
C.Company_id = MAN.company_Id ;

ALTER TABLE manufactuer 
RENAME COLUMN mugactured_car_type TO manufactured_CT ;

CREATE TABLE IF NOT EXISTS parts_type (
	Parts_type_Id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	Parts_type_name VARCHAR(100)  NOT NULL,
    part_type_description VARCHAR(120) NOT NULL
    
);

INSERT INTO parts_type (Parts_type_name, part_type_description) 
VALUES
    ('Engine Components', 'Internal and external parts related to the engine assembly, like pistons and valves.'),
    ('Electrical System', 'Components responsible for power generation, storage, and distribution, such as batteries and alternators.'),
    ('Body Panels', 'Exterior metal or composite sections of a vehicle, including fenders, doors, and hoods.'),
    ('Braking System', 'Parts designed for slowing and stopping motion, including pads, rotors, and calipers.'),
    ('Suspension & Steering', 'Components that connect the vehicle to its wheels and allow steering, like shocks and tie rods.'),
    ('Interior Trim', 'Non-mechanical parts located inside the cabin, such as seat covers, dashboards, and headliners.');
    
SELECT * FROM parts_type;

CREATE TABLE IF NOT EXISTS parts(
	parts_RFID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	maximum_stock_level INT NOT NULL,
    minimum_stock_level INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    parts_status ENUM('available', 'out_of_stock', 'discontinued'),
    Parts_type_Id INT,
    supplier_id INT,
   FOREIGN KEY  (Parts_type_Id) REFERENCES parts_type (Parts_type_Id)
   ON UPDATE CASCADE
   ON DELETE SET NULL,
    FOREIGN KEY  (supplier_id) REFERENCES supplier (supplier_id)
   ON UPDATE CASCADE
   ON DELETE SET NULL
);

INSERT INTO parts (maximum_stock_level, minimum_stock_level, unit_price, parts_status, Parts_type_Id, supplier_id)
VALUES
    (120, 15, 28000.00, 'available', 1, 1),
    (90, 20, 45000.00, 'available', 2, 2),
    (150, 25, 8500.00, 'out_of_stock', 3, 3),
    (75, 10, 12500.00, 'available', 4, 4),
    (60, 12, 3200.00, 'available', 5, 5),
    (45, 8, 18500.00, 'available', 6, 1),
    (80, 18, 12500.00, 'available', 1, 2),
    (100, 20, 9500.00, 'discontinued', 2, 3),
    (200, 30, 3200.00, 'available', 3, 4),
    (40, 5, 42000.00, 'available', 4, 5);

SELECT * FROM parts;

SELECT PA.Parts_type_Id , 
	   PA.Parts_type_name ,
       PA.part_type_description ,
       PP.* 
FROM parts_type PA 
JOIN parts PP 
ON
PA.Parts_type_Id = PP.Parts_type_Id ;

CREATE TABLE IF NOT EXISTS cars(
	car_RFID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    car_Description VARCHAR(200) UNIQUE NOT NULL,
    model VARCHAR(12) NOT NULL,
    launch_year DATE,
    price DECIMAL(12,2) NOT NULL,
    car_type ENUM('Sedan', 'SUV','Hatchback'),
    car_status ENUM('in_production', 'discontinues', 'planned'),
    horsepower INT NOT NULL,
    engine_capacity INT NOT NULL,
    Quantity_in_stock INT NOT NULL,
    seating_capacity INT NOT NULL,
    Manufactuerer_ID INT,
	FOREIGN KEY (Manufactuerer_ID) REFERENCES Manufactuer (Manufactuerer_ID)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO cars (car_Description, model, launch_year, price, car_type, car_status, horsepower, engine_capacity, Quantity_in_stock, seating_capacity, Manufactuerer_ID)
VALUES
    ('Zentara Vionix S8 2025 Executive Sedan with luxury interior', 'VionixS8', '2025-01-15', 1250000.00, 'Sedan', 'in_production', 162, 1600, 65, 5, 1001),
    ('Nexara Kryvex T7 2025 Premium SUV with terrain response', 'KryvexT7', '2025-02-01', 1680000.00, 'SUV', 'in_production', 178, 2000, 42, 7, 1002),
    ('Veltron Zynara H3 2025 Compact Hatchback urban edition', 'ZynaraH3', '2025-03-10', 850000.00, 'Hatchback', 'planned', 112, 1200, 0, 5, 1003),
    ('Aetheron Lumyx R5 2025 Sport Sedan performance package', 'LumyxR5', '2025-04-20', 1450000.00, 'Sedan', 'in_production', 195, 1800, 28, 5, 1004),
    ('Kryon Nextron Q9 2026 Family SUV with 360 camera system', 'NextronQ9', '2026-01-01', 1980000.00, 'SUV', 'planned', 220, 2500, 0, 7, 1005);
    
    SELECT * FROM cars;
    
    SELECT MAN.Manufactuerer_ID ,
		   MAN.manufactured_CT ,
           CR.* 
    FROM Manufactuer MAN
	JOIN cars CR 
    ON
    MAN.Manufactuerer_ID = CR.Manufactuerer_ID ;
    
CREATE TABLE IF NOT EXISTS Production (
    Production_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Units_produced INT NOT NULL,
    Production_end_date  DATE NOT NULL,
    Production_start_date DATE NOT NULL,
    state ENUM('complete', 'in_progress', 'scheduled') ,
    Manufactuerer_id INT,
    FOREIGN KEY (Manufactuerer_id) REFERENCES Manufactuer(Manufactuerer_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO Production (Units_produced, Production_end_date, Production_start_date, state, Manufactuerer_id) 
VALUES
    (500, '2025-10-15', '2025-09-01', 'complete', 1001),
    (250, '2025-11-28', '2025-11-20', 'in_progress', 1002),
    (1200, '2026-01-30', '2025-12-01', 'scheduled', 1003);
    
SELECT * FROM Production;

SELECT MAN.Manufactuerer_ID ,
	   PR.Units_produced ,
       PR.Production_id ,
       PR.Production_start_date ,
       PR. Production_end_date ,
       PR.state 
FROM Manufactuer MAN 
JOIN Production PR
ON
MAN.Manufactuerer_ID = PR.Manufactuerer_ID ;

CREATE TABLE IF NOT EXISTS cars_parts (
    Car_RFID INT,
    Parts_RFID INT,
    build_date DATE,
    quantity_used INT DEFAULT 1,
    PRIMARY KEY (Car_RFID, Parts_RFID),
    FOREIGN KEY(Car_RFID) REFERENCES cars(Car_RFID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY(Parts_RFID) REFERENCES parts(Parts_RFID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO cars_parts (Car_RFID, Parts_RFID, build_date, quantity_used) 
VALUES
    (1, 1, '2025-10-15', 1), 
    (1, 2, '2025-10-16', 3), 
    (2, 1, '2025-11-01', 2), 
    (2, 3, '2025-11-10', 4);

SELECT * FROM cars_parts;

SELECT *
FROM cars_parts AS C_P 
ORDER BY build_date ;

    CREATE TABLE IF NOT EXISTS Production_Parts (
    Production_id INT, 
    Parts_RFID INT,
    Quantity_Used INT NOT NULL,
    PRIMARY KEY(Production_id, Parts_RFID),
    FOREIGN KEY (Production_id) REFERENCES Production(Production_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (Parts_RFID) REFERENCES parts(Parts_RFID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO Production_Parts (Production_id, Parts_RFID, Quantity_Used) 
VALUES
    (1, 1, 500),
    (2, 2, 1000),
    (3, 3, 700);

SELECT * FROM Production_Parts;

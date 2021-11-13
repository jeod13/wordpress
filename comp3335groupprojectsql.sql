--
-- Database: `ProjectDB`
--
drop database IF EXISTS ProjectDB;
create database ProjectDB character set utf8mb4;
-- check 有無加到個database
show databases;
USE ProjectDB;

-- Create Table Admin 最高權限既Account
CREATE TABLE Admin (
  admin_ID int AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  password varchar(50) NOT NULL,
  PRIMARY KEY (admin_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table Admin
--

INSERT INTO Admin (name, password) VALUES 
('admin1', '12345'),
('admin2', '12345');

-- --------------------------------------------------------

-- Create Table Employee 員工
CREATE TABLE Employee(
  employee_ID int,
  first_name varchar(255) NOT NULL,
  last_name varchar(255) NOT NULL,
  password varchar(50) NOT NULL,
  type int NOT NULL DEFAULT 0 COMMENT '員工類型 : 0 = 經理 1 = 普通員工',
  phone_number int NOT NULL,
  address varchar(255) NOT NULL,
  email varchar(150) ,
  bank_number int,
  status int NOT NULL DEFAULT 0 COMMENT '0 = 在職 1 = 已解僱 2 = 其他',
  PRIMARY KEY (employee_ID)
 ) ENGINE = InnoDB;

--
-- AUTO_INCREMENT for table Employee
--
ALTER TABLE Employee
  MODIFY employee_ID int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10001;

--
-- Dumping data for table Employee
--

INSERT INTO Employee (first_name, last_name, password, type, phone_number, address, email, bank_number, status) VALUES 
('Employee_test', '1', 12345, 0, 12345678, 'aaaaaaa', '', 0, 0),
('Employee_test', '2', 12345, 0, 12345678, 'bbbbbbb', '', 0, 0),
('Employee_test', '3', 12345, 0, 12345678, 'ccccccc', '', 0, 1);

-- --------------------------------------------------------

-- Create Table Customer 客戶
CREATE TABLE Customer(
  customer_ID int ,
  first_name varchar(255) NOT NULL,
  last_name varchar(255) NOT NULL,
  password varchar(50) NOT NULL,  
  phone_number int NOT NULL,
  address varchar(255) NOT NULL,
  email varchar(150) ,  
  status int NOT NULL DEFAULT 0 COMMENT '0 = normal 1 = blocked 2 = other',
  PRIMARY KEY (customer_ID)
 ) ENGINE = InnoDB;

--
-- AUTO_INCREMENT for table Customer
--
ALTER TABLE Customer
  MODIFY customer_ID int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20001;

--
-- Dumping data for table Customer
--

INSERT INTO Customer (first_name, last_name, password, phone_number, address, email, status) VALUES 
('Customer_test', '1', 12345, 12345678, 'aaaaaaa','aaa@aaa.com', 0),
('Customer_test', '2', 12345, 12345678, 'bbbbbbb','bbb@bbb.com', 1),
('Customer_test', '3', 12345, 12345678, 'ccccccc','ccc@ccc.com', 0),
('Customer_test', '4', 12345, 12345678, 'ddddddd','ddd@ddd.com', 0),
('Customer_test', '5', 12345, 12345678, 'eeeeeee','eee@eee.com', 0),
('Customer_test', '6', 12345, 12345678, 'fffffff','fff@fff.com', 0);

-- --------------------------------------------------------

-- Create Table Product 貨品
CREATE TABLE Product(
  product_ID int AUTO_INCREMENT,
  customer_ID int NOT NULL,
  name varchar(255) NOT NULL,
  description varchar(50) NOT NULL,  
  price decimal(10,2) NOT NULL,
  stock int NOT NULL DEFAULT 0,  
  tag varchar(255) NOT NULL,
  status int NOT NULL DEFAULT 0 COMMENT '0 = enable 1 = disable',
  PRIMARY KEY (product_ID)
 ) ENGINE = InnoDB;

--
-- Dumping data for table Product
--

INSERT INTO Product (customer_ID, name, description, price, stock, tag, status) VALUES 
(20001, 'Z Gundam', 'Blue White Gundam', 129.9, 5,'Figure', 0),
(20001, 'Ferrari F7', 'Black Car', 599.9, 2,'Toy Car', 0),
(20003, 'G-Shock a8', 'Gold & Black', 1499.9, 10,'Watch', 0);

-- --------------------------------------------------------

-- Create Table Promotion 營銷/促銷活動
CREATE TABLE Promotion(
  promotion_ID int AUTO_INCREMENT,
  customer_ID int NOT NULL,
  name varchar(255) NOT NULL,
  description varchar(255) NOT NULL COMMENT '活動簡介',  
  discount decimal(2,2) NOT NULL,
  start_date datetime NOT NULL,
  end_date datetime NOT NULL,
  PRIMARY KEY (promotion_ID)
 ) ENGINE = InnoDB;

--
-- Dumping data for table Promotion
--

INSERT INTO Promotion (customer_ID, name, description, discount, start_date, end_date) VALUES 
(20001, 'Chinese Valentine Day', 'Celebrate Chinese Valentine Day', 0.8,'2021-08-14 00:00', '2021-08-28 23:59'),
(20003, 'Double 10 Event', 'Celebrate Double 10 Event', 0.75, '2021-10-10 00:00', '2021-10-24 23:59'),
(20003, 'Double 11 Event', 'Celebrate Double 11 Event', 0.75, '2021-11-11 00:00', '2021-11-25 23:59');

-- --------------------------------------------------------

-- Create Table Transaction_Record 交易記錄
CREATE TABLE Transaction_Record(
  transaction_record_ID int AUTO_INCREMENT,
  customer_ID int NOT NULL,
  transaction_datetime datetime NOT NULL,
  PRIMARY KEY (transaction_record_ID)
 ) ENGINE = InnoDB;

--
-- Dumping data for table Transaction_Record
--

INSERT INTO Transaction_Record (customer_ID, transaction_datetime) VALUES 
(20004, '2021-07-01 13:05:22'),
(20004, '2021-08-14 13:02:01'),
(20005, '2021-08-14 15:34:35'),
(20006, '2021-09-01 18:21:14'),
(20004, '2021-11-11 00:11:59');

-- --------------------------------------------------------

-- Create Table Employee_Server_log 員工記錄
CREATE TABLE Employee_Server_log(
  e_log_ID int AUTO_INCREMENT,
  employee_ID int NOT NULL,
  action varchar(255) NOT NULL,
  action_time datetime NOT NULL,
  action_type int NOT NULL COMMENT '0 = other 1 = insert 2 = update 3 = delete 4 = logout/login', 
  PRIMARY KEY (e_log_ID)
 ) ENGINE = InnoDB;

--
-- Dumping data for table Employee_Server_log
--

INSERT INTO Employee_Server_log (employee_ID, action, action_time, action_type) VALUES 
(10001, 'Employee 10001 Login Account', '2021-06-28 15:23:36', 4),
(10001, 'Employee 10001 Logout Account', '2021-06-28 15:24:01', 4),
(10001, 'Employee 10001 Login Account', '2021-06-28 15:24:21', 4),
(10001, 'Employee 10001 Edit Profile ', '2021-06-28 15:24:48', 2),
(10001, 'Employee 10001 Logout Account', '2021-06-28 15:26:16', 4);

-- --------------------------------------------------------

-- Create Table Customer_Server_log 客戶記錄
CREATE TABLE Customer_Server_log(
  c_log_ID int AUTO_INCREMENT,
  customer_ID int NOT NULL,
  action varchar(255) NOT NULL,
  action_time datetime NOT NULL,
  action_type int NOT NULL COMMENT '0 = other 1 = insert 2 = update 3 = delete 4 = logout/login 5 = register', 
  PRIMARY KEY (c_log_ID)
 ) ENGINE = InnoDB;

--
-- Dumping data for table Customer_Server_log
--

INSERT INTO Customer_Server_log (customer_ID, action, action_time, action_type) VALUES 
(20001, 'Customer 20001 Register Account', '2021-08-01 00:10:24', 5),
(20001, 'Customer 20001 Login Account', '2021-08-01 00:10:56', 4),
(20001, 'Customer 20001 Add Product 1', '2021-08-01 14:30:24', 1),
(20001, 'Customer 20001 Edit Product 1', '2021-08-01 14:32:31', 2),
(20001, 'Customer 20001 Add Product 2', '2021-08-01 14:35:11', 1),
(20001, 'Customer 20001 Edit Product 2', '2021-08-01 14:35:42', 2),
(20001, 'Customer 20001 Logout Account', '2021-08-01 15:26:16', 4),
(20001, 'Customer 20001 Login Account', '2021-08-09 22:10:44', 4),
(20001, 'Customer 20001 Create Promotion: Chinese Valentine Day', '2021-08-09 22:14:01', 1),
(20001, 'Customer 20001 Logout Account', '2021-08-09 22:20:10', 4);

-- --------------------------------------------------------

-- Create Table Promotion_Product 
CREATE TABLE Promotion_Product(
  promotion_ID int NOT NULL,
  product_ID int NOT NULL,
  PRIMARY KEY (promotion_ID, product_ID)
 ) ENGINE = InnoDB;

--
-- Dumping data for table Promotion_Product
--

INSERT INTO Promotion_Product (promotion_ID, product_ID) VALUES 
(1, 1),
(1, 2),
(2, 3),
(3, 3);

-- --------------------------------------------------------

-- Create Table Transaction_Record_Product 
CREATE TABLE Transaction_Record_Product(
  transaction_record_ID int NOT NULL,
  product_ID int NOT NULL,
  PRIMARY KEY (transaction_record_ID, product_ID)
 ) ENGINE = InnoDB;

--
-- Dumping data for table Transaction_Record_Product
--

INSERT INTO Transaction_Record_Product (transaction_record_ID, product_ID) VALUES 
(1, 1),
(2, 2),
(3, 2),
(4, 3),
(3, 3);

-- --------------------------------------------------------

--
-- Key for table Product
--
ALTER TABLE Product
  ADD KEY Product_fk1 (customer_ID);
                      
--
-- Constraints for table Product
--
ALTER TABLE Product
  ADD CONSTRAINT Product_fk1 FOREIGN KEY (customer_ID) REFERENCES Customer (customer_ID);

--
-- Key for table Promotion
--
ALTER TABLE Promotion
  ADD KEY Promotion_fk1 (customer_ID);
                      
--
-- Constraints for table Promotion
--
ALTER TABLE Promotion
  ADD CONSTRAINT Promotion_fk1 FOREIGN KEY (customer_ID) REFERENCES Customer (customer_ID);

--
-- Key for table Transaction_Record
--
ALTER TABLE Transaction_Record
  ADD KEY Transaction_Record_fk1 (customer_ID);
                      
--
-- Constraints for table Transaction_Record
--
ALTER TABLE Transaction_Record
  ADD CONSTRAINT Transaction_Record_fk1 FOREIGN KEY (customer_ID) REFERENCES Customer (customer_ID);

--
-- Key for table Employee_Server_log
--
ALTER TABLE Employee_Server_log
  ADD KEY Employee_Server_log_fk1 (employee_ID);
                      
--
-- Constraints for table Employee_Server_log
--
ALTER TABLE Employee_Server_log
  ADD CONSTRAINT Employee_Server_log_fk1 FOREIGN KEY (employee_ID) REFERENCES Employee (employee_ID);

--
-- Key for table Customer_Server_log
--
ALTER TABLE Customer_Server_log
  ADD KEY Customer_Server_log_fk1 (customer_ID);
                      
--
-- Constraints for table Customer_Server_log
--
ALTER TABLE Customer_Server_log
  ADD CONSTRAINT Customer_Server_log_fk1 FOREIGN KEY (customer_ID) REFERENCES Customer (customer_ID);

-- describe
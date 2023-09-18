create database comprehensive_problem;
use comprehensive_problem;

create table Customer(
Customer_Id nvarchar(4) primary key,
Customer_name varchar(30) not null,
Address varchar(50),
Birthday datetime,
Phone_number varchar(15)
);

create table Staff(
Staff_Id varchar(4) primary key,
Staff_fullname varchar(30) not null,
Gender bit default(1) not null,
Address varchar(50) not null,
Birthday datetime not null,
Phone_number varchar(15),
Email text,
Birth_place varchar(20) not null,
Date_start_work datetime,
Manager_Id varchar(4)
);

create table Supplier(
Sup_Id varchar(5) primary key,
Sup_name varchar(50) not null,
Address varchar(50) not null,
Phone_number varchar(15) not null,
Email varchar(30) not null,
Website varchar(30)
);
create table Product_type(
Product_type_Id varchar(4) primary key,
Product_type_name varchar(30) not null,
Product_type_descr varchar(100) not null
);

create table Product(
Product_Id varchar(4) primary key,
Product_type_Id varchar(4) not null,
foreign key(Product_type_Id) references Product_type(Product_type_Id),
Product_name varchar(50) not null,
Cal_Unit varchar(10) not null, 
Product_descr varchar(100)
);

create table Import_bill(
Import_bill_Id varchar(5) primary key,
Staff_Id varchar(4) not null,
Sup_Id varchar(5) not null,
foreign key(Staff_Id) references Staff(Staff_Id),
foreign key(Sup_Id) references Supplier(Sup_Id),
Import_date datetime default(current_date()) not null,
Import_bill_descr varchar(100)
);

create table Import_bill_detail(
Product_Id varchar(4),
Import_bill_Id varchar(5),
primary key(Product_Id, Import_bill_Id),
foreign key(Product_Id) references Product(Product_Id),
foreign key(Import_bill_Id) references Import_bill(Import_bill_Id),
Import_quantity smallint default(0) not null,
Import_price real not null check(Import_price>=0)
);

CREATE TABLE Export_bill (
    Export_bill_Id VARCHAR(5) PRIMARY KEY,
    Staff_Id VARCHAR(4) NOT NULL,
    Customer_Id NVARCHAR(4) NOT NULL,
    FOREIGN KEY (Staff_Id)
        REFERENCES Staff (Staff_Id),
    FOREIGN KEY (Customer_Id)
        REFERENCES Customer (Customer_Id),
    Export_date DATETIME NOT NULL,
    Export_bill_descr TEXT
);

delimiter //
create trigger validate_export_date before insert on Export_bill
for each row
Begin 
if new.Export_date < now() then 
signal SQLSTATE '45000'
set message_text = 'Export date should be greater than current date!';
END IF;
end;
//
delimiter ;

create table Export_bill_detail(
Export_bill_Id varchar(5),
Product_Id varchar(4),
primary key(Export_bill_Id, Product_Id),
foreign key(Export_bill_Id) references Export_bill(Export_bill_Id),
foreign key(Product_Id) references Product(Product_Id),
Quantity smallint not null check(Quantity>0) not null,
Export_price real check(Export_price>0) not null
);

-- insert info of all entities
insert into Customer(Customer_Id, Customer_name, Address, Birthday, Phone_number)
value('C001', 'Cao Thanh Tung', 'Thai Binh', '1994-08-07 15:00:00', '07084567213');
insert into Staff(Staff_Id, Staff_fullname, Gender, Address, Birthday, Phone_number, Email, Birth_place, Date_start_work, Manager_Id)
value('S001', 'Cao Minh Chau', 1, 'Ha Noi', '1994-05-05', '07045611235', 'chau@gmail.com', 'Hanoi', '2021-05-05', 'M001');
insert into Staff(Staff_Id, Staff_fullname, Gender, Address, Birthday, Phone_number, Email, Birth_place, Date_start_work, Manager_Id)
value('S002', 'Cao Van Hinh', 1, 'Ha Noi', '1994-05-05', '07045611235', 'hinh@gmail.com', 'Hanoi', '2021-05-05', 'M001');
insert into Supplier(Sup_Id, Sup_name, Address, Phone_number, Email, Website)
value('SP001', 'Carington', 'England', '100332556', 'carinton@gmail.com', 'http://carington.com');
insert into Product_type(Product_type_Id, Product_type_name, Product_type_descr)
value('P001', 'water-proof', 'popular');
insert into Product(Product_Id, Product_type_Id, Product_name, Cal_Unit, Product_descr)
value('J001', 'P001', 'sport shoes', 'pair', 'Best seller');
insert into Product(Product_Id, Product_type_Id, Product_name, Cal_Unit, Product_descr)
value('J002', 'P001', 'football shoes', 'pair', 'Best seller');
insert into Product(Product_Id, Product_type_Id, Product_name, Cal_Unit, Product_descr)
value('J003', 'P001', 'industial shoes', 'pair', 'Best seller');
insert into Product(Product_Id, Product_type_Id, Product_name, Cal_Unit, Product_descr)
value('J015', 'P001', 'kid shoes', 'pair', 'Best seller');
-- insert import bill IB001
insert into Import_bill(Import_bill_Id, Staff_Id, Sup_Id, Import_date, Import_bill_descr)
value('IB001', 'S001', 'SP001', '2023-05-05', 'first-order of 2023');
-- insert import bill detail for IB001
insert into Import_bill_detail(Product_Id, Import_bill_Id, Import_quantity, Import_price)
value('J001', 'IB001', 3, 45);
insert into Import_bill_detail(Product_Id, Import_bill_Id, Import_quantity, Import_price)
value('J002', 'IB001', 3, 45);
-- insert import bill IB002
insert into Import_bill(Import_bill_Id, Staff_Id, Sup_Id, Import_date, Import_bill_descr)
value('IB002', 'S001', 'SP001', '2023-05-05', 'first-order of 2023');
-- insert import bill detail for IB002
insert into Import_bill_detail(Product_Id, Import_bill_Id, Import_quantity, Import_price)
value('J001', 'IB002', 3, 45);
insert into Import_bill_detail(Product_Id, Import_bill_Id, Import_quantity, Import_price)
value('J003', 'IB002', 3, 45);
-- insert export bill EB001
insert into Export_bill(Export_bill_Id, Staff_Id, Customer_Id, Export_date, Export_bill_descr)
value('EB001', 'S001', 'C001', '2023-09-15', 'first-sale of 2023');
-- insert Export bill detail for EB001
insert into Export_bill_detail(Export_bill_Id, Product_Id, Quantity, Export_price)
value('EB001', 'J001', 3, 50);
insert into Export_bill_detail(Export_bill_Id, Product_Id, Quantity, Export_price)
value('EB001', 'J003', 3, 70);
-- insert export bill EB002
insert into Export_bill(Export_bill_Id, Staff_Id, Customer_Id, Export_date, Export_bill_descr)
value('EB002', 'S001', 'C001', '2023-09-16', 'first-sale of 2023');
-- insert Export bill detail for EB002
insert into Export_bill_detail(Export_bill_Id, Product_Id, Quantity, Export_price)
value('EB002', 'J001', 3, 50);
insert into Export_bill_detail(Export_bill_Id, Product_Id, Quantity, Export_price)
value('EB002', 'J002', 3, 80);

-- update info of customer and staff
UPDATE Customer 
SET 
    Phone_number = '07089564512'
WHERE
    Customer_Id = 'C001';
UPDATE Staff 
SET 
    Address = 'Thai Binh'
WHERE
    Staff_Id = 'S001';

-- Delete info of staff S002
DELETE FROM Staff 
WHERE
    Staff_Id = 'S002';
DELETE FROM Product 
WHERE
    Product_Id = 'J015';

-- Using Select to get data in tables
-- 1. problem 6.1
alter table Staff 
add Staff_age int;
insert into Staff(Staff_Id, Staff_fullname, Gender, Address, Birthday, Phone_number, Email, Birth_place, Date_start_work, Manager_Id)
value('S002', 'Cao Van Hinh', 1, 'Ha Noi', '1994-05-05', '07045611235', 'hinh@gmail.com', 'Hanoi', '2021-05-05', 'M001');
UPDATE Staff 
SET 
    Birthday = '1966-12-25'
WHERE
    Staff_Id = 'S002';
set SQL_SAFE_UPDATES = 0;
UPDATE Staff 
SET 
    Staff_age = YEAR(CURRENT_DATE()) - YEAR(Staff.Birthday)
WHERE
    Staff.Staff_Id IS NOT NULL;
SELECT 
    Staff_Id,
    Staff_fullname,
    Gender,
    Address,
    Birthday,
    Phone_number,
    Staff_age
FROM
    Staff
ORDER BY Staff.Staff_age DESC;
-- 2. problem 6.2
insert into Import_bill(Import_bill_Id, Staff_Id, Sup_Id, Import_date, Import_bill_descr)
value('IB003', 'S002','SP001', '2018-6-20', 'Important transaction');
SELECT 
    Import_bill.Import_bill_Id,
    Import_bill.Staff_Id,
    Staff.Staff_fullname,
    Supplier.Sup_name,
    Import_bill.Import_date,
    Import_bill.Import_bill_descr
FROM
    Import_bill
        INNER JOIN
    Staff ON Import_bill.Staff_Id = Staff.Staff_Id
        INNER JOIN
    Supplier ON Supplier.Sup_Id = Import_bill.Sup_Id
WHERE
    YEAR(Import_bill.Import_date) = 2018
        AND MONTH(Import_bill.Import_date);
-- 3. problem 6.3
SELECT 
    *
FROM
    Product
WHERE
    Product.Cal_Unit = 'pair';
-- 4. problem 6.4
insert into Import_bill_detail(Product_Id, Import_bill_Id, Import_quantity, Import_price)
value('J002', 'IB005', '20', 35);
alter table Import_bill_detail
add Total_price float;
UPDATE Import_bill_detail 
SET 
    Total_price = Import_bill_detail.Import_price * Import_bill_detail.Import_quantity
WHERE
    Import_bill_detail.Import_bill_Id IS NOT NULL;
insert into Import_bill(Import_bill_Id, Staff_Id, Sup_Id, Import_date, Import_bill_descr)
value('IB005', 'S002','SP001', '2018-9-20', 'Important transaction');
UPDATE Import_bill 
SET 
    Import_bill.Import_date = '2023-09-15'
WHERE
    Import_bill_Id = 'IB005';
SELECT 
    Import_bill_detail.Import_bill_Id,
    Import_bill_detail.Product_Id,
    Product.Product_name,
    Product.Product_type_Id,
    Product.Cal_Unit,
    Import_bill_detail.Import_quantity,
    Import_bill_detail.Import_price,
    Total_price
FROM
    Import_bill_detail
        INNER JOIN
    Import_bill ON Import_bill_detail.Import_bill_Id = Import_bill.Import_bill_Id
        INNER JOIN
    Product ON Import_bill_detail.Product_Id = Product.Product_Id
WHERE
    MONTH(Import_bill.Import_date) = MONTH(CURRENT_DATE());
-- 5. problem 6.5
SELECT 
    Import_bill.Sup_Id,
    Supplier.Sup_name,
    Supplier.Address,
    Supplier.Phone_number,
    Supplier.Email,
    Import_bill.Import_bill_Id,
    Import_bill.Import_date
FROM
    Import_bill
        INNER JOIN
    Supplier ON Import_bill.Sup_Id = Supplier.Sup_Id
WHERE
    MONTH(Import_bill.Import_date) = MONTH(CURRENT_DATE()); 
-- 6. problem 6.6
insert into Export_bill(Export_bill_Id, Staff_Id, Customer_Id, Export_date, Export_bill_descr)
value('EB006', 'S002', 'C001', '2023-09-18', 'Big transaction');
insert into Export_bill_detail(Export_bill_Id, Product_Id, Quantity, Export_price)
value('EB006', 'J003', 6, 50);
alter table Export_bill_detail
add column Revenue float;
UPDATE Export_bill_detail 
SET 
    Revenue = Export_bill_detail.Export_price * Export_bill_detail.Quantity
WHERE
    Export_bill_detail.Export_bill_Id IS NOT NULL;
SELECT 
    Export_bill_detail.Export_bill_Id,
    Export_bill.Staff_Id,
    Export_bill.Export_date,
    Export_bill_detail.Product_Id,
    Product.Product_name,
    Product.Cal_Unit,
    Export_bill_detail.Quantity,
    Export_bill_detail.Revenue
FROM
    Export_bill_detail
        INNER JOIN
    Export_bill ON Export_bill_detail.Export_bill_Id = Export_bill.Export_bill_Id
        INNER JOIN
    Product ON Export_bill_detail.Product_Id = Product.Product_Id
WHERE
    YEAR(Export_bill.Export_date) = 2023
        AND MONTH(Export_bill.Export_date) BETWEEN 9 AND 12;
-- 7. problem 6.7
SELECT 
    Customer.Customer_Id,
    Customer.Customer_name,
    Customer.Address,
    Customer.Birthday,
    Customer.Phone_number
FROM
    Customer
WHERE
    YEAR(Customer.Birthday) = YEAR(CURRENT_DATE())
        AND MONTH(Customer.Birthday) = MONTH(CURRENT_DATE());
-- 8. problem 6.8
SELECT 
    Export_bill_detail.Export_bill_Id,
    Export_bill.Staff_Id,
    Export_bill.Export_date,
    Export_bill_detail.Product_Id,
    Product.Product_name,
    Product.Cal_Unit,
    Export_bill_detail.Quantity,
    Export_bill_detail.Revenue
FROM
    Export_bill_detail
        INNER JOIN
    Export_bill ON Export_bill_detail.Export_bill_Id = Export_bill.Export_bill_Id
        INNER JOIN
    Product ON Export_bill_detail.Product_Id = Product.Product_Id
WHERE
    Export_bill.Export_date BETWEEN '2023-08-16' AND '2023-09-15';
-- 9. problem 6.9
SELECT 
    Export_bill.Customer_Id,
    Customer.Customer_name,
    Export_bill.Export_bill_Id,
    Export_bill.Export_date,
    Export_bill_detail.Revenue
FROM
    Export_bill
        INNER JOIN
    Export_bill_detail ON Export_bill.Export_bill_Id = Export_bill_detail.Export_bill_Id
        INNER JOIN
    Customer ON Export_bill.Customer_Id = Customer.Customer_Id
WHERE
    Export_bill.Customer_Id IS NOT NULL;
-- 10. problem 6.10
SELECT 
    Product.Product_name,
    SUM(Export_bill_detail.Quantity) AS QuantityOfProduct
FROM
    Export_bill_detail
        INNER JOIN
    Product ON Export_bill_detail.Product_Id = Product.Product_Id
WHERE
    Product.Product_name = 'sport shoes'
GROUP BY Product_name;
-- 11. problem 6.11
insert into Customer(Customer_Id, Customer_name, Address, Birthday, Phone_number)
value('C002', 'Nguyen thi lan anh', 'Bac Ninh', '1994-11-25', '07045697845');
insert into Export_bill(Export_bill_Id, Staff_Id, Customer_Id, Export_date, Export_bill_descr)
value('EB003', 'S002', 'C002', '2023-09-25', 'Important sale');
insert into Export_bill_detail(Export_bill_Id, Product_Id, Quantity, Export_price)
value('EB003', 'J002', 6, 50);
SELECT 
    MONTH(Export_bill.Export_date) AS Export_month,
    Export_bill.Customer_Id,
    Customer.Customer_name,
    Address,
    SUM(Export_bill_detail.Revenue) AS Total_sales
FROM
    Export_bill
        INNER JOIN
    Export_bill_detail ON Export_bill.Export_bill_Id = Export_bill_detail.Export_bill_Id
        INNER JOIN
    Customer ON Export_bill.Customer_Id = Customer.Customer_Id
GROUP BY MONTH(Export_bill.Export_date) , Export_bill.Customer_Id
ORDER BY Export_month , Customer.Customer_Id;
-- 12. problem 6.12
SELECT 
    YEAR(Export_bill.Export_date) AS Exp_Year,
    MONTH(Export_bill.Export_date) AS Exp_Month,
    Export_bill_detail.Product_Id,
    Product.Product_name,
    Product.Cal_Unit,
    SUM(Export_bill_detail.Quantity) AS Total_quantity
FROM
    Export_bill_detail
        INNER JOIN
    Export_bill ON Export_bill_detail.Export_bill_Id = Export_bill.Export_bill_Id
        INNER JOIN
    Product ON Export_bill_detail.Product_Id = Product.Product_Id
GROUP BY YEAR(Export_bill.Export_date) , MONTH(Export_bill.Export_date) , Export_bill_detail.Product_Id;
-- 13 problem 6.13
SELECT 
    MONTH(Export_bill.Export_date) AS Exp_month,
    Export_bill.Export_bill_Id,
    sum(Export_bill_detail.Revenue)
FROM
    Export_bill_detail
        INNER JOIN
    Export_bill ON Export_bill_detail.Export_bill_Id = Export_bill.Export_bill_Id
GROUP BY Export_bill.Export_bill_Id
order by MONTH(Export_bill.Export_date);
-- 14. problem 6.14
SELECT 
    Export_bill.Export_bill_Id,
    Export_bill.Export_date,
    Staff.Staff_fullname,
    Customer.Customer_name,
    SUM(Export_bill_detail.Revenue)
FROM
    Export_bill
        INNER JOIN
    Export_bill_detail ON Export_bill.Export_bill_Id = Export_bill_detail.Export_bill_Id
        INNER JOIN
    Customer ON Export_bill.Customer_Id = Customer.Customer_Id
        INNER JOIN
    Staff ON Export_bill.Staff_Id = Staff.Staff_Id
WHERE
    MONTH(Export_bill.Export_date) = 9
        AND YEAR(Export_bill.Export_date) = 2023
GROUP BY Export_bill.Export_bill_Id;
-- 15. problem 6.15
SELECT 
    Export_bill.Export_bill_Id,
    Export_bill.Customer_Id,
    Customer.Customer_name,
    Staff.Staff_fullname,
    DATE(Export_bill.Export_date) AS Export_date,
    SUM(Export_bill_detail.Revenue) AS Total_Revenue
FROM
    Export_bill
        INNER JOIN
    Export_bill_detail ON Export_bill.Export_bill_Id = Export_bill_detail.Export_bill_Id
        INNER JOIN
    Customer ON Export_bill.Customer_Id = Customer.Customer_Id
        INNER JOIN
    Staff ON Export_bill.Staff_Id = Staff.Staff_Id
WHERE
    DAY(Export_bill.Export_date) = 15
        AND MONTH(Export_bill.Export_date) = 9
        AND YEAR(Export_bill.Export_date) = 2023
GROUP BY Export_bill.Export_bill_Id;
-- 16. problem 6.16 ----- ERROR
SELECT 
    Export_bill.Staff_Id,
    Staff.Staff_fullname,
    Export_bill_detail.Product_Id,
    Product.Product_name,
    Product.Cal_Unit,
    SUM(Export_bill_detail.Quantity)
FROM
    Export_bill_detail
        INNER JOIN
    Export_bill ON Export_bill_detail.Export_bill_Id = Export_bill.Export_bill_Id
        INNER JOIN
    Product ON Export_bill_detail.Product_Id = Product.Product_Id
        INNER JOIN
    Staff ON Staff.Staff_Id = (SELECT 
            Staff_Id
        FROM
            Export_bill
        WHERE
            Export_bill_detail.Export_bill_Id = Export_bill.Export_bill_Id)
GROUP BY Export_bill.Staff_Id , Staff.Staff_fullname , Export_bill_detail.Product_Id , Product.Product_name , Product.Cal_Unit;
-- 17. problem 6.17
SELECT 
    Export_bill.Export_bill_Id,
    DATE(Export_bill.Export_date) AS DateOfExport,
    Export_bill_detail.Product_Id,
    Product.Product_name,
    Product.Cal_Unit,
    Export_bill_detail.Quantity,
    Export_bill_detail.Export_price,
    SUM(Export_bill_detail.Revenue)
FROM
    Export_bill_detail
        INNER JOIN
    Export_bill ON Export_bill_detail.Export_bill_Id = Export_bill.Export_bill_Id
        INNER JOIN
    Product ON Export_bill_detail.Product_Id = Product.Product_Id
WHERE
    Export_bill.Customer_Id = 'C002'
GROUP BY Export_bill.Export_bill_Id , Export_bill_detail.Product_Id;
-- 18. problem 6.18
insert into Product(Product_Id, Product_type_Id, Product_name, Cal_Unit, Product_descr)
value('J004', 'P001', 'old shoes', 'pair', 'rank B');
SELECT 
    Product.Product_Id,
    Product_name,
    Product_type.Product_type_name,
    Product.Cal_Unit
FROM
    Product
        INNER JOIN
    Product_type ON Product.Product_type_Id = Product_type.Product_type_Id
WHERE
    Product_Id NOT IN (SELECT 
            Product_Id
        FROM
            Export_bill_detail
        WHERE
            Export_bill_detail.Product_Id IS NOT NULL);
-- 19. problem 6.19
SELECT 
    Supplier.Sup_Id,
    Supplier.Sup_name,
    Supplier.Address,
    Supplier.Phone_number
FROM
    Supplier
WHERE
    Sup_Id NOT IN (SELECT 
            Sup_Id
        FROM
            Import_bill
        WHERE
            MONTH(Import_bill.Import_date) BETWEEN 4 AND 7
                AND YEAR(Import_bill.Import_date) = 2017);
-- 20. problem 6.20
SELECT 
    Export_bill.Customer_Id,
    Customer.Customer_name,
    MAX(Export_bill_detail.Revenue) AS MaxOrder
FROM
    Export_bill
        INNER JOIN
    Export_bill_detail ON Export_bill.Export_bill_Id = Export_bill_detail.Export_bill_Id
        INNER JOIN
    Customer ON Export_bill.Customer_Id = Customer.Customer_Id
GROUP BY Export_bill.Customer_Id;
-- 21. problem 6.21
SELECT 
    Export_bill.Customer_Id, COUNT(Export_bill.Customer_Id)
FROM
    Export_bill
GROUP BY Export_bill.Customer_Id;
-- 22. problem 6.22
SELECT 
    Export_bill.Staff_Id,
    Staff.Staff_fullname,
    Customer.Customer_name
FROM
    Export_bill
        INNER JOIN
    Staff ON Export_bill.Staff_Id = Staff.Staff_Id
        INNER JOIN
    Customer ON Export_bill.Customer_Id = Customer.Customer_Id;
-- 23. problem 6.23
SELECT 
    COUNT(CASE
        WHEN Staff.Gender = 1 THEN Staff.Gender
    END) AS NumberOfMale,
    COUNT(CASE
        WHEN Staff.Gender = 0 THEN Staff.Gender
    END) AS NumberOfFemale
FROM
    Staff;
-- 24. problem 6.24
SELECT 
    Staff.Staff_Id,
    Staff.Staff_fullname,
    MAX(YEAR(CURRENT_DATE()) - YEAR(Staff.Date_start_work)) AS Seniority
FROM
    Staff
GROUP BY Staff.Staff_Id;
-- 25. problem 6.25
SELECT 
    Staff_fullname
FROM
    Staff
WHERE
    (Staff.Gender = 1
        AND YEAR(CURRENT_DATE()) - YEAR(Staff.Birthday) = 60)
        OR (Staff.Gender = 0
        AND YEAR(CURRENT_DATE()) - YEAR(Staff.Birthday) = 55);
-- 26. problem 6.26
alter table Staff add year_retired int;
UPDATE Staff 
SET 
    Staff.year_retired = YEAR(CURRENT_DATE()) + 60 - Staff.Staff_age
WHERE
    Staff.Gender = 1;
UPDATE Staff 
SET 
    Staff.year_retired = YEAR(CURRENT_DATE()) + 55 - Staff.Staff_age
WHERE
    Staff.Gender = 0;
SELECT 
    Staff.Staff_fullname, Staff.year_retired
FROM
    Staff;
-- 27. problem 6.27
alter table Staff add seniority int;
UPDATE Staff 
SET 
    Staff.seniority = YEAR(CURRENT_DATE()) - YEAR(Staff.Date_start_work)
WHERE
    Staff.Staff_id IS NOT NULL;
alter table Staff add year_end_bonus float;
UPDATE Staff 
SET 
    year_end_bonus = 200000
WHERE
    Staff.seniority < 1;
UPDATE Staff 
SET 
    year_end_bonus = 400000
WHERE
    Staff.seniority >= 1
        AND Staff.seniority < 3;
UPDATE Staff 
SET 
    year_end_bonus = 400000
WHERE
    Staff.seniority >= 1
        AND Staff.seniority < 3;
UPDATE Staff 
SET 
    year_end_bonus = 600000
WHERE
    Staff.seniority >= 3
        AND Staff.seniority < 5;
UPDATE Staff 
SET 
    year_end_bonus = 800000
WHERE
    Staff.seniority >= 5
        AND Staff.seniority < 10;
UPDATE Staff 
SET 
    year_end_bonus = 1000000
WHERE
    Staff.seniority >= 10;
SELECT 
    Staff.Staff_Id,
    Staff.Staff_fullname,
    Staff.seniority,
    Staff.year_end_bonus
FROM
    Staff;
-- 28. problem 6.28-
insert into Product_type(Product_type_Id, Product_type_name, Product_type_descr)
value('P002', 'normal', 'popular');
insert into Product_type(Product_type_Id, Product_type_name, Product_type_descr)
value('P003', 'light reflection', 'popular');
alter table Product_type add Division varchar(20);
UPDATE Product_type 
SET 
    Division = 'shoes'
WHERE
    Product_type.Product_type_Id = 'P001';
UPDATE Product_type 
SET 
    Division = 'T-shirt'
WHERE
    Product_type.Product_type_Id = 'P002';
UPDATE Product_type 
SET 
    Division = 'suit'
WHERE
    Product_type.Product_type_Id = 'P003';
SELECT 
    Product.Product_name
FROM
    Product
        INNER JOIN
    Product_type ON Product.Product_type_Id = Product_type.Product_type_Id
WHERE
    Product_type.Division = 'shoes'; 
-- 29. problem 6.29
SELECT 
    Product.Product_name
FROM
    Product
        INNER JOIN
    Product_type ON Product.Product_type_Id = Product_type.Product_type_Id
WHERE
    Product_type.Division = 'T-shirt'; 
-- 30. problem 6.30
insert into Product(Product_Id, Product_type_Id, Product_name, Cal_Unit, Product_descr)
value('J005', 'P002', 'White T-shirt', 'pair', 'Best seller');
insert into Product(Product_Id, Product_type_Id, Product_name, Cal_Unit, Product_descr)
value('J006', 'P003', 'Kingsman suit', 'pair', 'Best seller');
select Product_type.Division, count(Product.Product_Id) as NumberOfProductInDiv
from Product_type
inner join Product on Product.Product_type_Id = Product_type.Product_type_Id
group by Product_type.Division
having Product_type.Division = 'shoes';
-- 31. problem 6.31
select Product_type.Division, count(Product.Product_Id) as NumberOfProductInDiv
from Product_type
inner join Product on Product.Product_type_Id = Product_type.Product_type_Id
group by Product_type.Division
having Product_type.Division = 'T-shirt';
-- 32. problem 6.32
select Product_type.Division, count(Product.Product_Id) as NumberOfProductInDiv
from Product_type
inner join Product on Product.Product_type_Id = Product_type.Product_type_Id
group by Product_type.Division

















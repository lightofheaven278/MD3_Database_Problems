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

create table Export_bill(
Export_bill_Id varchar(5) primary key,
Staff_Id varchar(4) not null,
Customer_Id nvarchar(4) not null,
foreign key(Staff_Id) references Staff(Staff_Id),
foreign key(Customer_Id) references Customer(Customer_Id),
Export_date datetime not null,
Export_bill_descr text
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
update Customer set Phone_number = '07089564512' where Customer_Id = 'C001';
update Staff set Address = 'Thai Binh' where Staff_Id = 'S001';

-- Delete info of staff S002
delete from Staff where Staff_Id = 'S002'; 
delete from Product where Product_Id = 'J015';

-- Using Select to get data in tables
-- 1. problem 6.1
alter table Staff 
add Staff_age int;
insert into Staff(Staff_Id, Staff_fullname, Gender, Address, Birthday, Phone_number, Email, Birth_place, Date_start_work, Manager_Id)
value('S002', 'Cao Van Hinh', 1, 'Ha Noi', '1994-05-05', '07045611235', 'hinh@gmail.com', 'Hanoi', '2021-05-05', 'M001');
update Staff
set Birthday = '1966-12-25'
where Staff_Id = 'S002';
set SQL_SAFE_UPDATES = 0;
update Staff
set Staff_age = Year(current_date()) - year(Staff.Birthday)
where Staff.Staff_Id is not null;
select Staff_Id, Staff_fullname, Gender, Address, Birthday, Phone_number, Staff_age
from Staff
order by Staff.Staff_age desc;
-- 2. problem 6.2
insert into Import_bill(Import_bill_Id, Staff_Id, Sup_Id, Import_date, Import_bill_descr)
value('IB003', 'S002','SP001', '2018-6-20', 'Important transaction');
select Import_bill.Import_bill_Id, Import_bill.Staff_Id, Staff.Staff_fullname, Supplier.Sup_name,
 Import_bill.Import_date, Import_bill.Import_bill_descr
from Import_bill
inner join Staff on Import_bill.Staff_Id = Staff.Staff_Id
inner join Supplier on Supplier.Sup_Id = Import_bill.Sup_Id
where year(Import_bill.Import_date) = 2018 and month(Import_bill.Import_date);
-- 3. problem 6.3
select * 
from Product
where Product.Cal_Unit = 'pair';
-- 4. problem 6.4
insert into Import_bill_detail(Product_Id, Import_bill_Id, Import_quantity, Import_price)
value('J002', 'IB005', '20', 35);
alter table Import_bill_detail
add Total_price float;
update Import_bill_detail
set Total_price = Import_bill_detail.Import_price * Import_bill_detail.Import_quantity
where Import_bill_detail.Import_bill_Id is not null;
insert into Import_bill(Import_bill_Id, Staff_Id, Sup_Id, Import_date, Import_bill_descr)
value('IB005', 'S002','SP001', '2018-9-20', 'Important transaction');
update Import_bill
set Import_bill.Import_date = '2023-09-15'
where Import_bill_Id = 'IB005';
select Import_bill_detail.Import_bill_Id, Import_bill_detail.Product_Id, Product.Product_name, Product.Product_type_Id,
Product.Cal_Unit, Import_bill_detail.Import_quantity, Import_bill_detail.Import_price, Total_price
from Import_bill_detail
inner join Import_bill on Import_bill_detail.Import_bill_Id = Import_bill.Import_bill_Id
inner join Product on Import_bill_detail.Product_Id = Product.Product_Id
where month(Import_bill.Import_date) = month(current_date());
-- 5. problem 6.5
select Import_bill.Sup_Id, Supplier.Sup_name, Supplier.Address, Supplier.Phone_number, Supplier.Email,
Import_bill.Import_bill_Id, Import_bill.Import_date
from Import_bill
inner join Supplier on Import_bill.Sup_Id = Supplier.Sup_Id
where month(Import_bill.Import_date) = month(current_date()); 
-- 6. problem 6.6
insert into Export_bill(Export_bill_Id, Staff_Id, Customer_Id, Export_date, Export_bill_descr)
value('EB006', 'S002', 'C001', '2023-09-18', 'Big transaction');
alter table Export_bill_detail
add column Revenue float;
update Export_bill_detail
set Revenue = Export_bill_detail.Export_price * Export_bill_detail.Quantity
where Export_bill_detail.Export_bill_Id is not null;
select Export_bill_detail.Export_bill_Id, Export_bill.Staff_Id, Export_bill.Export_date,
Export_bill_detail.Product_Id, Product.Product_name, Product.Cal_Unit, Export_bill_detail.Quantity,
Export_bill_detail.Revenue
from Export_bill_detail
inner join Export_bill on Export_bill_detail.Export_bill_Id = Export_bill.Export_bill_Id
inner join Product on Export_bill_detail.Product_Id = Product.Product_Id
where year(Export_bill.Export_date) = 2023 and month(Export_bill.Export_date) between 9 and 12;
-- 7. problem 6.7
select Customer.Customer_Id, Customer.Customer_name, Customer.Address, Customer.Birthday, Customer.Phone_number
from Customer
where Year(Customer.Birthday) = Year(current_date()) and month(Customer.Birthday) = month(current_date());
-- 8. problem 6.8
select Export_bill_detail.Export_bill_Id, Export_bill.Staff_Id, Export_bill.Export_date, Export_bill_detail.Product_Id,
Product.Product_name, Product.Cal_Unit, Export_bill_detail.Quantity, Export_bill_detail.Revenue
from Export_bill_detail
inner join Export_bill on Export_bill_detail.Export_bill_Id = Export_bill.Export_bill_Id
inner join Product on Export_bill_detail.Product_Id = Product.Product_Id
where Export_bill.Export_date between '2023-08-16' and '2023-09-15';
-- 9. problem 6.9
select Export_bill.Customer_Id, Customer.Customer_name, Export_bill.Export_bill_Id,
Export_bill.Export_date, Export_bill_detail.Revenue
from Export_bill
inner join Export_bill_detail on Export_bill.Export_bill_Id = Export_bill_detail.Export_bill_Id
inner join Customer on Export_bill.Customer_Id = Customer.Customer_Id
where Export_bill.Customer_Id is not null;
-- 10. problem 6.10
select Product.Product_name, sum(Export_bill_detail.Quantity) as QuantityOfProduct
from Export_bill_detail
inner join Product on Export_bill_detail.Product_Id = Product.Product_Id
where Product.Product_name = 'sport shoes'
group by Product_name;



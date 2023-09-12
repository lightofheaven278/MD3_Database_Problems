Create database bill_management;
use bill_management;
create table Export_bill(
Export_Id int primary key,
Export_date date default(current_timestamp)
);

create table Furniture(
Furniture_Id int primary key,
Furniture_name varchar(100) not null unique
);

create table Import_bill(
Import_Id int primary key,
Import_date date default(current_timestamp)
);

create table Supplier(
Sup_Id int primary key,
Sup_name varchar(50) not null unique,
Address varchar(10) not null,
Phone_Num text
);

create table Invoice(
Invoice_Id int primary key,
Invoice_date date default(current_timestamp)
);
alter table Invoice modify column Invoice_Id int;
alter table Invoice add column Supplier_Id int;
alter table Invoice rename column Supplier_Id to Sup_Id;
alter table Invoice add foreign key(Sup_Id) references Supplier(Sup_Id);

create table Export_bill_detail(
Furniture_Id int,
Export_Id int,
primary key(Furniture_Id, Export_Id),
foreign key(Furniture_Id) references Furniture(Furniture_Id),
foreign key(Export_Id) references Export_bill(Export_Id),
Export_price float not null,
Export_quantity int not null
);

create table Import_bill_detail(
Furniture_Id int,
Import_Id int,
primary key(Furniture_Id, Import_Id),
foreign key(Furniture_Id) references Furniture(Furniture_Id),
foreign key(Import_Id) references Import_bill(Import_Id),
Import_price float not null,
Import_quantity int not null
);

create table Invoice_detail(
Furniture_Id int,
Invoice_Id int,
primary key(Furniture_Id, Invoice_Id),
foreign key(Furniture_Id) references Furniture(Furniture_Id),
foreign key(Invoice_Id) references Invoice(Invoice_Id)
);
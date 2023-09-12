create database sale_manegement;
use sale_manegement;

create table Customer(
Customer_Id int primary key,
Customer_Name varchar(50) not null,
Customer_Age int not null
);

create table Order_from_Customer(
Order_Id int,
Customer_Id int,
primary key(Order_Id, Customer_Id),
foreign key(Customer_Id) references Customer(Customer_Id),
Order_date date default(current_date()),
Total_price float not null
);

create table Product(
Product_Id int primary key,
Product_name varchar(50) not null,
Product_price float not null
);

create table Order_detail(
Order_Id int,
Product_Id int,
primary key(Order_Id, Product_Id),
foreign key(Order_Id) references Order_from_Customer(Order_Id),
foreign key(Product_Id) references Product(Product_Id),
Order_quantity int not null
);

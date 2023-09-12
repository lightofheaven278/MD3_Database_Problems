Create database product_management;
use product_management;
Create Table Product(
Product_Id char(5) primary key,
Product_name varchar(100) not null unique,
Description text not null,
Product_status bit default(1)
);
Create Table Order_of_Product(
Order_Id int auto_increment primary key,
Date_now date default(current_timestamp),
Total_amount float
);
Create Table Order_detail(
Order_Id int,
Product_Id char(5),
primary key(Order_Id,Product_Id),
foreign key(Order_Id) references Order_of_Product(Order_Id),
foreign key(Product_Id) references Product(Product_Id),
Price float,
Quantity int,
Amount float as(Price*Quantity)
);

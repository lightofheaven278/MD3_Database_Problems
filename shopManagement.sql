create database ShopManagement;
use ShopManagement;

create table Categories(
CatalogId int primary key auto_increment,
CatalogName varchar(100) not null unique,
Priority int,
CatalogStatus bit default(1)
);

create table Product(
ProductId varchar(5) primary key,
ProductName varchar(100) not null unique,
Price float check(price > 0),
Create_date date default(current_date()),
Quantity int default(0),
View int default(0),
CatalogId int,
foreign key(CatalogId) references Categories(CatalogId),
ProductStatus bit default(1) 
);

DELIMITER //
create procedure get_all_categories()
begin
select CatalogId, CatalogName, Priority, CatalogStatus
from Categories;
end //
DELIMITER ;

DELIMITER //
create procedure get_all_categories_priority_asc()
begin
select CatalogId, CatalogName, Priority, CatalogStatus
from Categories
order by Priority;
end //
DELIMITER ;

DELIMITER //
create procedure get_categories_by_Id(
CatalogId_in int
)
begin
select CatalogId, CatalogName, Priority, CatalogStatus
from Categories
where CatalogId = CatalogId_in;
end //
DELIMITER ;

DELIMITER //
create procedure get_all_categories_priority_down()
begin
select CatalogId, CatalogName, Priority, CatalogStatus
from Categories
order by Priority desc;
end //
DELIMITER ;

DELIMITER //
create procedure insert_catelog(
CatalogId_in int, 
CatalogName_in varchar(100), 
Priority_in int, 
CatalogStatus_in bit
)
begin
insert into Categories 
value(CatalogId_in, CatalogName_in, Priority_in, CatalogStatus_in);
end //
DELIMITER ;

DELIMITER //
create procedure update_catalog(
CatalogId_in int,
CatalogName_in varchar(100), 
Priority_in int, 
CatalogStatus_in bit
)
begin
update Categories
set CatalogName = CatalogName_in,
    Priority = Priority_in,
    CatalogStatus = CatalogStatus_in
where CatalogId = CatalogId_in;
end //
DELIMITER ;

DELIMITER //
create procedure delete_catalog(
CatalogId_in int
)
begin
delete from Categories
where CatalogId = CatalogId_in;
end //
DELIMITER ;

DELIMITER //
create procedure serch_catalog_by_name(
CatalogName_in varchar(100)
)
begin
select CatalogId, CatalogName, Priority, CatalogStatus
from Categories
where CatalogName like concat('%', CatalogName_in, '%');
end //
DELIMITER ;

DELIMITER //
create procedure update_catalog_status(
CatalogId_in int,
CatalogStatus_in bit
)
begin
update Categories
set CatalogStatus = CatalogStatus_in
where CatalogId = CatalogId_in;
end //
DELIMITER ;

call insert_catelog(1, 'suit', 1, 1);
call get_all_categories;

/*===================Product procedures=====================*/

DELIMITER //
create procedure get_all_products()
begin
select ProductId, ProductName, Price, Create_date, Quantity, View, CatalogId, ProductStatus
from Product;
end //
DELIMITER ;

DELIMITER //
create procedure get_all_products_price_down()
begin
select ProductId, ProductName, Price, Create_date, Quantity, View, CatalogId, ProductStatus
from Product
order by Price desc;
end //
DELIMITER ;

DELIMITER //
create procedure get_product_by_Id(
ProductId_in varchar(5)
)
begin
select ProductId, ProductName, Price, Create_date, Quantity, View, CatalogId, ProductStatus
from Product
where ProductId = ProductId_in;
end //
DELIMITER ;

DELIMITER //
create procedure insert_product(
ProductId_in varchar(5),
ProductName_in varchar(100),
Price_in float,
Create_date_in date,
Quantity_in int,
View_in int,
CatalogId_in int,
ProductStatus_in bit
)
begin
insert into Product
value(ProductId_in, ProductName_in, Price_in, Create_date_in, Quantity_in, View_in, CatalogId_in, ProductStatus_in);
end //
DELIMITER ;

drop procedure update_product;
DELIMITER //
create procedure update_product(
ProductId_in varchar(5),
ProductName_in varchar(100),
Price_in float,
Create_date_in date,
Quantity_in int,
View_in int,
CatalogId_in int,
ProductStatus_in bit
)
begin
update Product
set ProductName = ProductName_in,
    Price = Price_in,
    Create_date = Create_date_in,
    Quantity = Quantity_in,
    View = View_in,
    CatalogId = CatalogId_in,
    ProductStatus = ProductStatus_in
where ProductId = ProductId_in;
end //
DELIMITER ;

DELIMITER //
create procedure update_product_status(
ProductId_in varchar(5),
ProductStatus_in bit
)
begin
update Product
set ProductStatus = ProductStatus_in
where ProductId = ProductId_in;
end //
DELIMITER ;

DELIMITER //
create procedure delete_product(
ProductId_in varchar(5)
)
begin
delete from Product
where ProductId = ProductId_in;
end //
DELIMITER ;

drop procedure search_product_by_name;
DELIMITER //
create procedure search_product_by_name(
ProductName_in varchar(100)
)
begin
select ProductId, ProductName, Price, Create_date, Quantity, View, CatalogId, ProductStatus
from Product
where ProductName like concat('%', ProductName_in, '%');
end //
DELIMITER ;

DELIMITER //
create procedure search_product_by_price_interval(
Price_in float,
Price_out float
)
begin
select ProductId, ProductName, Price, Create_date, Quantity, View, CatalogId, ProductStatus
from Product
where Price between Price_in and Price_out;
end //
DELIMITER ;

drop procedure update_product_quantity_after_sell;
DELIMITER //
create procedure update_product_quantity_after_sell(
ProductId_in varchar(5),
Quantity_in int
)
begin
update Product
set Quantity = Quantity_in
where ProductId = ProductId_in;
end //
DELIMITER ;

/*---------------------Statistics-----------------------*/
DELIMITER //
create procedure total_up_catalog_by_status()
begin
select CatalogStatus, count(CatalogStatus) as NumberOfCatalogs
from Categories
group by CatalogStatus;
end //
DELIMITER ;

drop procedure total_up_product_by_status;
DELIMITER //
create procedure total_up_product_by_status()
begin
select ProductStatus, count(ProductStatus) as NumberOfProduct
from Product
group by ProductStatus;
end //
DELIMITER ;

DELIMITER //
create procedure total_up_product_by_catalog()
begin
select Categories.CatalogName, count(Product.CatalogId) as NumberOfProducts
from Product
inner join Categories on Product.CatalogId = Categories.CatalogId
group by Categories.CatalogName;
end //
DELIMITER ;
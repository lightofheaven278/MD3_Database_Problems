create database MD3_Session5_Problems;
use MD3_Session5_Problems;
create table Category
(
    Category_Id   int primary key auto_increment,
    Category_name varchar(50) not null unique,
    Descr         text,
    Category_Status bit default (1)
);
create table Product
(
    Product_Id   varchar(5) primary key ,
    Product_name varchar(100) not null unique ,
    Date_mfg     date default(current_date()),
    Price        float default 0,
    Descr        text,
    Title        varchar(200),
    Category_Id  int,
    foreign key (Category_Id) references Category (Category_Id),
    Product_Status bit default 1
);

insert into Category (Category_Id, Category_name, Descr, Category_Status)
    value ('1', 'Suit', 'Main category', 1);
insert into Category (Category_Id, Category_name, Descr, Category_Status)
    value ('2', 'Shoes', 'New added category', 1);

insert into Product (Product_Id, Product_name, Date_mfg, Price, Descr, Title, Category_Id, Product_Status)
    value ('P001', 'English suit', '2015-08-27', 1524, 'High quality product', 'Best seller', 1, 1);
insert into Product (Product_Id, Product_name, Date_mfg, Price, Descr, Title, Category_Id, Product_Status)
    value ('P002', 'Scottish suit', '2015-11-25', 985, 'High quality product', 'Best seller', 2, 1);


CREATE VIEW Product_Price_Greater_Than_20000 AS
    SELECT 
        Category.Category_Id,
        Category.Category_name,
        Category.Category_Status,
        Product.Product_Id,
        Product.Product_name,
        Product.Price,
        Product.Product_Status
    FROM
        Product
            INNER JOIN
        Category ON Product.Category_Id = Category.Category_Id
    WHERE
        Product.Price > 1000;
        
/*------------------PROCEDURE--------------------*/
-- Procedure for inserting value into table Category
DELIMITER //
create procedure insert_value(
 CategoryId     int,
 Categoryname   varchar(50),
 Descr           text,
 CategoryStatus bit 
)
begin
insert into Category(Category_Id, Category_name, Descr, Category_Status)
value(CategoryId, Categoryname, Descr, CategoryStatus);
end //
DELIMITER ;
call insert_value('3', 'T-shirt', 'New added category', 1);
-- Procedure for updatting value of Category's element
DELIMITER //
create procedure update_value_of_Category(
 CategoryId     int,
 Categoryname   varchar(50),
 Descr           text,
 CategoryStatus bit 
)
begin
UPDATE Category 
SET 
    Category_name = CategoryName,
    Descr = Descr,
    Category_Status = CategoryStatus
WHERE
    Category_Id = CategoryId; 
end //
DELIMITER ;
-- Procedure for deleting value of Category's element
DELIMITER //
create procedure delete_element_of_Category(
CategoryId int
)
begin
delete from Category where Category_Id = CategoryId;
end //
DELIMITER ;
-- Procedure for get all elements of Category
DELIMITER //
create procedure get_all_element_of_Category(
)
begin
SELECT 
    *
FROM
    Category;
end //
DELIMITER ;
-- Procedure for get a element of Category by ID
DELIMITER //
create procedure get_element_of_Category_by_ID(
 CategoryId int
)
begin
SELECT 
    *
FROM
    Category
WHERE
    Category_Id = CategoryId;
end //
DELIMITER ;
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
-- Procedure for inserting value into table Product
DELIMITER //
create procedure insert_value_to_Product(
ProductId     varchar(5),
Productname   varchar(100),
DateMfg       date,
Price         float,
Descr         text,
Title         varchar(200),
CategoryId    int,
ProductStatus bit
)
begin
insert into Product(Product_Id, Product_name, Date_mfg, Price, Descr, Title, Category_Id, Product_Status)
value(ProductId, Productname, DateMfg, Price, Descr, Title, CategoryId, ProductStatus);
end //
DELIMITER ;
call insert_value_to_Product('P003', 'White T-shirt', '2015-11-25', 985, 'New design of 2024', 'Best seller', 3, 1);
-- Procedure for updatting value of Product's element
DELIMITER //
create procedure update_value_of_Product(
ProductId     varchar(5),
ProductName   varchar(100),
DateMfg       date,
Price         float,
Descr         text,
Title         varchar(200),
CategoryId    int,
ProductStatus bit
)
begin
UPDATE Product 
SET 
    Product_name = ProductName,
    Date_mfg = DateMfg,
    Price = Price,
    Descr = Descr,
    Title = Title,
    Category_Id = CategoryId,
    Product_Status = ProductStatus
WHERE
    Product_Id = ProductId; 
end //
DELIMITER ;
-- Procedure for deleting value of Category's element
DELIMITER //
create procedure delete_element_of_Product(
ProductId varchar(5)
)
begin
delete from Product where Product_Id = ProductId;
end //
DELIMITER ;
-- Procedure for get all elements of Product
DELIMITER //
create procedure get_all_element_of_Product(
)
begin
SELECT 
    *
FROM
    Product;
end //
DELIMITER ;
-- Procedure for get a element of Product by ID
DELIMITER //
create procedure get_element_of_Product_by_ID(
 ProductId int
)
begin
SELECT 
    *
FROM
    Product
WHERE
    Product_Id = ProductId;
end //
DELIMITER ;
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
-- Procedure for getting all products having status equal 1
DELIMITER //
create procedure get_product_status_1(
)
begin
SELECT 
    Product_Id, Product_name, Price, Category_Id, Product_Status
FROM
    Product
WHERE
    Product_Status = 1;
end //
DELIMITER ;
call get_product_status_1();
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
-- Procedure for showing statistics of quantity of products of each category
DELIMITER //
create procedure show_number_of_product_in_category(
)
begin
SELECT 
    Category.Category_Id,
    Category.Category_name,
    COUNT(Product.Category_Id)
FROM
    Category
        INNER JOIN
    Product ON Category.Category_Id = Product.Category_Id
GROUP BY Category.Category_Id , Category.Category_name;
end //
DELIMITER ;
call show_number_of_product_in_category();
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
-- Procedure for searching product by Product_name
DELIMITER //
create procedure search_product_by_name(
keyword varchar(100)
)
begin
SELECT 
    Product.Product_Id,
    Product.Product_name,
    Product.Price,
    Product.Product_Status,
    Category.Category_name,
    Category.Category_Status
FROM
    Product
        INNER JOIN
    Category ON Product.Category_Id = Category.Category_Id
WHERE
    Product.Product_name LIKE CONCAT('%', keyword, '%');
end //
DELIMITER ;
call search_product_by_name('w');
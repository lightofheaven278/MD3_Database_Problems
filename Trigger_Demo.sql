create database Trigger_Demo;
use Trigger_Demo;
CREATE TABLE Product (
    productId INT PRIMARY KEY,
    productName VARCHAR(20),
    price FLOAT
);
/* create a trigger before inserting value and stop if price is less than 0 */
DELIMITER //
create trigger Insert_data_into_table before insert on Product
for each row
begin
if new.Price < 0 then
SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Price should be greater than 0!';
        end if;
end //
DELIMITER ;
insert into Product(productId, productName, Price)
value(1, 'shoes', 15)
DELIMITER //
/* create a trigger before updating value and set price equal 0 if updated price less than 0 */
create trigger Update_data_into_table before update on Product
for each row
begin
if new.Price < 0 then set new.Price = 0;
        end if;
end //
DELIMITER ;
update Product
set Price = -15
where productId = 1;
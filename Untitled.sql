create database book_list;
use book_list;
create table Book(
bookId varchar(4) primary key,
bookName varchar(50) not null,
price float not null,
author varchar(20) not null,
status bit not null
);

drop procedure get_all_value;
DELIMITER //
create procedure get_all_value()
begin
select bookId, bookName, price, author, status
from Book
where bookId is not null;
end //
DELIMITER ;

DELIMITER //
create procedure insert_value(
book_Id varchar(4),
book_Name varchar(50),
price float,
Author varchar(20),
book_Status bit
)
begin
insert into Book(bookId, bookName, price, author, status)
value(book_Id, book_Name, price, Author, book_Status);
end //
DELIMITER ;

DELIMITER //
create procedure update_value(
book_Id varchar(4),
book_Name varchar(50),
price float,
Author varchar(20),
book_Status bit
)
begin
update Book
set bookName = book_Name, price = price, author = Author, status = book_Status
where bookId = book_Id;
end //
DELIMITER ;

DELIMITER //
create procedure delete_value(
book_Id varchar(4)
)
begin
delete from Book
where bookId = book_Id;
end //
DELIMITER ;

DELIMITER //
create procedure get_value_by_Id(
book_Id varchar(4)
)
begin
select bookId, bookName, price, author, status
from Book
where bookId = book_Id;
end //
DELIMITER ;

DELIMITER //
create procedure search_book_by_name(
book_Name varchar(4)
)
begin
select bookId, bookName, price, author, status
from Book
where bookName like concat('%', book_Name, '%');
end //
DELIMITER ;

DELIMITER //
create procedure statistics_by_author(
book_Name varchar(4)
)
begin
select author, count(author) as NumberOfBook
from Book
group by author;
end //
DELIMITER ;

call insert_value('B001', 'Legend of the fall', 25.5, 'Tung', 1);
call get_all_value();
call search_book_by_name('n');

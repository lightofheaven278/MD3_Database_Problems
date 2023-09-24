package ra.run;

import ra.bookBusiness.bookBusiness;
import ra.entity.Book;
import ra.entity.StatisticsByAuthor;

import java.util.List;
import java.util.Scanner;

public class bookManagement {
    public static Scanner input = new Scanner(System.in);

    public static List<Book> bookList = bookBusiness.getAllProduct();

    public static void main(String[] args) {

        do {
            bookList = bookBusiness.getAllProduct();
            System.out.println("-------------------Book Management System-----------------");
            System.out.println("1. Display all book in book list");
            System.out.println("2. Add new book into book list");
            System.out.println("3. Update book info based on book ID");
            System.out.println("4. Delete book info based on book ID");
            System.out.println("5. Search book info by book name");
            System.out.println("6. Show statistics of book by author");
            System.out.println("7. Sort book list by price in ascending order");
            System.out.println("8. Exit");
            System.out.println("Please input your number representing the function above:");
            try {
                int choice = Integer.parseInt(input.nextLine());
                switch (choice) {
                    case 1:
                        bookManagement.displayProduct();
                        break;
                    case 2:
                        bookManagement.addNewBook();
                        break;
                    case 3:
                        bookManagement.updateBook();
                        break;
                    case 4:
                        bookManagement.deleteBook();
                        break;
                    case 5:
                        bookManagement.searchBookByName();
                        break;
                    case 6:
                        bookManagement.statisticsByAuthor();
                        break;
                    case 7:
                        bookManagement.sortBookListByPrice();
                        break;
                    case 8:
                        System.exit(0);
                        break;
                    default:
                        System.err.println("The inputted choice is out of scope(1~8)!");
                }
            } catch (NumberFormatException ex1) {
                System.err.println("The inputted number is not an integer format!!! " + ex1.getMessage());
            } catch (Exception ex) {
                System.err.println("There are some unexpected errs while inputting choice! " + ex.getMessage());
            }
        } while (true);
    }

    public static void displayProduct() {
        System.out.println("The list of book");
        System.out.printf("%-15s%-30s%-15s%-20s%-15s\n", "Book ID", "Book Name", "Price", "Author", "Status");
        bookList.stream().forEach(book -> book.displayData(bookList));
    }

    public static void addNewBook() {
        Book book = new Book();
        book.inputData(input, bookList);
        boolean result = bookBusiness.addBook(book);
        if (result) {
            System.out.println("The new book info has already been added into list successfully!");
        } else {
            System.err.println("Cannot add new book to list!");
        }
    }

    public static void updateBook() {
        System.out.println("Please input ID of book you need to update info:");
        String bookIdUpdate = input.nextLine();
        Book bookUpdate = bookBusiness.getBookById(bookIdUpdate);
        if (bookUpdate != null) {
            bookUpdate.setBookName(bookUpdate.validateBookName(input));
            bookUpdate.setPrice(bookUpdate.validatePrice(input));
            bookUpdate.setAuthor(bookUpdate.validateAuthor(input));
            bookUpdate.setStatus(bookUpdate.validateStatus(input));
            boolean result = bookBusiness.updateBook(bookUpdate);
            if (result) {
                System.out.println("The book info has been updated successfully!");
            } else {
                System.err.println("Cannot update book info because of unexpected error!");
            }
        } else {
            System.err.println("There is no book contain the inputted ID!");
        }
    }

    public static void deleteBook() {
        System.out.println("Please input ID of book you wanna delete info:");
        String bookIdDelete = input.nextLine();
        Book bookDelete = bookBusiness.getBookById(bookIdDelete);
        if (bookDelete != null) {
            boolean result = bookBusiness.deleteBook(bookIdDelete);
            if (result) {
                System.out.println("The book info has been deleted successfully!");
            } else {
                System.err.println("Cannot delete book info because of unexpected error!");
            }
        } else {
            System.err.println("The inputted ID is not exist!");
        }
    }

    public static void searchBookByName() {
        System.out.println("Please input keyword representing book name:");
        String keyword = input.nextLine();
        List<Book> listBookSearch = bookBusiness.searchBookByName(keyword);
        if (listBookSearch != null) {
            System.out.printf("%-15s%-30s%-15s%-20s%-15s\n", "Book ID", "Book Name", "Price", "Author", "Status");
            listBookSearch.stream().forEach(book -> book.displayData(bookList));
        } else {
            System.err.println("There is no book whose name contains the keyword you inputted!");
        }
    }

    public static void statisticsByAuthor() {
        List<StatisticsByAuthor> statisticsByAuthors = bookBusiness.statisticsByAuthors();
        System.out.printf("%-20s%-15s\n", "Author", "Number Of Books");
        statisticsByAuthors.forEach(StatisticsByAuthor::displayStatisticsData);
    }

    public static void sortBookListByPrice() {
        List<Book> sortedBookList = bookBusiness.sortBookList();
        System.out.printf("%-15s%-30s%-15s%-20s%-15s\n", "Book ID", "Book Name", "Price", "Author", "Status");
        sortedBookList.stream().forEach(book -> book.displayData(sortedBookList));
    }

}

package ra.entity;

import java.util.FormatFlagsConversionMismatchException;
import java.util.List;
import java.util.Scanner;

public class Book {
    private String bookId;
    private String bookName;
    private Float price;
    private String author;
    private boolean status;

    public Book() {
    }

    public String getBookId() {
        return bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public Float getPrice() {
        return price;
    }

    public String getAuthor() {
        return author;
    }

    public boolean isStatus() {
        return status;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public void inputData(Scanner input, List<Book> bookList) {
        this.bookId = validateBookId(input, bookList);
        this.bookName = validateBookName(input);
        this.price = validatePrice(input);
        this.author = validateAuthor(input);
        this.status = validateStatus(input);
    }

    public String validateBookId(Scanner input, List<Book> bookList) {
        System.out.println("Please input book ID:");
        do {
            String bookId = input.nextLine();
            if (!bookId.trim().equals("")) {
                if (bookId.trim().length() == 4 && bookId.trim().startsWith("B")) {
                    if (bookList.size() == 0) {
                        return bookId;
                    } else {
                        boolean checkBookId = false;
                        for (Book book : bookList) {
                            if (bookId.trim().equals(book.getBookId().trim())) {
                                System.err.println("The inputted book ID has already existed. Please try another!");
                                checkBookId = true;
                            }
                        }
                        if (!checkBookId) {
                            return bookId;
                        }
                    }
                } else {
                    System.err.println("The book ID should follow this format: B***!");
                }
            } else {
                System.err.println("The book ID should not a blank!");
            }
        } while (true);
    }

    public String validateBookName(Scanner input) {
        System.out.println("Please input book name:");
        do {
            String bookName = input.nextLine();
            if (!bookName.trim().equals("")) {
                if (bookName.length() >= 10 && bookName.length() <= 50) {
                    return bookName;
                } else {
                    System.err.println("The book name should contain from 10 to 50 characters!");
                }
            } else {
                System.err.println("The book name should be a blank!");
            }
        } while (true);
    }

    public Float validatePrice(Scanner input) {
        System.out.println("Please input the price of book:");
        do {
            try {
                float price = Float.parseFloat(input.nextLine());
                if (price > 0) {
                    return price;
                } else {
                    System.err.println("The inputted price should be greater than 0!");
                }
            } catch (NumberFormatException ex1) {
                System.err.println("The inputted price is not an float format(exp: 52.53)!" + ex1.getMessage());
            } catch (Exception e) {
                System.err.println("Some errs occur while inputting price!" + e.getMessage());
            }
        } while (true);
    }

    public String validateAuthor(Scanner input) {
        System.out.println("Please input the author of book:");
        do {
            String author = input.nextLine();
            if (!author.trim().equals("")) {
                return author;
            } else {
                System.err.println("The author of book should not be a blank!");
            }
        } while (true);
    }

    public Boolean validateStatus(Scanner input) {
        System.out.println("Please input the status of book:");
        do {
            String checkStatus = input.nextLine();
            if (!checkStatus.trim().equals("")) {
                if (checkStatus.trim().equalsIgnoreCase("true") ||
                        checkStatus.trim().equalsIgnoreCase("false")) {
                    return Boolean.parseBoolean(checkStatus);
                } else {
                    System.err.println("The status of book should be 'true' or 'false'!");
                }
            } else {
                System.err.println("The status of book should not be a blank!");
            }
        } while (true);
    }

    public void displayData(List<Book> booklist) {
        System.out.printf("%-15s%-30s%-15.1f%-20s%-15b\n", this.bookId, this.bookName, this.price,
                this.author, this.status);
    }
}

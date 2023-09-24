package ra.bookBusiness;

import ra.entity.Book;
import ra.entity.StatisticsByAuthor;
import ra.utility.ConnectionDB;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class bookBusiness {
    public static List<Book> getAllProduct() {
        //1. Create Connection Object
        //2. Create CallableStatement
        //3. Call Procedure
        //4. Analyze data and return bookList
        List<Book> bookList = null;
        Connection con = null;
        CallableStatement callSt = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call get_all_value()}");
            // call procedure
            ResultSet rs = callSt.executeQuery();
            // check data and return bookList
            bookList = new ArrayList<>();
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getString("bookId"));
                book.setBookName(rs.getString("bookName"));
                book.setPrice(rs.getFloat("price"));
                book.setAuthor(rs.getString("author"));
                book.setStatus(rs.getBoolean("status"));
                bookList.add(book);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return bookList;
    }

    public static boolean addBook(Book book) {
        Connection con = null;
        CallableStatement callSt = null;
        boolean result = false;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call insert_value(?,?,?,?,?)}");
            callSt.setString(1, book.getBookId());
            callSt.setString(2, book.getBookName());
            callSt.setFloat(3, book.getPrice());
            callSt.setString(4, book.getAuthor());
            callSt.setBoolean(5, book.isStatus());
            //register return value
            //call procedure
            callSt.executeUpdate();
            result = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return result;
    }

    public static boolean updateBook(Book book) {
        Connection con = null;
        CallableStatement callSt = null;
        boolean result = false;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call update_value(?,?,?,?,?)}");
            callSt.setString(1, book.getBookId());
            callSt.setString(2, book.getBookName());
            callSt.setFloat(3, book.getPrice());
            callSt.setString(4, book.getAuthor());
            callSt.setBoolean(5, book.isStatus());
            callSt.executeUpdate();
            result = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return result;
    }

    public static Book getBookById(String bookId) {
        Book book = null;
        Connection con = null;
        CallableStatement callSt = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call get_value_by_Id(?)}");
            callSt.setString(1, bookId);
            ResultSet rs = callSt.executeQuery();

            while (rs.next()) {
                book = new Book();
                book.setBookId(rs.getString("bookId"));
                book.setBookName(rs.getString("bookName"));
                book.setPrice(rs.getFloat("price"));
                book.setAuthor(rs.getString("author"));
                book.setStatus(rs.getBoolean("status"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return book;
    }

    public static Boolean deleteBook(String bookId) {
        Connection con = null;
        CallableStatement callSt = null;
        Book book = null;
        boolean result = false;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call delete_value(?)}");
            callSt.setString(1, bookId);
            callSt.executeUpdate();
            result = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return result;
    }

    public static List<Book> searchBookByName(String book_name) {
        Connection con = null;
        CallableStatement callSt = null;
        List<Book> listBookSearch = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call search_book_by_name(?)}");
            callSt.setString(1, book_name);
            ResultSet rs = callSt.executeQuery();
            listBookSearch = new ArrayList<>();
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getString("bookId"));
                book.setBookName(rs.getString("bookName"));
                book.setPrice(rs.getFloat("price"));
                book.setAuthor(rs.getString("author"));
                book.setStatus(rs.getBoolean("status"));
                listBookSearch.add(book);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return listBookSearch;
    }

    public static List<StatisticsByAuthor> statisticsByAuthors() {
        Connection con = null;
        CallableStatement callSt = null;
        List<StatisticsByAuthor> statisticsByAuthors = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call statistics_by_author()}");
            ResultSet rs = callSt.executeQuery();
            statisticsByAuthors = new ArrayList<>();
            while (rs.next()) {
                StatisticsByAuthor statistics = new StatisticsByAuthor();
                statistics.setAuthor(rs.getString("author"));
                statistics.setNumberOfBook(rs.getInt("NumberOfBook"));
                statisticsByAuthors.add(statistics);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return statisticsByAuthors;
    }

    public static List<Book> sortBookList() {
        Connection con = null;
        CallableStatement callSt = null;
        List<Book> sortedBookList = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call sort_data_by_price()}");
            ResultSet rs = callSt.executeQuery();
            sortedBookList = new ArrayList<>();
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getString("bookId"));
                book.setBookName(rs.getString("bookName"));
                book.setPrice(rs.getFloat("price"));
                book.setAuthor(rs.getString("author"));
                book.setStatus(rs.getBoolean("status"));
                sortedBookList.add(book);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return sortedBookList ;
    }
}

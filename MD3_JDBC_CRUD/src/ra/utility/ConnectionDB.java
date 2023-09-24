package ra.utility;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionDB {
    /**
     * Steps to create connection to database
     * S1: Download mySQL JDBC jar from internet and decompress
     * S2: Add downloaded jar file into project through file->project structure->library-> find to location
     * file is located
     * S3: Create constants -DRIVER, URL, USERNAME, PASSWORD and the value which is suitable with them
     * S4: Set Driver for DriverManagement to run with CSDL mySql
     * S5: Create Connection object to create connecting phase with mysql
     */
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/book_list";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "MinhChau1510@";

    //1. Method to open connection to DB and return an object connection to run
    public static Connection openConnection() throws ClassNotFoundException, SQLException {
        // declare connection
        Connection con = null;
        // set driver for driver manager
        Class.forName(DRIVER);
        con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        return con;
    }

    //2. Close connection
    public static void closeConnection(Connection con, CallableStatement callSt) {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (callSt != null) {
            try {
                callSt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // test connection to DB
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        Connection con = ConnectionDB.openConnection();
        if (con != null) {
            System.out.println("Connect successful");
        } else {
            System.out.println("Connect failed");
        }
    }
}

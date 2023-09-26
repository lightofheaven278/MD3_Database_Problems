package ra.uitility;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionDB {
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/ShopManagement";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "MinhChau1510@";

    public static Connection openConnection() throws ClassNotFoundException, SQLException {
        Connection con = null;
        Class.forName(DRIVER);
        con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        return con;
    }

    public static void closeConnection(Connection con, CallableStatement callSt) {
        if (con != null) {
            try {
                con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        if (callSt != null) {
            try {
                callSt.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        Connection con = ConnectionDB.openConnection();
        if (con != null) {
            System.out.println("Connect successful");
        } else {
            System.out.println("Connect failed");
        }
    }
}

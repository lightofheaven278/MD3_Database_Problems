package ra.Business;

import ra.uitility.ConnectionDB;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

public class StatisticsReport {
    public static void statisticsOfCatalogByStatus() {
        Connection con = null;
        CallableStatement callSt = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call total_up_catalog_by_status()}");
            ResultSet rs = callSt.executeQuery();
            System.out.printf("%-20s%-20s\n", "Catalog Status", "Number of Catalogs");
            while (rs.next()) {
                String catalogStatus = rs.getString("CatalogStatus");
                int numberOfCatalogs = rs.getInt("NumberOfCatalogs");
                String catalogSt = "";
                if (catalogStatus.trim().equals("1")) {
                    catalogSt = "Active";
                } else {
                    catalogSt = "Inactive";
                }
                System.out.printf("%-20s%-20d\n", catalogSt, numberOfCatalogs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void statisticsOfProductByStatus() {
        Connection con = null;
        CallableStatement callSt = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call total_up_product_by_status()}");
            ResultSet rs = callSt.executeQuery();
            System.out.printf("%-20s%-20s\n", "Product Status", "Number of Products");
            while (rs.next()) {
                String productStatus = rs.getString("ProductStatus");
                int numberOfProduct = rs.getInt("NumberOfProduct");
                String productSt = "";
                if (productStatus.trim().equals("1")) {
                    productSt = "Active";
                } else {
                    productSt = "Inactive";
                }
                System.out.printf("%-20s%-20d\n", productSt, numberOfProduct);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void statisticsOfProductByCatalog() {
        Connection con = null;
        CallableStatement callSt = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call total_up_product_by_catalog()}");
            ResultSet rs = callSt.executeQuery();
            System.out.printf("%-20s%-20s\n", "Catalog Name", "Number of Products");
            while (rs.next()) {
                String productName = rs.getString("CatalogName");
                int numberOfProducts = rs.getInt("NumberOfProducts");
                System.out.printf("%-20s%-20d\n", productName, numberOfProducts);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

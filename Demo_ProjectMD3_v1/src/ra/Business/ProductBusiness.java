package ra.Business;

import ra.entity.Product;
import ra.run.ProductManagement;
import ra.uitility.ConnectionDB;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductBusiness {
    public static List<Product> getAllProducts() {
        Connection con = null;
        CallableStatement callSt = null;
        List<Product> productList = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call get_all_products()}");
            ResultSet rs = callSt.executeQuery();
            productList = new ArrayList<>();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getString("ProductId"));
                product.setProductName(rs.getString("ProductName"));
                product.setPrice(rs.getInt("Price"));
                product.setCreateDate(rs.getString("Create_date"));
                product.setQuantity(rs.getInt("Quantity"));
                product.setView(rs.getInt("View"));
                product.setCatalogId(rs.getInt("CatalogId"));
                product.setProductStatus(rs.getBoolean("ProductStatus"));
                productList.add(product);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return productList;
    }

    public static List<Product> getAllProductsSortedBrPriceDesc() {
        Connection con = null;
        CallableStatement callSt = null;
        List<Product> productList = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call get_all_products_price_down()}");
            ResultSet rs = callSt.executeQuery();
            productList = new ArrayList<>();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getString("ProductId"));
                product.setProductName(rs.getString("ProductName"));
                product.setPrice(rs.getInt("Price"));
                product.setCreateDate(rs.getString("Create_date"));
                product.setQuantity(rs.getInt("Quantity"));
                product.setView(rs.getInt("View"));
                product.setCatalogId(rs.getInt("CatalogId"));
                product.setProductStatus(rs.getBoolean("ProductStatus"));
                productList.add(product);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return productList;
    }

    public static Boolean addNewProduct(Product product) {
        Connection con = null;
        CallableStatement callSt = null;
        boolean result = false;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call insert_product(?,?,?,?,?,?,?,?)}");
            callSt.setString(1, product.getProductId());
            callSt.setString(2, product.getProductName());
            callSt.setFloat(3, product.getPrice());
            callSt.setString(4, product.getCreateDate());
            callSt.setInt(5, product.getQuantity());
            callSt.setInt(6, product.getView());
            callSt.setInt(7, product.getCatalogId());
            callSt.setBoolean(8, product.isProductStatus());
            callSt.executeUpdate();
            result = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return result;
    }

    public static Product getProductById(String ProductId_in) {
        Connection con = null;
        CallableStatement callSt = null;
        Product product = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call get_product_by_Id(?)}");
            callSt.setString(1, ProductId_in);
            ResultSet rs = callSt.executeQuery();
            while (rs.next()) {
                product = new Product();
                product.setProductId(rs.getString("ProductId"));
                product.setProductName(rs.getString("ProductName"));
                product.setPrice(rs.getInt("Price"));
                product.setCreateDate(rs.getString("Create_date"));
                product.setQuantity(rs.getInt("Quantity"));
                product.setView(rs.getInt("View"));
                product.setCatalogId(rs.getInt("CatalogId"));
                product.setProductStatus(rs.getBoolean("ProductStatus"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return product;
    }

    public static Boolean updateProduct(Product product) {
        Connection con = null;
        CallableStatement callSt = null;
        boolean result = false;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call update_product(?,?,?,?,?,?,?,?)}");
            callSt.setString(1, product.getProductId());
            callSt.setString(2, product.getProductName());
            callSt.setFloat(3, product.getPrice());
            callSt.setString(4, product.getCreateDate());
            callSt.setInt(5, product.getQuantity());
            callSt.setInt(6, product.getView());
            callSt.setInt(7, product.getCatalogId());
            callSt.setBoolean(8, product.isProductStatus());
            callSt.executeUpdate();
            result = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return result;
    }

    public static Boolean updateProductStatus(Product product) {
        Connection con = null;
        CallableStatement callSt = null;
        boolean result = false;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call update_product_status(?,?)}");
            callSt.setString(1, product.getProductId());
            callSt.setBoolean(2, product.isProductStatus());
            callSt.executeUpdate();
            result = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return result;
    }

    public static Boolean deleteProduct(Product product) {
        Connection con = null;
        CallableStatement callSt = null;
        boolean result = false;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call delete_product(?)}");
            callSt.setString(1, product.getProductId());
            callSt.executeUpdate();
            result = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return result;
    }

    public static List<Product> searchProductByName(String keyword) {
        Connection con = null;
        CallableStatement callSt = null;
        List<Product> searchProductList = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call search_product_by_name(?)}");
            callSt.setString(1, keyword);
            ResultSet rs = callSt.executeQuery();
            searchProductList = new ArrayList<>();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getString("ProductId"));
                product.setProductName(rs.getString("ProductName"));
                product.setPrice(rs.getInt("Price"));
                product.setCreateDate(rs.getString("Create_date"));
                product.setQuantity(rs.getInt("Quantity"));
                product.setView(rs.getInt("View"));
                product.setCatalogId(rs.getInt("CatalogId"));
                product.setProductStatus(rs.getBoolean("ProductStatus"));
                searchProductList.add(product);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return searchProductList;
    }

    public static List<Product> searchProductByPriceInterval(Float price_in, Float price_out) {
        Connection con = null;
        CallableStatement callSt = null;
        List<Product> searchProductList = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call search_product_by_price_interval(?,?)}");
            callSt.setFloat(1, price_in);
            callSt.setFloat(2, price_out);
            ResultSet rs = callSt.executeQuery();
            searchProductList = new ArrayList<>();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getString("ProductId"));
                product.setProductName(rs.getString("ProductName"));
                product.setPrice(rs.getInt("Price"));
                product.setCreateDate(rs.getString("Create_date"));
                product.setQuantity(rs.getInt("Quantity"));
                product.setView(rs.getInt("View"));
                product.setCatalogId(rs.getInt("CatalogId"));
                product.setProductStatus(rs.getBoolean("ProductStatus"));
                searchProductList.add(product);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return searchProductList;
    }

    public static Boolean updateProductQuantityAfterSell(Product product) {
        Connection con = null;
        CallableStatement callSt = null;
        boolean result = false;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call update_product_quantity_after_sell(?,?)}");
            callSt.setString(1, product.getProductId());
            callSt.setInt(2, product.getQuantity());
            callSt.executeUpdate();
            result = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return result;
    }

}

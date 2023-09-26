package ra.Business;

import ra.entity.Categories;
import ra.uitility.ConnectionDB;

import java.awt.print.Book;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryBusiness {
    public static List<Categories> getAllCategories() {
        Connection con = null;
        CallableStatement callSt = null;
        List<Categories> categoriesList = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call get_all_categories()}");
            ResultSet rs = callSt.executeQuery();
            categoriesList = new ArrayList<>();
            while (rs.next()) {
                Categories categories = new Categories();
                categories.setCatalogId(rs.getInt("CatalogId"));
                categories.setCatalogName(rs.getString("CatalogName"));
                categories.setPriority(rs.getInt("Priority"));
                categories.setCatalogStatus(rs.getBoolean("CatalogStatus"));
                categoriesList.add(categories);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return categoriesList;
    }

    public static List<Categories> sortCategoriesByPriorityAsc() {
        Connection con = null;
        CallableStatement callSt = null;
        List<Categories> sortedCategoriesList = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call get_all_categories_priority_asc()}");
            ResultSet rs = callSt.executeQuery();
            sortedCategoriesList = new ArrayList<>();
            while (rs.next()) {
                Categories categories = new Categories();
                categories.setCatalogId(rs.getInt("CatalogId"));
                categories.setCatalogName(rs.getString("CatalogName"));
                categories.setPriority(rs.getInt("Priority"));
                categories.setCatalogStatus(rs.getBoolean("CatalogStatus"));
                sortedCategoriesList.add(categories);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return sortedCategoriesList;
    }

    public static Boolean addNewCatalog(Categories catalog) {
        Connection con = null;
        CallableStatement callSt = null;
        boolean result = false;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call insert_catelog(?,?,?,?)}");
            callSt.setInt(1, catalog.getCatalogId());
            callSt.setString(2, catalog.getCatalogName());
            callSt.setInt(3, catalog.getPriority());
            callSt.setBoolean(4, catalog.isCatalogStatus());
            callSt.executeUpdate();
            result = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return result;
    }

    public static Categories getCatalogById(int CatalogId_in) {
        Connection con = null;
        CallableStatement callSt = null;
        Categories catalog = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call get_categories_by_Id(?)}");
            callSt.setInt(1, CatalogId_in);
            ResultSet rs = callSt.executeQuery();
            while (rs.next()) {
                catalog = new Categories();
                catalog.setCatalogId(rs.getInt("CatalogId"));
                catalog.setCatalogName(rs.getString("CatalogName"));
                catalog.setPriority(rs.getInt("Priority"));
                catalog.setCatalogStatus(rs.getBoolean("CatalogStatus"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return catalog;
    }

    public static Boolean updateCatalog(Categories catalog) {
        Connection con = null;
        CallableStatement callSt = null;
        boolean result = false;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call update_catalog(?,?,?,?)}");
            callSt.setInt(1, catalog.getCatalogId());
            callSt.setString(2, catalog.getCatalogName());
            callSt.setInt(3, catalog.getPriority());
            callSt.setBoolean(4, catalog.isCatalogStatus());
            callSt.executeUpdate();
            result = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return result;
    }

    public static Boolean deleteCatalog(Categories catalog) {
        Connection con = null;
        CallableStatement callSt = null;
        boolean result = false;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call delete_catalog(?)}");
            callSt.setInt(1, catalog.getCatalogId());
            callSt.executeUpdate();
            result = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return result;
    }

    public static List<Categories> searchBookByName(String catalogNameSearch){
        Connection con = null;
        CallableStatement callSt = null;
        List<Categories> searchCategoriesList = null;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call serch_catalog_by_name(?)}");
            callSt.setString(1, catalogNameSearch);
            ResultSet rs = callSt.executeQuery();
            searchCategoriesList = new ArrayList<>();
            while (rs.next()){
                Categories catalog = new Categories();
                catalog.setCatalogId(rs.getInt("CatalogId"));
                catalog.setCatalogName(rs.getString("CatalogName"));
                catalog.setPriority(rs.getInt("Priority"));
                catalog.setCatalogStatus(rs.getBoolean("CatalogStatus"));
                searchCategoriesList.add(catalog);
            }
        }catch (Exception ex){
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return searchCategoriesList;
    }

    public static Boolean updateCatalogStatus(Categories catalog) {
        Connection con = null;
        CallableStatement callSt = null;
        boolean result = false;
        try {
            con = ConnectionDB.openConnection();
            callSt = con.prepareCall("{call update_catalog_status(?,?)}");
            callSt.setInt(1, catalog.getCatalogId());
            callSt.setBoolean(2, catalog.isCatalogStatus());
            result = true;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            ConnectionDB.closeConnection(con, callSt);
        }
        return result;
    }
}

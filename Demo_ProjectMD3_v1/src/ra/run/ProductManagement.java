package ra.run;

import ra.Business.CategoryBusiness;
import ra.Business.ProductBusiness;
import ra.Business.StatisticsReport;
import ra.entity.Categories;
import ra.entity.Product;
import ra.uitility.ConnectionDB;

import java.sql.SQLOutput;
import java.util.List;
import java.util.Scanner;

public class ProductManagement {
    public static Scanner input = new Scanner(System.in);
    public static List<Categories> categoriesList = CategoryBusiness.getAllCategories();
    public static List<Product> productList = ProductBusiness.getAllProducts();

    public static void main(String[] args) {
        do {
            System.out.println("******************Shop Management**************");
            System.out.println("1. Category Management System");
            System.out.println("2. Product Management System");
            System.out.println("3. Statistics Report");
            System.out.println("4. Exit");
            System.out.println("Please input the number above representing function you wanna choose:");
            try {
                int choice = Integer.parseInt(input.nextLine());
                switch (choice) {
                    case 1:
                        ProductManagement.categoryManagement();
                        break;
                    case 2:
                        ProductManagement.productManagement();
                        break;
                    case 3:
                        ProductManagement.statisticsReport();
                        break;
                    case 4:
                        System.exit(0);
                        break;
                    default:
                        System.err.println("The inputted number is out of scope!");
                }
            } catch (NumberFormatException ex1) {
                System.err.println("The inputted number is not an integer format! " + ex1.getMessage());
            } catch (Exception ex) {
                System.err.println("Some errs occur while inputting number representing your choice!" +
                        ex.getMessage());
            }
        } while (true);
    }

    public static void categoryManagement() {
        boolean checkOutCategory = true;
        do {
            System.out.println();
            System.out.println("------------------Category Management System--------------------");
            System.out.println("1. Display all categories");
            System.out.println("2. Display sorted categories list in ascending order of priority");
            System.out.println("3. Add new category to categories list");
            System.out.println("4. Update category by catalog ID");
            System.out.println("5. Delete category by catalog ID");
            System.out.println("6. Search category by catalog name");
            System.out.println("7. Update status of category by category ID");
            System.out.println("8. Exit");
            System.out.println("Please input you choice:");
            try {
                int choice = Integer.parseInt(input.nextLine());
                switch (choice) {
                    case 1:
                        ProductManagement.displayAllCategories();
                        break;
                    case 2:
                        ProductManagement.sortCategoriesListByPriorityAsc();
                        break;
                    case 3:
                        ProductManagement.addNewCatalog();
                        break;
                    case 4:
                        ProductManagement.updateCatalog();
                        break;
                    case 5:
                        ProductManagement.deleteCatalog();
                        break;
                    case 6:
                        ProductManagement.searchCatalogByName();
                        break;
                    case 7:
                        ProductManagement.updateCatalogStatus();
                        break;
                    case 8:
                        checkOutCategory = false;
                        break;
                    default:
                        System.err.println("The inputted choice is out of scope!");
                }
            } catch (NumberFormatException ex1) {
                System.err.println("The inputted choice is not an integer format! " + ex1.getMessage());
            } catch (Exception ex) {
                System.err.println("Some errs occur while inputting number representing choice! " + ex.getMessage());
            }
        } while (checkOutCategory);
    }

    public static void displayAllCategories() {
        List<Categories> categoriesList = CategoryBusiness.getAllCategories();
        System.out.printf("%-15s%-30s%-15s%-20s\n", "Catalog ID", "Catalog Name", "Priority", "CatalogStatus");
        categoriesList.stream().forEach(Categories::displayData);
    }

    public static void sortCategoriesListByPriorityAsc() {
        List<Categories> categoriesList = CategoryBusiness.sortCategoriesByPriorityAsc();
        System.out.printf("%-15s%-30s%-15s%-20s\n", "Catalog ID", "Catalog Name", "Priority", "CatalogStatus");
        categoriesList.stream().forEach(Categories::displayData);
    }

    public static void addNewCatalog() {
        Categories catalog = new Categories();
        catalog.inputData(input, categoriesList);
        boolean result = CategoryBusiness.addNewCatalog(catalog);
        if (result) {
            System.out.println("The catalog has been added to categories list!");
        } else {
            System.err.println("Cannot add new catalog to list because of unexpected errs!");
        }
    }

    public static void updateCatalog() {
        System.out.println("Please input the ID of catalog you wanna update info:");
        try {
            int CatalogIdUpdate = Integer.parseInt(input.nextLine());
            Categories catalog = CategoryBusiness.getCatalogById(CatalogIdUpdate);
            if (catalog != null) {
                catalog.setCatalogName(catalog.validateCatalogName(input, categoriesList));
                catalog.setPriority(catalog.validatePriority(input));
                catalog.setCatalogStatus(catalog.validateCatalogStatus(input));
                boolean updateResult = CategoryBusiness.updateCatalog(catalog);
                if (updateResult) {
                    System.out.println("The catalog info has been updated successfully!");
                } else {
                    System.err.println("Cannot update info of catalog due to unexpected errs!");
                }
            } else {
                System.err.println("There is no catalog ID in Categories list!");
            }
        } catch (NumberFormatException ex1) {
            System.err.println("The inputted ID is not an integer format!");
        }
    }

    public static void deleteCatalog() {
        System.out.println("Please input the ID of catalog you wanna delete info:");
        try {
            int CatalogIdDelete = Integer.parseInt(input.nextLine());
            Categories catalog = CategoryBusiness.getCatalogById(CatalogIdDelete);
            if (catalog != null) {
                boolean checkProductInCatalog = false;
                for (Product p : productList) {
                    if (p.getCatalogId() == catalog.getCatalogId()) {
                        checkProductInCatalog = true;
                        break;
                    }
                }
                if (!checkProductInCatalog) {
                    boolean deleteResult = CategoryBusiness.deleteCatalog(catalog);
                    if (deleteResult) {
                        System.out.println("The catalog info has been deleted successfully!");
                    } else {
                        System.err.println("Cannot delete info of catalog due to unexpected errs!");
                    }
                } else {
                    System.err.println("Cannot delete catalog which has already contained product!");
                }
            } else {
                System.err.println("The inputted catalog ID does not exist in Categories list!");
            }
        } catch (NumberFormatException ex1) {
            System.err.println("The inputted ID is not an integer format! " + ex1.getMessage());
        } catch (Exception ex) {
            System.err.println("Some errs occur while inputting catalog ID! " + ex.getMessage());
        }
    }

    public static void searchCatalogByName() {
        System.out.println("Please input a keyword related to catalog you wanna search:");
        String keyword = input.nextLine();
        List<Categories> searchCatalogList = CategoryBusiness.searchBookByName(keyword);
        if (searchCatalogList != null) {
            System.out.printf("%-15s%-30s%-15s%-20s\n", "Catalog ID", "Catalog Name", "Priority", "CatalogStatus");
            searchCatalogList.stream().forEach(Categories::displayData);
        } else {
            System.err.println("There is no catalog whose name contains the inputted keyword!");
        }
    }

    public static void updateCatalogStatus() {
        System.out.println("Please input ID of catalog you wanna update status:");
        try {
            int catalogIdUpdate = Integer.parseInt(input.nextLine());
            Categories catalog = CategoryBusiness.getCatalogById(catalogIdUpdate);
            if (catalog != null) {
                catalog.setCatalogStatus(catalog.validateCatalogStatus(input));
                boolean updateStatusResult = CategoryBusiness.updateCatalogStatus(catalog);
                if (updateStatusResult) {
                    System.out.println("The status of catalog has been updated successfully!");
                } else {
                    System.err.println("Cannot update status of catalog due to unexpected errs!");
                }
            } else {
                System.err.println("The inputted catalog ID does not exist!");
            }
        } catch (NumberFormatException ex1) {
            System.err.println("The inputted ID is not an integer format! " + ex1.getMessage());
        } catch (Exception ex) {
            System.err.println("Some errs occur while inputting catalog ID! " + ex.getMessage());
        }
    }

    public static void productManagement() {
        boolean checkOutProduct = true;
        do {
            System.out.println();
            productList = ProductBusiness.getAllProducts();
            System.out.println("-----------------------Product Management System---------------------");
            System.out.println("1. Display all products in list");
            System.out.println("2. Display sorted list of products by price in desc order");
            System.out.println("3. Add new product to list");
            System.out.println("4. Update product info by product ID");
            System.out.println("5. Update status of product by product ID");
            System.out.println("6. Delete product info");
            System.out.println("7. Search product info by name");
            System.out.println("8. Search product whose price is from a to b");
            System.out.println("9. Sell product");
            System.out.println("10. Exit");
            System.out.println("Please input number representing the function you wanna choose:");
            try {
                int choice = Integer.parseInt(input.nextLine());
                switch (choice) {
                    case 1:
                        ProductManagement.displayAllProducts();
                        break;
                    case 2:
                        ProductManagement.displayAllProductsSortedByPriceDesc();
                        break;
                    case 3:
                        ProductManagement.addNewProduct();
                        break;
                    case 4:
                        ProductManagement.updateProduct();
                        break;
                    case 5:
                        ProductManagement.updateProductStatus();
                        break;
                    case 6:
                        ProductManagement.deleteProduct();
                        break;
                    case 7:
                        ProductManagement.searchProductByName();
                        break;
                    case 8:
                        ProductManagement.searchProductByPriceInterval();
                        break;
                    case 9:
                        ProductManagement.sellProduct();
                        break;
                    case 10:
                        checkOutProduct = false;
                        break;
                    default:
                        System.err.println("The inputted number is out of scope!");
                }
            } catch (NumberFormatException ex1) {
                System.err.println("The inputted number is not an integer format! " + ex1.getMessage());
            } catch (Exception ex) {
                System.err.println("Some errs occur while inputting number representing choice! " + ex.getMessage());
            }
        } while (checkOutProduct);
    }

    public static void displayAllProducts() {
        productList = ProductBusiness.getAllProducts();
        System.out.printf("%-15s%-30s%-15s%-15s%-15s%-15s%-15s%-20s\n", "Product ID", "Product Name", "Price",
                "Creat Date", "Quantity", "View", "Catalog ID", "Product Status");
        productList.stream().forEach(product -> product.displayData());
    }

    public static void displayAllProductsSortedByPriceDesc() {
        List<Product> sortedProductList = ProductBusiness.getAllProductsSortedBrPriceDesc();
        System.out.printf("%-15s%-30s%-15s%-15s%-15s%-15s%-15s%-20s\n", "Product ID", "Product Name", "Price",
                "Creat Date", "Quantity", "View", "Catalog ID", "Product Status");
        sortedProductList.stream().forEach(product -> product.displayData());
    }

    public static void addNewProduct() {
        System.out.println("-----------Catalog Menu----------");
        for (int i = 0; i < categoriesList.size(); i++) {
            System.out.println((i + 1) + ". " + categoriesList.get(i).getCatalogName());
        }
        System.out.println("Please input your choice:");
        try {
            int choice = Integer.parseInt(input.nextLine());
            Product product = new Product();
            product.inputData(input, productList);
            product.setCatalogId(categoriesList.get(choice - 1).getCatalogId());
            boolean result = ProductBusiness.addNewProduct(product);
            if (result) {
                System.out.println("The product has been added successfully!");
            } else {
                System.err.println("Cannot add product because of unexpected errs!");
            }
        } catch (NumberFormatException ex1) {
            System.err.println("The inputted choice is not an integer format! " + ex1.getMessage());
        } catch (Exception ex) {
            System.err.println("Some errs occur while inputting choice! " + ex.getMessage());
        }
    }

    public static void updateProduct() {
        System.out.println("Please input product ID you wanna update info:");
        String productIdUpdate = input.nextLine();
        Product product = ProductBusiness.getProductById(productIdUpdate);
        if (product != null) {
            product.setProductName(product.validateProductName(input, productList));
            product.setPrice(product.validatePrice(input));
            product.setCreateDate(product.validateDateFormat(input));
            product.setQuantity(product.validateQuantity(input));
            product.setView(product.validateView(input));
            System.out.println("-----------Catalog Menu----------");
            for (int i = 0; i < categoriesList.size(); i++) {
                System.out.println((i + 1) + ". " + categoriesList.get(i).getCatalogName());
            }
            System.out.println("Please input your choice:");
            try {
                int choice = Integer.parseInt(input.nextLine());
                product.setCatalogId(categoriesList.get(choice - 1).getCatalogId());
            } catch (NumberFormatException ex1) {
                System.err.println("The inputted choice is not an integer format! " + ex1.getMessage());
            } catch (Exception ex) {
                System.err.println("Some errs occur while inputting choice! " + ex.getMessage());
            }
            product.setProductStatus(product.validateProductStatus(input));
            boolean updateResult = ProductBusiness.updateProduct(product);
            if (updateResult) {
                System.out.println("The product info has been updated successfully!");
            } else {
                System.err.println("Cannot update product info due to unexpected errs!");
            }
        } else {
            System.err.println("The inputted ID does not exist!");
        }
    }

    public static void updateProductStatus() {
        System.out.println("Please input product ID you wanna update info:");
        String productIdUpdate = input.nextLine();
        Product product = ProductBusiness.getProductById(productIdUpdate);
        if (product != null) {
            product.setProductStatus(product.validateProductStatus(input));
            boolean updateResult = ProductBusiness.updateProductStatus(product);
            if (updateResult) {
                System.out.println("The product info has been updated successfully!");
            } else {
                System.err.println("Cannot update product info due to unexpected errs!");
            }
        } else {
            System.err.println("The inputted ID does not exist!");
        }
    }

    public static void deleteProduct() {
        System.out.println("Please input product ID you wanna delete!");
        String productIdDelete = input.nextLine();
        Product product = ProductBusiness.getProductById(productIdDelete);
        if (product != null) {
            boolean deleteResult = ProductBusiness.deleteProduct(product);
            if (deleteResult) {
                System.out.println("The product with ID- " + productIdDelete + " has been deleted successfully!");
            } else {
                System.err.println("Cannot delete product due to unexpected errs!");
            }
        } else {
            System.err.println("The inputted ID does not exist!");
        }
    }

    public static void searchProductByName() {
        System.out.println("Please input the keyword related to product name you wanna search:");
        String keyword = input.nextLine();
        List<Product> searchProductList = ProductBusiness.searchProductByName(keyword);
        if (searchProductList.size() != 0) {
            System.out.printf("%-15s%-30s%-15s%-15s%-15s%-15s%-15s%-20s\n", "Product ID", "Product Name", "Price",
                    "Creat Date", "Quantity", "View", "Catalog ID", "Product Status");
            searchProductList.stream().forEach(product -> product.displayData());
        } else {
            System.err.println("There is no product whose name contains inputted keyword!");
        }
    }

    public static void searchProductByPriceInterval() {
        System.out.println("Please input price-in:");
        float price_in = Float.parseFloat(input.nextLine());
        System.out.println("Please input price-out:");
        float price_out = Float.parseFloat(input.nextLine());
        List<Product> searchProductList = ProductBusiness.searchProductByPriceInterval(price_in, price_out);
        if (searchProductList != null) {
            System.out.printf("%-15s%-30s%-15s%-15s%-15s%-15s%-15s%-20s\n", "Product ID", "Product Name", "Price",
                    "Creat Date", "Quantity", "View", "Catalog ID", "Product Status");
            searchProductList.stream().forEach(product -> product.displayData());
        } else {
            System.err.println("There is no product whose price is from " + price_in + " to " + price_out + " !");
        }
    }

    public static void sellProduct() {
        // input productID and check the existence of product
        System.out.println("Please input the ID of product you wanna sell:");
        String productIdForSell = input.nextLine();
        Product product = ProductBusiness.getProductById(productIdForSell);
        if (product != null) {
            System.out.printf("%-15s%-30s%-15s%-15s%-15s%-15s%-15s%-20s\n", "Product ID", "Product Name", "Price",
                    "Creat Date", "Quantity", "View", "Catalog ID", "Product Status");
            product.displayData();
            System.out.println("Please input the quantity you wanna sell:");
            try {
                // input number of products want to sell and check with quantity of product
                int numberOfProduct = Integer.parseInt(input.nextLine());
                if (numberOfProduct < product.getQuantity()) {
                    int quantityAfterSell = product.getQuantity() - numberOfProduct;
                    product.setQuantity(quantityAfterSell);
                    boolean result = ProductBusiness.updateProductQuantityAfterSell(product);
                    if (result) {
                        System.out.println("Selling process has completed!");
                    } else {
                        System.err.println("Cannot sell product due to unexpected errs!");
                    }
                } else {
                    System.err.println("Cannot sell because the quantity of product is not enough at this moment!");
                }
            } catch (NumberFormatException ex) {
                ex.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.err.println("There is no product which has ID match with inputted ID!");
        }
    }


    public static void statisticsReport() {
        boolean checkOutReport = true;
        do {
            System.out.println();
            System.out.println("-------------------Statistics Report-------------------");
            System.out.println("1. Show statistics of number of catalogs group by status");
            System.out.println("2. Show statistics of number of products group by status");
            System.out.println("3. Show statistics of number of products group by catalog");
            System.out.println("4. Exit");
            System.out.println("Please input your choice:");
            try {
                int choice = Integer.parseInt(input.nextLine());
                switch (choice) {
                    case 1:
                        ProductManagement.showStatisticsOfCatalogByStatus();
                        break;
                    case 2:
                        ProductManagement.showStatisticsOfProductByStatus();
                        break;
                    case 3:
                        ProductManagement.showStatisticsOfProductByCatalog();
                        break;
                    case 4:
                        checkOutReport = false;
                        break;
                    default:
                        System.err.println("The inputted choice is out of scope!");
                }
            } catch (NumberFormatException ex) {
                System.err.println("The inputted choice is not an integer format!");
            } catch (Exception e) {
                e.printStackTrace();
            }
        } while (checkOutReport);
    }

    public static void showStatisticsOfCatalogByStatus() {
        StatisticsReport.statisticsOfCatalogByStatus();
    }

    public static void showStatisticsOfProductByStatus() {
        StatisticsReport.statisticsOfProductByStatus();
    }

    public static void showStatisticsOfProductByCatalog() {
        StatisticsReport.statisticsOfProductByCatalog();
    }
}

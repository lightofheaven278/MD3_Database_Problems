package ra.entity;

import java.util.List;
import java.util.Scanner;

public class Product {
    private String productId;
    private String productName;
    private float price;
    private String createDate;
    private int quantity;
    private int view;
    private int CatalogId;
    private boolean productStatus;

    public Product() {
    }

    public Product(String productId, String productName, float price, String createDate, int quantity, int view,
                   int catalogId, boolean productStatus) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.createDate = createDate;
        this.quantity = quantity;
        this.view = view;
        CatalogId = catalogId;
        this.productStatus = productStatus;
    }

    public String getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public float getPrice() {
        return price;
    }

    public String getCreateDate() {
        return createDate;
    }

    public int getQuantity() {
        return quantity;
    }

    public int getView() {
        return view;
    }

    public int getCatalogId() {
        return CatalogId;
    }

    public boolean isProductStatus() {
        return productStatus;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setView(int view) {
        this.view = view;
    }

    public void setCatalogId(int catalogId) {
        CatalogId = catalogId;
    }

    public void setProductStatus(boolean productStatus) {
        this.productStatus = productStatus;
    }

    public void inputData(Scanner input, List<Product> productList) {
        this.productId = validateProductId(input, productList);
        this.productName = validateProductName(input, productList);
        this.price = validatePrice(input);
        this.createDate = validateDateFormat(input);
        this.quantity = validateQuantity(input);
        this.view = validateView(input);
        this.productStatus = validateProductStatus(input);
    }

    public String validateProductId(Scanner input, List<Product> productList) {
        System.out.println("Please input product ID:");
        do {
            String productId = input.nextLine();
            if (!productId.trim().equals("") && productId.trim().length() == 5) {
                if (productList.size() != 0) {
                    boolean checkProductId = false;
                    for (Product product : productList) {
                        if (productId.trim().equals(product.getProductId())) {
                            checkProductId = true;
                            break;
                        }
                    }
                    if (!checkProductId) {
                        return productId;
                    } else {
                        System.err.println("The inputted product ID already existed. Please try another!");
                    }
                } else {
                    return productId;
                }
            } else {
                System.err.println("The product ID should not be a blank and contain 5 characters!");
            }
        } while (true);
    }

    public String validateProductName(Scanner input, List<Product> productList) {
        System.out.println("Please input product name:");
        do {
            String productName = input.nextLine();
            if (!productName.trim().equals("")) {
                if (productList.size() != 0) {
                    boolean checkProductName = false;
                    for (Product product : productList) {
                        if (productName.trim().equals(product.getProductName())) {
                            checkProductName = true;
                            break;
                        }
                    }
                    if (!checkProductName) {
                        return productName;
                    } else {
                        System.err.println("The inputted product name already existed. Please try another!");
                    }
                } else {
                    return productName;
                }
            } else {
                System.err.println("The product name should not be a blank!");
            }
        } while (true);
    }

    public Float validatePrice(Scanner input) {
        System.out.println("Please input price of product:");
        do {
            String priceStr = input.nextLine();
            try {
                float price = Float.parseFloat(priceStr.trim());
                if (!priceStr.trim().equals("")) {
                    if (price > 0) {
                        return price;
                    } else {
                        System.err.println("The price of product should be greater than 0!");
                    }
                } else {
                    System.err.println("The price of product should not be a blank!");
                }
            } catch (NumberFormatException e1) {
                System.err.println("The inputted price is not a float number! " + e1.getMessage());
            } catch (Exception ex) {
                System.err.println("Some errs occur while inputting price! " + ex.getMessage());
            }
        } while (true);
    }

    // validate date format???
    public String validateDateFormat(Scanner input) {
        System.out.println("Please input date of creation:");
        return input.nextLine();
    }

    public Integer validateQuantity(Scanner input) {
        System.out.println("Please input the quantity of product:");
        do {
            String quantityStr = input.nextLine();
            try {
                int quantity = Integer.parseInt(quantityStr.trim());
                if (!quantityStr.trim().equals("")) {
                    return quantity;
                }
            } catch (NumberFormatException ex1) {
                System.err.println("The inputted quantity is not an integer format " + ex1.getMessage());
            } catch (Exception ex) {
                System.err.println("Some errs occur while inputting quantity of product! " + ex.getMessage());
            }
        } while (true);
    }

    public Integer validateView(Scanner input) {
        System.out.println("Please input the view of product:");
        do {
            String viewStr = input.nextLine();
            try {
                int quantity = Integer.parseInt(viewStr.trim());
                if (!viewStr.trim().equals("")) {
                    return quantity;
                }
            } catch (NumberFormatException ex1) {
                System.err.println("The inputted view is not an integer format " + ex1.getMessage());
            } catch (Exception ex) {
                System.err.println("Some errs occur while inputting view of product! " + ex.getMessage());
            }
        } while (true);
    }

    public Boolean validateProductStatus(Scanner input) {
        System.out.println("Please input the status of product:");
        do {
            String status = input.nextLine();
            if (status.trim().equalsIgnoreCase("true") ||
                    status.trim().equalsIgnoreCase("false")) {
                return Boolean.parseBoolean(status);
            } else {
                System.err.println("The status of product should be 'true' or 'false'!");
            }
        } while (true);
    }

    public void displayData() {
        if (this.productStatus) {
            System.out.printf("%-15s%-30s%-15.1f%-15s%-15d%-15d%-15d%-20b\n", this.productId, this.productName,
                    this.price, this.createDate, this.quantity, this.view, this.CatalogId, this.productStatus);
        }
    }

}

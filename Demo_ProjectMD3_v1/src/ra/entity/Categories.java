package ra.entity;

import java.util.List;
import java.util.Scanner;

public class Categories {
    private int catalogId;
    private String catalogName;
    private int priority;
    private boolean catalogStatus;

    public Categories() {
    }

    public Categories(int catalogId, String catalogName, int priority, boolean catalogStatus) {
        this.catalogId = catalogId;
        this.catalogName = catalogName;
        this.priority = priority;
        this.catalogStatus = catalogStatus;
    }

    public int getCatalogId() {
        return catalogId;
    }

    public String getCatalogName() {
        return catalogName;
    }

    public int getPriority() {
        return priority;
    }

    public boolean isCatalogStatus() {
        return catalogStatus;
    }

    public void setCatalogId(int catalogId) {
        this.catalogId = catalogId;
    }

    public void setCatalogName(String catalogName) {
        this.catalogName = catalogName;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public void setCatalogStatus(boolean catalogStatus) {
        this.catalogStatus = catalogStatus;
    }

    public void inputData(Scanner input, List<Categories> categoryList) {
        this.catalogId = validateCatalogId(input, categoryList);
        this.catalogName = validateCatalogName(input, categoryList);
        this.priority = validatePriority(input);
        this.catalogStatus = validateCatalogStatus(input);
    }

    public Integer validateCatalogId(Scanner input, List<Categories> categoryList) {
        System.out.println("Please input catalog ID:");
        do {
            String catalogIdStr = input.nextLine();
            try {
                int catalogId = Integer.parseInt(catalogIdStr.trim());
                if (!catalogIdStr.trim().equals("")) {
                    if (categoryList.size() != 0) {
                        boolean checkCatalogId = false;
                        for (Categories catalog : categoryList) {
                            if (catalogId == catalog.getCatalogId()) {
                                checkCatalogId = true;
                                break;
                            }
                        }
                        if (!checkCatalogId) {
                            return catalogId;
                        } else {
                            System.err.println("The inputted catalog ID has already existed. Please try another!");
                        }
                    } else {
                        return catalogId;
                    }
                } else {
                    System.err.println("The catalog ID should not be a blank!");
                }
            } catch (NumberFormatException ex1) {
                System.err.println("The inputted catalog ID is not an integer format! " + ex1.getMessage());
            } catch (Exception ex) {
                System.err.println("Some errs occur while inputting catalog ID! " + ex.getMessage());
            }
        } while (true);
    }

    public String validateCatalogName(Scanner input, List<Categories> categoryList) {
        System.out.println("Please input the catalog name:");
        do {
            String catalogName = input.nextLine();
            if (!catalogName.trim().equals("")) {
                if (categoryList.size() != 0) {
                    boolean checkCatalogName = false;
                    for (Categories catalog : categoryList) {
                        if (catalogName.trim().equals(catalog.getCatalogName())) {
                            checkCatalogName = true;
                            break;
                        }
                    }
                    if (!checkCatalogName) {
                        return catalogName;
                    } else {
                        System.err.println("The inputted catalog name is already existed. Please try another!");
                    }
                } else {
                    return catalogName;
                }
            } else {
                System.err.println("The catalog name should not be a blank!");
            }
        } while (true);
    }

    public Integer validatePriority(Scanner input) {
        System.out.println("Please input priority of catalog:");
        do {
            String priorityStr = input.nextLine();
            try {
                int priority = Integer.parseInt(priorityStr);
                if (!priorityStr.trim().equals("")) {
                    return priority;
                }
            } catch (NumberFormatException e1) {
                System.err.println("The inputted priority is not an integer format! " + e1.getMessage());
            } catch (Exception e) {
                System.err.println("Some errs occur while inputting priority of catalog " + e.getMessage());
            }
        } while (true);
    }

    public Boolean validateCatalogStatus(Scanner input) {
        System.out.println("Please input the catalog status:");
        do {
            String catalogStatus = input.nextLine();
            if (!catalogStatus.trim().equalsIgnoreCase("")) {
                if (catalogStatus.trim().equalsIgnoreCase("true") ||
                        catalogStatus.trim().equalsIgnoreCase("false")) {
                    return Boolean.parseBoolean(catalogStatus);
                } else {
                    System.err.println("The catalog status should be inputted as 'true' or 'false'!");
                }
            } else {
                System.err.println("The catalog status should not be a blank!");
            }
        } while (true);
    }

    public void displayData() {
        if (this.catalogStatus){
            String catalogStatus = this.catalogStatus ? "Active" : "Inactive";
            System.out.printf("%-15d%-30s%-15d%-20s\n", this.catalogId, this.catalogName, this.priority, catalogStatus);
        }
    }
}

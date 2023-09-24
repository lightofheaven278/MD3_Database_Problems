package ra.entity;

import java.util.List;

public class StatisticsByAuthor {
    private String author;
    private int numberOfBook;

    public StatisticsByAuthor() {
    }

    public StatisticsByAuthor(String author, int numberOfBook) {
        this.author = author;
        this.numberOfBook = numberOfBook;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setNumberOfBook(int numberOfBook) {
        this.numberOfBook = numberOfBook;
    }

    public String getAuthor() {
        return author;
    }

    public int getNumberOfBook() {
        return numberOfBook;
    }

    public void displayStatisticsData(){
        System.out.printf("%-20s%-15d\n", this.author, this.numberOfBook);
    }
}

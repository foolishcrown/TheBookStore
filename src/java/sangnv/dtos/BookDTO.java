/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sangnv.dtos;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Objects;

/**
 *
 * @author Shang
 */
public class BookDTO implements Serializable {

    private static final boolean ATIVE = true;
    private static final boolean INACTIVE = false;
    private String bookID, title, image, description, author;
    private float price;
    private int cate, stock, quantityCart;
    private boolean status;
    private Timestamp importDate;

    public int getQuantityCart() {
        return quantityCart;
    }

    public void setQuantityCart(int quantityCart) {
        this.quantityCart = quantityCart;
    }

    public BookDTO() {
    }

    public BookDTO(String bookID, String title, float price) {
        this.bookID = bookID;
        this.title = title;
        this.price = price;
    }
    
    //Constructor for Seartch
    public BookDTO(String bookID,String title, String image, String author, float price, int cate, int stock) {
        this.bookID = bookID;
        this.title = title;
        this.image = image;
        this.author = author;
        this.price = price;
        this.cate = cate;
        this.stock = stock;
    }

    
    //Constructor for Insert
    
    public BookDTO(String bookID, String title, String image, String description, String author, float price, int cate, int stock) {
        this.bookID = bookID;
        this.title = title;
        this.image = image;
        this.description = description;
        this.author = author;
        this.price = price;
        this.cate = cate;
        this.stock = stock;
    }
    
    

    //Contructor for Update
    public BookDTO(String bookID, String title, String image, String description, String author, float price, int cate, int stock, Timestamp importDate) {
        this.bookID = bookID;
        this.title = title;
        this.image = image;
        this.description = description;
        this.author = author;
        this.price = price;
        this.cate = cate;
        this.stock = stock;
        this.importDate = importDate;
    }

    public BookDTO(String bookID, boolean status) {
        this.bookID = bookID;
        this.status = status;
    }

    public String getBookID() {
        return bookID;
    }

    public void setBookID(String bookID) {
        this.bookID = bookID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getCate() {
        return cate;
    }

    public void setCate(int cate) {
        this.cate = cate;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Timestamp getImportDate() {
        return importDate;
    }

    public void setImportDate(Timestamp importDate) {
        this.importDate = importDate;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final BookDTO other = (BookDTO) obj;
        if (!Objects.equals(this.bookID, other.bookID)) {
            return false;
        }
        return true;
    }

}

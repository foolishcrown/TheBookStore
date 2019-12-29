/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sangnv.dtos;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 *
 * @author Shang
 */
public class OrderDTO implements Serializable {

    private int orderID;
    private String userID;
    private float subtotal;
    private Timestamp orderDate;

    public OrderDTO() {
    }

    public OrderDTO(String userID, float subtotal) {
        this.userID = userID;
        this.subtotal = subtotal;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public float getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(float subtotal) {
        this.subtotal = subtotal;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public OrderDTO(int orderID, String userID, float subtotal, Timestamp orderDate) {
        this.orderID = orderID;
        this.userID = userID;
        this.subtotal = subtotal;
        this.orderDate = orderDate;
    }

}

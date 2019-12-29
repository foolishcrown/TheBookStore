/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sangnv.dtos;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import sangnv.daos.BookDAO;

/**
 *
 * @author Shang
 */
public class CartDTO implements Serializable {

    private String customerName;
    private HashMap<String, Integer> cart;
    private float total;
    private String discountCode;
    private float discount;

    public String getDiscountCode() {
        return discountCode;
    }

    public void setDiscountCode(String discountCode) {
        this.discountCode = discountCode;
    }

    public float getDiscount() {
        return discount;
    }

    public void setDiscount(float discount) {
        this.discount = discount;
    }

    public CartDTO() {
        this.customerName = "GUEST";
        this.cart = new HashMap<>();
    }

    public CartDTO(String customerName) {
        this.customerName = customerName;
        this.cart = new HashMap<>();
        this.discount = 0;
    }

    public String getCustomerName() {
        return customerName;
    }

    public HashMap<String, Integer> getCart() {
        return cart;
    }

    public float getTotal() {
        return total * (1 - discount);
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public void addToCart(String id) throws Exception {
        int quantityCart = 1;
        if (this.cart.containsKey(id)) {
            quantityCart = this.cart.get(id) + 1;
        }
        this.cart.put(id, quantityCart);
    }

    public void removeCart(String id) throws Exception {
        if (this.cart.containsKey(id)) {
            this.cart.remove(id);
        }
    }

    public void updateCart(String id, int quantityCart) throws Exception {
        if (this.cart.containsKey(id)) {
            this.cart.put(id, quantityCart);
        }
    }

    public List<BookDTO> getCartDetail() throws Exception {
        this.total = 0;
        List<BookDTO> result = new ArrayList<>();
        BookDAO dao = new BookDAO();
        for (String key : this.cart.keySet()) {
            BookDTO dto = dao.findCartDetailByID(key);
            if (dto != null) {
                int quantity = this.cart.get(key);
                if (dto.getStock() >= quantity) {
                    dto.setQuantityCart(quantity);
                    result.add(dto);
                    this.total += dto.getQuantityCart() * dto.getPrice();
                } 
            }
        }
        return result;
    }

    public boolean checkValidConfirm(List<BookDTO> listCart) throws Exception {
        boolean check = true;
        for (String string : this.cart.keySet()) {
            BookDTO dto = new BookDTO(string, false);
            if (!listCart.contains(dto)) {
                removeCart(string);
                check = false;
            }
        }
        return check;
    }

}

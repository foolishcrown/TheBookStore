/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sangnv.dtos;

import java.io.Serializable;

/**
 *
 * @author Shang
 */
public class DiscountDTO implements Serializable {
    
    private String code;
    private float value;
    private String userID;

    public DiscountDTO() {
    }

    public DiscountDTO(String code, float value) {
        this.code = code;
        this.value = value;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public float getValue() {
        return value;
    }

    public void setValue(float value) {
        this.value = value;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public DiscountDTO(String code, float value, String userID) {
        this.code = code;
        this.value = value;
        this.userID = userID;
    }
    
    
    
}

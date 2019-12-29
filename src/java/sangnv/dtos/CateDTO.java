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
public class CateDTO implements Serializable {
    private int cateID;
    private String cateName;
    private String cateCode;

    public CateDTO() {
    }

    public CateDTO(int cateID, String cateName, String cateCode) {
        this.cateID = cateID;
        this.cateName = cateName;
        this.cateCode = cateCode;
    }

    public int getCateID() {
        return cateID;
    }

    public void setCateID(int cateID) {
        this.cateID = cateID;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }

    public String getCateCode() {
        return cateCode;
    }

    public void setCateCode(String cateCode) {
        this.cateCode = cateCode;
    }
    
    
    
}

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
public class AccountDTO implements Serializable {

    private String userID, password, username;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    private int role;

    public AccountDTO() {
    }

    public AccountDTO(String userID, String password) {
        this.userID = userID;
        this.password = password;
    }

    public AccountDTO(String userID, int role) {
        this.userID = userID;
        this.role = role;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

}

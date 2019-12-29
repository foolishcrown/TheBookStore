/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sangnv.daos;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import sangnv.conn.MyConnection;
import sangnv.dtos.DiscountDTO;

/**
 *
 * @author Shang
 */
public class DiscountDAO implements Serializable {

    public DiscountDAO() {
    }

    public boolean isCodeAvailable(String code) throws NamingException, SQLException {
        boolean status = false;
        String sql = "Select userID From Discount Where DiscountCode = ?";
        try (Connection conn = MyConnection.getMyConnection();
                PreparedStatement preStm = conn.prepareStatement(sql)) {
            preStm.setString(1, code);
            try (ResultSet rs = preStm.executeQuery()) {
                if (rs.next()) {
                    String userID = rs.getString("userID");
                    if (userID == null) {
                        status = true;
                    }
                }
            }
        }
        return status;
    }

    public float getDiscountValue(String code) throws NamingException, SQLException {
        float value = -1;
        String sql = "Select Value From Discount Where DiscountCode = ?";
        try (Connection conn = MyConnection.getMyConnection();
                PreparedStatement preStm = conn.prepareStatement(sql)) {
            preStm.setString(1, code);
            try (ResultSet rs = preStm.executeQuery()) {
                if (rs.next()) {
                    value = rs.getFloat("Value");
                }
            }
        }
        return value;
    }

    public boolean applyDiscount(String userID, String code) throws NamingException, SQLException {
        boolean check;
        String sql = "Update Discount Set userID = ? Where DiscountCode = ?";
        try (Connection conn = MyConnection.getMyConnection();
                PreparedStatement preStm = conn.prepareStatement(sql)) {
            preStm.setString(1, userID);
            preStm.setString(2, code);
            check = preStm.executeUpdate() > 0;
        }
        return check;
    }
    
    public boolean createDiscount(String code ,float percent) throws NamingException, SQLException{
        boolean check;
        String sql = "Insert Into Discount(DiscountCode, Value) Values(?,?)";
        try(Connection conn = MyConnection.getMyConnection();
                PreparedStatement preStm = conn.prepareStatement(sql)){
            preStm.setString(1, code);
            preStm.setFloat(2, percent);
            check = preStm.executeUpdate() > 0;
        }
        return check;
    }
    
    
    public List<DiscountDTO> getAvailableDiscounts() throws NamingException, SQLException{
        List<DiscountDTO> result;
        String sql = "Select DiscountCode, Value From Discount where userID is null";
        try(Connection conn = MyConnection.getMyConnection();
                PreparedStatement preStm = conn.prepareStatement(sql)){
                result=  new ArrayList<>();
                try(ResultSet rs = preStm.executeQuery()){
                    while (rs.next()) {
                        String code = rs.getString("DiscountCode");
                        float value  = rs.getFloat("Value");
                        DiscountDTO dto = new DiscountDTO(code, value);
                        result.add(dto);
                    }
                }
        }
        return result;
    }
    

}

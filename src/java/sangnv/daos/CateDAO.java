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
import sangnv.dtos.CateDTO;

/**
 *
 * @author Shang
 */
public class CateDAO implements Serializable {

    public CateDAO() {
    }

    public List<CateDTO> getAllCate() throws NamingException, SQLException {
        List<CateDTO> result;
        String sql = "Select CateID, CateName, CateCODE From Category";

        try (Connection conn = MyConnection.getMyConnection();
                PreparedStatement preStm = conn.prepareStatement(sql)) {
            result = new ArrayList<>();
            CateDTO dto;
            try (ResultSet rs = preStm.executeQuery()) {
                while (rs.next()) {
                    int cateID = rs.getInt("CateID");
                    String cateName = rs.getString("CateName");
                    String cateCode = rs.getString("CateCODE");
                    dto = new CateDTO(cateID, cateName, cateCode);
                    result.add(dto);
                }
            }
        }
        return result;
    }

    public String getCateCode(int id) throws SQLException, NamingException {
        String result = null;
        String sql = "Select CateCODE From Category Where CateID = ?";
        try (Connection conn = MyConnection.getMyConnection();
                PreparedStatement preStm = conn.prepareStatement(sql)) {
            preStm.setInt(1, id);
            try (ResultSet rs = preStm.executeQuery()) {
                if (rs.next()) {
                    result = rs.getString("CateCODE");
                }
            }
        }
        return result;

    }

}

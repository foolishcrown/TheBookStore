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
import sangnv.dtos.RoleDTO;

/**
 *
 * @author Shang
 */
public class RoleDAO implements Serializable {

    public RoleDAO() {
    }

    public List<RoleDTO> getAllRole() throws NamingException, SQLException {
        List<RoleDTO> result;
        String sql = "Select RoleID, Description From Role";
        try (Connection conn = MyConnection.getMyConnection();
                PreparedStatement preStm = conn.prepareStatement(sql)) {
            result = new ArrayList<>();
            RoleDTO dto;
            try (ResultSet rs = preStm.executeQuery()) {
                while (rs.next()) {
                    int roleID = rs.getInt("RoleID");
                    String description = rs.getString("Description");
                    dto = new RoleDTO(roleID, description);
                    result.add(dto);

                }
            }
        }
        return result;
    }

}

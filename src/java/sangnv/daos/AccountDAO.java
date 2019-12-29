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
import sangnv.dtos.AccountDTO;

/**
 *
 * @author Shang
 */
public class AccountDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public AccountDAO() {
    }

    private void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (preStm != null) {
            preStm.close();
        }
        if (conn != null) {
            preStm.close();
        }
    }

    public String checkRole(AccountDTO dto) throws SQLException, NamingException {
        String role = "failed";
        try {
            String sql = "Select Description as Role From Role where RoleID in (Select Role From Account Where UserID = ? and Password = ?)";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getUserID());
            preStm.setString(2, dto.getPassword());
            rs = preStm.executeQuery();
            if (rs.next()) {
                role = rs.getString("Role");
            }
        } finally {
            closeConnection();
        }
        return role;
    }

    public boolean createAccount(AccountDTO dto) throws NamingException, SQLException {
        boolean check = false;
        try {
            String sql = "Insert Into Account(UserID, Password, Role, Username) Values(?,?,?,?)";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getUserID());
            preStm.setString(2, dto.getPassword());
            preStm.setInt(3, dto.getRole());
            preStm.setString(4, dto.getUsername());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public List<AccountDTO> getAllUser() throws NamingException, SQLException {
        List<AccountDTO> result = null;
        String sql = "Select UserID, Username, Role From Account";
        try {
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            result = new ArrayList<>();
            rs = preStm.executeQuery();
            while (rs.next()) {
                String userID = rs.getString("UserID");
                String username = rs.getString("Username");
                int role = rs.getInt("Role");
                AccountDTO dto = new AccountDTO(userID, role);
                dto.setUsername(username);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

}

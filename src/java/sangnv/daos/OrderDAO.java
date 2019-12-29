/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sangnv.daos;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import sangnv.conn.MyConnection;
import sangnv.dtos.BookDTO;
import sangnv.dtos.OrderDTO;
import sangnv.dtos.OrderDetailDTO;

/**
 *
 * @author Shang
 */
public class OrderDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    private void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (preStm != null) {
            preStm.close();
        }
        if (conn != null) {
            conn.close();
        }
    }

    public boolean confirmOrder(OrderDTO dto) throws NamingException, SQLException {
        boolean check = false;
        String sql = "Insert Into [dbo].[Order](UserID, SubTotal) Values(?,?)";
        try {
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getUserID());
            preStm.setFloat(2, dto.getSubtotal());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public int getOrderID(String userID) throws NamingException, SQLException {
        int id = -1;
        String sql = "Select OrderID From [dbo].[Order] Where OrderDate = (Select Max(OrderDate) from [dbo].[Order]) And UserID = ?";
        try {
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, userID);
            rs = preStm.executeQuery();
            if (rs.next()) {
                id = rs.getInt("OrderID");
            }
        } finally {
            closeConnection();
        }
        return id;
    }

    public int[] storeDetail(List<BookDTO> listDetail, int orderID) throws NamingException, SQLException {
        int[] check = null;
        String sql = "Insert Into OrderDetail(OrderID, BookID, BookName, Amount, Price) Values(?,?,?,?,?)";
        String sql2 = "Update Book set Stock  = ? Where BookID = ?";
        PreparedStatement preStm2 = null;
        try {
            conn = MyConnection.getMyConnection();
            conn.setAutoCommit(false);
            preStm = conn.prepareStatement(sql);
            preStm2 = conn.prepareStatement(sql2);
            for (BookDTO bookDTO : listDetail) {
                preStm.setInt(1, orderID);
                preStm.setString(2, bookDTO.getBookID());
                preStm.setString(3, bookDTO.getTitle());
                preStm.setInt(4, bookDTO.getQuantityCart());
                preStm.setFloat(5, bookDTO.getPrice());
                preStm.addBatch();

                int remainStock = bookDTO.getStock() - bookDTO.getQuantityCart();
                preStm2.setInt(1, remainStock);
                preStm2.setString(2, bookDTO.getBookID());
                preStm2.addBatch();
            }
            check = preStm.executeBatch();
            check = preStm2.executeBatch();
            conn.commit();

        } catch (SQLException ex) {
            conn.rollback();
            throw new SQLException("Something wrong when storing detail into Database: " + ex.getMessage());
        } finally {
            closeConnection();
            if (preStm2 != null) {
                preStm2.close();
            }
        }
        return check;

    }

    public List<OrderDTO> getAllOrder() throws NamingException, SQLException {
        List<OrderDTO> result = null;
        String sql = "Select OrderID, UserID, SubTotal, OrderDate From [dbo].[Order] ORDER BY OrderDate DESC";
        try {
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                int orderID = rs.getInt("OrderID");
                String userID = rs.getString("UserID");
                float subTotal = rs.getFloat("SubTotal");
                Timestamp orderDate = rs.getTimestamp("OrderDate");
                OrderDTO dto = new OrderDTO(orderID, userID, subTotal, orderDate);
                result.add(dto);
            }

        } finally {
            closeConnection();
        }
        return result;
    }

    public List<OrderDTO> searchByUserID(String userID) throws SQLException, NamingException {
        List<OrderDTO> result = null;
        try {
            String sql = "Select OrderID, UserID, SubTotal, OrderDate From [dbo].[Order] Where UserID like ? ORDER BY OrderDate DESC";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, "%" + userID + "%");
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                int orderID = rs.getInt("OrderID");
                String user = rs.getString("UserID");
                float subTotal = rs.getFloat("SubTotal");
                Timestamp orderDate = rs.getTimestamp("OrderDate");
                OrderDTO dto = new OrderDTO(orderID, user, subTotal, orderDate);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public List<OrderDTO> searchByOrderDate(String date) throws NamingException, SQLException {
        List<OrderDTO> result = null;
        String sql = "Select OrderID, UserID, SubTotal, OrderDate From [dbo].[Order] Where CONVERT(date, OrderDate) = ? ORDER BY OrderDate DESC";
        try {
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            Date convertDate = Date.valueOf(date);
            preStm.setDate(1, convertDate);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                int orderID = rs.getInt("OrderID");
                String userID = rs.getString("UserID");
                float subTotal = rs.getFloat("SubTotal");
                Timestamp orderDates = rs.getTimestamp("OrderDate");
                OrderDTO dto = new OrderDTO(orderID, userID, subTotal, orderDates);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public List<OrderDetailDTO> getDetailByID(int orderID) throws NamingException, SQLException {
        List<OrderDetailDTO> result = null;
        String sql = "Select BookID, BookName, Amount, Price From OrderDetail Where OrderID = ?";
        try {
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, orderID);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            while (rs.next()) {
                String bookID = rs.getString("BookID");
                String bookName = rs.getString("BookName");
                int amount = rs.getInt("Amount");
                float price = rs.getFloat("Price");
                OrderDetailDTO dto = new OrderDetailDTO(orderID, bookID, bookName, amount, price);
                result.add(dto);
            }

        } finally {
            closeConnection();
        }

        return result;
    }

    public OrderDTO findOrderByID(int id) throws SQLException, NamingException {
        OrderDTO dto = null;
        try {
            String sql = "Select UserID, SubTotal, OrderDate From [dbo].[Order] Where OrderID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, id);
            rs = preStm.executeQuery();
            if (rs.next()) {
                String userID = rs.getString("UserID");
                float subTotal = rs.getFloat("SubTotal");
                Timestamp orderDate = rs.getTimestamp("OrderDate");
                dto = new OrderDTO(id, userID, subTotal, orderDate);
            }
        } finally {
            closeConnection();
        }

        return dto;
    }

}

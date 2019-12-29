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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import sangnv.conn.MyConnection;
import sangnv.dtos.BookDTO;

/**
 *
 * @author Shang
 */
public class BookDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public BookDAO() {
    }

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

    public List<BookDTO> getAllBook() throws SQLException, NamingException {
        List<BookDTO> result = null;
        try {
            String sql = "Select BookID, Title, Image, Price, Author, Category, Stock, Description From Book Where Status = 1 and Stock > 0";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            BookDTO dto;
            while (rs.next()) {
                String bookID = rs.getString("BookID");
                String title = rs.getString("Title");
                String image = rs.getString("Image");
                float price = rs.getFloat("Price");
                String author = rs.getString("Author");
                int cate = rs.getInt("Category");
                int stock = rs.getInt("Stock");
                String description = rs.getString("Description");
                dto = new BookDTO(bookID, title, image, author, price, cate, stock);
                dto.setDescription(description);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public List<BookDTO> searchByLikeName(String search) throws NamingException, SQLException {
        List<BookDTO> result = null;
        try {
            String sql = "Select BookID, Title, Image, Price, Author, Category, Stock, Description From Book Where Status = 1 and Stock > 0 and Title like ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, "%" + search + "%");
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            BookDTO dto;
            while (rs.next()) {
                String bookID = rs.getString("BookID");
                String title = rs.getString("Title");
                String image = rs.getString("Image");
                float price = rs.getFloat("Price");
                String author = rs.getString("Author");
                int cate = rs.getInt("Category");
                int stock = rs.getInt("Stock");
                String description = rs.getString("Description");
                dto = new BookDTO(bookID, title, image, author, price, cate, stock);
                dto.setDescription(description);
                result.add(dto);
            }

        } finally {
            closeConnection();
        }
        return result;
    }

    public BookDTO findCartDetailByID(String id) throws NamingException, SQLException {
        BookDTO dto = null;
        try {
            String sql = "Select BookID, Title, Image, Price, Author, Category, Stock From Book Where Status = 1 and Stock > 0 and BookID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, id);
            rs = preStm.executeQuery();
            while (rs.next()) {
                String bookID = rs.getString("BookID");
                String title = rs.getString("Title");
                float price = rs.getFloat("Price");
                int stock = rs.getInt("Stock");
                dto = new BookDTO(bookID, title, price);
                dto.setStock(stock);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public BookDTO findByPrimaryKey(String id) throws NamingException, SQLException {
        BookDTO dto = null;
        try {
            String sql = "Select Title, Image, Description, Price, Author, Category, Stock, ImportDate From Book Where BookID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, id);
            rs = preStm.executeQuery();
            while (rs.next()) {
                String title = rs.getString("Title");
                String image = rs.getString("Image");
                String description = rs.getString("Description");
                float price = rs.getFloat("Price");
                String author = rs.getString("Author");
                int cate = rs.getInt("Category");
                int stock = rs.getInt("Stock");
                Timestamp importDate = rs.getTimestamp("ImportDate");
                dto = new BookDTO(id, title, image, description, author, price, cate, stock, importDate);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public List<BookDTO> searchByPrice(String txtPrice) throws NamingException, SQLException {
        List<BookDTO> result = null;
        try {
            String sql = "Select BookID, Title, Image, Price, Author, Category, Stock, Description From Book Where Status = 1 and Stock > 0 ";
            String subSQL = "";
            switch (txtPrice) {
                case "<15":
                    subSQL = "and Price < 15000";
                    break;
                case "15to30":
                    subSQL = "and Price Between 15000 And 30000";
                    break;
                case "30to50":
                    subSQL = "and Price Between 30000 And 50000";
                    break;
                case ">50":
                    subSQL = "and Price > 50000";
                    break;
                default:
                    break;
            }
            sql += subSQL;
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            BookDTO dto;
            while (rs.next()) {
                String bookID = rs.getString("BookID");
                String title = rs.getString("Title");
                String image = rs.getString("Image");
                float price = rs.getFloat("Price");
                String author = rs.getString("Author");
                int cate = rs.getInt("Category");
                int stock = rs.getInt("Stock");
                String description = rs.getString("Description");
                dto = new BookDTO(bookID, title, image, author, price, cate, stock);
                dto.setDescription(description);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public List<BookDTO> searchByCate(int cateID) throws NamingException, SQLException {

        List<BookDTO> result = null;
        try {
            String sql = "Select BookID, Title, Image, Price, Author, Category, Stock, Description From Book Where Status = 1 and Stock > 0 and Category = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, cateID);
            rs = preStm.executeQuery();
            result = new ArrayList<>();
            BookDTO dto;
            while (rs.next()) {
                String bookID = rs.getString("BookID");
                String title = rs.getString("Title");
                String image = rs.getString("Image");
                float price = rs.getFloat("Price");
                String author = rs.getString("Author");
                int cate = rs.getInt("Category");
                int stock = rs.getInt("Stock");
                String description = rs.getString("Description");
                dto = new BookDTO(bookID, title, image, author, price, cate, stock);
                dto.setDescription(description);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    private String generateBookIDbyCate(int cate) throws SQLException, NamingException {
        String result = null;
        String sql = "Select BookID From Book Where ImportDate = (Select MAX(ImportDate) From Book) and Category = ?";
        CateDAO cateDAO = new CateDAO();
        String code = cateDAO.getCateCode(cate);
        try {
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, cate);
            rs = preStm.executeQuery();
            if (rs.next()) {
                String newestID = rs.getString("BookID");
                String[] subString = newestID.split("-");
                int id = Integer.parseInt(subString[1]) + 1;
                result = subString[0] + "-" + id;
            } else {
                result = code + "-" + "0";
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean insertBook(BookDTO dto) throws NamingException, SQLException {
        boolean check = false;
        String bookID = generateBookIDbyCate(dto.getCate());
        try {
            String sql = "Insert Into Book(BookID, Title, Image, Description, Price, Author, Category, Stock) Values(?,?,?,?,?,?,?,?)";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, bookID);
            preStm.setString(2, dto.getTitle());
            preStm.setString(3, dto.getImage());
            preStm.setString(4, dto.getDescription());
            preStm.setFloat(5, dto.getPrice());
            preStm.setString(6, dto.getAuthor());
            preStm.setInt(7, dto.getCate());
            preStm.setInt(8, dto.getStock());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean deleteBook(String bookID) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "Update Book Set Status = 0 Where BookID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, bookID);
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean updateBook(BookDTO dto) throws NamingException, SQLException {
        boolean check = false;
        String sql = "Update Book Set Title = ?, Image = ?, Description = ?, Price = ?, Author = ?, Category = ?, Stock = ? Where BookID = ?";
        try {
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getTitle());
            preStm.setString(2, dto.getImage());
            preStm.setString(3, dto.getDescription());
            preStm.setFloat(4, dto.getPrice());
            preStm.setString(5, dto.getAuthor());
            preStm.setInt(6, dto.getCate());
            preStm.setInt(7, dto.getStock());
            preStm.setString(8, dto.getBookID());

            check = preStm.executeUpdate() > 0;

        } finally {
            closeConnection();
        }
        return check;
    }

    public int getStockByKey(String id) throws NamingException, SQLException {
        int stock = -1;
        try {
            String sql = "Select Stock From Book Where BookID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, id);
            rs = preStm.executeQuery();
            if (rs.next()) {
                stock = rs.getInt("Stock");
            }
        } finally {
            closeConnection();
        }
        return stock;
    }

}

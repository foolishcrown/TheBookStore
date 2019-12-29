/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sangnv.controllers;

import java.io.IOException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sangnv.daos.BookDAO;
import sangnv.dtos.BookDTO;

/**
 *
 * @author Shang
 */
public class UpdateBookController extends HttpServlet {

    private static final String SUCCESS = "AdminLoadController";
    private static final String FAIL = "EditBook";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = SUCCESS;
        try {
            String bookID = request.getParameter("txtBookID");
            String title = request.getParameter("txtTitle");
            String txtPrice = request.getParameter("txtPrice");
            String author = request.getParameter("txtAuthor");
            String txtStock = request.getParameter("txtStock");
            String txtCate = request.getParameter("cboCate");
            String description = request.getParameter("txtDescription");
            String image = request.getParameter("txtImage");
            if ("".equals(image)) {
                image = request.getParameter("oldImage");
            }
            float price = Float.parseFloat(txtPrice);
            int stock = Integer.parseInt(txtStock);
            int cate = Integer.parseInt(txtCate);
            BookDTO dto = new BookDTO(bookID, title, image, description, author, price, cate, stock);
            BookDAO dao = new BookDAO();
            boolean check = dao.updateBook(dto);
            if (check) {
                request.setAttribute("SUCCESS", "Update Successed");
            } else {
                String message = "Update Failed";
                url = FAIL;
                response.sendRedirect(url + "?FAIL=" + message);
            }

        } catch (IOException | NumberFormatException | SQLException | NamingException e) {
            log("Error at UpdateBookController:" + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

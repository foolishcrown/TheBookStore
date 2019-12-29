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
public class InsertBookController extends HttpServlet {

    private static final String SUCCESS = "AdminLoadController";
    private static final String FAIL = "admin_insertBook.jsp";

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
        String url = FAIL;
        try {
            String txtImage = request.getParameter("txtImage");
            String txtTitle = request.getParameter("txtTitle");
            String txtPrice = request.getParameter("txtPrice");
            String txtAuthor = request.getParameter("txtAuthor");
            String txtCate = request.getParameter("cboCate");
            String txtStock = request.getParameter("txtStock");
            String txtDescription = request.getParameter("txtDescription");
            float price = Float.parseFloat(txtPrice);
            int cate = Integer.parseInt(txtCate);
            int stock = Integer.parseInt(txtStock);
            BookDAO dao = new BookDAO();
            BookDTO dto = new BookDTO(null, txtTitle, txtImage, txtDescription, txtAuthor, price, cate, stock);
            boolean check = dao.insertBook(dto);
            if (check) {
                url = SUCCESS;
                request.setAttribute("SUCCESS", "Insert Successed");
            } else {
                request.setAttribute("FAIL", "Insert Failed");
            }
            
        } catch (NumberFormatException | SQLException | NamingException e) {
            log("Error at InsertBookController: " + e.getMessage());
            if (e.getMessage().contains("duplicate")) {
                request.setAttribute("FAIL", "Auto generate ID fail");
            }
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

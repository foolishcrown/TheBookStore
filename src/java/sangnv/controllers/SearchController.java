/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sangnv.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sangnv.daos.BookDAO;
import sangnv.daos.CateDAO;
import sangnv.dtos.BookDTO;
import sangnv.dtos.CateDTO;

/**
 *
 * @author Shang
 */
public class SearchController extends HttpServlet {

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
        try {
            String txtSearch = request.getParameter("txtSearch");
            String txtRange = request.getParameter("cboRange");
            String txtCate = request.getParameter("cboCate");
            BookDAO dao = new BookDAO();
            List<BookDTO> listBook;
            if (txtSearch != null && !"".equalsIgnoreCase(txtSearch)) {
                listBook = dao.searchByLikeName(txtSearch);
            } else if (txtRange != null && !"All".equals(txtRange) && !"".equalsIgnoreCase(txtRange)) {
                listBook = dao.searchByPrice(txtRange);
            } else if (txtCate != null && !"All".equals(txtCate) && !"".equalsIgnoreCase(txtCate)) {
                int cate = Integer.parseInt(txtCate);
                listBook = dao.searchByCate(cate);
            } else {
                listBook = dao.getAllBook();
            }
            request.setAttribute("BOOKS", listBook);

            CateDAO cateDao = new CateDAO();
            List<CateDTO> cateList = cateDao.getAllCate();
            request.setAttribute("CATES", cateList);

        } catch (NumberFormatException | SQLException | NamingException e) {
            log("Error at SearchController: " + e.getMessage());
        } finally {
            
            request.getRequestDispatcher("index.jsp").forward(request, response);
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

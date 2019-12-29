/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sangnv.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sangnv.daos.BookDAO;
import sangnv.dtos.AccountDTO;
import sangnv.dtos.CartDTO;

/**
 *
 * @author Shang
 */
public class AddCartController extends HttpServlet {

    private static final String SUCCESS = "Add Successed";
    private static final String FAIL = "Add Failed";

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
            String bookID = request.getParameter("bookID");
            HttpSession session = request.getSession();
            CartDTO cart = (CartDTO) session.getAttribute("CART");
            AccountDTO user = (AccountDTO) session.getAttribute("ACCOUNT");
            if (cart == null) {
                cart = new CartDTO(user.getUserID());
            }
            BookDAO dao = new BookDAO();
            int stock = dao.getStockByKey(bookID);
            switch (stock) {
                case -1:
                    request.setAttribute("FAIL", "Can't found BookID");
                    break;
                case 0:
                    request.setAttribute("FAIL", FAIL);
                    break;
                default:
                    cart.addToCart(bookID);
                    request.setAttribute("SUCCESS", SUCCESS);
                    session.setAttribute("CART", cart);
                    break;
            }

        } catch (Exception e) {
            log("Error at Add Cart Controller: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("SearchController").forward(request, response);
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

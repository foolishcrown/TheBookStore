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
import sangnv.daos.AccountDAO;
import sangnv.dtos.AccountDTO;

/**
 *
 * @author Shang
 */
public class CreateAccountController extends HttpServlet {

    private static final String SUCCESS = "AdminLoadController";
    private static final String FAIL = "admin_createAccount.jsp";

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
            String userID = request.getParameter("userID");
            String pass = request.getParameter("pass");
            String username = request.getParameter("username");
            String role = request.getParameter("cboRole");
            if (role != null) {
                int roleID = Integer.parseInt(role);
                AccountDTO dto = new AccountDTO(userID, roleID);
                dto.setPassword(pass);
                dto.setUsername(username);
                AccountDAO dao = new AccountDAO();
                boolean check = dao.createAccount(dto);
                if (check) {
                    request.setAttribute("SUCCESS", "Create Account Successed");
                    url = SUCCESS;
                    
                } 
                request.getRequestDispatcher(url).forward(request, response);
            }
        } catch (NumberFormatException | SQLException | NamingException e) {
            log("Error at CreateAccountController : " + e.getMessage());
            if (e.getMessage().contains("duplicate")) {
                response.sendRedirect(FAIL + "?FAIL=UserID existed, try another userID");
            }
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

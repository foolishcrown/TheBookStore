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
import javax.servlet.http.HttpSession;
import sangnv.daos.AccountDAO;
import sangnv.daos.RoleDAO;
import sangnv.dtos.AccountDTO;
import sangnv.dtos.RoleDTO;

/**
 *
 * @author Shang
 */
public class LoginController extends HttpServlet {
    
    private static final String INVALID = "LoadController";
    private static final String ADMIN = "AdminLoad";
    private static final String NONADMIN = "Load";

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
        String url = NONADMIN;
        
        try {
            String userID = request.getParameter("userID");
            String password = request.getParameter("password");
            AccountDAO dao = new AccountDAO();
            AccountDTO accDto = new AccountDTO(userID, password);
            String role = dao.checkRole(accDto);
            RoleDAO roleDAO = new RoleDAO();
            List<RoleDTO> roleList = roleDAO.getAllRole();
            for (RoleDTO roleDTO : roleList) {
                if (roleDTO.getDescription().equals(role)) {
                    accDto.setRole(roleDTO.getRoleID());
                    if (roleDTO.getDescription().equals("ADMIN")) {
                        url = ADMIN;
                    } 
                    HttpSession session = request.getSession();
                    session.setAttribute("ACCOUNT", accDto);
                }
            }
            if (role.equals("failed")) {
                url = INVALID;
                request.setAttribute("INVALID", "Wrong UserID or Password, try again!");
                request.getRequestDispatcher(url).forward(request, response);
            }
            
        } catch (SQLException | NamingException e) {
            log("Error at LoginController" + e.getMessage());
        } finally {
            System.out.println("Sang ");
            response.sendRedirect(url);
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sangnv.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sangnv.daos.DiscountDAO;
import sangnv.daos.OrderDAO;
import sangnv.dtos.BookDTO;
import sangnv.dtos.CartDTO;
import sangnv.dtos.OrderDTO;

/**
 *
 * @author Shang
 */
public class ConfirmCartController extends HttpServlet {

    private static final String SUCCESS = "LoadController";
    private static final String FAIL = "viewcart.jsp";

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
            HttpSession session = request.getSession();
            CartDTO cart = (CartDTO) session.getAttribute("CART");
            if (cart != null) {
                if (cart.getCart().size() > 0) {
                    List<BookDTO> listDetail = cart.getCartDetail();
                    
                    boolean checkValidCart = cart.checkValidConfirm(listDetail);
//                    boolean checkValidCart = false;
                    
                    String customerName = cart.getCustomerName();
                    float subtotal = cart.getTotal();
                    OrderDTO orderDTO = new OrderDTO(customerName, subtotal);
                    OrderDAO orderDAO = new OrderDAO();
                    
                    if (checkValidCart) {

                        boolean checkOrder = orderDAO.confirmOrder(orderDTO);
                        if (checkOrder) {
                            int orderID = orderDAO.getOrderID(customerName);
                            if (orderID != -1) {
                                if (cart.getDiscountCode() != null) {
                                    DiscountDAO discountDAO = new DiscountDAO();
                                    boolean checkDiscount = discountDAO.applyDiscount(customerName, cart.getDiscountCode());
                                    if (!checkDiscount) {
                                        request.setAttribute("FAIL", "Code was already used! you just miss, try another code");
                                    }
                                }
                                int[] checkDetail = orderDAO.storeDetail(listDetail, orderID);
                                url = SUCCESS;
                                request.setAttribute("SUCCESS", "Order Successed, your Order ID is: #" + orderID);
                                session.removeAttribute("CART");
                            } else {
                                request.setAttribute("FAIL", "Can't find your Cart!");
                            }
                        } else {
                            request.setAttribute("FAIL", "Too many connection, try again!");
                        }
                        
                    }else{
                        request.setAttribute("FAIL", "Some book out of stock or be deleted ! Try again !");
                    }
                        
                } else {
                    request.setAttribute("FAIL", "Empty Cart, please add book");
                }
            } else {
                request.setAttribute("FAIL", "Cart not found!");
            }

        } catch (Exception e) {
            log("Error at ConfirmCartController : " + e.getMessage());
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

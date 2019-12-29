/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sangnv.filters;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import sangnv.daos.CateDAO;
import sangnv.daos.DiscountDAO;
import sangnv.daos.OrderDAO;
import sangnv.daos.RoleDAO;
import sangnv.dtos.AccountDTO;
import sangnv.dtos.CateDTO;
import sangnv.dtos.DiscountDTO;
import sangnv.dtos.OrderDTO;
import sangnv.dtos.RoleDTO;

/**
 *
 * @author Shang
 */
public class FilterDispatcher implements Filter {

    private static final String LOGIN = "login.jsp";
    private static final String LOAD = "LoadController";
    private static final boolean debug = true;
    private static List<String> ADMIN;
    private static List<String> CUSTOMER;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public FilterDispatcher() {
        ADMIN = new ArrayList<>();
        //ADMIN Controller
        ADMIN.add("InsertBookController");
        ADMIN.add("UpdateBookController");
        ADMIN.add("DeleteBookController");
        ADMIN.add("EditController");
        ADMIN.add("AdminHistoryController");
        ADMIN.add("AdminLoadController");
        ADMIN.add("AdminSearchController");
        ADMIN.add("DetailHistoryController");
        ADMIN.add("EditBookController");
        ADMIN.add("InsertCodeController");

        ADMIN.add("admin.jsp");
        ADMIN.add("admin_detailHistory.jsp");
        ADMIN.add("admin_editBook.jsp");
        ADMIN.add("admin_history.jsp");
        ADMIN.add("admin_insertCode.jsp");

        CUSTOMER = new ArrayList<>();
        CUSTOMER.add("ConfirmCartController");
        CUSTOMER.add("ApplyDiscountController");
        CUSTOMER.add("AddCartController");
        CUSTOMER.add("RemoveCartController");
        CUSTOMER.add("UpdateCartController");
        CUSTOMER.add("viewcart.jsp");

    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("FilterDispatcher:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("FilterDispatcher:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        String uri = req.getRequestURI();
        System.out.println(uri);
        String url = LOAD;
        try {
            int lastIndex = uri.lastIndexOf("/");
            String resource = uri.substring(lastIndex + 1);

            if (resource.length() > 0) {
                if (resource.equals("admin_insertBook.jsp")) {
                    CateDAO cateDAO = new CateDAO();
                    try {
                        List<CateDTO> listCate = cateDAO.getAllCate();
                        request.setAttribute("CATES", listCate);
                    } catch (NamingException | SQLException ex) {
                        log("Error at FilterDispather : " + ex.getMessage());
                    }
                }
                if (resource.equals("admin_history.jsp")) {
                    OrderDAO orderDAO = new OrderDAO();
                    List<OrderDTO> listOrder;
                    try {
                        listOrder = orderDAO.getAllOrder();
                        request.setAttribute("ORDERS", listOrder);
                    } catch (NamingException | SQLException ex) {
                        log("Error at FilterDispatcher: " + ex.getMessage());
                    }

                }
                if (resource.equals("admin_insertCode.jsp")) {
                    DiscountDAO discountDAO = new DiscountDAO();
                    List<DiscountDTO> listDiscount;
                    try {
                        listDiscount = discountDAO.getAvailableDiscounts();
                        request.setAttribute("DISCOUNTS", listDiscount);
                    } catch (SQLException | NamingException e) {
                        log("Error at FilterDispatcher : " + e.getMessage());
                    }
                }
                if (resource.equals("admin_createAccount.jsp")) {
                    RoleDAO roleDAO = new RoleDAO();
                    try {
                        List<RoleDTO> listRole = roleDAO.getAllRole();
                        request.setAttribute("ROLES", listRole);
                    } catch (NamingException | SQLException ex) {
                        log("Error at FilterDispatcher : " + ex.getMessage());
                    }

                }
                if (resource.lastIndexOf(".jsp") > 0 || resource.lastIndexOf(".css") > 0 || resource.lastIndexOf(".js") > 0 || resource.lastIndexOf(".jpg") > 0) {
                    url = null;
                } else {
                    url = resource + "Controller";
                }
            }
//

            //checkRole
            HttpSession session = req.getSession();
            AccountDTO user = (AccountDTO) session.getAttribute("ACCOUNT");
            if (user != null) {
                int role = user.getRole();
                if (ADMIN.contains(url) || ADMIN.contains(resource)) {
                    if (role != 0) {
                        url = LOAD;
                    }
                } else if (CUSTOMER.contains(url) || CUSTOMER.contains(resource)) {
                    if (role != 1) {
                        url = LOAD;
                    }
                }
            } else if (ADMIN.contains(url) || ADMIN.contains(resource) || CUSTOMER.contains(url) || CUSTOMER.contains(resource)) {
                url = LOAD;
            }

            if (url != null) {
                req.getRequestDispatcher(url).forward(request, response);
            } else {
                chain.doFilter(request, response);
            }
            System.out.println("Trai ");
        } catch (IOException | ServletException e) {
            log("Error at Filter" + e.getMessage());
        }

    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("FilterDispatcher:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("FilterDispatcher()");
        }
        StringBuffer sb = new StringBuffer("FilterDispatcher(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}

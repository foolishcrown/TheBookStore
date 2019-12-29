<%-- 
    Document   : admin
    Created on : Nov 25, 2019, 8:09:09 AM
    Author     : Shang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert Code</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminview.css"/>
        <link rel="stylesheet" href="css/tableview.css"/>
        <style>
            .active{
                color: white;
            }

        </style>
    </head>
    <body>
        <div class="sidebar">
            <a><font color="white"><h3>Admin ${sessionScope.ACCOUNT.userID}</h3></font></a>
                <c:url var="LinkLoad" value="AdminLoad" />
            <a href="${LinkLoad}"  ><i class="fa fa-fw fa-home"></i> Book Manage</a>
            <a href="admin_insertBook.jsp"><i class="fa fa-fw fa-wrench"></i> Insert Book</a>
            <a href="admin_insertCode.jsp" class="active"><i class="fa fa-fw fa-wrench "></i> Insert Code Discount</a>
            <a href="admin_history.jsp"><i class="fa fa-fw fa-wrench"></i> Shopping History</a>
            <a href="admin_createAccount.jsp" ><i class="fa fa-fw fa-wrench"></i> Create Account</a>
            <c:url var="LogoutLink" value="Logout"/>
            <a href="${LogoutLink}"><i class="fa fa-sign-out"></i> Logout</a>
        </div>
        <div id="Customer" class="main">
            <h1>Discount Code Creator</h1>

            <br/>
            <form action="InsertCode" method="Post">

                <table border="1">

                    <tbody>
                        <tr>
                            <th>New Code:</th>
                            <td><input id="code" name="txtCode" required="" type="text" pattern="[A-Za-z0-9]{6}" oninvalid="this.setCustomValidity('You must have 6 char (A-Z), (a-z), (0-9)')" onchange="this.setCustomValidity('')" /></td>
                        </tr>
                        <tr>
                            <th>Percent(%) Discount :</th>
                            <td><select name="cboPercent">
                                    <option value="0.2">20%</option>
                                    <option value="0.3">30%</option>
                                    <option value="0.5">50%</option>
                                    <option value="0.7">70%</option>
                                    <option value="0.8">80%</option>
                                    <option value="0.9">90%</option>
                                </select></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><button>Insert new</button></td>
                        </tr>
                    </tbody>
                </table>

                <br/>
            </form>
            
           <c:if test="${requestScope.DISCOUNTS != null}">
                <c:if test="${not empty requestScope.DISCOUNTS}" var="checkEmpty">

                    <table border="1">
                        <thead>
                            <tr>
                                <th>NO</th>
                                <th>Code</th>
                                <th>Values</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                            <c:forEach items="${requestScope.DISCOUNTS}" var="dto" varStatus="counter">
                            <tr>
                                <td>${counter.count}</td>
                                <td>${dto.code}</td>
                                <td>${dto.value}</td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    
                </c:if>
                <c:if test="${!checkEmpty}">
                    <font color="red">Empty</font>
                </c:if>
            </c:if>
        </div>



    </body>
</html>

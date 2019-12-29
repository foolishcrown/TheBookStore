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
        <title>Order Detail</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminview.css"/>
        <link rel="stylesheet" href="css/tableview.css"/>

    </head>
    <body>
        <div class="sidebar">
            <a><font color="white"><h3>Admin ${sessionScope.ACCOUNT.userID}</h3></font></a>
                <c:url var="LinkLoad" value="AdminLoad" />
            <a href="${LinkLoad}"  ><i class="fa fa-fw fa-home"></i> Order History</a>
            <a href="admin_insertBook.jsp"><i class="fa fa-fw fa-wrench"></i> Insert Book</a>
            <a href="admin_insertCode.jsp"><i class="fa fa-fw fa-wrench "></i> Insert Code Discount</a>
            <a href="admin_history.jsp"  class="active"><i class="fa fa-fw fa-wrench"></i> Shopping History</a>
            <a href="admin_createAccount.jsp" ><i class="fa fa-fw fa-wrench"></i> Create Account</a>
            <c:url var="LogoutLink" value="Logout"/>
            <a href="${LogoutLink}"><i class="fa fa-sign-out"></i> Logout</a>
        </div>
        <div id="Customer" class="main">
            <h1>Order History</h1>

            <br/>
            <c:if test="${requestScope.DETAILS != null}">
                <c:if test="${not empty requestScope.DETAILS}" var="checkEmpty">

                    <table border="1">
                        <thead>
                            <tr>
                                <th>BookID</th>
                                <th>BookName</th>
                                <th>Amount</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach items="${requestScope.DETAILS}" var="dto" varStatus="total">
                                <tr>
                                    <td>${dto.bookID}</td>
                                    <td>${dto.bookName}</td>
                                    <td>${dto.amount}</td>
                                    <td>${dto.price}</td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <th colspan="3" style="text-align: right">Total: </th>
                                <th>${requestScope.ORDER.subtotal}</th>
                            </tr>
                        </tbody>

                    </table>


                </c:if>
                <c:if test="${!checkEmpty}">
                    <font color="red">Not Found</font>
                </c:if>
            </c:if>
            <c:url var="LinkBack" value="AdminHistorySearch">
                <c:param name="txtSearch" value="${param.txtSearch}"/>
                <c:param name="txtDate" value="${param.txtDate}"/>
            </c:url>
            <a href="${LinkBack}"><< Back</a>
        </div>
        <script>
            /* When the user clicks on the button, 
             toggle between hiding and showing the dropdown content */
            function myFunction1() {
                document.getElementById("myDropdown1").classList.toggle("show");
                document.getElementById("myDropdown2").classList.remove("show");

            }
            function myFunction2() {
                document.getElementById("myDropdown2").classList.toggle("show");
                document.getElementById("myDropdown1").classList.remove("show");

            }

// Close the dropdown if the user clicks outside of it
            window.onclick = function (e) {
                if (!e.target.matches('.dropbtn')) {
                    var myDropdown1 = document.getElementById("myDropdown1");
                    var myDropdown2 = document.getElementById("myDropdown2");

                    if (myDropdown1.classList.contains('show')) {
                        myDropdown1.classList.remove('show');
                    }
                    if (myDropdown2.classList.contains('show')) {
                        myDropdown2.classList.remove('show');
                    }

                }

                if (e.target === msg) {
                    msg.style.display = "none";
                }
            }

        </script>

    </body>
</html>

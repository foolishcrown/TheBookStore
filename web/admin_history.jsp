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
        <title>Order History</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminview.css"/>
        <link rel="stylesheet" href="css/tableview.css"/>
        <style>

            .navbar {
                overflow: hidden;
                background-color: #333;
                font-family: Arial, Helvetica, sans-serif;
            }

            .navbar a {
                float: left;
                font-size: 16px;
                color: white;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;
            }
            .navbar .button{
                float: right;
            }

            .dropdown {
                float: left;
                overflow: hidden;
            }

            .dropdown .dropbtn {
                cursor: pointer;
                font-size: 16px;  
                border: none;
                outline: none;
                color: white;
                padding: 14px 16px;
                background-color: inherit;
                font-family: inherit;
                margin: 0;
            }

            .navbar a:hover, .dropdown:hover .dropbtn, .dropbtn:focus {
                background-color: red;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f9f9f9;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            }

            .dropdown-content a {
                float: none;
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                text-align: left;
            }

            .dropdown-content a:hover {
                background-color: #ddd;
            }

            .show {
                display: block;
            }

            .sidebar a .active{
                color: white;
            }

            input[type=date] {
                -moz-appearance:textfield;
                width: 50%;
            }

            input::-webkit-outer-spin-button,
            input::-webkit-inner-spin-button {
                -webkit-appearance: none;
            }


        </style>
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
            <div class="navbar" id="navbar">

                <div class="dropdown">
                    <button class="dropbtn" onclick="myFunction1()">Search by UserID
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div class="dropdown-content " id="myDropdown1">
                        <form action="AdminHistorySearch" method="POST">
                            <a>
                                UserID: <input class="dropbtn" style="background-color: white; color: black" type="text" name="txtSearch"/>
                            </a> 
                            <a><button class="dropbtn" style="background-color: green">Search</button></a>
                        </form>
                    </div>
                </div> 
                <div class="dropdown">
                    <button class="dropbtn" onclick="myFunction2()">Search by OrderDate
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div class="dropdown-content " id="myDropdown2">
                        <form action="AdminHistorySearch" method="POST">
                            <a>
                                Order Date: <input class="dropbtn" onkeydown="return false" style="background-color: white; color: black" type="date" name="txtDate" />
                            </a>  
                            <a><button class="dropbtn" style="background-color: green">Search</button></a>
                        </form>
                    </div>
                </div> 


            </div>
            <br/>
            <c:if test="${requestScope.ORDERS != null}">
                <c:if test="${not empty requestScope.ORDERS}" var="checkEmpty">

                    <table border="1">
                        <thead>
                            <tr>
                                <th>OrderID</th>
                                <th>Customer ID</th>
                                <th>Sub Total</th>
                                <th>Newest</th>
                                <th>View</th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach items="${requestScope.ORDERS}" var="dto" >
                                <tr>
                                    <td>${dto.orderID}</td>
                                    <td>${dto.userID}</td>
                                    <td>${dto.subtotal}</td>
                                    <td>${dto.orderDate}</td>
                                    <td>
                                        <c:url var="LinkView" value="DetailHistory">
                                            <c:param name="orderID" value="${dto.orderID}"/>
                                            <c:param name="txtSearch" value="${param.txtSearch}"/>
                                            <c:param name="txtDate" value="${param.txtDate}"/>
                                        </c:url>
                                        <a href="${LinkView}">View Detail</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot style="text-align: left">
                            <tr>
                                <th>OrderID</th>
                                <th>Customer ID</th>
                                <th>Sub Total</th>
                                <th>Oldest</th>
                                <th>

                                </th>
                            </tr>
                        </tfoot>
                    </table>


                </c:if>
                <c:if test="${!checkEmpty}">
                    <font color="red">Not Found</font>
                </c:if>
            </c:if>
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

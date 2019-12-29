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
        <title>Create Account</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminview.css"/>
        <link rel="stylesheet" href="css/tableview.css"/>
        <link rel="stylesheet" href="css/loginpage.css"/>
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
            <a href="admin_insertCode.jsp" ><i class="fa fa-fw fa-wrench "></i> Insert Code Discount</a>
            <a href="admin_history.jsp"><i class="fa fa-fw fa-wrench"></i> Shopping History</a>
            <a href="admin_createAccount.jsp" class="active"><i class="fa fa-fw fa-wrench"></i> Create Account</a>
            <c:url var="LogoutLink" value="Logout"/>
            <a href="${LogoutLink}"><i class="fa fa-sign-out"></i> Logout</a>
        </div>
        <div id="Customer" class="main">
            <h1>Discount Code Creator</h1>

            <br/>
            <form action="CreateAccount" method="Post">

                <table border="1">

                    <tbody>
                        <tr>
                            <th>UserID: </th>
                            <td> <font color="red"> ${param.FAIL} </font><input type="text" name="userID" required="" maxlength="50" /></td>
                        </tr>
                        <tr>
                            <th>Password: </th>
                            <td><input type="password" id="password" name="pass" required="" maxlength="50" /></td>
                        </tr>
                        <tr>
                            <th>Confirm: </th>
                            <td><input type="password" id="confirm-pass" name="confirm" required="" maxlength="50" /></td>
                        </tr>
                        <tr>
                            <th>Username: </th>
                            <td><input type="text" name="username" required="" maxlength="50" /></td>
                        </tr>
                        <tr>
                            <th>Role: </th>
                            <td>
                                <select name="cboRole">
                                    <c:if test="${requestScope.ROLES != null}">

                                        <c:forEach items="${requestScope.ROLES}" var="dto">
                                            <option value="${dto.roleID}" >${dto.description}</option>
                                        </c:forEach>

                                    </c:if>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th><button type="reset">Reset</button></th>
                            <th><button type="submit">Create</button></th>
                        </tr>
                    </tbody>
                </table>


                <br/>
            </form>


        </div>

        <script>
            var password = document.getElementById("password"), confirm = document.getElementById("confirm-pass");
            function validatePassword() {
                if (password.value !== confirm.value) {
                    confirm.setCustomValidity("Confirm must be match with Password!");
                } else {")
                    confirm.setCustomValidity("");
                }
            }
            password.onchange = validatePassword;
            confirm.onkeyup = validatePassword;
        </script>

    </body>
</html>

<%-- 
    Document   : admin_viewuser
    Created on : Dec 9, 2019, 4:59:46 PM
    Author     : Shang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>List User</h1>
        <c:if test="${requestScope.USERS != null}">
            <c:if test="${not empty requestScope.USERS}" var="check">
                <table border="1">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>UserID</th>
                            <th>Username</th>
                            <th>Role</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.USERS}" var="dto" varStatus="counter">

                            <tr>
                                <td>${counter.count}</td>
                                <td>${dto.userID}</td>
                                <td>${dto.username}</td>
                                <td>${dto.role}</td>
                            </tr>    
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${!check}">
                EMpty List
            </c:if>
        </c:if>

    </body>
</html>

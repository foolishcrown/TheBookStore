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
        <title>Book Infor.</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminview.css"/>
        <link rel="stylesheet" href="css/tableview.css"/>
        <link rel="stylesheet" href="css/loginpage.css"/>
        <style>
            [type="file"] {
                border: 0;
                clip: rect(0, 0, 0, 0);
                height: 1px;
                overflow: hidden;
                padding: 0;
                position: absolute !important;
                white-space: nowrap;
                width: 1px;
            }

            [type="file"] + label {
                background-color: #000;
                border-radius: 4rem;
                color: #fff;
                cursor: pointer;
                display: inline-block;
                padding-left: 2rem 4rem;
            }

            [type="file"]:focus + label,
            [type="file"] + label:hover {
                background-color: #4CAF50;
            }

            [type="file"]:focus + label {
                outline: 1px dotted #000;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <a><font color="white"><h3>Admin ${sessionScope.ACCOUNT.userID}</h3></font></a>
                <c:url var="LinkLoad" value="AdminLoad" />
            <a href="${LinkLoad}"  ><i class="fa fa-fw fa-home"></i> Book Manage</a>
            <a href="admin_insertBook.jsp" class="active"><i class="fa fa-fw fa-wrench"></i> Insert Book</a>
            <a href="admin_insertCode.jsp"><i class="fa fa-fw fa-wrench"></i> Insert Code Discount</a>
            <a href="admin_history.jsp"  ><i class="fa fa-fw fa-wrench"></i> Shopping History</a>
            <a href="admin_createAccount.jsp" ><i class="fa fa-fw fa-wrench"></i> Create Account</a>
            <c:url var="LogoutLink" value="Logout"/>
            <a href="${LogoutLink}"><i class="fa fa-sign-out"></i> Logout</a>
        </div>
        <div id="Customer" class="main">
            <h1>Book Manager</h1>

            <br/>
            <c:url var="LinkBack" value="AdminSearch">
                <c:param name="txtSearch" value="${param.txtSearch}"/>
                <c:param name="cboRange" value="${param.cboRange}"/>
                <c:param name="cboCate" value="${param.cboCate}"/>
            </c:url>
            <a href="${LinkBack}"><< Back</a>
            <br/>

            <form action="UpdateBook" method="POST">

                <table border="1">
                    <thead>
                        <tr>
                            <th><img src="${pageContext.request.contextPath}/images/${requestScope.BOOK.image}" width="150" />
                                <input type="hidden" value="${requestScope.BOOK.image}" name="oldImage"/>
                            </th>
                            <th><input type="file" name="txtImage"  id="file" class="inputfile"/>
                                <label for="file">Choose a picture</label></th>

                        </tr>


                        <tr>
                            <th>BookID:</th>
                            <td><input type="text" name="txtBookID" value="${requestScope.BOOK.bookID}" maxlength="50"  readonly=""/></td>
                        </tr>
                        <tr>
                            <th>Title:</th>
                            <td><input type="text" name="txtTitle" value="${requestScope.BOOK.title}" maxlength="100"  required=""/></td>
                        </tr>
                        <tr>
                            <th>Price:</th>
                            <td><input type="number" name="txtPrice"  max="1000000000" value="${requestScope.BOOK.price}" required="" min="0" step="0.01"/> &dstrok;</td>
                        </tr>
                        <tr>
                            <th>Author:</th>
                            <td><input type="text" name="txtAuthor" value="${requestScope.BOOK.author}" maxlength="50" required="" /></td>
                        </tr>
                        <tr>
                            <th>Category</th>
                            <td><select name="cboCate">
                                    <c:forEach items="${requestScope.CATES}" var="dto">
                                        <option value="${dto.cateID}" <c:if test="${requestScope.BOOK.cate == dto.cateID}">selected=""</c:if> >${dto.cateName}</option>
                                    </c:forEach>
                                </select></td>
                        </tr>
                        <tr>
                            <th>Stock</th>
                            <td><input type="number" min="0" value="${requestScope.BOOK.stock}" required="" name="txtStock"/></td>
                        </tr>
                        <tr>
                            <th>Description:</th>
                            <td><textarea name="txtDescription">${requestScope.BOOK.description}</textarea></td>
                        </tr>
                        <tr>
                            <th></th>
                            <td><button type="submit">Update</button></td>
                        </tr>

                    </thead>
                </table>



            </form>
        </div>

    </body>
</html>

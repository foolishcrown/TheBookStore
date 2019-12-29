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
        <title>Admin Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminview.css"/>
        <link rel="stylesheet" href="css/tableview.css"/>
        <link rel="stylesheet" href="css/insertform.css"/>
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



        </style>
    </head>
    <body>
        <div class="sidebar">
            <a><font color="white"><h3>Admin ${sessionScope.ACCOUNT.userID}</h3></font></a>
                <c:url var="LinkLoad" value="AdminLoad" />
            <a href="${LinkLoad}" class="active" ><i class="fa fa-fw fa-home "></i> Book Manage</a>
            <a href="admin_insertBook.jsp"><i class="fa fa-fw fa-wrench"></i> Insert Book</a>
            <a href="admin_insertCode.jsp"><i class="fa fa-fw fa-wrench"></i> Insert Code Discount</a>
            <a href="admin_history.jsp"><i class="fa fa-fw fa-wrench"></i> Shopping History</a>
            <a href="admin_createAccount.jsp" ><i class="fa fa-fw fa-wrench"></i> Create Account</a>
            <a href="ListUser"> List All User</a>
            <c:url var="LogoutLink" value="Logout"/>
            <a href="${LogoutLink}"><i class="fa fa-sign-out"></i> Logout</a>
        </div>
        <div id="Customer" class="main">
            <h1>Book Manager</h1>
            <div class="navbar" id="navbar">

                <div class="dropdown">
                    <button class="dropbtn" onclick="myFunction1()">Search by title
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div class="dropdown-content " id="myDropdown1">
                        <form action="AdminSearch" method="POST">
                            <a>
                                Book Name: <input class="dropbtn" style="background-color: white; color: black" type="text" name="txtSearch"/>
                            </a> 
                            <a><button class="dropbtn" style="background-color: green">Search</button></a>
                        </form>
                    </div>
                </div> 
                <div class="dropdown">
                    <button class="dropbtn" onclick="myFunction2()">Search by Price
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div class="dropdown-content " id="myDropdown2">
                        <form action="AdminSearch" method="POST">
                            <a>
                                Price Range: <select class="dropbtn" style="background-color: white; color: black" name="cboRange">
                                    <option value="All"></option>
                                    <option value="<15" > Below 15.000&dstrok;</option>
                                    <option value="15to30"> From 15.000&dstrok; to  30.000&dstrok;</option>
                                    <option value="30to50"> From 30.000&dstrok; to  50.000&dstrok;</option>
                                    <option value=">50"> More than 50.000&dstrok;</option>
                                </select>
                            </a>
                            <a><button class="dropbtn" style="background-color: green">Search</button></a>
                        </form>
                    </div>
                </div> 
                <div class="dropdown">
                    <button class="dropbtn" onclick="myFunction3()">Search by Category
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div class="dropdown-content " id="myDropdown3">
                        <form action="AdminSearch" method="POST">
                            <a>
                                Category: <select class="dropbtn" style="background-color: white; color: black" name="cboCate">
                                    <option value="All"></option>
                                    <c:forEach items="${requestScope.CATES}" var="dto">
                                        <option value="${dto.cateID}">${dto.cateName}</option>
                                    </c:forEach>
                                </select>
                            </a>
                            <a><button class="dropbtn" style="background-color: green">Search</button></a>
                        </form>
                    </div>
                </div> 

            </div>

            <br/>
            <c:if test="${requestScope.BOOKS != null}">
                <c:if test="${not empty requestScope.BOOKS}" var="checkEmpty">
                    <div style="overflow-y: auto">
                        <table border="1">


                            <thead style="background-color: grey; color: white;">
                                <tr>
                                    <th>NO.</th>
                                    <th>Image</th>
                                    <th>Title</th>
                                    <th>Author</th>
                                    <th>Category</th>
                                    <th>Stock</th>
                                    <th>Price</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach items="${requestScope.BOOKS}" var="dto" varStatus="counter">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td><img src="${pageContext.request.contextPath}/images/${dto.image}" width="100" height="100" /></td>
                                        <td>${dto.title}</td>
                                        <td>${dto.author}</td>
                                        <td>
                                            <c:forEach items="${requestScope.CATES}" var="cate">
                                                <c:if test="${dto.cate == cate.cateID}">
                                                    ${cate.cateName}
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>${dto.stock}</td>
                                        <td>${dto.price}&dstrok;</td>
                                        <td>
                                            <c:url var="LinkEdit" value="EditBook">
                                                <c:param name="bookID" value="${dto.bookID}" />
                                                <c:param name="txtSearch" value="${param.txtSearch}" />
                                                <c:param name="cboRange" value="${param.cboRange}" />
                                                <c:param name="cboCate" value="${param.cboCate}" />
                                            </c:url>
                                            <a href="${LinkEdit}" style="text-decoration: none">View more</a>
                                        </td>
                                        <td>
                                            <c:url var="LinkDelete" value="DeleteBook">
                                                <c:param name="bookID" value="${dto.bookID}" />
                                                <c:param name="txtSearch" value="${param.txtSearch}" />
                                                <c:param name="cboRange" value="${param.cboRange}" />
                                                <c:param name="cboCate" value="${param.cboCate}" />
                                            </c:url>
                                            <a href="" onclick="confirmDelete(this, '${LinkDelete}')" style="text-decoration: none"><h1 style="color: red">&times;</h1></a>
                                            <script>
                                                function confirmDelete(link, address) {
                                                    var isDelete = confirm("Do you want to remove ?");
                                                    if (isDelete === true) {
                                                        link.href = address;
                                                        link.onclick = "";
                                                        link.click();
                                                    }
                                                }
                                            </script>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                    </div>

                </c:if>
                <c:if test="${!checkEmpty}">
                    <font color="red">Not Found, please insert more</font>
                </c:if>
            </c:if>
        </div>

        <div id="myMessage" class="modal" >
            <div class="modal-content" style="text-align: center">

                <span class="close">&times;</span>
                <br/>

                <h2 style="color: green" >${requestScope.SUCCESS}</h2>
                <h2 style="color: red" >${requestScope.FAIL}</h2>


            </div>
        </div>
        <!--popupMesage-->
        <script>

            var msg = document.getElementById("myMessage");
// Get the <span> element that closes the modal
            var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 

// When the user clicks on <span> (x), close the modal

            span.onclick = function () {
                msg.style.display = "none";
            };


// When the user clicks anywhere outside of the modal, close it

            <c:if test="${requestScope.SUCCESS != null || requestScope.FAIL != null}">
            msg.style.display = "block";
            </c:if>
        </script>

        <script>
            /* When the user clicks on the button, 
             toggle between hiding and showing the dropdown content */
            function myFunction1() {
                document.getElementById("myDropdown1").classList.toggle("show");
                document.getElementById("myDropdown2").classList.remove("show");
                document.getElementById("myDropdown3").classList.remove("show");
            }
            function myFunction2() {
                document.getElementById("myDropdown2").classList.toggle("show");
                document.getElementById("myDropdown1").classList.remove("show");
                document.getElementById("myDropdown3").classList.remove("show");
            }
            function myFunction3() {
                document.getElementById("myDropdown3").classList.toggle("show");
                document.getElementById("myDropdown1").classList.remove("show");
                document.getElementById("myDropdown2").classList.remove("show");
            }

// Close the dropdown if the user clicks outside of it
            window.onclick = function (e) {
                if (!e.target.matches('.dropbtn')) {
                    var myDropdown1 = document.getElementById("myDropdown1");
                    var myDropdown2 = document.getElementById("myDropdown2");
                    var myDropdown3 = document.getElementById("myDropdown3");
                    if (myDropdown1.classList.contains('show')) {
                        myDropdown1.classList.remove('show');
                    }
                    if (myDropdown2.classList.contains('show')) {
                        myDropdown2.classList.remove('show');
                    }
                    if (myDropdown3.classList.contains('show')) {
                        myDropdown3.classList.remove('show');
                    }
                }

                if (e.target === msg) {
                    msg.style.display = "none";
                }
            }

        </script>

    </body>
</html>

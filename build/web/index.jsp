<%-- 
    Document   : index
    Created on : Nov 24, 2019, 5:18:47 PM
    Author     : Shang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sang Sảng Sách Shop (4S)</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/insertform.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/loginpage.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tableview.css"/>
        <!--<link rel="stylesheet" href="${pageContext.request.contextPath}/css/nav.css"/>-->
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

            .sticky {
                position: fixed;
                top: 0;
                width: 100%;

            }

        </style>

    </head>
    <body>
        <h3 style="background-color: black; color: white; text-align: center">Thích TV thì đến điện máy xanh, thích sách thì đến nhà anh cho lành <3</h3>
        <div class="navbar" id="navbar">
            <a href="Load">Home</a>
            <div class="dropdown">
                <button class="dropbtn" onclick="myFunction1()">Search by title
                    <i class="fa fa-caret-down"></i>
                </button>
                <div class="dropdown-content " id="myDropdown1">
                    <form action="Search" method="POST">
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
                    <form action="Search" method="POST">
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
                    <form action="Search" method="POST">
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
            <a class="button" <c:if test="${sessionScope.ACCOUNT != null && sessionScope.ACCOUNT.role != 0}" var="checkLogin" >href="viewcart.jsp"</c:if><c:if test="${!checkLogin}">onclick="showForm()"</c:if>>View your Cart</a>
            <c:if test="${sessionScope.ACCOUNT != null}" var="checkSession">
                <a class="button" href="Logout">${sessionScope.ACCOUNT.userID} ,Logout</a>
            </c:if>
            <c:if test="${!checkSession}">
                <a class="button" href="#" onclick="showForm()" >Login</a>
            </c:if>
        </div>


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
                                <th>Description</th>
                                <th>Add to Cart</th>
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
                                    <td>${dto.price}</td>
                                    <td style="vertical-align: top; width: 30% ">

                                        <c:if test="${dto.description.length() > 400}" var="checkLength">
                                            ${dto.description.substring(0,400)}...
                                        </c:if>
                                        <c:if test="${!checkLength}">
                                            ${dto.description}
                                        </c:if>

                                    </td>
                                    <td><c:url var="LinkAdd" value="AddCart">
                                            <c:param name="bookID" value="${dto.bookID}" />
                                            <c:param name="txtSearch" value="${param.txtSearch}" />
                                            <c:param name="cboRange" value="${param.cboRange}" />
                                            <c:param name="cboCate" value="${param.cboCate}" />
                                        </c:url>
                                        <a <c:if test="${sessionScope.ACCOUNT != null && sessionScope.ACCOUNT.role != 0}" var="checkLogin" >href="${LinkAdd}"</c:if><c:if test="${!checkLogin}">onclick="showForm()"</c:if>><button>Add</button></a>
                                        </td>
                                    </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                </div>
            </c:if>
            <c:if test="${!checkEmpty}">
                <h4  style="color: red ;text-align: center">Chủ tiệm chưa cập nhập sách, mấy em thông cảm nghe hôn.</h4>
            </c:if>
        </c:if>


        <!--LoginModal-->
        <div id="myModal" class="modal">
            <div class="modal-content">

                <span class="close">&times;</span>
                <br/>   
                <h3>Login</h3>
                <h5 style="color: red">${requestScope.INVALID}</h5>
                <form class="form" action="Login" method="POST">
                    <input id="userID" type="text" placeholder="User ID" name="userID"/><br/>
                    <input id="password" type="password" placeholder="Password" name="password"/><br/>
                    <button type="submit" value="Login">Login</button>
                </form>
            </div>
        </div>

        <div id="myMessage" class="modal" >
            <div class="modal-content" style="text-align: center">

                <span class="close">&times;</span>
                <br/>

                <h2 style="color: green" >${requestScope.SUCCESS}</h2>
                <h2 style="color: red" >${requestScope.FAIL}</h2>


            </div>
        </div>

    </div>
    <script>
        var modal = document.getElementById("myModal");
        var msg = document.getElementById("myMessage");
        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];
        var span2 = document.getElementsByClassName("close")[1];
        // When the user clicks the button, open the modal 
        function showForm() {
            modal.style.display = "block";
        }
        // When the user clicks on <span> (x), close the modal
        span.onclick = function () {
            modal.style.display = "none";
        };
        span2.onclick = function () {
            msg.style.display = "none";
        };


        // When the user clicks anywhere outside of the modal, close it

        <c:if test="${requestScope.INVALID != null}">
        modal.style.display = "block";
        </c:if>
        <c:if test="${requestScope.SUCCESS != null || requestScope.FAIL != null}">
        msg.style.display = "block";
        </c:if>
    </script>

    <!--nav-->
    <script>
        window.onscroll = function () {
            doSticky();
        };

        // Get the navbar
        var navbar = document.getElementById("navbar");

        // Get the offset position of the navbar
        var sticky = navbar.offsetTop;

        // Add the sticky class to the navbar when you reach its scroll position. Remove "sticky" when you leave the scroll position
        function doSticky() {
            if (window.pageYOffset >= sticky) {
                navbar.classList.add("sticky");
            } else {
                navbar.classList.remove("sticky");
            }
        }
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
            if (e.target === modal || e.target === msg) {
                modal.style.display = "none";
                msg.style.display = "none";
            }
        }

    </script>
</body>
</html>

<%-- 
    Document   : viewcart
    Created on : Nov 25, 2019, 2:46:21 PM
    Author     : Shang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Cart</title>
        <link rel="stylesheet" href="css/tableview.css"/>
        <link rel="stylesheet" href="css/insertform.css"/>
        <style>
            input[type=number] {
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
        <script type="text/javascript">

            function increase(btnID)
            {
                var txt = document.getElementById(btnID);
                var txtValue = txt.value - -1;
                if (txtValue > txt.max)
                    txtValue = txt.max;
                if (txtValue < txt.min)
                    txtValue = txt.min;
                txt.value = txtValue;
                document.getElementById("updateBtn").click();
            }
            function decrease(btnID)
            {
                var txt = document.getElementById(btnID);
                var txtValue = txt.value - 1;
                if (txtValue <= 0) {
                    txtValue = 1;
                }
                txt.value = txtValue;
                document.getElementById("updateBtn").click();
            }
            function contrainstTheValue(textBox)
            {
                var value = parseInt(textBox.value);
                // console.log(textBox.max);
                if (value > textBox.max)
                    value = textBox.max;
                if (value < textBox.min)
                    value = textBox.min;
                console.log("value" + value);
                textBox.value = value;

                if (textBox.value === value) {
                    document.getElementById("updateBtn").click();
                }

            }
        </script>
        <h1 style="background-color: black; color: white; text-align: center">${sessionScope.ACCOUNT.userID}'s cart.</h1>


        <br/><br/>
        <a href="Load"><button type="button"><h5>Continues to shopping</h5></button></a>
        <br/><br/>
        <br/><br/>

        <c:if test="${sessionScope.CART != null}">
            <c:if test="${not empty sessionScope.CART.getCartDetail()}" var="checkEmpty">
                <form action="UpdateCart" method="post">
                    <div style="overflow-x: auto">
                        <table border="1">
                            <thead>
                                <tr>
                                    <th>NO.</th>
                                    <th>Title</th>
                                    <th style="width: 12%;">Amount</th>
                                    <th>Price</th>
                                    <th>Total</th>
                                    <th>Remove</th>
                                </tr>
                            </thead>
                            <tbody>
                            <button id="updateBtn" style="display: none"></button>

                            <c:forEach items="${sessionScope.CART.getCartDetail()}" var="dto" varStatus="counter">
                                <tr>
                                    <td>${counter.count}</td>
                                    <td>
                                        ${dto.title}
                                        <input type="hidden" name="bookID" value="${dto.bookID}"/>

                                    </td>
                                    <td> <button type="button" onclick="decrease('${dto.bookID}');"><span>&blacktriangleleft;</span></button>
                                        <input id="${dto.bookID}" onchange="document.getElementById('updateBtn').click();" onkeydown="contrainstTheValue(this);" type="number" name="quantity" max="${dto.stock}" min="1" value="${dto.quantityCart}" />
                                        <button type="button" onclick="increase('${dto.bookID}')"><span>&blacktriangleright;</span></button></td>
                                    <td>${dto.price} &dstrok;</td>
                                    <td>${dto.quantityCart * dto.price} &dstrok;</td>
                                    <td>
                                        <c:url var="LinkDelete" value="RemoveCart">
                                            <c:param name="id" value="${dto.bookID}" />
                                        </c:url>
                                        <a href="" onclick="confirmDelete(this, '${LinkDelete}')" style="text-decoration: none; font-size: larger"><strong><span>&times;</span></strong></a></td>
                                </tr>
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
                            </c:forEach>
                            <tr>
                                <td></td>
                                <td colspan="3" style="text-align: right"><h3>BILL TOTAL:</h3></td>
                                <td><h4> ${sessionScope.CART.getTotal()} &dstrok;</h4></td>
                                <td></td>
                            </tr>
                            </tbody>
                        </table>

                    </div>
                </form>
                <form action="ApplyDiscount" method="POST">
                    <div style="overflow-x: auto">
                        <table border="1">
                            <thead>
                                <tr style="text-align: center">
                                    <th style="width: 50%">Discount Code: <input value="${param.discountCode}" name="discountCode" type="text" <c:if test="${sessionScope.CART.discount != 0}" var="isApplied">disabled=""</c:if> /><button <c:if test="${isApplied}">disabled=""</c:if>>Apply</button></th>
                                        <th style="width: 50%"><a href="ConfirmCart"><button type="button" >Confirm</button></a></th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </form>                

            </c:if>
            <c:if test="${!checkEmpty}">
                Empty cart!
            </c:if>
        </c:if>

        <div id="myMessage" class="modal" >
            <div class="modal-content" style="text-align: center">

                <span class="close">&times;</span>
                <br/>

                <h2 style="color: green" >${requestScope.SUCCESS}</h2>
                <h2 style="color: red" >${requestScope.FAIL}</h2>

            </div>
        </div>
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
            window.onclick = function (event) {
                if (event.target === msg) {
                    msg.style.display = "none";
                }
            };
            <c:if test="${requestScope.SUCCESS != null || requestScope.FAIL != null}">
            msg.style.display = "block";
            </c:if>
        </script>
    </body>
</html>

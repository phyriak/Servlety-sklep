<%--
  Created by IntelliJ IDEA.
  User: piotr
  Date: 28.01.2020
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="style.css" type="text/css"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="loginDiv">


    <%



        String user = (String) session.getAttribute("user");
        //String user = (String) request.getParameter("user");
        if (user != null) {
            out.print("<button onclick=\"location.href = 'wyloguj';\" id=\"myButton\" class=\" float:left  submit-button\" >LogOut</button>\n");
            out.print("User: " + user);
            out.print("<form action = \"showShoppingCart.jsp\" method=\"post\">" +
                    "<input id=\"myButton\" type=\"submit\" class=\"button\"value=\"shopping cart\"/></form>");

        } else out.print(" <div id=\"TopButtons\">\n" +
                "    <button onclick=\"location.href = 'login.jsp';\" id=\"myButton\" style=\" float:left  submit-button\" >Sign in</button>\n" +
                "    <button onclick=\"location.href = 'createUserAccount.jsp';\" id=\"myButton\" class=\" float:left  submit-button\" >Register</button>\n" +
                "    </div>\n" +
                "    <div style=\"clear: both\"></div>");

    %>


</div>
<div style="clear:both"></div>
</body>
</html>

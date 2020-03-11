<%--
  Created by IntelliJ IDEA.
  User: piotr
  Date: 19.01.2020
  Time: 15:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="style.css" type="text/css"/>
<html>
<head>
    <title>Zaloguj się do sklepu</title>
</head>
<body>
<%@include file="header.jsp"%>
<div class="login">
<form method="post" action="waliduj">
    Podaj swój login: <br/>
    <div style="float: left"><input type="text" name="user"/></div>


    <div style="clear: both"></div>


    Podaj swoje hasło: <br/>
    <div style="float: left"><input type="password" name="password"/></div>
    <div style="color: red; padding-left:10px; float: left">
        <%

            String message = (String) request.getAttribute("statusLogin");
            if (request.getAttribute("statusLogin") != null) {
                out.print(message);
            }
        %>
    </div>
    <div style="clear: both"></div>
    <input type="submit" value="Sign in">
    <br/>
</form>
Nie masz konta?
<br/>
<button onclick="location.href = 'createUserAccount.jsp';" id="myButton" class=" float:left submit-button" >Register</button>

</div>
<%@include file="footer.jsp"%>
</body>
</html>

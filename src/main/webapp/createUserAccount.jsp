<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%--
  Created by IntelliJ IDEA.
  User: piotr
  Date: 19.01.2020
  Time: 15:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<link rel="stylesheet" href="style.css" type="text/css"/>
<html>
<head>
    <title>Tworzenie nowego użytkownia</title>
    <%@include file="header.jsp" %>
</head>
<body>
<h2>Dodawanie nowego użytkownia </h2>


<form method="post" action="walidujNowegoUzytkownia">
    Podaj swój login: <br/>
    <div style="float: left"><input type="text" name="user"/></div>
    <div style="color: red; padding-left:10px; float: left">

        <%

            String message = (String) request.getAttribute("statusLogin");
            if (request.getAttribute("statusLogin") != null) {
                out.print(message);
            }
        %>

    </div>
    <div style="clear: both"></div>

    Podaj imie: <br/>
    <div style="float: left"><input type="text" name="firstName"/></div>
    <div style="clear: both"></div>

    Podaj nazwisko: <br/>
    <div style="float: left"><input type="text" name="lastName"/></div>
    <div style="clear: both"></div>

    Podaj miasto: <br/>
    <div style="float: left"><input type="text" name="city"/></div>
    <div style="clear: both"></div>

    Podaj kod pocztowy: <br/>
    <div style="float: left"><input type="text" name="code"/></div>
    <div style="clear: both"></div>

    Podaj ulice: <br/>
    <div style="float: left"><input type="text" name="street"/></div>
    <div style="clear: both"></div>

    Podaj numer domu: <br/>
    <div style="float: left"><input type="text" name="streetNumber"/></div>
    <div style="clear: both"></div>


    Podaj swoje hasło: <br/>
    <div style="float: left"><input type="password" name="password"/></div>
    <div style="color: red; padding-left:10px; float: left">

        <%

             message = (String) request.getAttribute("statusPassword");
            if (request.getAttribute("statusPassword") != null) {
                out.print(message);
            }
        %>

    </div>

    <div style="clear: both"></div>

    Powtórz hasło: <br/>
    <div style="float: left"><input type="password" name="passwordCheck"/></div>
    <div style="color: red; padding-left:10px; float: left">

        <%

            message = (String) request.getAttribute("statusPasswordChecked");
            if (request.getAttribute("statusPasswordChecked") != null) {
                out.print(message);
            }
        %>

    </div>
    <div style="clear: both"></div>
    <input type="submit" value="Register">
    <button type="button" onclick="location = 'login.jsp'">Preview</button>
    <%@include file="footer.jsp"%>
</form>
</body>
</html>

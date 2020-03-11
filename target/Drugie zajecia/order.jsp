<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Item" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: piotr
  Date: 19.01.2020
  Time: 21:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<link rel="stylesheet" href="style.css" type="text/css"/>
<html>
<head>
    <title>Order</title>
</head>
<body>
<%@include file="header.jsp" %>
<%@include file="loginDiv.jsp" %>

<%
    List<Item> koszyk = (List<Item>) session.getAttribute("shoppingCart");
    final String USER = "root";
    final String PASS = "mekzio10";
    final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    final String DB_URL = "jdbc:mysql://localhost:3306/sklep?serverTimezone=UTC";
    login = (String) session.getAttribute("user");
    double sum = 0;

    for (Item item : koszyk) {
        out.print("<p>" + item.getProduct() + ", quantity: " + item.getQuantity() + ", price: " + item.getPrice() + "</p>");
        sum += item.getQuantity() * item.getPrice();
    }

    out.print("</br>Total price : " + String.format("%.2f", sum));
    String category = request.getParameter("category");
    System.out.println("category: " + category);
    if (category == null)
        category = "all";
    String sort = request.getParameter("sort");
    if (sort == null)
        sort = "all";
    Statement stmt = null;
    ResultSet rs;
    String firtName = "";
    String lastName = "";
    String city = "";
    String code = "";
    String street = "";
    String streetNumber = "";
    rs = null;

    try {

        Class.forName(JDBC_DRIVER);
        Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
        stmt = conn.createStatement();
        String sql = "SELECT*FROM users WHERE login=\'" + login + "\'";
        rs = stmt.executeQuery(sql);
        rs.next();
        firtName = rs.getString("firstname");
        lastName = rs.getString("lastName");
        city = rs.getString("city");
        code = rs.getString("code");
        street = rs.getString("street");
        streetNumber = rs.getString("streetNumber");
    } catch (ClassNotFoundException cnfe) {
        System.out.println("!!!" + cnfe.getMessage());
    } catch (SQLException se) {
        System.out.println("@@@" + se.getMessage());
    }
%>

<c:set var="first" value="<%=firtName%>"/>
<c:set var="lastName" value="<%=lastName%>"/>
<div style="position:center;background-color: antiquewhite;padding-left: 600px" >
    <form action="newOrder" method="post">
        Your first name:<input type="text" class="textBox" name="firstName" value="${first}"><br/>
        Your last name :<input type="text" class="textBox" name="lastName" value="${last}"><br/>
        City: <input type="text" class="textBox" name="city" value="<%=city%>"><br/>
        City code:<input type="text" class="textBox" name="code" value="<%=code%>" width="6"><br/>
        Street address: <input type="text" class="textBox" name="street" value="<%=street%>"><br/>
        Street number: <input type="text" class="textBox" name="streetNumber" value="<%=streetNumber%>" width="8"><br/>
        Editional comment: <input type="text" class="textBox" name="comments"><br/>
        <input class="button" type="submit" title="Create order">
    </form>
</div>

</body>
<%@include file="footer.jsp" %>
</html>

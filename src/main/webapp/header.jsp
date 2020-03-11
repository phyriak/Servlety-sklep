<%--
  Created by IntelliJ IDEA.
  User: piotr
  Date: 22.01.2020
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Header</title>
</head>
<body>

<%
    String login="";
    login= (String) session.getAttribute("user");
%>

<div class="header">
    <h2>Witaj <% if(login!=null )out.print(login);%> w Gardenshop.pl</h2>
    <p>Życzymy udanych zakupów</p>
</div>

</body>
</html>

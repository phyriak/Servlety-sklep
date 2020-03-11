<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%--
  Created by IntelliJ IDEA.
  User: piotr
  Date: 18.01.2020
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>

<html>
<head>
    <title>SQL</title>
</head>
<body>

<sql:setDataSource var = "baza"
                   driver = "com.mysql.jdbc.Driver"
                   url = "jdbc:mysql://localhost:3306/sklep?serverTimezone=UTC"
                   user = "root" password = "mekzio10"/>
<sql:query dataSource = "${baza}" var = "result">
    SELECT * from users;
</sql:query>




<table style ="border:1px;" >
    <tr> <th>reg_number</th>
        <th>userNum</th>
        <th>login</th>
        <th>md5</th>
        <th>lastLogin</th>
    </tr>
    <c:forEach var = "row" items = "${result.rows}">
        <tr>
            <td><c:out value = "${row.userNum}"/></td>
            <td><c:out value = "${row.login}"/></td>
            <td><c:out value = "${row.md5}"/></td>
            <td><c:out value = "${row.lastLogin}"/></td>
        </tr>
    </c:forEach>
</table>

</body>
</html>

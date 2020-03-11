<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="static com.mysql.cj.x.protobuf.MysqlxCrud.Order.Direction.DESC" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page import="javax.servlet.http.Cookie" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: piotr
  Date: 27.01.2020
  Time: 13:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<html>
<head>
    <meta charset="windows-1250"/>
    <link rel="stylesheet" href="style.css" type="text/css"/>
    <title>Products</title>


</head>
<body>

<%@include file="header.jsp" %>
<%@include file="loginDiv.jsp" %>

<%
    out.print("<div class=\"container\">");
    final String USER = "root";
    final String PASS = "mekzio10";
    final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    final String DB_URL = "jdbc:mysql://localhost:3306/sklep?serverTimezone=UTC";
    ResultSet rs = null;
    Statement stmt = null;
    Connection conn = null;
    String sql = "SELECT*FROM products";

    String category = request.getParameter("category");
    String sort = request.getParameter("sort");
    String direction = request.getParameter("direction");


    if (category == null) {
        category = "all";
    }
    if (sort == null) {
        sort = "name";
    }
    if (direction == null) {
        direction = "DESC";
    }


    try {
        Class.forName(JDBC_DRIVER);
        conn = DriverManager.getConnection(DB_URL, USER, PASS);
        stmt = conn.createStatement();


        sql = "SELECT*FROM products";
        if (!category.equals("all"))
            sql = "SELECT*FROM products WHERE category=\'" + category + "\'";
        if (sort.equals("name")) {
            sql = sql + " ORDER BY " + sort;
            if (direction.equals("ASC")) {
                sql = sql + " ASC";
            } else sql = sql + " DESC";
        }
        if (sort.equals("price")) {
            sql = sql + " ORDER BY " + sort;
            if (direction.equals("ASC")) {
                sql = sql + " ASC";
            } else sql = sql + " DESC";
        }


        rs = stmt.executeQuery(sql);

        out.print("<div class=\"ad\">Advertisement");


        out.print("</div>");

        out.print("<div class=\"article\">");
        out.print("<form method=\"post\" action=\"products.jsp\">");
        out.print("Selected category:<select name=\"category\" class=\"textBox\">");
        if (category.equals("all"))
            out.print("  <option value=\"all\" selected>All</option>");
        else
            out.print("  <option value=\"all\">All</option>");
        if (category.equals("plants"))
            out.print("  <option value=\"plants\" selected>Plants</option>");
        else
            out.print("  <option value=\"plants\" >Plants</option>");
        if (category.equals("tools"))
            out.print("  <option value=\"tools\" selected>Tools</option>");
        else
            out.print("  <option value=\"tools\">Tools</option>");
        if (category.equals("fertilizersl"))
            out.print("  <option value=\"fertilizersl\" selected>Fertilizersl</option>");
        else
            out.print("  <option value=\"fertilizersl\">Fertilizersl</option>");
        if (category.equals("relax"))
            out.print("  <option value=\"relax\" selected>Relax</option>");
        else
            out.print("  <option value=\"relax\">Relax</option>");
        out.print("</select>");
        out.print("Order by: <select name=\"sort\" class=\"textbox\">");

        String[] values = new String[]{"name", "price"};
        for (String val : values)
            if (!sort.equals(val)) {
                out.print(" <option value=\"" + val + "\">" + val + "</option>");
            } else out.print(" <option value=\"" + val + "\"selected>" + val + "</option>");
        out.print("</select>");
        out.print("Sort type<select name=\"direction\" class=\"textbox\">");
        if (direction.equals("DESC")) {
            out.print("<option value=\"DESC\" selected>Malejaco</option>");
        } else out.print("<option value=\"DESC\">Malejaco</option>");
        if (direction.equals("ASC")) {
            out.print("<option value=\"ASC\" selected>Rosnaco</option>");
        } else out.print("<option value=\"ASC\">Rosnaco</option>");
        out.print("</select>");
        out.print("<input type=\"submit\" class=\"button\" value=\"update\">");
        out.print("</form>");


        out.println(
                "<table id=\"words\"><thead>" +
                        "    <tr>" +
                        "      <th>Product name</th>" +
                        "      <th>Product price</th>" +
                        "      <th>Product category</th>" +
                        "      <th>Product index</th>" +
                        "      <th>Image</th>" +
                        "      <th>Quantity</th>" +
                        "      <th></th>" +
                        "    </tr>\n" +
                        "  </thead>");

        int poprzedni=0;
        while (rs.next()) {
            String bgColor = "background-color: antiqewhite;";
            int rand = (int) (Math.random() * 2);

            if(rand==poprzedni) {
                rand++;
                rand=rand%2;
                poprzedni=rand;
            }
        else poprzedni=rand;

                switch(rand){
                    case 0:
                        bgColor = "background-color: antiqewhite;";
                        break;
                    case 1:
                        bgColor = "background-color: aliceblue;";
                        break;
                    default:
                        bgColor = "background-color: beige;";
                        break;


                }

            out.print("<tr style=\"" + bgColor + "\"><td>" +
                    rs.getString("name") +
                    "</td><td>" + rs.getDouble("price") +
                    "</td><td>" + rs.getString("category") +
                    "</td><td>" + rs.getInt("indexNum") +
                    "</td><td><img src=\"" + rs.getString("imageURL") + "\" width=\"120\" height=\"120\">" +
                    "</td><td><form action = \"addProduct.jsp\" method=\"post\">" +
                    "<input type =\"number\" name=\"quantity\" class=\"textBox\"/>" +
                    "<input type=\"hidden\" name=\"product\" value=\"" + rs.getInt("indexNum") + "\"/>" +
                    "<input type=\"hidden\" name=\"category\" value=\"" + category + "\"/>" +
                    "<input type=\"hidden\" name=\"sort\" value=\"" + sort + "\"/>" +
                    "<input type=\"hidden\" name=\"price\" value=\"" + rs.getDouble("price") + "\"/>" +
                    "<input type=\"submit\" value=\"add to cart\" class=\"button\"/></form>"+
                    "</td></tr>"
            );

        }
        out.print("</table>");

        out.print("</div>");
        out.print("<div class=\"ad\">" + "Advertisement" + "</div>");
        out.print("<div style=\"clear:both\"></div>");


    } catch (ClassNotFoundException cnfe) {
        System.out.println("Error: " + cnfe);
    } catch (SQLException se) {
        System.out.println("Error: " + se);
    }


    out.print("</div>");


%>
<%@include file="footer.jsp" %>

</body>
</html>

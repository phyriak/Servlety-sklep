<%@ page import="model.Item" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %><%--
  Created by IntelliJ IDEA.
  User: piotr
  Date: 19.01.2020
  Time: 21:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="style.css" type="text/css"/>
<html>
<head>
    <title>Shopping Cart</title>
</head>
<%@include file="header.jsp"%>
<%@include file="loginDiv.jsp" %>
<br/>


    <%
        List<Item> koszyk = (ArrayList<Item>)session.getAttribute("shoppingCart");
        double suma = 0;
        out.print("<table>");
        for(Item item : koszyk) {
            out.print(
                    "<tr>" +
                            "<td>" + item.getProduct() + "</td>" +
                            "<td> quantity: " + item.getQuantity() + "</td>" +
                            "<td> price: " + item.getPrice() + "</td>" +
                            "<td> " +
                            "<form action=\"deleteItem\" method=\"get\">" +
                            "<input type=\"hidden\" class=\"textBox\" name=\"productINDEX\" value=\"" + item.getProduct() + "\">" +

                            "<input type=\"hidden\" class=\"textBox\" name=\"productQuantity\" value=\"" + item.getQuantity() + "\">" +
                            "<input class=\"button\" type=\"submit\" value=\"USUŃ\"></form>" +
                            "</td>" +
                            "</tr>");
            suma += item.getQuantity()*item.getPrice();
        }
        out.print("</table>");
        out.print("<br/>Total price : " + String.format("%.2f", suma));
        Cookie[] ciastka = request.getCookies();
        //wyświetlenie ciasteczka o kluczu o wartości zalogowany użytkownik
        login = (String)session.getAttribute("user");
        for(Cookie cookie : ciastka) {
            if (cookie.getName().equals(login)) {
                String st = cookie.getValue();
                st = st.replace("^%", "\"");
                st = st.replace("!%", ",");
                Gson json = new Gson();
                Item[] items = json.fromJson(st, Item[].class);
                out.print("<br/>Products in cookie (shopping cart):<br/>");
                for (Item item : items)
                    out.print("<p>" + item.getProduct() + " " + item.getQuantity() + "</p>");
            }
        }
    %>
    <form action="order.jsp" method="post">
        <input type="submit"  title="Order" value="Create new order">
    </form>

</body>
<%@include file="footer.jsp"%>
</html>

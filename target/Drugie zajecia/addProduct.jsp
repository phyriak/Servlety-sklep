<%@ page import="model.Item" %>
<%@ page import="java.util.List" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %><%--
  Created by IntelliJ IDEA.
  User: piotr
  Date: 30.01.2020
  Time: 15:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>

<%@include file="header.jsp" %>
<%@include file="loginDiv.jsp" %>
<body>
<%

    String product = request.getParameter("product");
    String name = request.getParameter("name");
    System.out.println("name: " + name);
    String quantity = request.getParameter("quantity");
    System.out.println("quantity: " + quantity);
    String category = request.getParameter("category");
    double price = Double.parseDouble(request.getParameter("price"));
    String sort = request.getParameter("sort");
    System.out.println("@category: " + category);
    System.out.println("@sort:" + sort);
    out.print("<p>product: " + product + "</p>");
    out.print("<p>quantity: " + quantity + "</p>");

//    int cartSize;
//    if (session.getAttribute("shoppingCartSize") == null) {
//        cartSize = 0;
//    } else cartSize = (int) session.getAttribute("shoppingCartSize");

    // List<Item> koszyk = new ArrayList<>();
    //session.setAttribute("shoppingCartSize", cartSize);
    //session.setAttribute("shoppingCart", koszyk);
    user = (String) session.getAttribute("user");

    //koszyk = (ArrayList<Item>) session.getAttribute("shoppingCart");

    List<Item> koszyk = (ArrayList<Item>) session.getAttribute("shoppingCart");
    if (koszyk == null)
        koszyk = new ArrayList<>();
    int cartSize = (int) session.getAttribute("shoppingCartSize");
    System.out.println("cartSize: " + cartSize);
    // sprawdzenie czy produkt już jest w koszyku (jeśli tak, to zwiększenie jego liczby sztuk)
    boolean jest = false;
    for (Item item : koszyk) {
        if (item.getProduct().compareTo(product) == 0) {
            int n1 = item.getQuantity();
            int n2 = Integer.parseInt(quantity);
            int sum = n1 + n2;
            item.setQuantity(sum);
            item.setPrice(price);
            System.out.println("produkt: " + product + " razem:" + sum);
            jest = true;
            break;
        }
    }
    if (!jest) {
        koszyk.add(new Item(product, Integer.parseInt(quantity), price));
        cartSize++;
    }
    session.setAttribute("shoppingCartSize", cartSize);
    session.setAttribute("shoppingCart", koszyk);
    user = (String) session.getAttribute("user");
    Gson gson = new GsonBuilder().create();
    String ciastko = gson.toJson(koszyk);
    //ciastko = ciastko.replace("^%", "\"");
    //ciastko = ciastko.replace("!%", ",");
    ciastko = ciastko.replace("\"", "^%");
    ciastko = ciastko.replace(",",  "!%");
    System.out.println(ciastko);
    Cookie cookie = new Cookie(user, ciastko);
    response.addCookie(cookie);
    Thread.sleep(300);
    response.sendRedirect("products.jsp?category=" + category + "&sort=" + sort);

%>


</body>

<%@include file="footer.jsp" %>

</html>

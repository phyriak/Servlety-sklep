package model;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.*;

@WebServlet("/waliduj")
public class Validate extends HttpServlet {
    final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    final String DB_URL = "jdbc:mysql://localhost:3306/sklep?serverTimezone=UTC";
    String USER = "root";
    String PASS = "mekzio10";
    Statement stmt = null;
    Connection conn = null;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String login = request.getParameter("user"); //////////change uname to login
        String password = request.getParameter("password"); //////////change uname to login
        PrintWriter out = response.getWriter();
        String page="";
        boolean userExists = checkIfUserExsists(login, password);
        if (userExists == false) {
            request.setAttribute("statusLogin", "" + login + " uzytkownik nie istnieje lub nieproawidlowe haslo");
            getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
        }

        if (userExists == true) {
            System.out.println("user exist");

            Cookie[] cookies= request.getCookies();
            List<Item> koszyk = new ArrayList<>();
            for(Cookie cookie : cookies)
                if (cookie.getName().equals(login)) {
                    // utworzenie pustego koszyka zakupów
                    Gson json = new Gson();
                    String st = cookie.getValue();
                    st = st.replace("^%", "\"");
                    st = st.replace("!%", ",");
                    System.out.println(st);
                    // utworzenie kolekcji Item z ciasteczka i zapisanie kolekcji w koszyku
                    Item[] items = json.fromJson(st, Item[].class);
                    koszyk.addAll(Arrays.asList(items));
                }
                HttpSession session=request.getSession();
                session.setAttribute("user",login);
                session.setAttribute("shoppingCart",koszyk);
                session.setAttribute("shoppingCartSize",koszyk.size());
                session.setAttribute("USER",USER);
                session.setAttribute("PASS",PASS);
                page="products.jsp";
            }
        response.sendRedirect(page);
        }


    protected void doPost(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {
// TODO Auto-generated method stub
        doGet(request, response);
    }


    private boolean checkIfUserExsists(String login, String password) {
        Md5Maker md5Maker=new Md5Maker();
        String md5 = md5Maker.makeMDS(password);
        String sql = "SELECT*FROM users WHERE login='" + login + "'AND md5='" + md5 + "'";
        boolean isAvaible = false;
        try {
            connectionToDatabase(JDBC_DRIVER,DB_URL,USER,PASS);
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                isAvaible = true;
            }
        } catch (ClassNotFoundException cnfe) {
            System.out.println("Error: " + cnfe);
        } catch (SQLException se) {
            System.out.println("Error: " + se);
        }
        return isAvaible;
    }

    public void connectionToDatabase(String JDBC_DRIVER, String DB_URL, String USER, String PASS) throws ClassNotFoundException, SQLException {
        Class.forName(JDBC_DRIVER);
        conn = DriverManager.getConnection(DB_URL, USER, PASS);
        stmt = conn.createStatement();
    }

}
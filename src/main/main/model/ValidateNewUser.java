package model;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.*;

@WebServlet("/walidujNowegoUzytkownia")
public class ValidateNewUser extends HttpServlet {
    final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    final String DB_URL = "jdbc:mysql://localhost:3306/sklep?serverTimezone=UTC";
    String USER = "root";
    String PASS = "mekzio10";
    Statement stmt = null;
    Connection conn = null;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String login = request.getParameter("user"); //////////change uname to login
        String password = request.getParameter("password"); //////////change uname to login
        String passwordCheck = request.getParameter("passwordCheck"); //////////change uname to login
        String firstName = request.getParameter("firstName"); //////////change uname to login
        String lastName = request.getParameter("lastName"); //////////change uname to login
        String city = request.getParameter("city"); //////////change uname to login
        String code = request.getParameter("code"); //////////change uname to login
        String street = request.getParameter("street"); //////////change uname to login
        String streetNumber = request.getParameter("streetNumber"); //////////change uname to login

        boolean userExists = checkIfUserExsists(login, password);
        boolean correctPassword = validateCorrectOfPassword(password, passwordCheck);


        if (userExists == true) {
            System.out.println("user exist");
            request.setAttribute("statusLogin", "" + login + " użytkownik już istnieje");
            getServletContext().getRequestDispatcher("/createUserAccount.jsp").forward(request, response);
            System.out.println(request.getAttribute("status"));
        }
        if (password.isEmpty() || (password.length() <= 4)) {
            request.setAttribute("statusPassword", "Brak hasła lub haslo nie posiada co najmniej 5 znaków");
            getServletContext().getRequestDispatcher("/createUserAccount.jsp").forward(request, response);
        }
        if ((correctPassword == false)) {
            request.setAttribute("statusPasswordChecked", "Hasła różnią się");
            getServletContext().getRequestDispatcher("/createUserAccount.jsp").forward(request, response);
            System.out.println(password + "-" + passwordCheck);
        }
        if (userExists == false && correctPassword == true) {
            addUser(login, password, firstName, lastName, city, code, street, streetNumber);
            response.sendRedirect("products.jsp");
        }

        Cookie[] ciastka = request.getCookies();
        List<Item> koszyk = new ArrayList<>();
        for (Cookie cookie : ciastka) {
            if (cookie.getName().equals(login)) {
                Gson gson = new Gson();
                String st = cookie.getValue();
                st = st.replace("^%", "\"");
                st = st.replace("!%", ",");
                System.out.println(st);
                Item[] items = gson.fromJson(st, Item[].class);
                koszyk.addAll(Arrays.asList(items));
            }


            HttpSession session = request.getSession();
            session.setAttribute("user", login);
            session.setAttribute("shopingCart", koszyk);
            session.setAttribute("shopingCartSize", koszyk.size());
        }
    }


    private boolean validateCorrectOfPassword(String password, String passwordCheck) {
        boolean passwordValidator = false;
        if (password.equals(passwordCheck) && password.length() > 4)
            passwordValidator = true;
        return passwordValidator;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {


// TODO Auto-generated method stub
        doGet(request, response);
    }


    private boolean checkIfUserExsists(String login, String password) {
        String sql = "SELECT*FROM users WHERE login='" + login + "'";

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

    public boolean addUser(String login, String password,String firstName,String lastname, String city,String code,String street,String streetnumber) {
        Md5Maker md5Maker=new Md5Maker();
        String md5 = md5Maker.makeMDS(password);
        String sql =
                "INSERT INTO sklep.users (login,md5,firstName,lastName,city,code,street,streetNumber) " +
                        "values ('" + login + "','" + md5 + "','" + firstName + "','"+lastname+"','"+city+"','"+code+"','"+street+"','"+streetnumber+"')";
        //INSERT INTO `sklep`.`users` (`login`, `md5`, `firstName`, `lastName`, `city`) VALUES ('ffff', 'ff', 'a', 'a', 'poz');
        boolean isAvaible = false;
        try {
            connectionToDatabase(JDBC_DRIVER,DB_URL,USER,PASS);
            stmt.executeUpdate(sql);
            isAvaible = true;
            System.out.println("user added");

        } catch (ClassNotFoundException cnfe) {
            System.out.println("Error: " + cnfe);
        } catch (SQLException se) {
            System.out.println("Error: " + se);
        }

        return isAvaible;
    }

    public void connectionToDatabase(String JDBC_DRIVER,String DB_URL,String USER,String PASS) throws ClassNotFoundException, SQLException {
        Class.forName(JDBC_DRIVER);
        conn = DriverManager.getConnection(DB_URL, USER, PASS);
        stmt = conn.createStatement();
    }
}
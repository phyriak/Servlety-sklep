package model;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebFilter("/walidujNowegoUzytkownia2")
public class nameFilter implements Filter {
    public nameFilter() {
    } // konstruktor

    public void destroy() {
    } // metoda wywoływana podczas usuwania filtra

    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        PrintWriter out = response.getWriter();
        String user = req.getParameter("user");
        String messageInvalidUserName="";




            messageInvalidUserName=(user+ " juz istnieje!");

            out.println("Niepoprawna nazwa użytkownika: " + user);

            request.setAttribute("message", messageInvalidUserName);
            req.getRequestDispatcher("/createUserAccount.jsp").forward(request, response);




    }

    public void init(FilterConfig fConfig) throws ServletException {
    } // inicjowanie filtra
}
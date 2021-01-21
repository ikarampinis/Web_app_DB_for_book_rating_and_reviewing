package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import project_dao.UserDAO;
import entity.User;
import javax.servlet.http.HttpSession;

@WebServlet(name = "user_login", urlPatterns = {"/user_login"})
public class user_login extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userdao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        userdao = new UserDAO();
        
        String username = request.getParameter("user_name");
        String password = request.getParameter("password");
        
        User user = new User(username, password);
        
        int result = userdao.check_username(user);
        
        if(result == 0){
            HttpSession session = request.getSession();
            if(session.getAttribute("username") != null){
                response.sendRedirect("login.jsp?error=Already logged in with another account!");
            }
            else{
                session.setAttribute("username", username);
                response.sendRedirect("home_page.jsp");
            }
        }
        else if(result==1){
            response.sendRedirect("login.jsp?error=This username doesn't exist!");
        }
        else if(result==2){
            response.sendRedirect("login.jsp?error=The password is wrong!");
        }
        else{
            response.sendRedirect("login.jsp?error=Something went wrong!");
        }
    }
}

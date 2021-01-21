package servlet;

import entity.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import project_dao.UserDAO;

@WebServlet(name = "user_signup", urlPatterns = {"/user_signup"})
public class user_signup extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userdao;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        userdao = new UserDAO();
        
        String firstname = request.getParameter("first_name");
        String lastname = request.getParameter("last_name");
        String username = request.getParameter("user_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repeat_pass = request.getParameter("repeat_pass");
        String country = request.getParameter("country");
        String gender = request.getParameter("gender");
        String birthdate = request.getParameter("birth-date");
        if(password.length()<6){
            response.sendRedirect("sign_up.jsp?error=Password less than 6-characters!");
            return;
        }
        
        if(!password.equals(repeat_pass)){
            response.sendRedirect("sign_up.jsp?error=Password didn't match!");
            return;
        }
        
        User user = new User(username, firstname, lastname, email, password, birthdate, gender, country);
        int result = userdao.addUser(user);
        
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
            response.sendRedirect("sign_up.jsp?error=Username already exists!");
        }
        else if(result==2){
            response.sendRedirect("sign_up.jsp?error=Email already exists!");
        }
        else{
            response.sendRedirect("sign_up.jsp?error=Something went wrong!");
        }
    }
}

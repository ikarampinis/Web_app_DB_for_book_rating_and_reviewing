package servlet;

import entity.User;
import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import project_dao.UserDAO;

public class user_edit extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userdao = new UserDAO();
        HttpSession session = request.getSession();
        String[] info = (String[])session.getAttribute("profile_info");
        
        String firstname = request.getParameter("first_name");
        String lastname = request.getParameter("last_name");
        String username = session.getAttribute("username").toString();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repeat_pass = request.getParameter("repeat_pass");
        String country = request.getParameter("country");
        String gender = request.getParameter("gender");
        String birthdate = request.getParameter("birth-date");
        if(!password.equals("")){
            if(password.length()<6){
                response.sendRedirect("edit_profile.jsp?error=Password less than 6-characters!");
                return;
            }
        }
        else{
            password = info[4];
        }
        
        if(!repeat_pass.equals(info[4])){
            response.sendRedirect("edit_profile.jsp?error=Password didn't match!");
            return;
        }
        
        User user = new User(username, firstname, lastname, email, password, birthdate, gender, country);
        int result = userdao.updateUser(user);
        
        if(result == 0){
            String[] profile_array = userdao.getProfile(username);
            session.setAttribute("profile_info", profile_array);
            response.sendRedirect("profile.jsp");
        }
        else if(result==1){
            response.sendRedirect("edit_profile.jsp?error=Username already exists!");
        }
        else if(result==2){
            response.sendRedirect("edit_profile.jsp?error=Email already exists!");
        }
        else{
            response.sendRedirect("edit_profile.jsp?error=Something went wrong!");
        }
    }
}

package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import project_dao.UserDAO;

public class user_profile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDAO userdao = new UserDAO();
        String[] profile_array = userdao.getProfile(session.getAttribute("username").toString());
        session.setAttribute("profile_info", profile_array);
        response.sendRedirect("profile.jsp");
    }
}

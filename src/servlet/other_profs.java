package servlet;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import project_dao.UserDAO;

public class other_profs extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uname = request.getParameter("name");
        UserDAO other_user = new UserDAO();
        String[] array = other_user.getOtherProfile(uname);
        request.setAttribute("other_user_info", array);
        RequestDispatcher view = request.getRequestDispatcher("/other_profile.jsp");
        view.forward(request, response);
    }
}
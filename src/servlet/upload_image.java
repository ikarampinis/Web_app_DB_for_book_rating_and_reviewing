package servlet;

import com.mchange.io.FileUtils;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import project_dao.UserDAO;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Part;

@WebServlet(name = "upload_image", urlPatterns = {"/upload_image"})
@MultipartConfig(maxFileSize = 16177215)
public class upload_image extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        InputStream inputStream = null;
        HttpSession session = request.getSession();
        String username = session.getAttribute("username").toString();
        //Part filename = request.getPart("change_image");
        //inputStream = filename.getInputStream();
        Part file = request.getPart("change_image");
        if(file!=null){
            inputStream = file.getInputStream();
            byte[] image = inputStream.readAllBytes();
            boolean result = userDAO.uploadImage(image, username);
            if(result){
                response.sendRedirect("profile.jsp");
            }
            else{
                response.sendRedirect("edit_profile.jsp");
            }
        }
    }
}

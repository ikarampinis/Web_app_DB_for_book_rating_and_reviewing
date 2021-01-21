package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import entity.Books;
import javax.servlet.RequestDispatcher;
import project_dao.bookDao;

public class book extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        bookDao bookdao = new bookDao();
        String[] info = request.getParameter("info").split("==");
        Books book = new Books(info[2], info[1], info[0], 0 ,(int)(Integer.parseInt(info[3])*Float.parseFloat(info[4])), Integer.parseInt(info[3]), info[5]);
        int result = bookdao.addBook(book);
        String[] array = bookdao.getbook(info[2]);
        request.setAttribute("book_information", array);
        RequestDispatcher view = request.getRequestDispatcher("/book_page.jsp");
        view.forward(request, response);
    }
}
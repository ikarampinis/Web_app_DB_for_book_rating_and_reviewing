<%@page import="entity.UserBooks"%>
<%@page import="project_dao.UserBooksDAO"%>
<%@page import="entity.FavAuthors"%>
<%@page import="entity.Books"%>
<%@page import="project_dao.FavAuthDAO"%>
<%@page import="project_dao.bookDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="project_dao.TopAuthorsDAO"%>
<%@page import="entity.TopAuthors"%>
<%@page import="project_dao.UserDAO"%>
<%@ page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>BookWay | Home</title>
        <meta charset ="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
        <link href="https://fonts.googleapis.com/css2?family=Nothing+You+Could+Do&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="header_style.css">
        <link rel="stylesheet" href="mybooks.css">
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <script src="https://code.jquery.com/jquery-3.1.0.js"></script>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");//http 1.1
            response.setHeader("Pragma", "no-cache");//http 1.0
            response.setHeader("Expires", "0");//proxies
            
            if(session.getAttribute("username")==null){
                response.sendRedirect("login.jsp");
            }
        %>
        <div class="header">
            <img src="images/book.png" class="book-image" width="40">
            <a href="home_page.jsp" class="logo">Bookway</a>
            <div class="header-right">
                <a class="active" href="home_page.jsp">Home</a>
                <div class="dropdown">
                    <button class="dropbtn">Genres
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div class="genre">
                        <a href="search_category?category=art">Art</a>
                        <a href="search_category?category=biography/autobiography">Biography & Autobiography</a>
                        <a href="search_category?category=comics/graphic/novels">Comics & Graphic Novels</a>
                        <a href="search_category?category=drama">Drama</a>
                        <a href="search_category?category=fiction">Fiction</a>
                        <a href="search_category?category=history">History</a>
                        <a href="search_category?category=music">Music</a>
                        <a href="search_category?category=music">Nature</a>
                        <a href="search_category?category=philosophy">Philosophy</a>
                        <a href="search_category?category=technology/engineering">Technology & Engineering</a>
                        <a href="search_category?category=true crime">True Crime</a>
                        <a href="analytic_categories.jsp">More...</a>
                    </div>
                </div>
                <div class="dropdown">
                    <button class="dropbtn">Explore
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div class="dropdown-content">
                        <a href="analytic_categories.jsp">By Genre</a>
                        <a href="by_author.jsp">By Author</a>
                        <a href="editor_picks.jsp?WhichEdit=1">Editors' Picks</a>
                    </div>
                </div>
                <a href="about_us.jsp">About Us</a>
                <div class="search-container" ondrag="highlight">
                  <form method="post" action="search_book">
                    <input id="search-text" type="text" placeholder="Search.." name="search" required>
                    <button id="search" type="submit" onclick=""><i class="fa fa-search"></i></button>
                  </form>
                </div>
                <div class="dropdown">
                    <button class="dropbtn" id="profilepic"><img src="
                            <%
                                if(session.getAttribute("username")!=null){
                                    String username = session.getAttribute("username").toString();
                                    UserDAO userdao = new UserDAO();
                                    String imageData = userdao.getUserImage(username);
                                    if(imageData==null){
                                        out.print("images/defaultImage.jpg");
                                    }
                                    else{
                                        out.print("data:image/jpg;base64,"+imageData);
                                    }
                                }
                            %>"
                            id="profilepic">
                        ${username}
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div class="dropdown-content">
                        <a href="user_profile">Profile</a>
                        <a href="myBooks.jsp?WhichBooks=4">My Books</a>
                        <a href="user_logout">Sign Out</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="page_body">
            <div class="body_left">
                <%
                    int param = Integer.parseInt(request.getParameter("WhichEdit"));
                    if(param!=0){
                    bookDao editorsBooks = new bookDao();
                  
                  List editorslist = editorsBooks.getEditorsPicks(param);
                  Iterator<Books> it_editors = editorslist.iterator();
//                  out.print("<div class=\"body_left\">");
                  if(!it_editors.hasNext()){
                      out.print("<center><h2>No editor's picks availiable!</h2></center>");
                  }
                  while(it_editors.hasNext()){
                      Books curr_pick = it_editors.next();
                      String curr_path = curr_pick.getTitle()+"=="+curr_pick.getAuthor()+"=="+curr_pick.getIsbn()+"=="+curr_pick.getRatingCounter()+"=="+curr_pick.getRatings()+"=="+curr_pick.getImage();
                      out.print("<div class=\"book\"><div class=\"book_photo\">");
                      if(curr_pick.getImage().equals("http://inf-server.inf.uth.gr/~ikarampinis/bookNotFound.png")){
                          out.print("<img src=\"http://inf-server.inf.uth.gr/~ikarampinis/bookNotFound.png\" style=\"width:70px\"></div><div class=\"book_info\">");
                      }
                      else{
                          out.print("<img src=\""+curr_pick.getImage()+"&printsec=frontcover&img=1&zoom=1&source=gbs_api"+"\" style=\"width: 70px\"></div><div class=\"book_info\">");
                      }
                      out.print("<h3>"+curr_pick.getTitle()+"</h3><p><b>Author:<b>"+curr_pick.getAuthor()+"&emsp;");
                      int rating = 0;
                      if(curr_pick.getRatings() != 0 && curr_pick.getRatingCounter()!=0){
                        rating = curr_pick.getRatings() / curr_pick.getRatingCounter();
                      }
                      if(rating != 0){
                        out.print("<b>Rating:<b> "+rating+" / 5<i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>&emsp;");
                      }
                      out.print("<div class=\"no\"><button><a class=\"button\" href=\"book?info="+curr_path+"\">View</a></button></div></div></div>");
                  }
                  
                    }
//                    out.print("</div>");
//                  out.print("<div class=\"body_right\">");
//                  out.print("<center><h2>Editors:</h2></center>");
//                  out.print("<a class=\"active\" href=\"?WhichEdit=1"+"\">Yiannis</a><hr>");
//                  out.print("<a class=\"active\" href=\"?WhichEdit=2"+"\">Alkisti</a><hr>");
//                  out.print("<a class=\"active\" href=\"?WhichEdit=3"+"\">Cleopatra</a>");
//                  out.print("</div>");
                %>
            </div>
            <div class="body_right">
                <center><h2>Editors:</h2></center>
                <a class="active" href="?WhichEdit=1">Ioannis</a><hr>
                <a class="active" href="?WhichEdit=2">Alkisti</a><hr>
                <a class="active" href="?WhichEdit=3">Cleopatra</a><hr>
            </div>
        </div>
    </body>
</html>
<%@page import="project_dao.ViewDAO"%>
<%@page import="entity.UserReview"%>
<%@page import="entity.UserReviewPK"%>
<%@page import="java.util.Iterator"%>
<%@page import="entity.UserBooks"%>
<%@page import="java.util.List"%>
<%@page import="project_dao.UserBooksDAO"%>
<%@page import="project_dao.bookDao"%>
<%@page import="project_dao.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BookWay | MyBooks</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <LINK rel="stylesheet" href="mybooks.css">
        <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
        <link href="https://fonts.googleapis.com/css2?family=Nothing+You+Could+Do&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="header_style.css">
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
                <a href="home_page.jsp">Home</a>
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
                        <a href="editors_picks.jsp?WhichEdit=1">Editors' Picks</a>
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
              <%
                String param_all = request.getParameter("WhichBooks");
                String[] all = param_all.split("!@");
                String param = all[0];
                String uname = all[1];
                if(param != null && !param.equals("")){
                  UserBooksDAO userbookdao = new UserBooksDAO();
                  bookDao BookDao = new bookDao();
                  ViewDAO review = new ViewDAO();
                  List userbooklist;
                  Iterator<UserBooks> it_userBooks;
                  UserBooks curr;
                  if(param.equals("4")){
                      List finished, reading, want;
                      finished = userbookdao.getFinishedList(uname);
                      reading = userbookdao.getReadNowList(uname);
                      want = userbookdao.getWantToReadList(uname);
                      if(finished.size()==0 && want.size()==0 && reading.size()==0){
                        out.print("<div class=\"body_left\">");
                        out.print("<p><center>No Books!</center></p>");
                      }
                  }
                  if(param.equals("1") || param.equals("4")){
                    userbooklist = userbookdao.getWantToReadList(uname);
                    if(userbooklist.size() == 0 && param.equals("1")){
                        out.print("<div class=\"body_left\">");
                        out.print("<p><center>No Books!</center></p>");
                    }
                    else{
                        it_userBooks = userbooklist.iterator();
                        curr = null;

                        if(!userbooklist.isEmpty()){
                            out.print("<div class=\"body_left\">");
                            if(!param.equals("4")){
                            }
                            while(it_userBooks.hasNext()){
                              curr = it_userBooks.next();
                              String ub_isbn = curr.getUserBooksPK().getBooksIsbn();
                              String ub_user = curr.getUserBooksPK().getUserUsername();
                              int rate = review.bookRating(ub_user, ub_isbn);
                              String[] book_details = BookDao.getbook(ub_isbn);
                              int num = userbookdao.FindStatus(ub_user, ub_isbn);
                              String status=" ";
                              if(num==1){
                                  status="TBR";
                              }
                              else if(num==2){
                                  status="Reading now";
                              }
                              else if(num==3){
                                  status="Read";
                              }
                              String path = book_details[2]+"=="+book_details[1]+"=="+book_details[0]+"=="+book_details[4]+"=="+book_details[3]+"=="+book_details[5];
                              out.print("<div class=\"book\"><div class=\"book_photo\">");
                              out.print("<img src=\""+book_details[5]+"\" style=\"width: 70px\"></div><div class=\"book_info\">");
                              out.print("<h3>"+book_details[2]+"</h3><p><b>Author:</b> "+book_details[1]+" &emsp; <b>Status:</b> "+status+" ");
                              if(rate != -1){
                                out.print("&emsp; <b>Your Rating:</b> "+rate+" / 5<i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>");
                              }
                              out.print("<div class=\"no\"><button><a  href=\"book?info="+path+"\">View</a></button></div></div></div>");
                            }
                        }
                      }
                  }
                  if(param.equals("2") || param.equals("4")){
                    userbooklist = userbookdao.getReadNowList(uname); 
                    if(userbooklist.size()==0 && param.equals("2")){
                        out.print("<div class=\"body_left\">");
                        out.print("<p><center>No Books!</center></p>");
                    } 
                    else{
                        it_userBooks = userbooklist.iterator();
                        curr = null;
                        if(!userbooklist.isEmpty()){
                            if(!param.equals("4")){
                                out.print("<div class=\"body_left\">");
                            }
                            while(it_userBooks.hasNext()){
                              curr = it_userBooks.next();
                              String ub_isbn = curr.getUserBooksPK().getBooksIsbn();
                              String ub_user = curr.getUserBooksPK().getUserUsername();
                              int rate = review.bookRating(ub_user, ub_isbn);
                              String[] book_details = BookDao.getbook(ub_isbn);
                              int num = userbookdao.FindStatus(ub_user, ub_isbn);
                              String status=" ";
                              if(num==1){
                                  status="TBR";
                              }
                              else if(num==2){
                                  status="Reading now";
                              }
                              else if(num==3){
                                  status="Read";
                              }
                              String path = book_details[2]+"=="+book_details[1]+"=="+book_details[0]+"=="+book_details[4]+"=="+book_details[3]+"=="+book_details[5];
                              out.print("<div class=\"book\"><div class=\"book_photo\">");
                              out.print("<img src=\""+book_details[5]+"\" style=\"width: 70px\"></div><div class=\"book_info\">");
                              out.print("<h3>"+book_details[2]+"</h3><p><b>Author:</b> "+book_details[1]+" &emsp; <b>Status:</b> "+status+" ");
                              if(rate != -1){
                                out.print("&emsp; <b>Your Rating:</b> "+rate+" / 5<i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>");
                              }
                              out.print("<div class=\"no\"><button><a  href=\"book?info="+path+"\">View</a></button></div></div></div>");
                            }
                        }
                      }
                  }
                  if(param.equals("3") || param.equals("4")){
                    userbooklist = userbookdao.getFinishedList(uname);
                    if(userbooklist.size()==0 && param.equals("3")){
                        out.print("<div class=\"body_left\">");
                        out.print("<p><center>No Books!</center></p>");
                    }
                    else{
                        it_userBooks = userbooklist.iterator();
                        curr = null;

                        if(!userbooklist.isEmpty()){
                            if(!param.equals("4")){
                                out.print("<div class=\"body_left\">");
                            }
                            while(it_userBooks.hasNext()){
                              curr = it_userBooks.next();
                              String ub_isbn = curr.getUserBooksPK().getBooksIsbn();
                              String ub_user = curr.getUserBooksPK().getUserUsername();
                              int rate = review.bookRating(ub_user, ub_isbn);
                              String[] book_details = BookDao.getbook(ub_isbn);
                              int num = userbookdao.FindStatus(ub_user, ub_isbn);
                              String status=" ";
                              if(num==1){
                                  status="TBR";
                              }
                              else if(num==2){
                                  status="Reading now";
                              }
                              else if(num==3){
                                  status="Read";
                              }
                              String path = book_details[2]+"=="+book_details[1]+"=="+book_details[0]+"=="+book_details[4]+"=="+book_details[3]+"=="+book_details[5];
                              out.print("<div class=\"book\"><div class=\"book_photo\">");
                              out.print("<img src=\""+book_details[5]+"\" style=\"width: 70px\"></div><div class=\"book_info\">");
                              out.print("<h3>"+book_details[2]+"</h3><p><b>Author:</b> "+book_details[1]+" &emsp; <b>Status:</b> "+status+" ");
                              if(rate != -1){
                                out.print("&emsp; <b>Your Rating:</b> "+rate+" / 5<i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>");
                              }
                              out.print("<div class=\"no\"><button><a  href=\"book?info="+path+"\">View</a></button></div></div></div>");
                            }
                        }
                    }
                  }
                  out.print("</div>");
                  out.print("<div class=\"body_right\">");
                  out.print("<center><h2>Shelves:</h2></center>");
                  out.print("<a class=\"active\" href=\"?WhichBooks=4!@"+uname+"\">All Books</a><hr>");
                  out.print("<a class=\"active\" href=\"?WhichBooks=1!@"+uname+"\">Want To Read (TBR)</a><hr>");
                  out.print("<a class=\"active\" href=\"?WhichBooks=2!@"+uname+"\">Reading Now</a><hr>");
                  out.print("<a class=\"active\" href=\"?WhichBooks=3!@"+uname+"\">Finished</a>");
                  out.print("</div>");
                }
              %>
        </div>
    </body>
</html>

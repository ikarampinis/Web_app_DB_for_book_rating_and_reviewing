<%@page import="entity.FavAuthors"%>
<%@page import="project_dao.FavAuthDAO"%>
<%@page import="entity.Quotes"%>
<%@page import="project_dao.QuotesDAO"%>
<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entity.UserBooks"%>
<%@page import="project_dao.UserBooksDAO"%>
<%@page import="entity.UserReview"%>
<%@page import="project_dao.bookDao"%>
<%@page import="project_dao.ViewDAO"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="project_dao.UserDAO"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
 <title>BookWay | Profile</title>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
 <link href="https://fonts.googleapis.com/css2?family=Nothing+You+Could+Do&display=swap" rel="stylesheet">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 <link rel="stylesheet" href="header_style.css">
 <link rel="stylesheet" href="profiles.css">
 <link rel="stylesheet" href="quote.css">
 <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
 <script src="https://code.jquery.com/jquery-3.1.0.js"></script>
 <script src="https://kit.fontawesome.com/a076d05399.js"></script>
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
      
    <%  String[] others_info = (String[])request.getAttribute("other_user_info");
        String other_img = "";
        String other_name = others_info[2];
        if(session.getAttribute("username")!=null){
            UserDAO userdao = new UserDAO();
            String imageData = userdao.getUserImage(other_name);
            if(imageData==null){
                other_img = "images/defaultImage.jpg";
            }
            else{
                other_img = "data:image/jpg;base64,"+imageData;
            }
        }
        String fname = others_info[0];
        String lname = others_info[1];
        String bday = others_info[3];
        String other_gender = others_info[4];
        String other_country = others_info[5];
    %>
  <div class="page_body">
      <div class="body_left" id="round">
        <img src=<%= other_img%> alt="Profile_picture" style="height: 300px;" class="prof_pic">
      <div id="HASH">
          <h2 class="serif"><% out.print(fname+" "+lname);%></h2>
      </div>
      <hr>
      <p style="font-size:130%" class="serif"><b>Username:</b> <%= other_name%></p>
      <p style="font-size:130%" class="serif"><b>Birthday:</b> <%= bday%></p>
      <p style="font-size:130%" class="serif"><b>Details:</b> Age 
          <%
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date d = sdf.parse(bday);
            Calendar c = Calendar.getInstance();
            c.setTime(d);
            int year = c.get(Calendar.YEAR);
            int month = c.get(Calendar.MONTH) + 1;
            int date = c.get(Calendar.DATE);
            LocalDate l1 = LocalDate.of(year, month, date);
            LocalDate now1 = LocalDate.now();
            Period diff1 = Period.between(l1, now1);
            out.print(diff1.getYears());
          %>
          , <%= other_gender%>, <%= other_country%></p>
      <br><br><br><br>
      <p style="font-size: 21px"><%= fname%>'s Bookcase</p>
      <hr>
      <div class="row">
          <%
              UserBooksDAO userbookdao = new UserBooksDAO();
              bookDao firstBookDao = new bookDao();
              List userbooklist = userbookdao.getWantToReadList(other_name);
              Iterator<UserBooks> it_userBooks;
              UserBooks curr_UserBooks = null;
              if(userbooklist.isEmpty() || userbooklist == null){
                    out.print("<div class=\"column\"><div class=\"card\"><div class=\"container\">");
                    out.print("<center><a href=\"#\" style=\"color:black\"><p style=\"font-size:17px\" class=\"serif\"><b>Want to Read-Books</b></a>: 0</p></center>");
                    out.print("</div><center><p>No books found!</p><center></div></div>");
              }
              else{
                    it_userBooks = userbooklist.iterator();
                    curr_UserBooks = it_userBooks.next();
                    String ub_isbn = curr_UserBooks.getUserBooksPK().getBooksIsbn();
                    String[] first_book_details = firstBookDao.getbook(ub_isbn);
                    out.print("<div class=\"column\"><div class=\"card\"><div class=\"container\">");
                    out.print("<center><a href=\"other_books.jsp?WhichBooks=1!@"+other_name+"\" style=\"color:black\"><p style=\"font-size:17px\" class=\"serif\"><b>Want to Read-Books</b></a>: "+userbooklist.size()+"</p></center>");
                    out.print("</div><center><img src=\""+first_book_details[5]+"\" height=\"200px\"><center></div></div>");
              }
              
              userbooklist = userbookdao.getReadNowList(other_name);
              if(userbooklist.isEmpty() || userbooklist == null){
                    out.print("<div class=\"column\"><div class=\"card\"><div class=\"container\">");
                    out.print("<center><a href=\"#\" style=\"color:black\"><p style=\"font-size:17px\" class=\"serif\"><b>Reading Now-Books</b></a>: 0</p></center>");
                    out.print("</div><center><p>No books found!</p><center></div></div>");
              }
              else{
                    it_userBooks = userbooklist.iterator();
                    curr_UserBooks = it_userBooks.next();
                    String ub_isbn = curr_UserBooks.getUserBooksPK().getBooksIsbn();
                    String[] first_book_details = firstBookDao.getbook(ub_isbn);
                    out.print("<div class=\"column\"><div class=\"card\"><div class=\"container\">");
                    out.print("<center><a href=\"other_books.jsp?WhichBooks=2!@"+other_name+"\" style=\"color:black\"><p style=\"font-size:17px\" class=\"serif\"><b>Reading Now-Books</b></a>: "+userbooklist.size()+"</p></center>");
                    out.print("</div><center><img src=\""+first_book_details[5]+"\" height=\"200px\"><center></div></div>");
              }
              
              userbooklist = userbookdao.getFinishedList(other_name);

              if(userbooklist.isEmpty() || userbooklist == null){
                    out.print("<div class=\"column\"><div class=\"card\"><div class=\"container\">");
                    out.print("<center><a href=\"#\" style=\"color:black\"><p style=\"font-size:17px\" class=\"serif\"><b>Read Books</b></a>: 0</p></center>");
                    out.print("</div><center><p>No books found!</p><center></div></div>");
              }
              else{
                    it_userBooks = userbooklist.iterator();
                    curr_UserBooks = it_userBooks.next();
                    String ub_isbn = curr_UserBooks.getUserBooksPK().getBooksIsbn();
                    String[] first_book_details = firstBookDao.getbook(ub_isbn);
                    out.print("<div class=\"column\"><div class=\"card\"><div class=\"container\">");
                    out.print("<center><a href=\"other_books.jsp?WhichBooks=3!@"+other_name+"\" style=\"color:black\"><p style=\"font-size:17px\" class=\"serif\"><b>Read Books</b></a>: "+userbooklist.size()+"</p></center>");
                    out.print("</div><center><img src=\""+first_book_details[5]+"\" height=\"200px\"><center></div></div>");
              }
          %>
      </div>
      <br><br>
      
        <hr>
        <div id="Quotes">
            <p style="font-size:21px"><%= fname%>'s Quotes </p>
        <%
            QuotesDAO quotesdao = new QuotesDAO();
            List quotesList = quotesdao.getQuotes(other_name);
            if(!quotesList.isEmpty()){
                Iterator it_quotes = quotesList.iterator();
                int qCounter=0;
                while(it_quotes.hasNext()){
                    Quotes curr = (Quotes) it_quotes.next();
                    out.print("<div class=\"column_2\"><div class=\"card_2\">");
                    out.print("<div class=\"container_2\">");
                    out.print("<ul><li class=\"serif\"><b>\""+curr.getQuote()+"\"</b><br>- "+curr.getAuthor()+", "+curr.getBook()+"</li></ul>");
                    out.print("</div></div></div>");
                    qCounter++;
                }
            }
            else{
                out.print("<center><p>No Quotes Found!</p></center>");
            }
            
        %>
        </div>
    </div>
    <div class="body_right">
      <div class="right_rows">
          <center><h2 class="serif"><u>Top Rated Books</u></h2></center>
        <%
            ViewDAO review = new ViewDAO();
            bookDao top_book = new bookDao();
            List best_three = review.getTopRated(other_name);
            if(best_three == null){
                out.print("You have not rated books yet!");
            }
            else{
                Iterator<UserReview> it = best_three.iterator();
                while(it.hasNext()){
                    UserReview curr = it.next();
                    String isbn_top = curr.getUserReviewPK().getBooksIsbn();
                    String[] book_details = top_book.getbook(isbn_top);
                    out.print("<div class=\"top_rated\"><div class=\"books\">");
                    out.print("<img src=\""+book_details[5]+"\" width=\"80px\">");
                    out.print("</div><div class=\"information\">");
                    out.print("<p style=\"font-size:20px\"><b>"+book_details[2]+"</b></p>");
                    out.print("<p style=\"font-size:15px\">by "+book_details[1]+"</p>");
                    out.print("<p>Rate: "+ curr.getRate()+" / 5<i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>");
                    out.print("</div></div>");
                }
            }
        %>
      </div>
      <hr>
      <center><h2 class="serif"><u>Favourite authors</u></h2></center>
          <div class="favAuthors" id="favAuthors">
          <%
              FavAuthDAO favauth = new FavAuthDAO();
              List fav_list = favauth.getFavAuthList(other_name);
              if(!fav_list.isEmpty()){
                  Iterator it_favlist = fav_list.iterator();
                  out.print("<hr>");
                  while(it_favlist.hasNext()){
                      FavAuthors currfav = (FavAuthors)it_favlist.next();
                      out.print("<a class=\"active\" href=\"by_author.jsp?authors="+currfav.getAuthor()+"\">"+currfav.getAuthor()+"</a><hr>");
                  }
              }
              else{
                  out.print("<p>No Favourite Authors!</p>");
              }
          %>
          </div>
    </div>
  </div>
  </body>
</html>
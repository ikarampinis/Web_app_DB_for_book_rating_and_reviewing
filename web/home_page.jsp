<%@page import="java.util.ArrayList"%>
<%@page import="project_dao.UpcomingDAO"%>
<%@page import="entity.Upcoming"%>
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
        <LINK rel="stylesheet" href="home_style.css">
        <LINK rel="stylesheet" href="topauthor.css">
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
          <div class="body_left">
            <h2>Recommended</h2>
            
            <%
                bookDao bdao = new bookDao();
                FavAuthDAO fadao = new FavAuthDAO();
                
                List<FavAuthors> FavList = fadao.getTwofav(session.getAttribute("username").toString());
                String author_one="";
                String author_two="";
                if(!FavList.isEmpty()){
                    if(FavList.size() == 1){
                        author_one = FavList.get(0).getAuthor();
                    }
                    else{
                        author_one = FavList.get(0).getAuthor();
                        author_two = FavList.get(1).getAuthor();
                    }
                }
                Books[] BookArray = bdao.getListofBooks();

                if(FavList.isEmpty()){
                    for(int i=0; i<4; i++){
                        if(BookArray[i].getRatingCounter() == 0){
                            continue;
                        }
                        out.print("<div class=\"book\"><div class=\"book_photo\">");
                        if(!BookArray[i].getImage().equals("http://inf-server.inf.uth.gr/~ikarampinis/bookNotFound.png")){
                            out.print("<img src=\""+BookArray[i].getImage()+"&printsec=frontcover&img=1&zoom=1&source=gbs_api"+"\" style=\"width: 170px\">");
                        }
                        else{
                            out.print("<img src=\""+BookArray[i].getImage()+"\" style=\"width: 170px\">");
                        }
                        out.print("</div><div class=\"book_info\">");
                        out.print("<h3>"+BookArray[i].getTitle()+"</h3>");
                        out.print("<p>Author: "+BookArray[i].getAuthor()+"</p>");
                        float value = (float)BookArray[i].getRatings()/BookArray[i].getRatingCounter();
                        value = value * 100;
                        value = Math.round(value);
                        value = value /100;
                        if(value - (int)value == 0){
                            out.print("<p>Rating: "+(int)value+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>");
                        }
                        else{
                            out.print("<p>Rating: "+value+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>");
                        }
                        String info_path = BookArray[i].getTitle()+"=="+BookArray[i].getAuthor()+"=="+BookArray[i].getIsbn()+"=="+BookArray[i].getRatingCounter()+"=="+BookArray[i].getRatings()+"=="+BookArray[i].getImage();
                        out.print("<button><a class=\"button\" style=\"color: white; text-decoration: none\" href=\"book?info="+info_path+"\">View</a></button></div></div>");
                    }
                    out.print("<div id=\"hideRec\">");
                    for(int i=4; i<10; i++){
                        if(BookArray[i].getRatingCounter() == 0){
                            continue;
                        }
                        out.print("<div class=\"book\"><div class=\"book_photo\">");
                        if(!BookArray[i].getImage().equals("http://inf-server.inf.uth.gr/~ikarampinis/bookNotFound.png")){
                            out.print("<img src=\""+BookArray[i].getImage()+"&printsec=frontcover&img=1&zoom=1&source=gbs_api"+"\" style=\"width: 170px\">");
                        }
                        else{
                            out.print("<img src=\""+BookArray[i].getImage()+"\" style=\"width: 170px\">");
                        }
                        out.print("</div><div class=\"book_info\">");
                        out.print("<h3>"+BookArray[i].getTitle()+"</h3>");
                        out.print("<p>Author: "+BookArray[i].getAuthor()+"</p>");
                        float value = (float)BookArray[i].getRatings()/BookArray[i].getRatingCounter();
                        value = value * 100;
                        value = Math.round(value);
                        value = value /100;
                        if(value - (int)value == 0){
                            out.print("<p>Rating: "+(int)value+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>");
                        }
                        else{
                            out.print("<p>Rating: "+value+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>");
                        }
                        String info_path = BookArray[i].getTitle()+"=="+BookArray[i].getAuthor()+"=="+BookArray[i].getIsbn()+"=="+BookArray[i].getRatingCounter()+"=="+BookArray[i].getRatings()+"=="+BookArray[i].getImage();
                        out.print("<button><a class=\"button\" style=\"color: white; text-decoration: none\" href=\"book?info="+info_path+"\">View</a></button></div></div>");
                    }
                    out.print("</div>");
                    out.print("<div id=\"LessRec\"><a><button class=\"more\" onclick=\"RecMore()\">View Less...</button></a></div>");
                    out.print("<div id=\"MoreRec\"><a><button class=\"more\" onclick=\"RecMore()\">View More...</button></a></div>");
                }
                else{
                    for(int i=0; i<2; i++){
                        if(BookArray[i].getRatingCounter() == 0){
                            continue;
                        }
                        out.print("<div class=\"book\"><div class=\"book_photo\">");
                        if(!BookArray[i].getImage().equals("http://inf-server.inf.uth.gr/~ikarampinis/bookNotFound.png")){
                            out.print("<img src=\""+BookArray[i].getImage()+"&printsec=frontcover&img=1&zoom=1&source=gbs_api"+"\" style=\"width: 170px\">");
                        }
                        else{
                            out.print("<img src=\""+BookArray[i].getImage()+"\" style=\"width: 170px\">");
                        }
                        out.print("</div><div class=\"book_info\">");
                        out.print("<h3>"+BookArray[i].getTitle()+"</h3>");
                        out.print("<p>Author: "+BookArray[i].getAuthor()+"</p>");
                        float value = (float)BookArray[i].getRatings()/BookArray[i].getRatingCounter();
                        value = value * 100;
                        value = Math.round(value);
                        value = value /100;
                        if(value - (int)value == 0){
                            out.print("<p>Rating: "+(int)value+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>");
                        }
                        else{
                            out.print("<p>Rating: "+value+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>");
                        }
                        String info_path = BookArray[i].getTitle()+"=="+BookArray[i].getAuthor()+"=="+BookArray[i].getIsbn()+"=="+BookArray[i].getRatingCounter()+"=="+BookArray[i].getRatings()+"=="+BookArray[i].getImage();
                        out.print("<button><a class=\"button\" style=\"color: white; text-decoration: none\" href=\"book?info="+info_path+"\">View</a></button></div></div>");
                    }
                }
                if(FavList.size() == 1){
                    out.print("<div id=\"single\"></div>");
                    out.print("<div id=\"hideRec\">");
                    for(int i=2; i<6; i++){
                        if(BookArray[i].getRatingCounter() == 0){
                            continue;
                        }
                        out.print("<div class=\"book\"><div class=\"book_photo\">");
                        if(!BookArray[i].getImage().equals("http://inf-server.inf.uth.gr/~ikarampinis/bookNotFound.png")){
                            out.print("<img src=\""+BookArray[i].getImage()+"&printsec=frontcover&img=1&zoom=1&source=gbs_api"+"\" style=\"width: 170px\">");
                        }
                        else{
                            out.print("<img src=\""+BookArray[i].getImage()+"\" style=\"width: 170px\">");
                        }
                        out.print("</div><div class=\"book_info\">");
                        out.print("<h3>"+BookArray[i].getTitle()+"</h3>");
                        out.print("<p>Author: "+BookArray[i].getAuthor()+"</p>");
                        float value = (float)BookArray[i].getRatings()/BookArray[i].getRatingCounter();
                        value = value * 100;
                        value = Math.round(value);
                        value = value /100;
                        if(value - (int)value == 0){
                            out.print("<p>Rating: "+(int)value+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>");
                        }
                        else{
                            out.print("<p>Rating: "+value+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>");
                        }
                        String info_path = BookArray[i].getTitle()+"=="+BookArray[i].getAuthor()+"=="+BookArray[i].getIsbn()+"=="+BookArray[i].getRatingCounter()+"=="+BookArray[i].getRatings()+"=="+BookArray[i].getImage();
                        out.print("<button><a class=\"button\" style=\"color: white; text-decoration: none\" href=\"book?info="+info_path+"\">View</a></button></div></div>");
                    }
                    out.print("<div id=\"single-extend\"></div></div>");
                    out.print("<div id=\"LessRec\"><a><button class=\"more\" onclick=\"RecMore()\">View Less...</button></a></div>");
                    out.print("<div id=\"MoreRec\"><a><button class=\"more\" onclick=\"RecMore()\">View More...</button></a></div>");
                }
                if(FavList.size() == 2){
                    out.print("<div id=\"first\"></div>");
                    out.print("<div id=\"second\"></div>");
                    out.print("<div id=\"hideRec\">");
                    for(int i=2; i<4; i++){
                        if(BookArray[i].getRatingCounter() == 0){
                            continue;
                        }
                        out.print("<div class=\"book\"><div class=\"book_photo\">");
                        if(!BookArray[i].getImage().equals("http://inf-server.inf.uth.gr/~ikarampinis/bookNotFound.png")){
                            out.print("<img src=\""+BookArray[i].getImage()+"&printsec=frontcover&img=1&zoom=1&source=gbs_api"+"\" style=\"width: 170px\">");
                        }
                        else{
                            out.print("<img src=\""+BookArray[i].getImage()+"\" style=\"width: 170px\">");
                        }
                        out.print("</div><div class=\"book_info\">");
                        out.print("<h3>"+BookArray[i].getTitle()+"</h3>");
                        out.print("<p>Author: "+BookArray[i].getAuthor()+"</p>");
                        float value = (float)BookArray[i].getRatings()/BookArray[i].getRatingCounter();
                        value = value * 100;
                        value = Math.round(value);
                        value = value /100;
                        if(value - (int)value == 0){
                            out.print("<p>Rating: "+(int)value+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>");
                        }
                        else{
                            out.print("<p>Rating: "+value+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i></p>");
                        }
                        String info_path = BookArray[i].getTitle()+"=="+BookArray[i].getAuthor()+"=="+BookArray[i].getIsbn()+"=="+BookArray[i].getRatingCounter()+"=="+BookArray[i].getRatings()+"=="+BookArray[i].getImage();
                        out.print("<button><a class=\"button\" style=\"color: white; text-decoration: none\" href=\"book?info="+info_path+"\">View</a></button></div></div>");
                    }
                    out.print("<div id=\"first-extend\"></div>");
                    out.print("<div id=\"second-extend\"></div></div>");
                    out.print("<div id=\"LessRec\"><a><button class=\"more\" onclick=\"RecMore()\">View Less...</button></a></div>");
                    out.print("<div id=\"MoreRec\"><a><button class=\"more\" onclick=\"RecMore()\">View More...</button></a></div>");
                }
             %>
             <script>
                 window.onload = function(){
                    if("<%= author_one%>" !== ""){
                        searchFunction("<%= author_one%>", "<%= FavList.size()%>");
                    }
                    RecMore();
                    TopAuth();
                 };
                 
                function RecMore(){
                    var x = document.getElementById("hideRec");
                    var less = document.getElementById("LessRec");
                    var more = document.getElementById("MoreRec");
                    if (x.style.display === "none") {
                      x.style.display = "block";
                      less.style.display = "block";
                      more.style.display = "none";
                    } else {
                      x.style.display = "none";
                      less.style.display = "none";
                      more.style.display = "block";
                    }
                }
                
                function TopAuth(){
                    var x = document.getElementById("hideAuth");
                    var less = document.getElementById("LessAuth");
                    var more = document.getElementById("MoreAuth");
                    if (x.style.display === "none") {
                      x.style.display = "block";
                      less.style.display = "block";
                      more.style.display = "none";
                    } else {
                      x.style.display = "none";
                      less.style.display = "none";
                      more.style.display = "block";
                    }
                }
                 function searchFunction(searchData, check){
                    var item, bookImg, title, author, publisher, bookLink, bookIsbn, publish_date, page_count, rating, ratings_count;
                    var bookUrl = "https://www.googleapis.com/books/v1/volumes?q=";
                    var apiKey = "key=AIzaSyCcGQ9qXq3eNzZVn1Vcvk94D65IsE8kUFc";
                    var placeHldr = "http://inf-server.inf.uth.gr/~ikarampinis/bookNotFound.png";
                    
                    $.ajax({
                       url: bookUrl + "inauthor:"+searchData +"&maxResults=40&"+apiKey,

                       dataType: "json",
                       success: function(response) {
                         console.log(response);
                         if (response.totalItems === 0) {
                           alert("no result!.. try again")
                         }
                         else {
                           $(".page_body").css("visibility", "visible");
                           add(response, check);
                         }
                       },
                       error: function () {
                         alert("Something went wrong.....Try again!");
                       }
                    });
                    
                    function add(response, check){
                        var table = [];
                        var newtable = [];
                        var counter = 0;
                        for (var i = 0; i < 40; i++) {
                          item = response.items[i];
                          if(typeof item === 'undefined'){
                              break;
                          }
                          var bookImage = (item.volumeInfo.imageLinks) ? item.volumeInfo.imageLinks.thumbnail : placeHldr ;
                          if(typeof item.volumeInfo.title === 'undefined'){
                              item.volumeInfo.title="Untitled";
                          }
                          if(typeof item.volumeInfo.authors === 'undefined'){
                              item.volumeInfo.authors="Unknown";
                          }
                          if(typeof item.volumeInfo.publisher === 'undefined'){
                              item.volumeInfo.publisher = "Unknown";
                          }
                          if(typeof item.volumeInfo.ratingsCount === 'undefined' || typeof item.volumeInfo.averageRating === 'undefined'){
                              continue;
                          }
                          if(typeof item.volumeInfo.ratingsCount === 0 || typeof item.volumeInfo.averageRating === 0){
                              continue;
                          }
                          if(typeof item.volumeInfo.industryIdentifiers === 'undefined'){
                              continue;
                          }
                          if(item.volumeInfo.industryIdentifiers[0].type === 'OTHER'){
                              continue;
                          }
                          if(item.volumeInfo.industryIdentifiers[0].type === 'ISSN'){
                              continue;
                          }


                          var book = {
                            title: item.volumeInfo.title,
                            author: item.volumeInfo.authors,
                            publisher: item.volumeInfo.publisher,
                            bookIsbn : item.volumeInfo.industryIdentifiers[0].identifier,
                            publish_date : item.volumeInfo.publishedDate,
                            page_count : item.volumeInfo.pageCount,
                            ratings: item.volumeInfo.averageRating,
                            ratings_count : item.volumeInfo.ratingsCount,
                            bookImg: bookImage
                          };
                          table[counter]= book;
                          counter++;
                        }
                        if(table.length > 5){
                            for(i=0; i<5; i++){
                                var random = Math.floor(Math.random() * table.length); 
                                var j=0;
                                for(j=0; j<i; j++){
                                    if(newtable[j] === table[random]){
                                        break;
                                    }
                                }
                                if(j !== i){
                                    i--;
                                    continue;
                                }
                                newtable[i] = table[random];
                            }
                        }
                        else{
                            for(i=0; i<table.length; i++){
                                newtable[i] === table[i];
                            }
                        }
                        displayResults(newtable, check);
                    }

                    function displayResults(newtable, check) {
                        if(check === "1"){
                            var outputList = document.getElementById("single");
                            outputList.innerHTML="";
                            for (var i = 0; i < newtable.length; i++) {
                                if(i === 2){
                                    break;
                                }
                                outputList.innerHTML += formatOutput(newtable[i]);
                            }
                            var outputList = document.getElementById("single-extend");
                            outputList.innerHTML="";
                            for(var i=2; i<newtable.length; i++){
                                outputList.innerHTML += formatOutput(newtable[i]);
                            }
                        }
                        if(check === "2"){
                            var outputList = document.getElementById("first");
                            outputList.innerHTML="";
                            outputList.innerHTML += formatOutput(newtable[0]);
                            var outputList = document.getElementById("first-extend");
                            outputList.innerHTML="";
                            for(i=1; i<newtable.length; i++){
                                if(i === 3){
                                    break;
                                }
                                outputList.innerHTML += formatOutput(newtable[i]);
                            }
                            searchFunction("<%= author_two%>", "3");
                        }
                        if(check === "3"){
                            var outputList = document.getElementById("second");
                            outputList.innerHTML="";
                            outputList.innerHTML += formatOutput(newtable[0]);
                            var outputList = document.getElementById("second-extend");
                            outputList.innerHTML="";
                            for(i=1; i<newtable.length; i++){
                                if(i === 3){
                                    break;
                                }
                                outputList.innerHTML += formatOutput(newtable[i]);
                            }
                        }
                    }

                    function formatOutput(info) {
                      if(info.ratings_count === 0 || info.ratings === 0){
                          return "";
                      }
                      var info_path = info.title+"=="+info.author+"=="+info.bookIsbn+"=="+info.ratings_count+"=="+info.ratings+"=="+info.bookImg;
                      var htmlCard = `<div class="book">
                            <div class="book_photo">
                            <img src="\${info.bookImg}" style="width: 170px">
                            </div><div class="book_info">
                            <h3>\${info.title}</h3>
                            <p>Author: \${info.author}</p>
                            <p>Rating: \${info.ratings} / 5 <i style="color:#ffcc00" class="fas fa-star"></i></p>
                            <button><a class="button" style=\"color: white; text-decoration: none\" href="book?info=\${info_path}">View</a></button></div></div>`;
                      return htmlCard;
                    }
                    function displayError() {
                      alert("search term can not be empty!")
                    }
                }
             </script>
            <br><br><br>
            <hr>
            <br>

            <h2>Editors' Picks</h2>
            <div class="Suggestions">
                <%
                  bookDao editorsBooks = new bookDao();
                  List editorslist = editorsBooks.getEditorsPicks();
                  Iterator<Books> it_editors = editorslist.iterator();
                  int editors_picks_counter = 0;
                  while(it_editors.hasNext()){
                      editors_picks_counter++;
                      Books curr_pick = it_editors.next();
                      String curr_path = curr_pick.getTitle()+"=="+curr_pick.getAuthor()+"=="+curr_pick.getIsbn()+"=="+curr_pick.getRatingCounter()+"=="+curr_pick.getRatings()+"=="+curr_pick.getImage();
                      out.print("<a href=\"book?info="+curr_path+"\"><button class=\"Suggestion-button\">");
                      if(curr_pick.getImage().equals("http://inf-server.inf.uth.gr/~ikarampinis/bookNotFound.png")){
                          out.print("<div class=\"Suggestion-image\"><img src=\"http://inf-server.inf.uth.gr/~ikarampinis/bookNotFound.png\" style=\"height: 200px\">");
                      }
                      else{
                          out.print("<div class=\"Suggestion-image\"><img src=\""+curr_pick.getImage()+"&printsec=frontcover&img=1&zoom=1&source=gbs_api"+"\" style=\"height: 200px\">");
                      }
                      out.print("</div><p>"+curr_pick.getTitle()+"</p></button></a>");
                      if(editors_picks_counter == 4){
                          break;
                      }
                  }
                %>
            </div>
            <br><br><br>
            <a href="editors_picks.jsp?WhichEdit=1"><button class="more">View More...</button></a>
            <br><br><br>
            <hr>
            <br>


            <h2>Popular Authors</h2>
            <div class="authors">
                <%
                    TopAuthorsDAO dao = new TopAuthorsDAO();
                    List list = dao.getTopAuthors();
                    Iterator<TopAuthors> it = list.iterator();
                    TopAuthors author;
                    while(it.hasNext()){
                        author = it.next();
                        out.print("<a href=\"by_author.jsp?authors="+author.getName()+"\">");
                        out.print("<button class=\"authors-btn\">");
                        out.print("<div class=\"authors-img\" id=\"round\">");
                        out.print("<img src=\""+author.getPhoto()+"\">");
                        out.print("<p>"+author.getName()+"</p>");
                        out.print("</div>");
                        out.print("</button></a>");
                        if(author.getId() == 4){
                            out.print("<div id=\"hideAuth\">");
                        }
                    }
                    out.print("</div>");
                %>
            </div>
            <br><br><br>
            <div id="MoreAuth"><a><button class="more" onclick="TopAuth()">View More...</button></a></div>
            <div id="LessAuth"><a><button class="more" onclick="TopAuth()">View Less...</button></a></div>
            <br><br><br>
            <hr>

            <h2>My TBR Books:</h2>
            <div class="Suggestions">
            <%
                UserBooksDAO userdao = new UserBooksDAO();
                bookDao bookdao = new bookDao();
                List array = userdao.getWantToReadList(session.getAttribute("username").toString());
                if(array.isEmpty()){
                    out.print("<center><p>No books to be read!</p></center>");
                }
                Iterator<UserBooks> user_it = array.iterator();
                UserBooks book;
                int i = 0;
                while(user_it.hasNext()){
                    if(i > 3){
                        break;
                    }
                    book = user_it.next();
                    String isbn = book.getUserBooksPK().getBooksIsbn();
                    String[] details = bookdao.getbook(isbn);
                    String curr_path = details[2]+"=="+details[1]+"=="+details[0]+"=="+details[4]+"=="+details[3]+"=="+details[5];
                    out.print("<a href=\"book?info="+curr_path+"\">");
                    out.print("<button class=\"Suggestion-button\">");
                    out.print("<div class=\"Suggestion-image\">");
                    out.print("<img src=\""+details[5]+"\" style=\"height:200px\">");
                    out.print("</div><p>"+details[2]+"</p></button></a>");
                    i = i + 1;
                }
                out.print("</div><br><br><br>");
                if(array.size()>4){
                    out.print("<a href=\"myBooks.jsp?WhichBooks=1\"><button class=\"more\">View More...</button></a>");
                }
                out.print("<br><br><br></div>");
            %>


          <div class="body_right">
            <center><h2>Upcoming Releases...</h2></center>
            <div class="container">
              <%
                UpcomingDAO upcomingbook = new UpcomingDAO();
                List upc = upcomingbook.upcomingbooks();
                int length = upc.size();
                String image;
                Upcoming books;
                int j=1;
                Iterator<Upcoming> it1 = upc.iterator();
                while(it1.hasNext()){
                    books = it1.next();
                    image = upcomingbook.getImage(books.getId());
                    out.print("<div class=\"mySlides\">");
                    out.print("<div class=\"numbertext\">"+j+ "/"+ length+"</div>");
                    out.print("<center><img src=\"data:image/jpg;base64,"+image+"\" title=\""+books.getName()+"\" style=\"height: 318px\"></center></div>"); 
                    j = j+1;
                }
            %>

              <a class="prev" onclick="plusSlides(-1)"><</a>
              <a class="next" onclick="plusSlides(1)">></a>

              <div class="caption-container">
                <p id="caption"></p>
              </div>

              <%
                  j=1;
                  Iterator<Upcoming> it2 = upc.iterator();
                  while(it2.hasNext()){
                    books = it2.next();
                    image = upcomingbook.getImage(books.getId());
                    out.print("<div class=\"row\">");
                    out.print("<div class=\"column\" style=\"margin-bottom:4px;\">");
                    out.print("<center><img class=\"demo cursor\" src=\"data:image/jpg;base64,"+image+"\" style=\"height: 52.5px;\" onclick=\"currentSlide("+j+")\" alt=\""+books.getName()+"\"></center></div>"); 
                }
              %>
            </div>

            <script>
            var slideIndex = 1;
            showSlides(slideIndex);

            function plusSlides(n) {
              showSlides(slideIndex += n);
            }

            function currentSlide(n) {
              showSlides(slideIndex = n);
            }

            function showSlides(n) {
              var i;
              var slides = document.getElementsByClassName("mySlides");
              var dots = document.getElementsByClassName("demo");
              var captionText = document.getElementById("caption");
              if (n > slides.length) {slideIndex = 1}
              if (n < 1) {slideIndex = slides.length}
              for (i = 0; i < slides.length; i++) {
                  slides[i].style.display = "none";
              }
              for (i = 0; i < dots.length; i++) {
                  dots[i].className = dots[i].className.replace(" active", "");
              }
              slides[slideIndex-1].style.display = "block";
              dots[slideIndex-1].className += " active";
              captionText.innerHTML = dots[slideIndex-1].alt;
            }
            </script>
            
          </div>
        </div>
    </body>
</html>

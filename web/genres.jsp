<%@page import="project_dao.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BookWay | Genres</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <LINK rel="stylesheet" href="search_result.css">
        <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
        <link href="https://fonts.googleapis.com/css2?family=Nothing+You+Could+Do&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="header_style.css">
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <script src="https://code.jquery.com/jquery-3.1.0.js"></script>
        <script>
            function searchFunction(){
                var item, bookImg, title, author, publisher, bookLink, bookIsbn, publish_date, page_count, rating, ratings_count;
                var bookUrl = "https://www.googleapis.com/books/v1/volumes?q=";
                var apiKey = "key=AIzaSyCcGQ9qXq3eNzZVn1Vcvk94D65IsE8kUFc";
                var placeHldr = "http://inf-server.inf.uth.gr/~ikarampinis/bookNotFound.png";
                var outputList = document.getElementById("list-output");
                var subject= '<%= request.getParameter("genre")%>';
                var total_response_size=0;
                var table = [];
                var k=1;
                var counter=0;
                subject = "subject:"+subject;
                outputList.innerHTML="";
                
                $.ajax({
                   url: bookUrl + subject +"&maxResults=40&"+"startIndex="+k+"&"+ apiKey,
                   dataType: "json",
                   success: function(response) {
                     console.log(response);
                     if (response.totalItems === 0) {
                       alert("no result!.. try again")
                     }
                     else {
                       total_response_size = response.totalItems;
                       $(".page_body").css("visibility", "visible");
                       addarray(response, 0);
                       if(total_response_size>39){
                        next(40);
                       }
                     }
                   },
                   error: function () {
                     alert("Something went wrong.....Try again!");
                   }
                });
                
                console.log(table);
                
                function next(k){
                    if(k<total_response_size){
                        $.ajax({
                            url: bookUrl + subject +"&maxResults=40&"+"startIndex="+k+"&"+apiKey,
                            dataType: "json",
                            success: function(response) {
                              console.log(response);
                              if (response.totalItems === 0) {
                                alert("no result!.. try again")
                              }
                              else {
                                total_response_size = response.totalItems;
                                $(".page_body").css("visibility", "visible");
                                if(total_response_size - k > 0){
                                    addarray(response, k);
                                }
                                else{
                                    table.sort(compare);
                                    displayResults(table);
                                }
                                if(total_response_size>k+40){
                                    next(k+40);
                                }
                                else{
                                    table.sort(compare);
                                    displayResults(table);
                                }
                              }
                            },
                            error: function () {
                              alert("Something went wrong.....Try again!");
                            }
                        });
                    }
                }
                
                function addarray(response, step){
                    for (var i = 0; i < 40; i++) {
                      item = response.items[i];
                      if(typeof item === 'undefined'){
                          table.sort(compare);
                          displayResults(table);
                          break;
                      }
                      if(typeof item.volumeInfo === 'undefined'){
                          continue;
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
                            item.volumeInfo.ratingsCount = 0;
                            item.volumeInfo.averageRating = 0;
                      }
                      if(typeof item.volumeInfo.industryIdentifiers === 'undefined' || item.volumeInfo.industryIdentifiers[0] === 'undefined'){
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
                        bookLink: item.volumeInfo.previewLink,
                        bookIsbn : item.id,
                        publish_date : item.volumeInfo.publishedDate,
                        page_count : item.volumeInfo.pageCount,
                        ratings: item.volumeInfo.averageRating, 
                        ratings_count : item.volumeInfo.ratingsCount,
                        bookImg: bookImage
                      };
                      table[counter]= book;
                      counter++;
                    }
                }
                
                function close_gif(){
                    var x = document.getElementById("loader");
                      x.style.display = "none";
                }
                
                function compare( a, b ) {
                    if ( a.ratings_count < b.ratings_count ){
                      return 1;
                    }
                    if ( a.ratings_count > b.ratings_count ){
                      return -1;
                    }
                    return 0;
                }
                
                function displayResults(table) {
                    for (var i = 0; i < table.length; i++) {
                      outputList.innerHTML += formatOutput(table[i]);
                    }
                    close_gif();
                }

                function formatOutput(info) {
                  info.author = info.author.toString().replace(/&/g, "and");
                  info.title = info.title.toString().replace(/&/g, "and");
                  var info_path = info.title+"=="+info.author+"=="+info.bookIsbn+"=="+info.ratings_count+"=="+info.ratings+"=="+info.bookImg;
                  var htmlCard = `<div class="book">
                        <div class="book_photo">
                          <img src="\${info.bookImg}" style="width: 170px">
                        </div>
                        <div class="book_info">
                          <h3>\${info.title}</h3>
                          <p>Author: \${info.author}</p>
                          <p>Publisher: \${info.publisher}</p>
                          <p>Page count: \${info.page_count}</p>
                          <a class="button" href="book?info=\${info_path}">View</a>
                        </div>
                      </div>`;
                  return htmlCard;
                }
                function displayError() {
                  alert("search term can not be empty!")
                }
            }
        </script>
    </head>

    <body onload="searchFunction();">
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
          <div id="list-output" class="body_left">

          </div>
        </div>
        <center><div id="loader" style="display: block;"><img src="images/load.gif"/></div></center>
    </body>
</html>


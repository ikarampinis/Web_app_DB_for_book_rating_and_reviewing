<%@page import="project_dao.FavAuthDAO"%>
<%@page import="project_dao.UserBooksDAO"%>
<%@page import="entity.Comments"%>
<%@page import="java.util.ListIterator"%>
<%@page import="java.util.Iterator"%>
<%@page import="project_dao.CommentDAO"%>
<%@page import="java.util.List"%>
<%@page import="project_dao.UserDAO"%>
<%@page import="project_dao.ViewDAO"%>
<%@page import="java.lang.Math"%>
<%@page import="java.math.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>BookWay | Book page</title>
        <meta charset ="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <LINK rel="stylesheet" href="book_styles.css">
        <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
        <link href="https://fonts.googleapis.com/css2?family=Nothing+You+Could+Do&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="header_style.css">
        <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <script src="https://code.jquery.com/jquery-3.1.0.js"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.6.3/js/all.js" integrity="sha384-EIHISlAOj4zgYieurP0SdoiBYfGJKkgWedPHH4jCzpCXLmzVsw1ouK59MuUtP4a1" crossorigin="anonymous"></script>
    </head>

    <body onload="searchFunction(), authorBooks()">
        <%
            response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");//http 1.1
            response.setHeader("Pragma", "no-cache");//http 1.0
            response.setHeader("Expires", "0");//proxies
            
            if(session.getAttribute("username")==null){
                response.sendRedirect("login.jsp");
            }
        %>
        <% String[] array = (String[])request.getAttribute("book_information");%>
        <% int isbn_len = array[0].length();%>
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
            <div class="body_left">
                <div class="book">
                    <div class="book_photo">
                        <div class="book_img" id="book_img">
                            <!-- image -->
                        </div>
                        <div id="Books_Status">
                            <%
                                UserBooksDAO ubdao = new UserBooksDAO();
                                int status = ubdao.FindStatus(session.getAttribute("username").toString(), array[0]);
                                if(status == 0){
                                    out.print("<center><button id=\"add-list\" onclick=\"AddList()\"style=\"background-color:green;color:white;border-radius:4px;padding:5px;font-size:14px;border:0\">Add to my list</button></center>");
                                }
                                else if(status == 1){
                                    out.print("<center><button id=\"add-reading\" onclick=\"AddReading()\"style=\"background-color:green;color:white;border-radius:4px;padding:5px;font-size:14px;border:0\">Reading now</button>&ensp;");
                                    out.print("<button id=\"remove-list\" onclick=\"RemoveList()\"style=\"background-color:red;color:white;border-radius:4px;padding:5px;font-size:14px;border:0\">Remove from my list</button></center>");
                                }
                                else if(status==2){
                                    out.print("<center><button id=\"add-finished\" onclick=\"AddFinished()\"style=\"background-color:green;color:white;border-radius:4px;padding:5px;font-size:14px;border:0\">Read</button>&ensp;");
                                    out.print("<button id=\"remove-reading\" onclick=\"RemoveReading()\"style=\"background-color:red;color:white;border-radius:4px;padding:5px;font-size:14px;border:0\">Remove from my list</button></center>");
                                }
                                else if(status == 3){
                                    out.print("<center><p style=\"border-style: 1px solid\"><i class=\"fa fa-check\" aria-hidden=\"true\"></i>Read &ensp;");
                                    out.print("<button id=\"remove-finished\" onclick=\"RemoveFinished()\"style=\"background-color:red;color:white;border-radius:4px;padding:5px;font-size:14px;border:0\">Remove from my list</button></p></center>");
                                }
                            %>
                        </div>
                        <br>
                        <center>
                            <div class="user_rate" id="user_rate">
                            <%  ViewDAO view = new ViewDAO();
                                int your_rate = view.bookRating(session.getAttribute("username").toString(), array[0]);
                                if(your_rate !=-1){
                                    out.print("You rated this book with: "+your_rate+" / 5 <i style=\"color:#ffcc00 \" class=\"fas fa-star\"></i>");
                                }
                                else{
                                    out.print("<label for=\"rate\">Rate this book:<br></label>");
                                    out.print("<select name=\"rate_value\" id=\"rate_value\" style=\"width: 35px;height: 23px;background-color: transparent;font-size: 18px;\"><option value=\"1\">1</option><option value=\"2\">2</option><option value=\"3\">3</option><option value=\"4\">4</option><option value=\"5\">5</option></select> / 5 <i style=\"color:#ffcc00 \" class=\"fas fa-star\"></i>");
                                    out.print("<br><button class=\"submit\" onclick=\"Rated()\">Submit</button>");
                                }
                            %>
                            </div>
                        </center>
                    </div>
                    <div class="book_info">
                        <div class="book_characteristics" id="book_characteristics_1">
                            <!-- information -->
                        </div>
                        <div id="fav-author">
                        <%
                            FavAuthDAO fav = new FavAuthDAO();
                            if(fav.isFavAuth(session.getAttribute("username").toString(), array[1])){
                                out.print("<h3>"+array[1]+" <button id=\"heart\" onclick=\"rmfav()\"><i class=\"fa fa-heart\" style=\"width: 20px; height: 20px; color: red\"></i></button></h3>");
                            }
                            else{
                                out.print("<h3>"+array[1]+" <button id=\"heart\" onclick=\"addfav()\"><i class=\"fa fa-heart\" style=\"width: 20px; height: 20px\"></i></button></h3>");
                            }
                        %>
                        </div>
                        <div class="book_characteristics_2" id="book_characteristics_2">
                            <!-- information -->
                        </div>
                    </div>
                </div>
                
                
                    
               
                <br>
                <h3>Reviews</h3>
               
                <hr>
                <div class="Reviews">
                    <textarea placeholder="Write your review..." name="new_comment" id="new_comment"></textarea>
                    <button id="add_comment" onclick="addTheComment()">Submit</button>
                    <br><br><br><br>
                    
                    <div class="The_comments" id="The_comments">
                    <% 
                        CommentDAO commentdao = new CommentDAO();
                        ViewDAO comm_viewdao = new ViewDAO();
                        List list = commentdao.getComments(array[0]);
                        Iterator<Comments> it = list.iterator();
                        String user_comment = "";
                        String date_comment = "";
                        int rate_comment = 0;
                        String Comment = "";
                        Comments comm = null;
                        while(it.hasNext()){
                            comm = it.next();
                            user_comment = comm.getCommentsPK().getUserHasBooksUserUsername();
                            date_comment = comm.getDate();
                            Comment = comm.getComment();
                            rate_comment = comm_viewdao.bookRating(user_comment, comm.getCommentsPK().getUserHasBooksBooksIsbn());
                            out.print("<div class=\"row\">");
                            out.print("<div class=\"column\">");
                            out.print("<div class=\"card\">");
                            if(session.getAttribute("username").equals(user_comment)){
                                out.print("<button onclick=\"RmvComment("+comm.getCommentsPK().getId()+")\" style=\"float: right; border: none; background-color: transparent; font-size: 24px; font-weight: bold; color: black;\">&times;</button>");
                            }
                            out.print("<div class=\"container\">");
                            if(rate_comment == -1){
                                if(session.getAttribute("username").equals(user_comment)){
                                    out.print("<ul><li class=\"serif\"><b>"+user_comment+"</b>&emsp;&emsp;"+date_comment+"<br>-\""+Comment+"\"</li></ul>");
                                }
                                else{
                                    out.print("<ul><li class=\"serif\"><b><a style=\"color:black\" href=\"other_profs?name="+user_comment+"\">"+user_comment+"</a></b>&emsp;&emsp;"+date_comment+"<br>-\""+Comment+"\"</li></ul>");
                                }
                            }
                            else{
                                if(session.getAttribute("username").equals(user_comment)){
                                    out.print("<ul><li class=\"serif\"><b>"+user_comment+"</b> rated with "+rate_comment+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i>&emsp;&emsp;"+date_comment+"<br>-\""+Comment+"\"</li></ul>");
                                }
                                else{
                                    out.print("<ul><li class=\"serif\"><b><a style=\"color:black\" href=\"other_profs?name="+user_comment+"\">"+user_comment+"</a></b> rated with "+rate_comment+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i>&emsp;&emsp;"+date_comment+"<br>-\""+Comment+"\"</li></ul>");
                                }
                            }
                            out.print("</div></div></div></div>");
                        }
                    %>
                    </div>
                </div>
            </div>

            <div class="body_right">
                <center><h2>Other books by <%= array[1]%></h2></center>
                <div class="suggested" id="AuthorBooks">

                </div>
            </div>
        </div>
        <script>
            function searchFunction(){
                var item, bookImg, title, author, publisher, desc, bookIsbn, date, pages, rating, ratings_count;
                var bookUrl = "https://www.googleapis.com/books/v1/volumes?q=";
                var apiKey = "key=AIzaSyCcGQ9qXq3eNzZVn1Vcvk94D65IsE8kUFc";
                var placeHldr = "http://inf-server.inf.uth.gr/~ikarampinis/bookNotFound.png";
                var outputList = document.getElementById("book_img");
                var info_array =["<%= array[0]%>","<%=array[1]%>","<%=array[2]%>","<%=array[3]%>","<%=array[4]%>"];
                <% float value = (float)Integer.parseInt(array[3])/Integer.parseInt(array[4]);
                   value = value * 100;
                   value = Math.round(value);
                   value = value /100;%>
                var rate = <%= value%>;
                outputList.innerHTML="";
                
                $.ajax({
                   url: bookUrl + "isbn:"+info_array[0]+"&"+apiKey,
                   dataType: "json",
                   success: function(response) {
                     console.log(response);
                     if (response.totalItems === 0) {
                       second_try();
                     }
                     else {
                       $(".page_body").css("visibility", "visible");
                       displayResponse(response);
                     }
                   },
                   error: function () {
                     alert("Something went wrong.....Try again!");
                   }
                });
                function second_try(){
                    $.ajax({
                       url: bookUrl+info_array[0]+"&"+apiKey,
                       dataType: "json",
                       success: function(response) {
                         console.log(response);
                         if (response.totalItems === 0) {
                           alert("no result!.. try again");
                         }
                         else {
                           $(".page_body").css("visibility", "visible");
                           displayResponse(response);
                         }
                       },
                       error: function () {
                         alert("Something went wrong.....Try again!");
                       }
                    });
                }

                function displayResponse(response) {

                    item = response.items[0];
                    if(typeof item.volumeInfo.title === 'undefined'){
                        item.volumeInfo.title = "Unknown";
                    }
                    if(typeof item.volumeInfo.authors === 'undefined'){
                        item.volumeInfo.authors = "Unknown";
                    }
                    if(typeof item.volumeInfo.publisher === 'undefined'){
                        item.volumeInfo.publisher = "Unknown";
                    }
                    if(typeof item.volumeInfo.publishedDate === 'undefined'){
                        item.volumeInfo.publishedDate = "Unknown";
                    }
                    if(typeof item.volumeInfo.pageCount === 'undefined'){
                        item.volumeInfo.pageCount = "Unknown";
                    }
                    if(typeof item.volumeInfo.description === 'undefined'){
                        item.volumeInfo.description = "There is no description for this book!";
                    }
                    title = item.volumeInfo.title;
                    author = item.volumeInfo.authors;
                    publisher = item.volumeInfo.publisher;
                    bookImg = (item.volumeInfo.imageLinks) ? item.volumeInfo.imageLinks.thumbnail : placeHldr ;
                    date = item.volumeInfo.publishedDate;
                    pages = item.volumeInfo.pageCount;
                    desc = item.volumeInfo.description;
                    outputList.innerHTML += formatOutput1(bookImg);
                    outputList = document.getElementById("book_characteristics_1");
                    outputList.innerHTML="";
                    outputList.innerHTML += formatOutput2(title);
                    outputList = document.getElementById("book_characteristics_2");
                    outputList.innerHTML="";
                    outputList.innerHTML += formatOutput3(publisher, pages, desc, date);
                }

                function formatOutput1(bookImg) {
                    var htmlCard = `<img src="\${bookImg}" >`;
                    return htmlCard;
                }

                function formatOutput2(title) {
                    var htmlCard = `<h2>\${title}</h2>`;
                    return htmlCard;
                }
                
                function formatOutput3(publisher, pages, desc, date) {
                    var htmlCard = `
                            <div class="details">
                                <p>Published: \${date} by <i> \${publisher}</i></p>
                                <p>Page count: \${pages}</p>
                                <p class="rateOfBook" id="rateOfBook">Rating: \${rate} / 5 <i style="color:#ffcc00 " class="fas fa-star"></i></p>
                            </div>
                            <br>
                            <p>\${desc}</p>`;
                    return htmlCard;
                }

                function displayError() {
                  alert("search term can not be empty!")
                }
            }
        </script>

        <script>
            function authorBooks(){
                var item, bookImg, title, author, publisher, desc, bookIsbn, date, pages, ratings, ratings_count;
                var bookUrl = "https://www.googleapis.com/books/v1/volumes?q=";
                var apiKey = "key=AIzaSyCcGQ9qXq3eNzZVn1Vcvk94D65IsE8kUFc";
                var placeHldr = "http://inf-server.inf.uth.gr/~ikarampinis/bookNotFound.png";
                var outputList = document.getElementById("AuthorBooks");
                var info_array =["<%= array[0]%>","<%=array[1]%>","<%=array[2]%>","<%=array[3]%>","<%=array[4]%>"];
                outputList.innerHTML="";

                $.ajax({
                   url: bookUrl + "inauthor:"+info_array[1]+"&maxResults=40"+"&"+apiKey,
                   dataType: "json",
                   success: function(response) {
                     console.log(info_array[1]);
                     console.log(response);
                     if (response.totalItems === 0) {
                       alert("no result!.. try again");
                     }
                     else {
                       $(".page_body").css("visibility", "visible");
                       displayAuthorBooks(response);
                     }
                   },
                   error: function () {
                     alert("Something went wrong.....Try again!");
                   }
                });


                function displayAuthorBooks(response) {
                    var max=0;
                    for(var i=0; i<40; i++){
                        item = response.items[i];
                        if(max === 8){
                            break;
                        }
                        max=max+1;
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
                        if(typeof item.volumeInfo.industryIdentifiers === 'undefined'){
                            max=max-1;
                            continue;
                        }
                        if(item.volumeInfo.industryIdentifiers[0].type === 'OTHER'){
                            max=max-1;
                            continue;
                        }
                        if(item.volumeInfo.industryIdentifiers[0].type === 'ISSN'){
                            max=max-1;
                            continue;
                        }

                        title = item.volumeInfo.title;
                        author = item.volumeInfo.authors;
                        publisher= item.volumeInfo.publisher;
                        bookIsbn = item.volumeInfo.industryIdentifiers[0].identifier;
                        date = item.volumeInfo.publishedDate;
                        pages = item.volumeInfo.pageCount;
                        ratings= item.volumeInfo.averageRating;
                        ratings_count = item.volumeInfo.ratingsCount;
                        bookImg = (item.volumeInfo.imageLinks) ? item.volumeInfo.imageLinks.thumbnail : placeHldr ;

                        if(bookImg === placeHldr){
                            max=max-1;
                            continue;
                        }

                        outputList.innerHTML+= formatOutput(title, author, bookIsbn, ratings_count, ratings, bookImg);
                    }
                    console.log(outputList);
                }

                function formatOutput(title, author, bookIsbn, ratings_count, ratings, bookImg) {
                  var info_path = title+"=="+author+"=="+bookIsbn+"=="+ratings_count+"=="+ratings+"=="+bookImg;
                  var htmlCard = `<a class="button" title="\${title}" href="book?info=\${info_path}"><img src="\${bookImg}"></a>`;
                  return htmlCard;
                }
                function displayError() {
                  alert("search term can not be empty!");
                }
            }
        </script>

        <script>
            function Rated(){
                var user_rating = $("#rate_value").val();
                var book_isbn = "<%= array[0]%>";
                var isbn_length = "<%= isbn_len%>";
                if(user_rating === "" || user_rating === null) {
                    Error();
                }
                else{
                    var NewRating = "<%= Integer.parseInt(array[3])%>";
                    var NewRateCount = "<%= Integer.parseInt(array[4])%>";
                    document.cookie = `new_comment = ""}`;
                    document.cookie = `the_rate= \${user_rating}`;
                    document.cookie = `the_isbn= \${book_isbn}`;
                    document.cookie = `length= \${isbn_length}`;
                    document.cookie = `new_rating = \${NewRating}`;
                    document.cookie = `new_rate_count = \${NewRateCount}`;
                    document.cookie = `comm_id="-1"`;
                    console.log(document.cookie);
                    $('#user_rate').load('new_rate.jsp');
                    $('#rateOfBook').load('update_rate.jsp');
                    $('#The_comments').load('new_comment.jsp');
                }  
            }
            
            function addTheComment(){
                var user_new_comment = $("#new_comment").val();
                var book_isbn = "<%= array[0]%>";
                var isbn_length = "<%= isbn_len%>";
                if(user_new_comment === "" || user_new_comment === null) {
                    Error();
                }
                else{
                    user_new_comment = user_new_comment.replace(/\s/g, "!2#@");
                    document.cookie = `the_rate= "-1"`;
                    document.cookie = `new_comment = \${user_new_comment}`;
                    document.cookie = `the_isbn= \${book_isbn}`;
                    document.cookie = `length= \${isbn_length}`;
                    document.cookie = `new_rating = "-1"`;
                    document.cookie = `new_rate_count = "-1"`;
                    document.cookie = `comm_id="-1"`;
                    console.log(document.cookie);
                    $('#The_comments').load('new_comment.jsp');
                    $("#new_comment").val("");
                } 
            }
            
            function RmvComment(id){
                var book_isbn = "<%= array[0]%>";
                var isbn_length = "<%= isbn_len%>";
                document.cookie = `the_rate= "-1"`;
                document.cookie = `new_comment = ""`;
                document.cookie = `the_isbn= \${book_isbn}`;
                document.cookie = `length= \${isbn_length}`;
                document.cookie = `new_rating = "-1"`;
                document.cookie = `new_rate_count = "-1"`;
                document.cookie = `comm_id=\${id}`;
                $('#The_comments').load('new_comment.jsp');
            }
            
            function AddList(){
                var book_isbn = "<%= array[0]%>";
                var isbn_length = "<%= isbn_len%>";
                document.cookie = `activity="1"`;
                document.cookie = `the_isbn= \${book_isbn}`;
                document.cookie = `length= \${isbn_length}`;
                $('#Books_Status').load('Books_list.jsp');
            }
            
            function AddReading(){
                var book_isbn = "<%= array[0]%>";
                var isbn_length = "<%= isbn_len%>";
                document.cookie = `activity="2"`;
                document.cookie = `the_isbn= \${book_isbn}`;
                document.cookie = `length= \${isbn_length}`;
                $('#Books_Status').load('Books_list.jsp');
            }
            
            function RemoveList(){
                var book_isbn = "<%= array[0]%>";
                var isbn_length = "<%= isbn_len%>";
                document.cookie = `activity="3"`;
                document.cookie = `the_isbn= \${book_isbn}`;
                document.cookie = `length= \${isbn_length}`;
                $('#Books_Status').load('Books_list.jsp');
            }
            
            function AddFinished(){
                var book_isbn = "<%= array[0]%>";
                var isbn_length = "<%= isbn_len%>";
                document.cookie = `activity="4"`;
                document.cookie = `the_isbn= \${book_isbn}`;
                document.cookie = `length= \${isbn_length}`;
                $('#Books_Status').load('Books_list.jsp');
            }
            
            function RemoveReading(){
                var book_isbn = "<%= array[0]%>";
                var isbn_length = "<%= isbn_len%>";
                document.cookie = `activity="5"`;
                document.cookie = `the_isbn= \${book_isbn}`;
                document.cookie = `length= \${isbn_length}`;
                $('#Books_Status').load('Books_list.jsp');
            }
            
            function RemoveFinished(){
                var book_isbn = "<%= array[0]%>";
                var isbn_length = "<%= isbn_len%>";
                document.cookie = `activity="8"`;
                document.cookie = `the_isbn= \${book_isbn}`;
                document.cookie = `length= \${isbn_length}`;
                $('#Books_Status').load('Books_list.jsp');
            }
            
            function addfav(){
                var author = "<%= array[1]%>";
                author = author.replace(/\s/g, "!2#@");
                document.cookie = `activity="6"`;
                document.cookie = `the_author= \${author}`;
                $('#fav-author').load('Author.jsp');
            }
            
            function rmfav(){
                var author = "<%= array[1]%>";
                author = author.replace(/\s/g, "!2#@");
                document.cookie = `activity="7"`;
                document.cookie = `the_author= \${author}`;
                $('#fav-author').load('Author.jsp');
            }
            
            function Error() {
                alert("Can not be empty!");
            }
        </script>
    </body>
</html>
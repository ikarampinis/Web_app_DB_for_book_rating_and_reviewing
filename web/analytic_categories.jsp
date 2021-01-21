<%@page import="project_dao.UserDAO"%>
<%@ page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>BookWay | Genres</title>
        <meta charset ="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <LINK rel="stylesheet" href="genres_style.css">
        <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
        <link href="https://fonts.googleapis.com/css2?family=Nothing+You+Could+Do&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="header_style.css">
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
        
        <div class="page_body">
            <div class="main">
                <center><h1>Genres</h1></center>
                <div class="genres_choices">
                    <div class="left">
                        <a class="active" href="search_category?category=antiques/collectibles">Antiques & Collectibles</a><hr>
                            <a class="active" href="search_category?category=architecture">Architecture</a><hr>
                            <a class="active" href="search_category?category=art">Art</a><hr>
                            <a class="active" href="search_category?category=bibles">Bibles</a><hr>
                            <a class="active" href="search_category?category=biography/autobiography">Biography & Autobiography</a><hr>
                            <a class="active" href="search_category?category=body/mind/spirit">Body, Mind & Spirit</a><hr>
                            <a class="active" href="search_category?category=business/economics">Business & Economics</a><hr>
                            <a class="active" href="search_category?category=comics/graphic/novels">Comics & Graphic Novels</a><hr>
                            <a class="active" href="search_category?category=computers">Computers</a><hr>
                            <a class="active" href="search_category?category=cooking">Cooking</a><hr>
                            <a class="active" href="search_category?category=crafts/hobbies">Crafts & Hobbies</a><hr>
                            <a class="active" href="search_category?category=design">Design</a><hr>
                            <a class="active" href="search_category?category=drama">Drama</a><hr>
                            <a class="active" href="search_category?category=education">Education</a><hr>
                            <a class="active" href="search_category?category=family/relationships">Family & Relationships</a><hr>
                            <a class="active" href="search_category?category=fiction">Fiction</a><hr>
                            <a class="active" href="search_category?category=foreign/language/study">Foreign Language Study</a><hr>
                            <a class="active" href="search_category?category=games/activities">Games & Activities</a><hr>
                    </div>
                    <div class="center">
                            <a class="active" href="search_category?category=gardening">Gardening</a><hr>
                            <a class="active" href="search_category?category=health/fitness">Health & Fitness</a><hr>
                            <a class="active" href="search_category?category=history">History</a><hr>
                            <a class="active" href="search_category?category=house/home">House & Home</a><hr>
                            <a class="active" href="search_category?category=humor">Humor</a><hr>
                            <a class="active" href="search_category?category=juvenile/fiction">Juvenile Fiction</a><hr>
                            <a class="active" href="search_category?category=juvenile/nonfiction">Juvenile Nonfiction</a><hr>
                            <a class="active" href="search_category?category=language/arts/disciplines">Language Arts & Disciplines</a><hr>
                            <a class="active" href="search_category?category=law">Law</a><hr>
                            <a class="active" href="search_category?category=literary/collections">Literary Collections</a><hr>
                            <a class="active" href="search_category?category=literary/criticism">Literary Criticism</a><hr>
                            <a class="active" href="search_category?category=mathematics">Mathematics</a><hr>
                            <a class="active" href="search_category?category=medical">Medical</a><hr>
                            <a class="active" href="search_category?category=music">Music</a><hr>
                            <a class="active" href="search_category?category=nature">Nature</a><hr>
                            <a class="active" href="search_category?category=performing/arts">Performing Arts</a><hr>
                            <a class="active" href="search_category?category=pets">Pets</a><hr>
                            <a class="active" href="search_category?category=philosophy">Philosophy</a><hr>
                    </div>
                    <div class="right">
                            <a class="active" href="search_category?category=photography">Photography</a><hr>
                            <a class="active" href="search_category?category=poetry">Poetry</a><hr>
                            <a class="active" href="search_category?category=political/science">Political Science</a><hr>
                            <a class="active" href="search_category?category=psychology">Psychology</a><hr>
                            <a class="active" href="search_category?category=reference">Reference</a><hr>
                            <a class="active" href="search_category?category=religion">Religion</a><hr>
                            <a class="active" href="search_category?category=science">Science</a><hr>
                            <a class="active" href="search_category?category=self-help">Self-Help</a><hr>
                            <a class="active" href="search_category?category=social/science">Social Science</a><hr>
                            <a class="active" href="search_category?category=sports/recreation">Sports & Recreation</a><hr>
                            <a class="active" href="search_category?category=study/aids">Study Aids</a><hr>
                            <a class="active" href="search_category?category=technology/engineering">Technology & Engineering</a><hr>
                            <a class="active" href="search_category?category=transportation">Transportation</a><hr>
                            <a class="active" href="search_category?category=travel">Travel</a><hr>
                            <a class="active" href="search_category?category=true/crime">True Crime</a><hr>
                            <a class="active" href="search_category?category=young/adult/fiction">Young Adult Fiction</a><hr>
                            <a class="active" href="search_category?category=young/adult/nonfiction">Young Adult Nonfiction</a><hr>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

<%@page import="project_dao.UserDAO"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
 <title>BookWay | About Us</title>
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
 <link href="https://fonts.googleapis.com/css2?family=Nothing+You+Could+Do&display=swap" rel="stylesheet">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 <link rel="stylesheet" href="header_style.css">
 <link rel="stylesheet" href="about_us.css">
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
                <a class="active" href="about_us.jsp">About Us</a>
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

<center><h1><u><b>Meet The Team!</b></u></h1>

<div class="row">
  <div class="column">
    <div class="card">
      <center><img src="images/giannis.jpg" alt="Giannis" width="40%" height="40%" >
      <div class="container">
        <h2>Ioannis Karabinis</h2>
        <p class="title">Undergraduate Student</p>
        <p>Compartment of Electrical & Computer Engineering @UTH, 21 years old from Athens.</p>
        <span class='underline'>
        <a  href="https://github.com/ikarampinis" target="_blank" ><i class="fab fa-github"></i><b style="color:black">Github</b></a>
      </span>
        <p>Email: <b>ikarampinis@uth.gr</b></p>
        <span class='underline'>
        <p><a href="mailto:ikarampinis@uth.gr"><button class="button">Contact</button></a></p>
        </span>
      </div>
    </div>
  </div>

  <div class="column">
    <div class="card">
      <center><img src="images/alkisti.jpg"alt="Alkisti" width="30%" height="30%" class="up">
      <div class="container">
        <h2>Evangelia-Alkistis Lemonaki</h2>
        <p class="title">Undergraduate Student</p>
        <p>Compartment of Electrical & Computer Engineering @UTH, 21 years old from<br>Volos.</p>
        <span class='underline'>
        <a  href="https://github.com/alemonaki" target="_blank" ><i class="fab fa-github"></i><b style="color:black">Github</b></a>
      </span>
        <p>Email: <b>elemonaki@uth.gr</b></p>
        <span class='underline'>
        <p><a href="mailto:elemonaki@uth.gr"><button class="button">Contact</button></a></p>
        </span>
      </div>
    </div>
  </div>

  <div class="column">
    <div class="card">
      <center><img src="images/cleo.jpg" class="image2" alt="Cleopatra" width="30%" height="30%">
      <div class="container">
        <h2>Cleopatra Beka</h2>
        <p class="title">Undergraduate Student</p>
        <p>Compartment of Electrical & Computer Engineering @UTH, 23 years old from Preveza.</p>
        <span class='underline'>
        <a  href="https://github.com/kbeka" target="_blank" ><i class="fab fa-github"></i><b style="color:black">Github</b></a>
      </span>
        <p>Email: <b>kbeka@uth.gr</b></p>
        <span class='underline'>
        <p><a href="mailto:kbeka@uth.gr"><button class="button">Contact</button></a></p>
        </span>
      </div>
    </div>
  </div>
</div>
</body>
</html>

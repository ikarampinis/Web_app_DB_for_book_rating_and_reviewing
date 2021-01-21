<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>BookWay | Login</title>
        <meta charset ="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <LINK rel="stylesheet" href="style.css">
        <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
        <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
        <meta name="theme-color" content="#ffffff">   
    </head>
    <body>

        <div class="box">
            <div class="">
              <center><img src="images/wow.png" alt="logo" style="width:270px"></center>
            </div>
            <h1 align="center" style="font-family: Raleway"><b>Welcome!</b></h1>

            <form method="GET" action="user_login">
                <input type="text" id="user_name" name="user_name" placeholder="Enter your username" style="font-family: Raleway"  required>
                <input type="password" id="password" name="password" placeholder="Enter your password" style="font-family: Raleway" required>
                <button>Login</button>
                <p>Not a member? <a href="sign_up.jsp" style="color: white">Sign up</a></p>
            </form>
            <%
                String error = request.getParameter("error");
                if(error!=null){
                    out.print("<b><center style=\"color:red;\">"+request.getParameter("error")+"</center></b>");
                }
            %>
        </div>
    </body>
</html>

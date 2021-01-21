<%@page import="project_dao.ViewDAO"%>
<% 
    ViewDAO view = new ViewDAO();
    Cookie[] cookies = request.getCookies();
    String book_rate="";
    String book_code="";
    int length = 0;
    String pad = "";
    for(Cookie cookie : cookies){
        if(cookie.getName().equals("the_isbn")){
            book_code = cookie.getValue();
        }
        if(cookie.getName().equals("the_rate")){
            book_rate = cookie.getValue();
        }
        if(cookie.getName().equals("length")){
            length = Integer.parseInt(cookie.getValue());
        }
    }
    for(int i=0; i<length - book_code.length(); i++){
        pad+="0";
    }
    out.print("You rated this book with: "+book_rate+" / 5 <i style=\"color:#ffcc00 \" class=\"fas fa-star\"></i>");
    view.addReview(session.getAttribute("username").toString(), pad+book_code, book_rate);
%>

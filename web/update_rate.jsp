<%@page import="project_dao.bookDao"%>
<%
    bookDao bookdao = new bookDao();
    Cookie[] Cookies = request.getCookies();
    int the_rating = 0;
    int the_count = 0;
    int book_rate = 0;
    String book_code="";
    int length = 0;
    String pad = "";
    for(Cookie cookie:Cookies){
        if(cookie.getName().equals("new_rating")){
            the_rating = Integer.parseInt(cookie.getValue());
        }
        if(cookie.getName().equals("new_rate_count")){
            the_count = Integer.parseInt(cookie.getValue());
        }
        if(cookie.getName().equals("the_isbn")){
            book_code = cookie.getValue();
        }
        if(cookie.getName().equals("length")){
            length = Integer.parseInt(cookie.getValue());
        }
        if(cookie.getName().equals("the_rate")){
            book_rate = Integer.parseInt(cookie.getValue());
        }
    }
    for(int i=0; i<length - book_code.length(); i++){
        pad+="0";
    }
    the_rating = the_rating + book_rate;
    the_count++;
    boolean res = bookdao.updateRate(pad+book_code, the_rating, the_count);
    
    float result = (float)the_rating/the_count;
    result = result*100;
    result = Math.round(result);
    result = result/100;
    if(result-(int)result == 0){
        out.print("Rating: "+(int)result+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i>");
    }
    else{
        out.print("Rating: "+result+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i>");
    }
    %>

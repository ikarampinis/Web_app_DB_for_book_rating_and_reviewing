<%@page import="project_dao.UserBooksDAO"%>
<%
    UserBooksDAO ubdao = new UserBooksDAO();
    Cookie[] ubCookies = request.getCookies();
    int activity = 0, length = 0;
    String pad="", book_code="";
    for(Cookie cookie:ubCookies){
        if(cookie.getName().equals("activity")){
            activity = Integer.parseInt(cookie.getValue());
        }
        if(cookie.getName().equals("the_isbn")){
            book_code = cookie.getValue();
        }
        if(cookie.getName().equals("length")){
            length = Integer.parseInt(cookie.getValue());
        }
    }
    for(int i=0; i<length - book_code.length(); i++){
        pad+="0";
    }
    
    if(activity == 3 || activity == 5 || activity == 8){
        ubdao.RemoveFromList(session.getAttribute("username").toString(), pad+book_code);
        out.print("<center><button class=\"add_list\" id=\"add-list\" onclick=\"AddList()\"style=\"background-color:green;color:white;border-radius:4px;padding:5px;font-size:14px;border:0\">Add to my list</button></center>");
    }
    else if(activity == 1){
        ubdao.addWantToRead(session.getAttribute("username").toString(), pad+book_code);
        out.print("<center><button class=\"readingnow_list\" id=\"add-reading\" onclick=\"AddReading()\"style=\"background-color:green;color:white;border-radius:4px;padding:5px;font-size:14px;border:0\">Reading now</button>&ensp;");
        out.print("<button class=\"remove_list\" id=\"remove-list\" onclick=\"RemoveList()\"style=\"background-color:red;color:white;border-radius:4px;padding:5px;font-size:14px;border:0\">Remove from my list</button></center>");
    }
    else if(activity == 2){
        ubdao.addReadNow(session.getAttribute("username").toString(), pad+book_code);
        out.print("<center><button class=\"add_list\" id=\"add-finished\" onclick=\"AddFinished()\"style=\"background-color:green;color:white;border-radius:4px;padding:5px;font-size:14px;border:0\">Read</button>&ensp;");
        out.print("<button class=\"remove_list\" id=\"remove-reading\" onclick=\"RemoveReading()\"style=\"background-color:red;color:white;border-radius:4px;padding:5px;font-size:14px;border:0\">Remove from my list</button></center>");
    }
    else if(activity == 4){
        ubdao.addFinished(session.getAttribute("username").toString(), pad+book_code);
        out.print("<center><p style=\"border-style: 1px solid\"><i class=\"fa fa-check\" aria-hidden=\"true\"></i>Read &ensp;");
        out.print("<button id=\"remove-finished\" onclick=\"RemoveFinished()\"style=\"background-color:red;color:white;border-radius:4px;padding:5px;font-size:14px;border:0\">Remove from my list</button></p></center>");
    }
%>
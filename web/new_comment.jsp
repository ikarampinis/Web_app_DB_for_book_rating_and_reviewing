<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="entity.Comments"%>
<%@page import="entity.CommentsPK"%>
<%@page import="project_dao.CommentDAO"%>
<%@page import="project_dao.ViewDAO"%>
<%
    ViewDAO review = new ViewDAO();
    CommentDAO comm = new CommentDAO();
    
    Cookie[] Cookies_comm = request.getCookies();
    String book_code = "";
    String the_comment = "";
    String pad ="";
    int length = 0;
    int update_rate=0;
    int id=0;
    for(Cookie cookie:Cookies_comm){
        if(cookie.getName().equals("the_isbn")){
            book_code = cookie.getValue();
        }
        if(cookie.getName().equals("length")){
            length = Integer.parseInt(cookie.getValue());
        }
        if(cookie.getName().equals("new_comment")){
            the_comment = cookie.getValue();
        }
        if(cookie.getName().equals("the_rate")){
            update_rate = Integer.parseInt(cookie.getValue());
        }
        if(cookie.getName().equals("comm_id")){
            id = Integer.parseInt(cookie.getValue());
        }
    }
    
    for(int i=0; i<length - book_code.length(); i++){
        pad+="0";
    }
    
    if(update_rate == -1 && id == -1){
        the_comment = the_comment.replaceAll("!2#@", " ");

        review.addReview(session.getAttribute("username").toString(), pad+book_code, "0");
        CommentsPK comment_pk = new CommentsPK(session.getAttribute("username").toString(), pad+book_code);
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");  
        Date date = new Date();  
        Comments item = new Comments(comment_pk, the_comment, formatter.format(date));
        comm.addComment(item);
    }
    
    if(id!=-1){
        CommentsPK comment_pk = new CommentsPK(id, session.getAttribute("username").toString(), pad+book_code);
        comm.rmvComment(comment_pk);
    }
    
    List list = comm.getComments(pad+book_code);
    Iterator<Comments> it = list.iterator();
    String user_comment = "";
    String date_comment = "";
    int rate_comment = 0;
    String Comment = "";
    Comments Comm = null;
    while(it.hasNext()){
        Comm = it.next();
        user_comment = Comm.getCommentsPK().getUserHasBooksUserUsername();
        date_comment = Comm.getDate();
        Comment = Comm.getComment();
        rate_comment = review.bookRating(user_comment, Comm.getCommentsPK().getUserHasBooksBooksIsbn());
        out.print("<div class=\"row\">");
        out.print("<div class=\"column\">");
        out.print("<div class=\"card\">");
        if(session.getAttribute("username").equals(user_comment)){
            out.print("<button onclick=\"RmvComment("+Comm.getCommentsPK().getId()+")\" style=\"float: right; border: none; background-color: transparent; font-size: 24px; font-weight: bold; color: black;\">&times;</button>");
        }
        out.print("<div class=\"container\">");
        if(update_rate != -1 && user_comment.equals(session.getAttribute("username").toString())){
            rate_comment = update_rate;
            out.print("<ul><li class=\"serif\"><b>"+user_comment+"</b> rated with "+rate_comment+" / 5 <i style=\"color:#ffcc00\" class=\"fas fa-star\"></i>&emsp;&emsp;"+date_comment+"<br>-\""+Comment+"\"</li></ul>");
        }
        else if(rate_comment == -1){
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
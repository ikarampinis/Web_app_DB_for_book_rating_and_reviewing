<%@page import="entity.Quotes"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="project_dao.QuotesDAO"%>
<%
    QuotesDAO qdao = new QuotesDAO();
    Cookie[] qcookies = request.getCookies();
    String qBook="", qAuth="", qQuote="";
    int action=0, rmcount=0;
    for(Cookie cookie:qcookies){
        if(cookie.getName().equals("Qbook")){
            qBook = cookie.getValue();
        }
        if(cookie.getName().equals("Qauth")){
            qAuth = cookie.getValue();
        }
        if(cookie.getName().equals("QQuote")){
            qQuote = cookie.getValue();
        }
        if(cookie.getName().equals("action")){
            action = Integer.parseInt(cookie.getValue());
        }
        if(cookie.getName().equals("count")){
            rmcount = Integer.parseInt(cookie.getValue());
        }
    }

    qBook = qBook.replaceAll("!2#@", " ");
    qAuth = qAuth.replaceAll("!2#@", " ");
    qQuote = qQuote.replaceAll("!2#@", " ");

    if(action == 1){
        qdao.addQuote(session.getAttribute("username").toString(), qQuote, qAuth, qBook);
    }
    else{
        Quotes rmquote = (Quotes)qdao.getQuotes(session.getAttribute("username").toString()).get(rmcount);
        qdao.rmvQuote(session.getAttribute("username").toString(), rmquote.getQuote(), rmquote.getAuthor(), rmquote.getBook());
    }
  
    List quotesList = qdao.getQuotes(session.getAttribute("username").toString());
    if(!quotesList.isEmpty()){
        Iterator it_quotes = quotesList.iterator();
        int qCounter=0;
        while(it_quotes.hasNext()){
            Quotes curr = (Quotes) it_quotes.next();
            out.print("<div class=\"column_2\"><div class=\"card_2\">");
            out.print("<button onclick=\"RmvQuote("+qCounter+")\" style=\"float: right; border: none; background-color: transparent; font-size: 24px; font-weight: bold;\">&times;</button><div class=\"container_2\">");
            out.print("<ul><li class=\"serif\"><b>\""+curr.getQuote()+"\"</b><br>- "+curr.getAuthor()+", "+curr.getBook()+"</li></ul>");
            out.print("</div></div></div>");
            qCounter++;
        }
    }
    else{
        out.print("<center><p>No Quotes Found!</p></center>");
    }
%>

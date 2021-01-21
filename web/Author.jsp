<%@page import="project_dao.FavAuthDAO"%>
<%
  FavAuthDAO fav = new FavAuthDAO();
  Cookie[] authCookies = request.getCookies();
  int action=0;
  String auth="";
  for(Cookie cookie:authCookies){
      if(cookie.getName().equals("the_author")){
          auth = cookie.getValue();
      }
      if(cookie.getName().equals("activity")){
          action = Integer.parseInt(cookie.getValue());
      }
  }
  
  auth = auth.replaceAll("!2#@", " ");
  
  if(action == 6){
      if(fav.addFavAuth(session.getAttribute("username").toString(), auth)){
          out.print("<h3>"+auth+" <button id=\"heart\" onclick=\"rmfav()\"><i class=\"fa fa-heart\" style=\"width: 20px; height: 20px; color: red\"></i></button></h3>");
      }
      else{
          out.print("<h3>"+auth+" <button id=\"heart\" onclick=\"addfav()\"><i class=\"fa fa-heart\" style=\"width: 20px; height: 20px\"></i></button></h3>");
      }
  }
  else{
      if(fav.rmvFavAuth(session.getAttribute("username").toString(), auth)){
          out.print("<h3>"+auth+" <button id=\"heart\" onclick=\"addfav()\"><i class=\"fa fa-heart\" style=\"width: 20px; height: 20px\"></i></button></h3>");
      }
      else{
          out.print("<h3>"+auth+" <button id=\"heart\" onclick=\"rmfav()\"><i class=\"fa fa-heart\" style=\"width: 20px; height: 20px; color: red\"></i></button></h3>");
      }
  }
%>

<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>退出聊天室</title>
</head>
<body>
<%
      String roomid=request.getParameter("roomid"); 
      List<String> userslist = (List<String>) application.getAttribute("userslist"+roomid);
      String username = (String) session.getAttribute("name");
      userslist.remove(username);
      response.sendRedirect("index.jsp");
%> 
  <br> 
//跳转到首页
</body>
</html>
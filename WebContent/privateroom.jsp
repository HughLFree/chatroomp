<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="2">
<!--  
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.convform.css">-->
<title>Insert title here</title>
</head>
<body bgcolor="#b8c9c7">
<div id="chat">
<%
	request.setCharacterEncoding("UTF-8");
	String roomid=request.getParameter("roomid"); 
	String user=(String)session.getAttribute("name");
	String pall=(String)application.getAttribute("pall"+roomid+user);
	out.println(pall);
%>
</div>
</body>
</html>
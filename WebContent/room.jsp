<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="3">

<link rel="stylesheet" type="text/css" href="css/style.css">

<title>公聊</title>
</head>
<body >
<%
	request.setCharacterEncoding("UTF-8");
	String roomid=request.getParameter("roomid"); 
	String all=(String)application.getAttribute("all"+roomid);
	out.println(all);
%>

</body>
</html>
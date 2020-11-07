<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="3">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<title>显示在线人员</title>   
</head>
<body>
<div class="panel panel-default">
    <div class="panel-heading">用户列表</div>
	    <div class="panel-body">
	  	<%
	  		request.setCharacterEncoding("UTF-8");
			String roomid=request.getParameter("roomid");
			out.print("聊天室"+roomid+"号");
			List<String> userslist = (List<String>) application.getAttribute("userslist"+roomid);
			out.print("目前在线有：" + userslist.size() + "人");
		%>
	    </div>
    <table class="table">
        <%
			for (int i = 0; i < userslist.size(); i++) {
				String username = (String) userslist.get(i);
				out.print("<tr><td>" + username+"</td></tr>");
			}
		%>
    </table>
</div>

</body>
</html>
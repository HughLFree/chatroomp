<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>无聊天室</title>
</head>
<%
	request.setCharacterEncoding("UTF-8"); 
	String roomid=request.getParameter("roomid"); 
	String user=(String)session.getAttribute("name");
	List<String> userslist=(List<String>) application.getAttribute("userslist"+roomid);
    //如果该用户列表还不存在，实例化该用户列表 
    if (userslist == null) {
    	userslist = new ArrayList<String>();
    }
    if (!userslist.contains(user)) {
    	userslist.add(user);
    }
    application.setAttribute("userslist"+roomid, userslist);
%>   
<frameset rows="65%,15%,20%" border="1">
	<frameset cols="25%,75%">
		<frameset rows="40%,60%">
			<frame src="userslist.jsp?roomid=<%=roomid%>">
			<frame src="upload.jsp">
		</frameset>
		<frame src="room.jsp?roomid=<%=roomid%>">
	</frameset>
	<frame src="privateroom.jsp?roomid=<%=roomid%>">
	<frame src="talk.jsp?roomid=<%=roomid%>">
	
</frameset>

</html>
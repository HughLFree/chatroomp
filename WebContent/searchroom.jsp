<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,chatroomplus.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String searchroom=(String)request.getParameter("searchroom");
	if(searchroom!=null){
		String select2 ="select * from users where email='"+searchroom+"'";
		List<List> data=DB.queryList(select2);
		for(List list2 :data){
			out.print("<tr>");
			for(Object object :list2){
				out.print("<td>");
				out.print(object+"&nbsp;");
				 out.print("</td>");
			}
			out.print("</tr>");
		}
	}
%>
</body>
</html>
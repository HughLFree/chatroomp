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
	request.setCharacterEncoding("UTF-8");
	String email=(String)session.getAttribute("email");
	String roomname=(String)request.getParameter("roomname");
	String roomclass=(String)request.getParameter("roomclass");
	if(roomname!=null&&roomclass!=null){
		Connection conn1=DB.getConnection();
		String sql = "insert into rooms(name,roomclass,master_id) values (?,?,?)";
		PreparedStatement pstmt1=conn1.prepareStatement(sql);
		pstmt1.setString(1,roomname);
		pstmt1.setString(2,roomclass);
		pstmt1.setString(3,email);
		int ret = pstmt1.executeUpdate();
		if(ret>0){
			response.sendRedirect("index.jsp");
		}else{
		
			out.println("FAIL");
		}
		DB.close(pstmt1);
		DB.close(conn1);
	}
	
%>

	
	
</body>
</html>
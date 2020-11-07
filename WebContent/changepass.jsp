<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="chatroomplus.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<body>
<script src="js/jquery.base64.js" type="text/javascript"></script>
<script src="js/jquery-3.5.1.min.js"></script> 
<%
	request.setCharacterEncoding("UTF-8");//习惯
	String password = request.getParameter("newpass");
	String password2 = request.getParameter("newpass2");
	String email = request.getParameter("email2");
	String he = request.getParameter("he");
	String myhe =(String)session.getAttribute("myhe");
	//out.print(email+";2:"+he+";3:"+myhe);
	if(!myhe.equals(he)&&password==null){
		response.sendRedirect("jgn.jsp");
	}
	
	long start=(long)session.getAttribute("mytime1");
	//获得系统的时间，单位为毫秒,转换为妙
	long totalMilliSeconds = System.currentTimeMillis();
	long totalSeconds = totalMilliSeconds / 1000;
	if(totalSeconds > start+60*8){
		out.print("超过时限！");
	}
	else{
	
		if(null!=email){
			if(password!=null&&password2!=null&&password.equals(password2)){
				password=MD5.getMD5(password,password.length());
				Connection conn2 = DB.getConnection();
				String sql2 = "update users set password=? where email=?";
				PreparedStatement pstmt2 = conn2.prepareStatement(sql2);
				pstmt2.setString(1, password);
				pstmt2.setString(2, email);
				int i = pstmt2.executeUpdate();
				
				DB.close(pstmt2);
				DB.close(conn2);
				if(i>0){
					response.sendRedirect("index.jsp");
				}else{
					out.print("不存在此用户！");
				}
				
			}else if(password!=null&&password2!=null&&!password.equals(password2)){
				%>
				<div id="pass" class="alert alert-warning">
				    <a href="#" class="close" data-dismiss="alert">
				        &times;
				    </a>
				    <strong>警告!</strong>两次密码不一致。
				</div>
				<script>
					$(function(){
					    $(".close").click(function(){
					     
					        $("#pass").alert('close');
					    });
					});
				</script>
				<% 
			}
		}
%>

<form class="form-control-static" action="changepass.jsp" method="post">
	密码：<input name="newpass" type="password" class="form-control-static"><br>
	再次输入密码：<input name="newpass2" type="password" class="form-control-static"><br>
	<input type="hidden" name="he" value="<%=he%>">
	<input type="hidden" name="email2" value="<%=email%>">
	<input type="submit" class="form-control-static">
</form>

<%} %>
</body>
</html>
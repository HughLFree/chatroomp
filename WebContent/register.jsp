<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="chatroomplus.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/login.css">
<title>注册用户</title>
<script src="js/jquery.base64.js" type="text/javascript"></script>
<script src="js/jquery-3.5.1.min.js"></script> 

</head>
<div >
<nav class="navbar navbar-default" role="navigation" > 
    <div class="container-fluid " > 
        <div class="navbar-header" > 
            <a class="navbar-brand" href="index.jsp">聊天室</a> 
        </div> 
    </div> 
</nav>
</div>
<body>
<%
	request.setCharacterEncoding("UTF-8");//习惯
	String password = request.getParameter("password");
	String password2 = request.getParameter("password2");
	String email = request.getParameter("email");
	String name = request.getParameter("name");
	if(null!=email){
		if(password!=null&&password2!=null&&password.equals(password2)){
			password=MD5.getMD5(password,password.length());
			Connection conn=DB.getConnection();
			String sql = "insert into users values (?,?,?)";
			PreparedStatement pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1,password);
			pstmt.setString(3,email);
			pstmt.setString(2,name);
			int ret = pstmt.executeUpdate();
			if(ret>0){
				response.sendRedirect("index.jsp");
			}else{
				%>
				<div id="name" class="alert alert-warning">
				    <a href="#" class="close" data-dismiss="alert">
				        &times;
				    </a>
				    <strong>警告!</strong>用户名被占用。
				</div>
				<% 
			}
			DB.close(pstmt);
			DB.close(conn);
		}else{
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
				        $("#name").alert('close');
				        $("#pass").alert('close');
				    });
				});
			</script>
			
			<% 
		}
	}
%>
<div class="container">
	<div class="card">
		<form class="card-form" action="register.jsp" method="post">
			<div class="input">
				<input type="text" class="input-field" value="" name="email" required/>
				<label class="input-label">Email</label>
			</div>
			<div class="input">
				<input type="text" class="input-field" value="" name="name" required>
				<label class="input-label">昵称</label>
			</div>
				<div class="input">
				<input type="password" class="input-field"  name="password" required>
				<label class="input-label">登录密码</label>
			</div>
			<div class="input">
				<input type="password" class="input-field"  name="password2" required>
				<label class="input-label">重复密码</label>
			</div>
			<div class="action">
				<input type="submit" value="确认注册" class="action-button">
			</div>
		</form>
		<div class="card-info">
			<p>若已有账号，请 <a href="login.jsp">登录</a></p>
		</div>
	</div>
</div>
</body>
</html>
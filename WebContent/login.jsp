<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="chatroomplus.*,java.sql.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
<title>用户登录</title>
</head>
<body>

<nav class="navbar navbar-default" role="navigation" > 
    <div class="container-fluid " > 
        <div class="navbar-header" > 
            <a class="navbar-brand" href="index.jsp">聊天室</a> 
        </div> 
         
    </div> 
</nav>

	<%
	request.setCharacterEncoding("UTF-8");//习惯
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	if(null!=email){	
		Connection conn=DB.getConnection();
		//String sql="SELECT *FROM tb_user where name='"+name+"' and password='"+password+"'";
		//Statement stmt =conn.createStatement();
		password=MD5.getMD5(password,password.length());
		String sql="SELECT *FROM users where email=? and password=?";
		PreparedStatement pstmt =conn.prepareStatement(sql);
		String sql2="SELECT *FROM bans where email=?";
		PreparedStatement pstmt2 =conn.prepareStatement(sql2);
		pstmt2.setString(1,email);
		pstmt.setString(1,email);
		pstmt.setString(2,password);
		System.out.println("email:"+email);
		System.out.println("password:"+password);
		System.out.println("sql:"+sql);
		ResultSet rs= pstmt.executeQuery();
		ResultSet rs2= pstmt2.executeQuery();
		if(!rs2.next()){
			if(rs.next()){//结果不为空
				session.setAttribute("email",rs.getString("email"));
				session.setAttribute("name",rs.getString("name"));
				response.sendRedirect("index.jsp");
			}else{
				%>
				<div id="nouser" class="alert alert-warning">
				    <a href="#" class="close" data-dismiss="alert">
				        &times;
				    </a>
				    <strong>账号或密码错误！</strong>若无账号，请先<a href="register.jsp">注册</a>；若有账号，请点击下方找回密码。
				</div>
				
				<% 	
			}
		}else{
			%>
			<div id="banuser" class="alert alert-warning">
			    <a href="#" class="close" data-dismiss="alert">
			        &times;
			    </a>
			    <strong>您的账号已经被封锁</strong>
			</div>
			<script>
				$(function(){
				    $(".close").click(function(){
				        $("#nouser").alert('close');
				        $("#banuser").alert('close');
				    });
				});
			</script>	
			<%
		}
		DB.close(pstmt);
		DB.close(conn);
	}else{
	//	response.sendRedirect("index.jsp");
	}
	
	%>
<link rel="stylesheet" href="css/login.css">
<div class="container">
	<div class="card"> 
		<form class="card-form" action="login.jsp" method="post" >
			<div class="input">
				<input type="text" class="input-field" value="" name="email" required>
				<label class="input-label">Email</label>
			</div>
				<div class="input">
				<input type="password" class="input-field"  name="password" required>
				<label class="input-label">登录密码</label>
			</div>
			<div class="action">
				<input type="submit" value="登录" class="action-button">
			</div>
		</form>
		<div class="card-info">
			<p>若忘记密码，请点击 找回密码</p>
		</div>
		<button   data-toggle="modal" data-target="#myModal">找回密码</button>
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				    <div class="modal-dialog">
				        <div class="modal-content">
				            <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				                <h4 class="modal-title" id="myModalLabel">找回密码</h4>
				            </div>
				            <form  method="post" action="/chatroomplus/SendEmailServlet">
				            	<div class="modal-body">
									<label>确认一遍，你的邮箱是</label><input class="form-control-static" type="text"  name="to" />
				            	</div>
				            	<div class="modal-footer">
					                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					                <button type="submit" class="btn btn-primary">提交</button>
					            </div>
				            </form>
				        </div>
				    </div>
				</div>
		
		
		
		
	</div>
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,chatroomplus.*,java.util.*"%>
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
<nav class="navbar navbar-default" role="navigation" > 
    <div class="container-fluid " > 
        <div class="navbar-header" > 
            <a class="navbar-brand" href="index.jsp">聊天室</a> 
        </div> 
    </div> 
</nav>
<% 
	request.setCharacterEncoding("UTF-8");
	String name=(String)session.getAttribute("name");
	String email=(String)session.getAttribute("email");
	if(!email.equals("1")){
		response.sendRedirect("index.jsp");
	}
%>
	<form action="gmlucy.jsp" method="post" style="margin:0 auto;padding:50px;text-align:center;">
		<label>查询邮箱（为空显示全部）：</label><input name="searchmail" type="text" class="form-control-static"> 
		<label>需要禁止或者恢复该用户的登录权限？（输入Y或者N）：</label><input name="ban" class="form-control-static" type="text"> 
		<input type="submit" value="提交" class="btn btn-default"></form>
		<table  class="table table-hover" style="width:61%;margin:0 auto;padding:50px;">
			 <thead>
			    <tr>
			   	  <th>email</th>
			      <th>name</th>
			      <th>封禁状态</th>
			    </tr>
		  	</thead>
		  	<tbody>
				<%
					String searchmail = request.getParameter("searchmail");
					if(searchmail==null||searchmail==""){
						String select ="select email,name from users";
						List<List> data=DB.queryList(select);
						for(List list2 :data){
							out.print("<tr>");
							for(Object object :list2){
								out.print("<td>");
								out.print(object+"&nbsp;");
								 out.print("</td>");
							}
							Connection conn3=DB.getConnection();
							String sql3 = "select * from bans where email=?";
							PreparedStatement pstmt=conn3.prepareStatement(sql3);
							pstmt.setString(1,list2.get(0)+"");
							ResultSet rs = pstmt.executeQuery();
							out.print("<td>");
							if(rs.next()){
								out.print("被封禁");
							}
							else{
								out.print("没被封禁");
							}
							out.print("</td>");
							out.print("</tr>");
							DB.close(pstmt);
							DB.close(conn3);
						}
						
					}else{
						String select2 ="select email,name from users where email='"+searchmail+"'";
						List<List> data=DB.queryList(select2);
						for(List list2 :data){
							out.print("<tr>");
							for(Object object :list2){
								out.print("<td>");
								out.print(object+"&nbsp;");
								 out.print("</td>");
							}
							Connection conn3=DB.getConnection();
							String sql3 = "select * from bans where email=?";
							PreparedStatement pstmt=conn3.prepareStatement(sql3);
							pstmt.setString(1,list2.get(0)+"");
							ResultSet rs = pstmt.executeQuery();
							out.print("<td>");
							if(rs.next()){
								out.print("被封禁");
							}
							else{
								out.print("没被封禁");
							}
							out.print("</td>");
							out.print("</tr>");
							DB.close(pstmt);
							DB.close(conn3);
						}
					
					}
				
				%>
			</tbody>
		</table>
		
		<%
			String ban = request.getParameter("ban");
			if(searchmail!=null&&ban!=null&&ban!=""){
				if(ban.equals("Y")){
					String sql2 = "insert into bans values ('"+searchmail+"')";
					int ret = DB.executeUpdate(sql2);
					if(ret>0){
					//	response.sendRedirect("index.jsp");
					}else{%>
					<div id="alban" class="alert alert-warning">
					    <a href="#" class="close" data-dismiss="alert">
					        &times;
					    </a>
					    <strong>警告!</strong>该用户已被封禁过了。
					</div>
					
					<%
					}
				}
				else if( ban.equals("N")){
					Connection conn=DB.getConnection();
					String sql="delete from bans where email=?";
					PreparedStatement pstmt=conn.prepareStatement(sql);
					pstmt.setString(1,searchmail);
					pstmt.executeUpdate();
					DB.close(pstmt);
					DB.close(conn);
				}
				else{%>
					<div id="wux" class="alert alert-warning">
					    <a href="#" class="close" data-dismiss="alert">
					        &times;
					    </a>
					    <strong>警告!</strong>请输入Y/N；Y为加入禁止名单；
					</div>
					<script>
						$(function(){
						    $(".close").click(function(){
						        $("#alban").alert('close');
						        $("#wux").alert('close');
						    });
						});
					</script>
				<%
				}
			}
		%>

</body>
</html>
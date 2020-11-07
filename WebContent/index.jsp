<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*,chatroomplus.*,java.util.*"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<title>NO FUN -聊天室</title>
</head>
<%! //可以声明方法 不调用不运行 几乎不用 因为import 考试考
public String gmemail="1";
//public static void test(){
//	System.out.println(123);
//}
%>
<body>
<script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>

<nav class="navbar navbar-default" role="navigation"> 
    <div class="container-fluid "> 
        <div class="navbar-header"> 
            <a class="navbar-brand" href="#">聊天室</a> 
        </div> 
        
        <ul class="nav navbar-nav navbar-right" id="navuser"> 
            <li><a href="register.jsp"><span class="glyphicon glyphicon-user"></span> 注册</a></li> 
            <li><a href="login.jsp"><span class="glyphicon glyphicon-log-in"></span> 登录</a></li> 
        </ul> 
    </div> 
</nav>
<!-- "<li class='dropdown'><a href='#' class='dropdown-toggle' data-toggle='dropdown'><span class='glyphicon glyphicon-user'></span>"+<%//=name%>+"<span class='caret'></span></a><ul class='dropdown-menu'><li><a href='gmlucy.jsp'>gm</a></li><li><a href='logout.jsp'>退出登录</a></li></ul></li>"; -->
	<% 
		List list=new Vector();
		String name=(String)session.getAttribute("name");
		String email=(String)session.getAttribute("email");
		request.setCharacterEncoding("UTF-8");
		if(email==null){
	%>
		<div style="text-align:center;with:100px;margin:0 auto;padding:50px;"><h2>please login!</h2></div>	
	<% 
		}else{
			
			if(email.equals(gmemail)){ 
				out.print("<li class='dropdown' style='float:right;top:-50px;'><a href='#' class='dropdown-toggle' data-toggle='dropdown'><span class='glyphicon glyphicon-user'></span>"+name+"<span class='caret'></span></a><ul class='dropdown-menu'><li><a href='gmlucy.jsp'>gm</a></li><li><a href='logout.jsp'>退出登录</a></li></ul></li>");
				
			%>
			
				<script type="text/javascript">
					document.getElementById("navuser").innerHTML =""; 
				</script>
			<%}else{ out.print("<li class='dropdown' style='float:right;top:-50px;'><a href='#' class='dropdown-toggle' data-toggle='dropdown'><span class='glyphicon glyphicon-user'></span>"+name+"<span class='caret'></span></a><ul class='dropdown-menu'><li><a href='#'>#</a></li><li><a href='logout.jsp'>退出登录</a></li></ul></li>");%>
			
				<script type="text/javascript">
					document.getElementById("navuser").innerHTML ="";
				</script>
			
			<% }%>
		<div style="width:70%;margin:0 auto;padding:50px;" >
			<div style="width:70%;margin:0 auto;padding:15px; text-align:center;">
				<form action="index.jsp" method="post">
					<label>聊天室名称</label><input name="searchroom" type="text" class="form-control-static">
					<input type="submit" value="提交" class="btn btn-primary">
				</form>
			</div>
			<table  class="table table-hover">
				<thead>
				    <tr>
				      <th>聊天室ID</th>
				      <th>聊天室名称</th>
				      <th>聊天室类型</th>
				      <th>创建人ID</th>
				      <th>链接</th>
				    </tr>
			  	</thead>
			  	<tbody>
			  	<%
				String searchroom=(String)request.getParameter("searchroom");
				if(searchroom!=null&&searchroom!=""){
					String sr ="select * from rooms where name='"+searchroom+"'";
					List<List> data=DB.queryList(sr);
					for(List list2 :data){
						out.print("<tr>");
						for(Object object :list2){
							out.print("<td>");
							out.print(object+"&nbsp;");
							 out.print("</td>");
						}
						String url="oneroom.jsp?roomid="+list2.get(0);
						out.print("<td><a href='"+url+"'>进入聊天室</td>");
						 out.print("</tr>");
					}
				}else{
						String select ="select * from rooms";
						List<List> data=DB.queryList(select);
						for(List list2 :data){
							out.print("<tr>");
							for(Object object :list2){
								out.print("<td>");
								out.print(object+"&nbsp;");
								 out.print("</td>");
							}
							
							String url="oneroom.jsp?roomid="+list2.get(0);
							out.print("<td><a href='"+url+"'>进入聊天室</td>");
							 out.print("</tr>");
						}
					
					} %>
				</tbody>
			</table>
		
			<button class="btn btn-primary " data-toggle="modal" data-target="#myModal">创建新聊天室</button>
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				    <div class="modal-dialog">
				        <div class="modal-content">
				            <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				                <h4 class="modal-title" id="myModalLabel">新聊天室</h4>
				            </div>
				            <form action="creatrooms.jsp" method="post">
				            	<div class="modal-body">
									<label>聊天室名称</label><input name="roomname" type="text" class="form-control-static">
									<label>聊天室类型</label><input name="roomclass" type="text" class="form-control-static">
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
	<%	}
	%>
	
<div> 

</div>

</body>
</html>
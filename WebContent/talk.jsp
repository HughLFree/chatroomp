<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">

<title>Insert title here</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	String roomid=request.getParameter("roomid");
	String msg=request.getParameter("msg");
	String user=(String)session.getAttribute("name");
	String to_sb=(String)application.getAttribute("to_sb");
	String from_sb=(String)application.getAttribute("from_sb");
	if(to_sb==null) to_sb="";
	if(from_sb==null) from_sb="";
	String to = "";
	try {
		List<String> tmp = (List<String>) application.getAttribute("userslist"+roomid);
		//获取下拉列表的值
		String SS = request.getParameter("select");
		int a = Integer.parseInt(SS);//强制类型转换问整数
		if (a == 0)//当to为所有人时，表示接收方是所有人，实现群聊
			to = "allusers";
		else//因为从0开始且0是群聊，1代表第一个用户，2代表第二个用户，所以要a-1，最后强制转换成string类型显示tmp列表的用户名
			to = (String) tmp.get(a - 1);
	} catch (Exception e) {
	}
	to_sb=to;
	from_sb=user;
	application.setAttribute("to_sb", to_sb);
	application.setAttribute("from_sb", from_sb);	
%>

<%	
	request.setCharacterEncoding("UTF-8");
	if(msg==null){
		String firstin=(String)request.getAttribute("firstin");
	//	out.print("第一次进入");
		
		if(firstin==null) {
			firstin="ing";
			request.setAttribute("firstin",firstin);//cunyi
			msg="<p>进入聊天室</p><br>";
		}	
	}
	if(msg!=null){
		if(!to_sb.equals("allusers")){
			if((to_sb.equals(user)||from_sb.equals(user))&&!to_sb.isEmpty()){//防止一直刷进入聊天室
				msg=from_sb+" to "+to_sb+":"+msg+"<br>";
				String pall=(String)application.getAttribute("pall"+roomid+user);
				String pall2=(String)application.getAttribute("pall"+roomid+to_sb);
				if(pall==null) pall="";
				pall=msg+pall;
				if(pall2==null) pall2="";
				pall2=msg+pall2;
				application.setAttribute("pall"+roomid+user,pall);
				application.setAttribute("pall"+roomid+to_sb,pall2);
			}
		}
		else{
			msg=user+":"+msg+"<br/>";
			String all=(String)application.getAttribute("all"+roomid);
			if(all==null) all="";
			all=msg+all;
			application.setAttribute("all"+roomid,all);
		}
	}

%>

<form action="talk.jsp" method="post">
	<p align="left">
		<label >当前用户:&nbsp</label>
		<%=user%> 
		<label >&nbsp&nbsp发送消息给:&nbsp&nbsp&nbsp&nbsp</label>
		 <select name="select" class="form-control-static" style="width:100px;">
			<option value="0">所有人</option>
			<%
				List<String> userslist2 = (List<String>) application.getAttribute("userslist"+roomid);
				for (int i = 0; i < userslist2.size(); i++) {
					String username = (String) userslist2.get(i);
			%>
		 	<option value="<%=i + 1%>"><%=username%></option>
			<%
				}
			%>
	 	</select>  
		
	
 	<input type="hidden" name="roomid" value="<%=roomid%>">
	 <input type="submit" class="form-control-static" value="发送消息" >
 	<a target="_top" href="outroom.jsp?roomid=<%=roomid %>"> 返回首页</a>
	
	
	<script src="js/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="js/wangEditor.js"></script>
    <div id="div1" ></div>
    <textarea id="msg" name="msg" style="width:70%; height:70px;"></textarea>
    <script type="text/javascript">
        var E = window.wangEditor
        var editor = new E('#div1')
        var $text1 = $('#msg')
        editor.customConfig.onchange = function (html) {
            // 监控变化，同步更新到 textarea
            $text1.val(html)
        }
        editor.create()
        // 初始化 textarea 的值
        $text1.val(editor.txt.html())
    </script>
  

	
</form>


</body>
</html>
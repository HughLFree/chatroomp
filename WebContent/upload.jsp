<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<title>文件上传</title>
</head>
<body>
<%request.setCharacterEncoding("UTF-8"); %>
<div class="panel panel-default">
    <div class="panel-heading">文件上传</div>
	<form method="post" action="/chatroomplus/UploadServlet" class="form-horizontal" enctype="multipart/form-data">
		<br>
	 	<label>  选择一个文件:</label>
	    <input type="file" name="uploadFile" /><br>
	    <button type="submit" class="btn btn-default">上传</button>
	</form>
	<br>
	<label>成功上传文件</label><br>
		<%=request.getAttribute("fileName") %><br>
	    <br>
	    <br>
	    <br>
	    <br>
	    <br>
	    <br>
	    <br>
</div>

</body>
</html>
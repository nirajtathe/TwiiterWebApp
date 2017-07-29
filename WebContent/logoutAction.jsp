<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Again</title>
</head>
<body>

	<%
		response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
		response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
		response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
		response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
		try{
			session.removeAttribute("twitter");
			session.invalidate();
		}
		catch(Exception e){
			session=null;
			%><jsp:forward page="login.jsp"/><%		
		}
	%>
	Successfully Logout
	
	<br>
	<br>
	
	<jsp:include page="login.jsp"></jsp:include>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Twitter Login</title>
	<link rel="stylesheet" href="css/style.css">
</head>
<body>

	<%
		response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
		response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
		response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
		response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
		
		if(!(session.getAttribute("twitter")==null)){
	%>
		<%-- <jsp:forward page="home.jsp"/> --%> 
	<%		
		}
	%>
	
	<!-- Css template starts here -->
	<div class="panda">
		<div class="ear"></div>
		<div class="face">
			<div class="eye-shade"></div>
			<div class="eye-white">
				<div class="eye-ball"></div>
			</div>
			<div class="eye-shade rgt"></div>
			<div class="eye-white rgt">
				<div class="eye-ball"></div>
			</div>
			<div class="nose"></div>
			<div class="mouth"></div>
		</div>
		<div class="body"></div>
		<!-- <div class="foot">
			<div class="finger"></div>
		</div>
		<div class="foot rgt">
			<div class="finger"></div>
		</div> -->
	</div>
	<!-- Css template panda design ends -->>
	
	<form action="home.jsp" name="login" method="post" class="form">
		<div class="hand"></div>
		<div class="hand rgt"></div>
		<h1>Twitter Login</h1>
		
		<div class="form-group">
			<input class="form-control" name="consumerKey"/> 
			<label class="form-label">Consumer Key </label>
		</div>
		
		<div class="form-group">
			<input id="password" type="password" class="form-control" name="consumerSecret"/> 
			<label class="form-label">Consumer Secret</label>
		</div>
		
		<div class="form-group">
			<input class="form-control" name="accessToken"/> 
			<label class="form-label">Access Token</label>
		</div>
		
		<div class="form-group">
			<input id="password" type="password" class="form-control" name="accessTokenSecret"/> 
			<label class="form-label">Access Token Secret</label>
			
			<button class="btn" type="submit" >Login</button>
		</div>
		
	</form>
	
	

</body>
</html>
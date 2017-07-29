<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="twitter4j.Status" import="java.util.List" import="twitter.app.TwitterData"%>
    
<%@ page errorPage="loginError.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Twitter Home</title>
	<link rel="stylesheet" href="css/main.css" />
</head>
<body>
	
	<% 
		response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
		response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
		response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
		response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
		
		TwitterData twitter=null;
		
		if(session.getAttribute("twitter")==null){
			
			try{
				String consumerKey=request.getParameter("consumerKey");
				String consumerSecret=request.getParameter("consumerSecret");
				String accessToken=request.getParameter("accessToken");
				String accessTokenSecret=request.getParameter("accessTokenSecret");

				if(!(consumerKey.isEmpty() && consumerSecret.isEmpty() && accessToken.isEmpty() && accessTokenSecret.isEmpty())){
					try{
						twitter=new TwitterData(consumerKey,consumerSecret,accessToken,accessTokenSecret);
						session.setAttribute("twitter", twitter);
						session.setMaxInactiveInterval(300);//5 mins
				
					}
					catch(Exception e){
						//System.out.println(e.getMessage());
						throw new Exception("Error while trying to connect Twitter. Problem with credentials ! Please Lgin Again.");
					}
				}
			}
			catch(Exception e){
				throw new Exception("Either session is expired or Login Data is not available.");
			}
		}else{
			twitter=(TwitterData)session.getAttribute("twitter");
			if(twitter==null){
				//System.out.println("Problem with twitter object");
				throw new Exception("Problem with twitter web service. Please Login Again.");
			}
		}
		
		List<Status> status=null;
		try{
			if(twitter!=null)
				status=twitter.getStatusList();
			
			if(status==null){
				%>No Data Available to Display<%
			}
		}
		catch(Exception e){
			throw new Exception("Please Login to continue");
		}
	%>
	
	<!-- Header -->
	<header id="header">
		<div class="inner">
			<a href="home.jsp" class="logo"><strong>Twitter</strong> By Niraj</a>
			<nav id="nav">
				<a href="home.jsp">Home</a>
				<!-- <a href="#">Bookmarked</a> -->
				<a href="logoutAction.jsp">Logout</a>
			</nav>
			
			<nav>
				<form action="searchResult.jsp" name="searchAny" method="post" class="form">
					<input name="search" type="text" value="search"/>
					<!-- <button type="submit" class="button">Search</button> -->
				</form>
			</nav>
			
			<a href="#navPanel" class="navPanelToggle"><span class="fa fa-bars"></span></a>
		</div>
	</header>

	<!-- Banner -->
	<section id="banner">
		<div class="inner">
			<header>
				<h1>Welcome to Twitter</h1>
				 <div class="image">
					<img src="<%=twitter.getUserProfileUrl()%>" alt="Pic 01" />	
				 </div>
				 <h1><%=twitter.getUsername()%></h1>
			</header>
			
			<div class="flex ">
					<img src="<%=twitter.getUserBannerUrl()%>" alt="Banner Pic">
			</div>
		</div>
	</section>
	
	<!-- body -->
	
	<section id="three" class="wrapper align-center">
		<div class="inner">
			<div class="flex flex-2">
			
			<% 
			for(int i=0;i<status.size();i++){ 
			%>
				<article>
					<div class="image round">
						<img src="<%=status.get(i).getUser().getProfileImageURL()%>" alt="Pic" />	
					</div>
					<header>
						<h3><%=status.get(i).getUser().getName() %><br /> <%=status.get(i).getUser().getScreenName()%></h3>
					</header>
					<p><%=status.get(i).getText() %></p>
					<footer>
						<a href="#" class="button">Bookmark</a>
						<a href="#" class="button">Like</a>
						<a href="#" class="button">Dislike</a>
					</footer>
				</article>
			<%}
			%>	
				
			</div>
		</div>
	</section>

</body>
</html>
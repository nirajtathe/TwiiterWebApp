<%@ page language="java" contentType="text/html; charset=UTF-8"
   	pageEncoding="UTF-8" import="twitter4j.Status" import="java.util.List" import="twitter.app.TwitterData"%>
    
<%@ page errorPage="loginError.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Search Result</title>
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
			throw new Exception("Please Login to continue..");
		}
		
		
		List<Status> searchResult=null;
		try{
			twitter=(TwitterData)session.getAttribute("twitter");
			if(twitter==null){
				//System.out.println("Problem with twitter object");
				throw new Exception("Problem with twitter web service. Please Login Again.");
			}
			String searchText=null;
			if(request.getParameter("search")!=null){
				searchText=request.getParameter("search");
			}
			if(searchText==null || searchText.isEmpty()){
				searchResult=null;
			}
			else{
				searchResult=twitter.searchTweets(searchText);
			}
			if(searchResult==null){
				%>No Data found using the search text<%
			}
		}
		catch(Exception e){
			throw new Exception("Login failed...Try Again");
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
				<h1>Search Results</h1>
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
					if(searchResult!=null){
						for(int i=0;i<searchResult.size();i++){ 
					%>
						<article>
							<div class="image round">
								<img src="<%=searchResult.get(i).getUser().getProfileImageURL()%>" alt="Pic" />	
							</div>
							<header>
								<h3><%=searchResult.get(i).getUser().getName() %><br /> <%=searchResult.get(i).getUser().getLocation()%></h3>
							</header>
							<p><%=searchResult.get(i).getText() %></p>
							<footer>
								<a href="#" class="button" >Bookmark</a>
								<a href="#" class="button">Like</a>
								<a href="#" class="button">Dislike</a>
							</footer>
						</article>
					<%}
					}
					%>	
						
					</div>
				</div>
			</section>
	

</body>
</html>
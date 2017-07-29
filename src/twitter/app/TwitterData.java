package twitter.app;

import java.util.List;

import twitter4j.Status;
import twitter4j.examples.user.ShowUser;
import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.conf.ConfigurationBuilder;

public class TwitterData {
	String consumerKey;
	String consumerSecret;
	String accessToken;
	String accessTokenSecret;
	
	String username;
	String userBannerUrl;
	String userProfileUrl;
	
	List<Status> status=null;
	
	List<Status> bookmarkList=null;
	
	public TwitterData(String consumerKey,String consumerSecret,String accessToken,String accessTokenSecret){
		this.consumerKey=consumerKey;
		this.consumerSecret=consumerSecret;
		this.accessToken=accessToken;
		this.accessTokenSecret=accessTokenSecret;
	}
	
	public boolean checkConnection(){
		try{
			ConfigurationBuilder cf= new ConfigurationBuilder();
			
			cf.setDebugEnabled(true)
				.setOAuthConsumerKey(consumerKey)
				.setOAuthConsumerSecret(consumerSecret)
				.setOAuthAccessToken(accessToken)
				.setOAuthAccessTokenSecret(accessTokenSecret);
			
			TwitterFactory tf=new TwitterFactory(cf.build());
			
			twitter4j.Twitter twitter=tf.getInstance();
			
			twitter4j.User newUser=twitter.showUser(twitter.getScreenName());
            this.username=newUser.getName();
            this.userBannerUrl=newUser.getProfileBannerURL();
            this.userProfileUrl=newUser.getProfileImageURL();
            //System.out.println(username);

		}
		catch(Exception e){
			System.out.println("Error while accessing twitter. Problem might be with credentials.\nSee Error:"+ e.getMessage());
			return false;
		}
		
		return true;
	}
	
	public String getUsername(){
		return this.username;
	}
	
	public String getUserBannerUrl(){
		return this.userBannerUrl;
	}
	
	public String getUserProfileUrl(){
		return this.userProfileUrl;
	}
	
	public List<Status>  getStatusList(){
		ConfigurationBuilder cf= new ConfigurationBuilder();
		
		cf.setDebugEnabled(true)
			.setOAuthConsumerKey(consumerKey)
			.setOAuthConsumerSecret(consumerSecret)
			.setOAuthAccessToken(accessToken)
			.setOAuthAccessTokenSecret(accessTokenSecret);
		
		TwitterFactory tf=new TwitterFactory(cf.build());
		
		twitter4j.Twitter twitter=tf.getInstance();
		List<Status> status=null;
		try {
			status=twitter.getHomeTimeline();
			
			twitter4j.User newUser=twitter.showUser(twitter.getScreenName());
	        this.username=newUser.getName();
	        this.userBannerUrl=newUser.getProfileBannerURL();
            this.userProfileUrl=newUser.getProfileImageURL();
		} catch (TwitterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return status;
	}
	
	public List<Status> searchTweets(String searchText){
		List<Status> searchResult=null;
		
		ConfigurationBuilder cf= new ConfigurationBuilder();
		
		cf.setDebugEnabled(true)
			.setOAuthConsumerKey(consumerKey)
			.setOAuthConsumerSecret(consumerSecret)
			.setOAuthAccessToken(accessToken)
			.setOAuthAccessTokenSecret(accessTokenSecret);
		
		TwitterFactory tf=new TwitterFactory(cf.build());
		
		twitter4j.Twitter twitter=tf.getInstance();
		List<Status> status=null;
		try {
            Query query = new Query(searchText);
            QueryResult result;
            result = twitter.search(query);
            searchResult = result.getTweets();
			
            twitter4j.User newUser=twitter.showUser(twitter.getScreenName());
	        this.username=newUser.getName();
	        this.userBannerUrl=newUser.getProfileBannerURL();
            this.userProfileUrl=newUser.getProfileImageURL();
		} catch (TwitterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return searchResult;
	}
	
	public void addBookmark(int i){
		
		if(status==null){
			return;
		}
		
		Status temp=status.get(i);
		if(!bookmarkList.contains(temp)){
			bookmarkList.add(temp);
		}
		
	}
	
	public List<Status> getBookmarks(){
		return bookmarkList;
	}
	
}

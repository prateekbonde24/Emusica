<!DOCTYPE html>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%!
	
		Connection con;
		public void jspInit()
		{
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/emusica","root","");
			
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
		}
		public void jspDestroy()
		{try{
			con.close();
			}
		catch(Exception e)
		{
			System.out.println(e);
		}
		}
	%>
<html>
<head>
	<title>Emusica</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="css/bootstrap.css" rel="stylesheet" media="screen">
	<link rel="stylesheet" type="text/css" href="css/customstyles.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>

	<link rel="stylesheet" type="text/css" href="css/MetroJs.lt.min.css">
	<script type="text/javascript" src="js/MetroJs.lt.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="css/page-player.css" />
	<script type="text/javascript" src="js/soundmanager/soundmanager2.js"></script>
	
	<script>
		/* --------

		  Config override: This demo uses shiny flash 9 stuff, overwriting Flash 8-based defaults
		  Alternate PP_CONFIG object must be defined before soundManager.onready()/onload() fire.
		  Alternately, edit the config in page-player.js to simply use the values below by default

		-------- */

		// demo only, but you can use these settings too..
		soundManager.setup({
		  flashVersion: 9,
		  preferFlash: true, // for visualization effects
		  useHighPerformance: true, // keep flash on screen, boost performance
		  wmode: 'transparent', // transparent SWF, if possible
		  url: 'swf/'
		});

		// custom page player configuration

		var PP_CONFIG = {
		  autoStart: false,      // begin playing first sound when page loads
		  playNext: true,        // stop after one sound, or play through list until end
		  useThrottling: false,  // try to rate-limit potentially-expensive calls (eg. dragging position around)</span>
		  usePeakData: true,     // [Flash 9 only] whether or not to show peak data (left/right channel values) - nor noticable on CPU
		  useWaveformData: false,// [Flash 9 only] show raw waveform data - WARNING: LIKELY VERY CPU-HEAVY
		  useEQData: false,      // [Flash 9 only] show EQ (frequency spectrum) data
		  useFavIcon: false     // try to apply peakData to address bar (Firefox + Opera) - performance note: appears to make Firefox 3 do some temporary, heavy disk access/swapping/garbage collection at first(?) - may be too heavy on CPU
		};
	</script>
	<script type="text/javascript" src="js/soundmanager/page-player.js"></script>
</head>
<body style="background-image: url('images/bg.png'); background-repeat: repeat;">
	<div class="navbar navbar-inverse navbar-fixed-top" >
	    <div class="container">
	        <div class="navbar-header">
	          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	          </button>
	          <a class="navbar-brand" href="#">Emusica</a>
	        </div>
	        <div class="navbar-collapse collapse">
	          <ul class="nav navbar-nav">
	            <li><a href="index.jsp">Home</a></li>
	            <li><a href="profile.jsp">Profile</a></li>
	            <li><a href="songs.jsp">Songs</a></li>
	          </ul>
	          <ul class="nav navbar-nav navbar-right">
	            <li><a href="Logout.jsp">Logout</a></li>
	          </ul>
	        <form action="search.jsp" class="navbar-form navbar-right" >
	      		<div class="form-group">
	        	<input name="search" type="text" class="form-control" placeholder="Search">
	    	  	</div>
	        </form>
	       
	        </div><!--/.navbar-collapse -->
	      </div>
	</div>
	<%
		String search=request.getParameter("search");
		String uquery= "select * from user where firstname=? or lastname=?";	
		PreparedStatement ups=con.prepareStatement(uquery);
		ups.setString(1,search);
		ups.setString(2,search);
		ResultSet urs=ups.executeQuery();
		ArrayList users=new ArrayList();
		ArrayList userpics=new ArrayList();
		ArrayList userlinks=new ArrayList();
				
		
		while(urs.next())
		{
			users.add(urs.getString("firstname"));
			userpics.add(urs.getString("profilepic"));
			userlinks.add(urs.getInt("uid"));
			
		}
		String aquery= "select * from artist where firstname=? or lastname=?";	
		PreparedStatement aps=con.prepareStatement(aquery);
		aps.setString(1,search);
		aps.setString(2,search);
		ResultSet ars=aps.executeQuery();
		ArrayList artists=new ArrayList();
		ArrayList artpics=new ArrayList();
		ArrayList artlinks=new ArrayList();
		
		while(ars.next())
		{
			artists.add(ars.getString("firstname"));
			artpics.add(ars.getString("profilepic"));
			artlinks.add(ars.getInt("aid"));
			
		}
		String squery= "select * from artist_song where songname=?";	
		PreparedStatement sps=con.prepareStatement(squery);
		sps.setString(1,search);
		ResultSet srs=sps.executeQuery();
		ArrayList songs=new ArrayList();
		ArrayList songpics=new ArrayList();
		ArrayList songlinks=new ArrayList();
		
		while(srs.next())
		{
			songs.add(srs.getString("songname"));
			int aid=srs.getInt("aid");
			String artquery2= "select * from artist where aid='"+aid+"'";
			Statement stat2=con.createStatement();
			ResultSet rs2=stat2.executeQuery(artquery2);
			rs2.next();
			songpics.add(rs2.getString("profilepic"));
			songlinks.add(srs.getString("songaddr"));
			
		}
	%>
	<div class="row" style="margin-top:70px; padding-left:20px;">
		<div class="col-md-2">
			
			
		</div>	
		<div class="col-md-8" style="border-left:1px solid">
			<h3 align="center">Search Results</h3>
			<%for(int i=0;i<users.size();i++) 
			{%>
			<div class="media" style="border-bottom:1px solid">
			 <a class="pull-left" href="profile.jsp?<%="id="+userlinks.get(i)%>">
			 <div class="live-tile half-tile">  <img class="full media-object" src="<%=userpics.get(i) %>" alt="..."/></div>
			 </a>
			 <div class="media-body">
			   <h4 class="media-heading" style="font-size:28px"><%=users.get(i) %></h4>
			 
			   
			 </div>
			 
			</div>
			
			<%} %>
			<%for(int i=0;i<artists.size();i++) 
			{%>
			<div class="media" style="border-bottom:1px solid">
			 <a class="pull-left" href="artist.jsp?<%="id="+artlinks.get(i)%>">
			 <div class="live-tile half-tile">  <img class="full media-object" src="<%=artpics.get(i) %>" alt="..."/></div>
			 </a>
			 <div class="media-body">
			   <h4 class="media-heading" style="font-size:28px"><%=artists.get(i) %></h4>
			  
			   
			 </div>
			 
			</div>
			<%} %>
			<%for(int i=0;i<songs.size();i++) 
			{%>
			<div class="media" style="border-bottom:1px solid">
			 <a class="pull-left" href="#">
			 <div class="live-tile half-tile">  <img class="full media-object" src="<%=songpics.get(i) %>" alt="..."/></div>
			 </a>
			 <div class="media-body">
			   <h4 class="media-heading" style="font-size:28px"><%=songs.get(i) %></h4>
			  
			   
			 </div>
			 
			</div>
			<%} %>
		</div>

	</div>
</body>
</html>
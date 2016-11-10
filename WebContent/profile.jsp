<!DOCTYPE html>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
 
<% 
	String s=request.getParameter("id");
	int id;
	boolean self=false;
	if(s==null)
	{
		self=true;
		id=3;
	}
	else
	{	
		self=false;
		id=Integer.parseInt(s);
	}
%>
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
		<%
		String username="";
		if(request.getSession(false).getAttribute("username") == null)
	    {
	        response.sendRedirect("First.jsp"); 
	    }
	else
	    {
	        username=String.valueOf(session.getAttribute("username"));
	        id=Integer.parseInt(session.getAttribute("uid").toString());
	        System.out.println(id);
	    } %> 
<html>
<head>
	<title>Emusica</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	
	<link href="css/bootstrap.css" rel="stylesheet" media="screen">
	<link rel="stylesheet" type="text/css" href="css/customstyles.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.file-input.js"></script>
	<link rel="stylesheet" type="text/css" href="css/tango/skin.css">
	<script type="text/javascript" src="js/jquery.jcarousel.min.js"></script>

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
		
		
		
		$(document).ready(function(){$('input[type=file]').bootstrapFileInput();
		$('#controls').hide();
		$('#picsubmit').hide();
		$('#uploadsong').change(function(){
		    var hasNoFiles = this.files.length == 0;
		    if(hasNoFiles)
		    {
		    	$('#controls').hide();
		    }
		    else
		    	{
		    	$('#controls').show();
		    	}
		});
		$('#uploadpic').change(function(){
		    var hasNoFiles = this.files.length == 0;
		    if(hasNoFiles)
		    {$(this).closest('form') /* Select the form element */
		       .find('input[type=submit]') /* Get the submit button */
		       .hide(); /* Disable the button. */}
		    else
		    	{
		    	$(this).closest('form') /* Select the form element */
			       .find('input[type=submit]') /* Get the submit button */
			       .show();
		    	}
		});
		$("#songname").keyup(function(){
	        if ($(this).val() != "") {
	            $("#submitsong").removeAttr("disabled");
	        } else {
	            $("#submitsong").attr("disabled", "true");        
	        }
	    });  
				});
	
		function addplay()
		{
			var name=$("#playname").val();
			var select=$("#selplay");
			var option = new Option(name, name);
			 select.append(option);
		}

		
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
	            <li ><a href="index.jsp">Home</a></li>
	            <%if(self){ %>
	            <li class="active"><a href="#">Profile</a></li><%}else{ %>
	            <li><a href="profile.jsp">Profile</a></li><% }%>
	            <li><a href="songs.jsp">Songs</a></li>
	          </ul>
	          <ul class="nav navbar-nav navbar-right">
	            <li><a href="Logout.jsp">Logout</a></li>
	          </ul>
	        <form action="search.jsp" class="navbar-form navbar-right" >
	      		<div class="form-group">
	        	<input name="search"  type="text" class="form-control" placeholder="Search">
	    	  	</div>
	        </form>
	       
	        </div><!--/.navbar-collapse -->
	      </div>
	</div>
	<%
	
	String query="select * from user where uid=?";
	PreparedStatement ps=con.prepareStatement(query);
	ps.setInt(1, id);
	ResultSet rs=ps.executeQuery();
	String profilepic;
	rs.next();
	profilepic=rs.getString("profilepic");
	
	
	
	
	
	
	
	
	
	
	String query3="select distinct playlist from user_song where uid=?";
	PreparedStatement ps3=con.prepareStatement(query3);
	ps3.setInt(1,id);
	ResultSet rs3=ps3.executeQuery();
	ArrayList playlists=new ArrayList<ArrayList>();
	ArrayList<ArrayList> song_names=new ArrayList();
	ArrayList<ArrayList> links=new ArrayList();
	while(rs3.next())
	{
		playlists.add(rs3.getString("playlist"));
		String query2= "select songname, songaddr from user_song where uid=? and playlist=?";
		PreparedStatement ps2=con.prepareStatement(query2);
		ps2.setInt(1,id);
		ps2.setString(2,rs3.getString("playlist"));
		ResultSet rs2=ps2.executeQuery();
		ArrayList tempsongs=new ArrayList();
		ArrayList templinks=new ArrayList();
		
		while(rs2.next())
		{
			tempsongs.add(rs2.getString("songname"));
			templinks.add(rs2.getString("songaddr"));
		
		}
		song_names.add(tempsongs);
		links.add(templinks);
		
	}
	
	

	
		
		
	%>
	<div class="row" style="margin-top:60px;padding:20px;">
	<div class="col-md-3">
	    <div class="live-tile exclude" style="border: 2px solid #000">
	      <img class="full" src="<%=profilepic%>">
	  	</div>
	  	<div class="clearfix"></div>
	  	
	      <%if(self)
  { %>
  
  <p>
  <form class="pull-left" action="uploadImgServlet" method="post" name="uploadForm" enctype="multipart/form-data">
  <input type="hidden" name="usertype" value="user"> 
   <input type="hidden" name="id" value="<%=id%>"> 
      
  <input id="uploadpic" class="btn btn-primary" title="Change Picture" name="uploadpic" type="file">
  </p>

  
  <input id="picsubmit" class="btn btn-primary" name="submit" type="submit" value="Submit">
 </form>
 
	
	
	
<%} %>
<%System.out.println("Profile id:"+id); %>
</div>
  	<div class="col-md-7">
  	<%if(self){ %>
  	 <form action="uploadServlet" method="post" name="uploadForm" enctype="multipart/form-data">
     <input type="hidden" name="usertype" value="user"> 
     <input type="hidden" name="id" value="<%=id%>"> 
     
     <p><input id="uploadsong" class="btn btn-primary" title="Upload Song" name="uploadfile" type="file"></p>
     <div id="controls">
     <p id="genre" class="pull-left"> Select Genre: 
	 <select name="genre" class="form-control">
	  <option value="Jazz">Jazz</option>
	  <option value="Pop">Pop</option>
	  <option value="Bollywood">Bollywood</option>
	  <option value="Rock">Rock</option>
	  <option value="Punk">Punk</option>
	  <option value="Instrumental">Instrumental</option>
	  <option value="Misc">Misc</option>
	</select></p>
	<p id="playdrop" class="pull-left" style="margin-left:10px;">Playlist Name:<select id="selplay" name="playlistname" class="form-control">
	<%for(int i=0;i<playlists.size();i++){
		%>
		<option value="<%=playlists.get(i)%>"><%=playlists.get(i) %></option>
	<%} %>
	</select></p>
	<div class="pull-right">
	<p>Create New Playlist<p class="pull-left"><input id="playname" name="playname" type="text" class="form-control"></p>
	<p class="pull-right"><a id="createplay" href="javascript:addplay()" class="pull-left btn btn-primary">Create Playlist</a></p>
	</div>
	<div class="clearfix"></div>
	<p>Song Name:<input id="songname" name="songname" type="text" class="form-control"></p>
    <input id="submitsong" disabled="disabled" class="btn btn-primary" name="submit" type="submit" value="Submit">
 	</div>
 	</form>
  		
  	<%} %>
  		<div class="clearfix"></div>
  		<ul class="playlist">
				<%for(int j=0;j<playlists.size();j++){
					%>
				
				<h3><%=playlists.get(j) %></h3>
				<% for(int i=0;i<song_names.get(j).size();i++)
				{%>
					
				  <li style="border-bottom: 2px solid;" ><a href="<%=links.get(j).get(i)%>"><%=(i+1)+". "+song_names.get(j).get(i)%></a><a class="exclude download" href="/WebsiteNew/MusicDownload?filename=<%=links.get(j).get(i)%>"><img src="images/download.png"></a>
				  	<%if(self){ %>	<%} %>
				  </li>
				  <%}}
				  %>
		</ul>
  	</div>
  	
  	
  	<%
  	ArrayList favart=new ArrayList();
  	ArrayList favartpic=new ArrayList();
	String artquery="select aid from follower where uid=?";
  	PreparedStatement artps=con.prepareStatement(artquery);
  	artps.setInt(1, id);
  	ResultSet artrs=artps.executeQuery();
  	while(artrs.next())
  	{
  		int aid=artrs.getInt("aid");
  		String artquery2= "select * from artist where aid='"+aid+"'";
		Statement stat2=con.createStatement();
		ResultSet rs2=stat2.executeQuery(artquery2);
		rs2.next();
		favart.add(rs2.getString("firstname"));
		favartpic.add(rs2.getString("profilepic"));
  	}
  	
  	
  	
  	%>
  	<div class="col-md-2">
  		<h3>Favorite Artists</h3>
  		<ul id="mycarousel" class="jcarousel-skin-tango">
		   <%for(int i=0;i<favart.size();i++){
			     %>
		   
		   <li class="live-tile half-tile exclude" style="border: 2px solid #000">
		   	<img class="full" src="<%=favartpic.get(i)%>">
	  	</li>
			
	  	<%} %>
		
		</ul>
  	</div>
  	</div>
 	<script type="text/javascript">
		function mycarousel_initCallback(carousel)
		{
		    // Disable autoscrolling if the user clicks the prev or next button.
		    carousel.buttonNext.bind('click', function() {
		        carousel.startAuto(0);
		    });

		    carousel.buttonPrev.bind('click', function() {
		        carousel.startAuto(0);
		    });

		    // Pause autoscrolling if the user moves with the cursor over the clip.
		    carousel.clip.hover(function() {
		        carousel.stopAuto();
		    }, function() {
		        carousel.startAuto();
		    });
		};
		jQuery(document).ready(function() {
		    jQuery('#mycarousel').jcarousel({
		        vertical: true,
		    	auto: 2,
		    	wrap: 'last',
		        initCallback: mycarousel_initCallback
		            });
		});
	</script>
</body>
</html>
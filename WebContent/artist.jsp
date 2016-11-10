<!DOCTYPE html>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<% 
	String s=request.getParameter("id");

	int id;
	String usertype="";
	boolean self=false;
	if(s==null)
	{
		self=true;
		id=3;
		usertype="artist";
	}
	
	else
	{	
		self=false;
		id=Integer.parseInt(s);
		usertype="user";
	}
	if(self)
	{	String str=session.getAttribute("aid").toString();}

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

	
	<link rel="stylesheet" type="text/css" href="css/MetroJs.lt.min.css">
	<script type="text/javascript" src="js/MetroJs.lt.min.js"></script>

	<link rel="stylesheet" type="text/css" href="css/soundmanager/360player.css" />
	<link rel="stylesheet" type="text/css" href="css/soundmanager/360player-visualization.css" />
	
	<script type="text/javascript" src="js/soundmanager/berniecode-animator.js"></script>

	<!-- the core stuff -->
	<script type="text/javascript" src="js/soundmanager/soundmanager2.js"></script>
	<script type="text/javascript" src="js/soundmanager/360player.js"></script>

	<script type="text/javascript" src="js/soundmanager/setupsound.js"></script>

	<script>
				
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
	<script>
	var XMLHttpReq;

	//XMLHttpRequest
    function createXMLHttpRequest()
	{
		if(window.XMLHttpRequest)
		{ //Mozilla 
			XMLHttpReq = new XMLHttpRequest();
		}
		else if (window.ActiveXObject)
		{
			// IE
			try
			{
				XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
			}
			catch (e)
			{
				try
				{
					XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
				}
				catch (e)
				{
				}
			}
		}
	}
	
	//Send request function
	function clearcomments()
	{
		$("#comments").empty();
		sendEmptyRequest();
	}
	function sendEmptyRequest()
	{
		createXMLHttpRequest();
		var id=document.getElementById("cursongid").innerHTML;
		var url = "comments";
		XMLHttpReq.open("POST", url, true);
		XMLHttpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		XMLHttpReq.onreadystatechange = processResponse;//Specifies the response function
		XMLHttpReq.send("sid="+id); // Send request
		setTimeout("sendEmptyRequest()" , 1000);
	}

	// Processing functions return information
    function processResponse()
	{
		if (XMLHttpReq.readyState == 4)
		{
			// Determine the state of the object
			if (XMLHttpReq.status == 200)
			{
				var req=XMLHttpReq.responseText.split("\n");
				$("#comments").empty();
				for(var i=0;i<req.length;i++)
				{
					if(i==0)
						continue;
					if(!(req[i]==null||req[i].length==0))
					// Message has been successfully returned to start processing information
					{	var p=document.createElement("p")
					p.innerHTML=req[i];
					document.getElementById("comments").appendChild(p);}
				}
            }
			else
			{
				//Page is not normal
                window.alert("the page you requested has an exception.");
            }
        }
    }

	

</script>
	

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
	          <%if(self) {%>
	            <li ><a href="#">Home</a></li><%}else{ %>
	            <li ><a href="index.jsp">Home</a></li><%} %>
	           <%if(!self) {%>
	            <li><a href="profile.jsp">Profile</a></li>
	            <li><a href="songs.jsp">Songs</a></li>
	          </ul>
	          <form action="search.jsp" class="navbar-form navbar-right" >
	      		<div class="form-group">
	        	<input name="search"  type="text" class="form-control" placeholder="Search">
	    	  	</div>
	        </form><%} %>
	        <ul class="nav navbar-nav navbar-right">
	            <li><a href="Logout.jsp">Logout</a></li>
	          </ul>
	        
	       
	        </div><!--/.navbar-collapse -->
	      </div>
	</div>
	<p id="userid" style="display:none"><%=id %></p>
	<%
	
	String query="select * from artist where aid=?";
	PreparedStatement ps=con.prepareStatement(query);
	ps.setInt(1, id);
	ResultSet rs=ps.executeQuery();
	String profilepic;
	rs.next();
	profilepic=rs.getString("profilepic");
	
	
	
	String query3="select distinct playlist from artist_song where aid=?";
	PreparedStatement ps3=con.prepareStatement(query3);
	ps3.setInt(1,id);
	ResultSet rs3=ps3.executeQuery();
	ArrayList playlists=new ArrayList<ArrayList>();
	ArrayList<ArrayList> song_names=new ArrayList();
	ArrayList<ArrayList> links=new ArrayList();
	ArrayList<ArrayList> songids=new ArrayList();
	while(rs3.next())
	{
		playlists.add(rs3.getString("playlist"));
		String query2= "select sid, songname, songaddr from artist_song where aid=? and playlist=?";
		PreparedStatement ps2=con.prepareStatement(query2);
		ps2.setInt(1,id);
		ps2.setString(2,rs3.getString("playlist"));
		ResultSet rs2=ps2.executeQuery();
		ArrayList tempsongs=new ArrayList();
		ArrayList templinks=new ArrayList();
		ArrayList tempsongids=new ArrayList();
		
		while(rs2.next())
		{
			tempsongs.add(rs2.getString("songname"));
			templinks.add(rs2.getString("songaddr"));
			tempsongids.add(rs2.getString("sid"));
		}
		song_names.add(tempsongs);
		links.add(templinks);
		songids.add(tempsongids);
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
  <input id="uploadpic" class="btn btn-primary" title="Change Picture" name="uploadpic" type="file">
  </p>

 	<input type="hidden" name="usertype" value="artist"> 
  <input id="picsubmit" class="btn btn-primary" name="submit" type="submit" value="Submit">
 </form>

	
	
	
<%} %>
</div>
  	<div class="col-md-6">
  	<%if(self){ %>
  	 <form action="uploadServlet" method="post" name="uploadForm" enctype="multipart/form-data">
 	<input type="hidden" name="usertype" value="artist"> 
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
  	
  	<div id="wrap">
  	<%for(int i=0;i<playlists.size();i++)
  		{%>
  		<h3><%=playlists.get(i)%></h3>
  		<%for(int j=0;j<song_names.get(i).size();j++) {%>
    		<div class="normtile live-tile half-tile" data-delay="1000" data-initdelay="100"  data-direction="horizontal">
    		<div><a class="song" onclick="javascript:clearcomments()" href="#"><p style="display:none"><%=links.get(i).get(j) %></p>
    			<div style="display:none">
    				
    					<p><%=songids.get(i).get(j)%></p>
    				
    			</div>
    		
    		<img class="full" src="<%=profilepic%>" /></a>
    			
		        <span class="tile-title"><%=song_names.get(i).get(j)%></span>
		        </div>
		        <div style="background-color:<%="#"+i*10+""+i*10+""+i*10%>;"><p>Song Name: <%=song_names.get(i).get(j) %>
		        </p></div>
    	</div>
    	<%} %>
     	<div class="clearfix"></div>	
     	
  <%} %>
   </div>
  </div>
  	<%
  		String foquery="select count(uid) from follower where aid=?";
  		PreparedStatement fops=con.prepareStatement(foquery);
  		fops.setInt(1,id);
  		ResultSet fors=fops.executeQuery();
  		fors.next();
  		int number=fors.getInt(1);
  		
  		if(usertype.equals("user"))
  		{
  			
  		}
  				
  	%>
  	<div class="col-md-3">
  		
  	
  		<div style="border:2px solid #000;background-color:#1f1f1f" id="player" class="ui360 ui360-vis" style="margin:0 auto;"><a id="currSong" href="music/Aashiyan.mp3"></a></div>
		<div class="clearfix"></div>
		<%if(!self){ %>
  		
 		<form action="addcomment" method="post">
  		
  			<input id="mycomment" type="text" name="comment" ">
  			<input id="mysongid" type="hidden" name="sid" >
  			<input id="myid" type="hidden" name="myid" value="<%=id %>">
  			<input id="submitcomment" class="btn btn-primary" name="submit" type="submit" value="comment">
  		</form>
  		
  		<%} %>
  		<p id="cursongid" style="display:none" ></p>
		<p>Comments</p>
		<div id="comments"></div>	
  		
  		<p>
  		
  	</div>
 	 <script type="text/javascript">
        $(document).ready(function () {
        
		$(".normtile").liveTile();
        });
</script>
	<script type="text/javascript">
		  		 		
	$(".song").click(function(){
		   if (threeSixtyPlayer.lastSound) {
			threeSixtyPlayer.lastSound.stop(); // may not be needed (but to be safe..) - indicate "stop" to UI..
			 // kill this sound, kill HTTP request etc.
		}
		// and then assign the new URL, and start it:
		var path=$(this).children("p").html();
		document.getElementById('currSong').href = path // new URL..
		threeSixtyPlayer.handleClick({target: document.getElementById('currSong')})
		
		var comdiv=$(this).children("div");
		var currid=comdiv.find("p").text();
		$("#cursongid").empty();
		$("#cursongid").text(currid);
		$("#mysongid").val(currid);
	});
	</script>
</body>
</html>
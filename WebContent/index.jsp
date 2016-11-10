<!DOCTYPE html>
<%@ page import="java.util.ArrayList" 

%>
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
		<%
		int id=0;
		String username="";
		if(request.getSession(false).getAttribute("username") == null)
	    {
	        response.sendRedirect("First.jsp"); 
	    }
	else
	    {
	        username=String.valueOf(session.getAttribute("userId"));
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

	
	<link rel="stylesheet" type="text/css" href="css/slider/advanced-slider-base.css" media="screen"/>
	<link rel="stylesheet" type="text/css" href="css/slider/glossy-square-blue.css" media="screen"/>
	<link rel="stylesheet" type="text/css" href="css/slider/responsive-proportional-slider.css" media="screen"/>
	<link rel="stylesheet" type="text/css" href="css/slider/presentation.css" media="screen"/>
	<!--[if IE 7]><link rel="stylesheet" type="text/css" href="css/slider/presentation-ie7.css" media="screen"/><![endif]-->

	<!--[if IE]><script type="text/javascript" src="js/slider/excanvas.compiled.js"></script><![endif]-->
	<script type="text/javascript" src="js/slider/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="js/slider/jquery.transition.min.js"></script>
	<script type="text/javascript" src="js/slider/jquery.touchSwipe.min.js"></script>
	<script type="text/javascript" src="js/slider/jquery.advancedSlider.min.js"></script>

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

<body  onload ="sendEmptyRequest()" style="background-image: url('images/bg.png'); background-repeat: repeat;">
	<p id="myid" style="display:none"><%=id %></p>
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
	            <li class="active"><a href="#">Home</a></li>
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
		String query="select * from artist_song order by rating desc limit 10";
		Statement stat=con.createStatement();
		ResultSet rs=stat.executeQuery(query);
		ArrayList<String> art_names=new ArrayList<String>();
		ArrayList<String> art_pics=new ArrayList<String>();
		ArrayList<String> art_names1=new ArrayList<String>();
		ArrayList<String> art_pics1=new ArrayList<String>();
		ArrayList<String> song_names1=new ArrayList<String>();
		ArrayList<String> links1=new ArrayList<String>();
		ArrayList<String> song_names=new ArrayList<String>();
		ArrayList<String> links=new ArrayList<String>();
		
		while(rs.next())
		{
			song_names.add(rs.getString("songname").replace("%"," "));
			links.add(rs.getString("songaddr"));
			
		}
		String query1="select aid, count(uid) from follower group by aid order by count(uid) desc limit 10";
		Statement stat1=con.createStatement();
		ResultSet rs1=stat1.executeQuery(query1);
		while(rs1.next())
		{
			int aid=rs1.getInt("aid");
			String query2= "select * from artist where aid='"+aid+"'";
			Statement stat2=con.createStatement();
			ResultSet rs2=stat2.executeQuery(query2);
			rs2.next();
			art_names.add(rs2.getString("firstname"));
			art_pics.add(rs2.getString("profilepic"));
				
		}
		ArrayList timestamp=new ArrayList();
		String query3="select * from artist_song order by timestamp desc";
		Statement stat3=con.createStatement();
		ResultSet rs3=stat3.executeQuery(query3);
		while(rs3.next())
		{
			int aid=rs3.getInt("aid");
			song_names1.add(rs3.getString("songname"));
			links1.add(rs3.getString("songaddr"));
			String query2= "select * from artist where aid='"+aid+"'";
			Statement stat2=con.createStatement();
			ResultSet rs2=stat2.executeQuery(query2);
			rs2.next();
			art_names1.add(rs2.getString("firstname"));
			art_pics1.add(rs2.getString("profilepic"));
			timestamp.add(rs3.getTimestamp("timestamp"));
			
		}
		
		
	%>
	
	<div class="advanced-slider" id="responsive-slider" style="top:40px;">
		<h3> Top Artists</h3>
		<br/>
		<ul class="slides">
		<%
		for(int i=0;i<art_pics.size();i++)
		{%>
			<li class="slide">
				<img class="image" src="<%=art_pics.get(i)%>"/>
				<div class="caption"><%=art_names.get(i) %></div>
			</li>
		<%
		}%>
		</ul>
	</div>
	<br/>
	<br/>
	<br/>
	
	
	
	<div class="row col-md-offset-1 col-md-10" style="margin-top:25px;border-top: 1px solid #000;">
		<div class="col-md-4">
			<h3>Top Songs</h3>
			<ul class="playlist">
				<% for(int i=0;i<song_names.size();i++)
				{%>
				  <li style="border-bottom: 2px solid;"><a href="<%=links.get(i)%>"><%=(i+1)+". "+song_names.get(i)%></a><a class="exclude download" href="/WebsiteNew/MusicDownload?filename=<%=links.get(i)%>"><img src="images/download.png"></a>
				  </li>
				  <%}
				  %>
			</ul>
		</div>
		<div class="col-md-8">
		<h3 align="center">Music Feed</h3>
		<div id="feed" class="tiles">
			<%for(int i=0;i<art_names1.size();i++)
			{%>
				<%switch(i%5){
				case 0:%>
					<div class="normtile live-tile" data-mode="flip" data-delay="3500" data-initdelay="200">
				        
		        <%break ;case 1:%>
		        	<div class="normtile live-tile" data-mode="flip" data-direction="horizontal">
		        <%break; case 2: %>
		       	<div class="normtile live-tile half-tile" data-delay="2000" data-initdelay="500"  data-direction="horizontal">       
		    	
		    	<%break; case 3:%>
		        	<div class="normtile live-tile half-tile" data-mode="flip" data-delay="3000" data-initdelay="300">
		        
		        <%break; case 4:%>
		        	<div class="normtile live-tile half-tall" data-mode="flip" data-direction="horizontal"data-delay="2500" data-initdelay="500">
		        <%break;}%>
		       	<!-- adding the 'full' class to an 'img' or 'a' tag causes it to fill the entire tile -->
		        <p class="timestamp"><%=timestamp.get(i) %></p>
		        <div><a href="<%=links1.get(i)%>"><img class="full" src="<%=art_pics1.get(i)%>" /></a>
		        <span class="tile-title"><%=art_names1.get(i)%></span>
		        </div>
		        <div style="background-color:<%="#"+i*10+""+i*10+""+i*10%>;"><p>Song Name: <%=song_names1.get(i) %>
		        </p></div>
		    	</div>
			<%}%>    
		</div>	
	</div>
	
        
  <script type="text/javascript">
        $(document).ready(function () {
        
		$(".normtile").liveTile();
        });
</script>



	<script type="text/javascript">	
	jQuery(document).ready(function($){
		$('#responsive-slider').advancedSlider({width: '90%',
												height: '60%',
												scaleType: 'outsideFit',
												skin: 'glossy-square-blue',
												effectType: 'swipe',
												pauseSlideshowOnHover: true,
												swipeThreshold: 50,
												slideArrowsToggle: false,
												slideProperties:{
													captionSize: 35, captionHideEffect: 'slide'
														}
		});
		
		
		// set the initial height of the slider to 50% from the width
		$('#responsive-slider').css('height', $('#responsive-slider').width() * 0.50);
		$('#responsive-slider').advancedSlider().doSliderLayout();
		
		// as the window resizes, maintain the slider's height at 50% from the width
		$(window).resize(function() {
			$('#responsive-slider').css('height', $('#responsive-slider').width() * 0.50);
		});
		
	});
	
	
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
	
	function sendEmptyRequest()
	{
		createXMLHttpRequest();
	    var url = "news";
	    var uid=document.getElementById("myid").innerHTML;
		XMLHttpReq.open("get", url, true);
		XMLHttpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		XMLHttpReq.onreadystatechange = processResponse;//Specifies the response function
		XMLHttpReq.send("uid="+uid); // Send request
		//setTimeout("sendEmptyRequest()" , 10000);
	}


	// Processing functions return information
    function processResponse()
	{
		if (XMLHttpReq.readyState == 4)
		{
			// Determine the state of the object
			if (XMLHttpReq.status == 200)
			{
				// Message has been successfully returned to start processing information
				var arr1=XMLHttpReq.responseText.split("\n");
				var maindiv=document.getElementById("feed");
				while(maindiv.hasChildNodes())
				{
					maindiv.removeChild(maindiv.lastChild);
				}
				for(var i=0;i<arr1.length;i++)
				{
				if(i==0||i==arr1.length-1)
					continue;
				var arr=arr1[i].split(" ");
			
				var t=document.createElement("div");
				if((i-1)%5==0)
					{
						t.className="norm-tile live-tile";
						t.setAttribute("data-mode","flip");
						t.setAttribute("data-delay","2000");
						t.setAttribute("data-initdelay","10");
					}
				else if((i-2)%5==0)
					{
					t.className="norm-tile live-tile";
					t.setAttribute("data-mode","flip");
					t.setAttribute("data-direction","horizontal");
					t.setAttribute("data-delay","3000");
					t.setAttribute("data-initdelay","10");
				
					}
				else if((i-3)%5==0)
					{
					t.className="norm-tile live-tile half-tile";
					t.setAttribute("data-direction","horizontal");
					t.setAttribute("data-delay","2500");
					t.setAttribute("data-initdelay","10");
					}
				else if((i-4)%5==0)
				{	
					t.className="norm-tile live-tile half-tile";
					t.setAttribute("data-mode","flip");
					t.setAttribute("data-delay","4000");
					t.setAttribute("data-initdelay","10");
				}
				else if((i-5)%5==0)
					{
					t.className="norm-tile live-tile half-tall";
					t.setAttribute("data-direction","horizontal");
					t.setAttribute("data-mode","flip");
					t.setAttribute("data-delay","1500");
					t.setAttribute("data-initdelay","10");
					}	
				var innerfront=document.createElement("div");
				var a=document.createElement("a");
				a.href=arr[3];
				var image=document.createElement("img");
				image.src=arr[1];
				image.className="full";
				a.appendChild(image);
				innerfront.appendChild(a);
				var sp=document.createElement("span");
				sp.className="tile-title";
				sp.value=arr[0];
				innerfront.appendChild(sp);
				
				var innerback=document.createElement("div");
				innerback.setAttribute("style","background-color:#000;")
				var para=document.createElement("p");
				var regex = new RegExp('%', 'g');
				var name=arr[2].replace(regex," ");
				para.innerHTML="Song Name:"+name;
				innerback.appendChild(para);
				
				t.appendChild(innerfront);
				t.appendChild(innerback);
				
				
				if(!(t==null))
				maindiv.appendChild(t);
				
            }
				$(".norm-tile").liveTile();
			}
			else
			{
				//Page is not normal
                window.alert("the page you requested has an exception.");
            }
			
        }
    }

	

</script>

	
</body>
</html>
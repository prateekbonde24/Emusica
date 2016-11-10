<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../css/ico/favicon.png">
       
        <title>Emusica</title>
        
        <!-- Our CSS stylesheet file -->
        <link rel="stylesheet" href="css/styles2.css" />
       
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/avgrund/avgrund.css" />
    <link rel="stylesheet" type="text/css" href="css/avgrund/styles.css" />

    <!-- Custom styles for this template -->
    <link href="css/customstyles.css" rel="stylesheet">

<script type="text/javascript" src="js/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/soundmanager/360player.css" />
<link rel="stylesheet" type="text/css" href="css/soundmanager/360player-visualization.css" />
<!--[if IE]><script type="text/javascript" src="script/excanvas.js"></script><![endif]-->
<!-- Apache-licensed animation library -->
<script type="text/javascript" src="js/soundmanager/berniecode-animator.js"></script>
<!-- the core stuff -->
<script type="text/javascript" src="js/soundmanager/soundmanager2.js"></script>
<script type="text/javascript" src="js/soundmanager/360player.js"></script>

		<script type="text/javascript" src="js/script.js"></script>
  	<link rel="stylesheet" type="text/css" href="css/loginstyle.css">
  	<script type="text/javascript" src="js/avgrund/avgrund.js"></script>
 <script type="text/javascript" src="js/jquery.form-validator.js"></script> 
		<script type="text/javascript">
		   
		jQuery(document).ready(function(){		     
	$.validate();
		
		});
		
	</script>
	<script type="text/javascript">
	window.history.forward(1);
	</script>
		
<script type="text/javascript">
function openDialog() {
	Avgrund.show( "#default-popup" );
}
function closeDialog() {
	Avgrund.hide();
}
</script>

<script type="text/javascript">

soundManager.setup({
  // path to directory containing SM2 SWF
  url: 'swf/'
});

threeSixtyPlayer.config.scaleFont = (navigator.userAgent.match(/msie/i)?false:true);
threeSixtyPlayer.config.showHMSTime = true;

// enable some spectrum stuffs

threeSixtyPlayer.config.useWaveformData = true;
threeSixtyPlayer.config.useEQData = true;

// enable this in SM2 as well, as needed

if (threeSixtyPlayer.config.useWaveformData) {
  soundManager.flash9Options.useWaveformData = true;
}
if (threeSixtyPlayer.config.useEQData) {
  soundManager.flash9Options.useEQData = true;
}
if (threeSixtyPlayer.config.usePeakData) {
  soundManager.flash9Options.usePeakData = true;
}

if (threeSixtyPlayer.config.useWaveformData || threeSixtyPlayer.flash9Options.useEQData || threeSixtyPlayer.flash9Options.usePeakData) {
  // even if HTML5 supports MP3, prefer flash so the visualization features can be used.
  soundManager.preferFlash = true;
}

// favicon is expensive CPU-wise, but can be used.
if (window.location.href.match(/hifi/i)) {
  threeSixtyPlayer.config.useFavIcon = true;
}

if (window.location.href.match(/html5/i)) {
  // for testing IE 9, etc.
  soundManager.useHTML5Audio = true;
}

</script>
<!-- Our CSS stylesheet file -->
	
		
		
	
        
        <!--[if lt IE 9]>
          <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
    
    





    </head>
    
    <body > 
    <div class="navbar navbar-inverse navbar-fixed-top" style="opacity:0.6;">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Emusica</a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Home</a></li>
            
         <!--       <li><a href="Login.jsp">Login</a></li>-->
           <li style="float:right;"><a href="#" onclick="javascript:openDialog();">Login</a></li>
           <li> </li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

       
      <div class="afternav">

     <div class="ui360 ui360-vis" id="player"><a href="music/Bailando.mp3" ></a></div>
        
<aside id="default-popup" class="avgrund-popup">

        


		<div class="formContainer" id="move" >
			<form id="login" method="post" action="Login1">
				<a href="#" id="flipToRecover" class="flipLink">Forgot?</a>
				<a href="#" id="flipToSignup" class="flipLink1" style="left:0;">Signup?</a>
				<input type="text" name="email" id="loginEmail" value=""  placeholder="Email" data-validation="email" data-validation-error-msg="Incorrect format!!"  data-validation-help="Please give us some more information"/>
				<input type="password" name="pass" id="loginPass" value="" placeholder="Password" data-validation="required" data-validation-error-msg="You did not enter a password"  />
				<input type="submit" name="submit" value="Login" />
				
			</form>
			<form id="recover" method="get" action="Mail">
				<a href="#" id="flipToLogin" class="flipLink">Login</a>
				<input type="text" name="email" id="recoverEmail" value="" placeholder="Email" data-validation="email" data-validation-error-msg="Incorrect format!!"  data-validation-help="Please give us some more information"/>
				<input type="submit" name="submit" value="Recover" />
			</form>
			<form id="signup" method="post" action="Signup">
				<a href="#" id="flipToLogin" class="flipLink1">Login</a>
					<input type="text" name="email" id="loginEmail1" data-validation="email" data-validation-error-msg="Wrong Email id!!" placeholder="Email" />
				<input type="password" name="pass" id="loginPass1"  placeholder="Password"  data-validation="strength" data-validation-strength="2" />
						<input type="password" name="pass" id="loginPass2"  placeholder="Re Enter Password"  data-validation="confirmation"/>
				<input type="submit" name="submit" value="Sign Up" />
				
           
                <input type="radio" checked name="type" id="tab1" value="User">
                <label for="tab1">User</label>
             
                <input type="radio" name="type" id="tab2"  value="Artist">
                <label for="tab2">Artist</label>
              
                 
       
			</form>
		</div>

        

      
   <button onclick="javascript:closeDialog();">Close</button>
		</aside>
		
		<div id="logo"><img src="css/img/logo.png" height="60%" width="60%"></div>
     <div id="player2"><img src="css/img/glow.png"> </div>
        <div>
        <img src="css/img/wall3.jpg" height="100%" width="100%" id="back">
    <img src="css/img/wall3.jpg" height="100%" width="100%" id="back1">
      </div>
      <div id="top-image"></div>
      <div id="back2"><img src="images/img/bakg2.png" >
      </div>
      <%
  	String query3="select songname,songaddr from artist_song";
  	Statement stat3=con.createStatement();
  	ResultSet rs3=stat3.executeQuery(query3);
  		ArrayList<String> song_names=new ArrayList<String>();
		ArrayList<String> links=new ArrayList<String>();
		
		while(rs3.next())
		{
			song_names.add(rs3.getString("songname"));
			links.add(rs3.getString("songaddr"));
			
		}%>
    <% int i=0;
		int j=0;	%>
        <div class="divclass">
       <a href="#" id="blu1" class="allnotes" > <img src="css/img/notes/blue1.png" height="70%" width="70%"><span class="classic"></span></a>
       <a href="#" id="blu2" class="allnotes" > <img src="css/img/notes/blue2.png"height="70%" width="70%"><span class="classic"></span></a>
       <a href="#" id="blu3" class="allnotes" > <img src="css/img/notes/blue3.png" height="40%" width="40%"><span class="classic"></span></a>
       <a href="#" id="blu4" class="allnotes" > <img src="css/img/notes/blue4.png" height="60%" width="60%"><span class="classic"></span></a>
      <a href="#" id="blu5" class="allnotes" > <img src="css/img/notes/blue5.png" height="60%" width="60%"><span class="classic"></span></a>
       <a href="#" id="blu6" class="allnotes" > <img src="css/img/notes/blue6.png"height="35%" width="35%"><span class="classic"></span></a>
       
	  <a href="#" id="blu7" class="allnotes" > <img src="css/img/notes/blue7.png" height="40%" width="40%"><span class="classic"> </span></a>
       <a href="#" id="blu8" class="allnotes" > <img src="css/img/notes/blue8.png" height="30%" width="30%"><span class="classic"> </span></a>
        <a href="#" id="blu9" class="allnotes" > <img src="css/img/notes/blue9.png" height="60%" width="60%"><span class="classic"> </span></a>
</div>

    <div class="divclass">
        <a href="#" id="blu10" class="allnotes"> <img src="css/img/notes/blue1.png" height="40%" width="40%"><span class="classic"> </span></a>
       <a href="#" id="blu11" class="allnotes" > <img src="css/img/notes/blue2.png"height="80%" width="90%"><span class="classic"> </span></a>
       <a href="#" id="blu12" class="allnotes" > <img src="css/img/notes/blue3.png" height="50%" width="50%"><span class="classic"> </span></a>
       <a href="#" id="blu13" class="allnotes" > <img src="css/img/notes/blue4.png" height="40%" width="64%"><span class="classic"> </span></a>
       <a href="#" id="blu14" class="allnotes" > <img src="css/img/notes/blue5.png" height="60%" width="60%"><span class="classic"> </span></a>
       <a href="#" id="blu15" class="allnotes" > <img src="css/img/notes/blue6.png"height="55%" width="55%"><span class="classic"> </span></a>
       <a href="#" id="blu16" class="allnotes" > <img src="css/img/notes/blue7.png" height="50%" width="50%"><span class="classic"> </span></a>
       <a href="#" id="blu17" class="allnotes" > <img src="css/img/notes/blue8.png" height="50%" width="50%"><span class="classic"> </span></a>
        <a href="#" id="blu18" class="allnotes" > <img src="css/img/notes/blue9.png" height="40%" width="40%"><span class="classic"> </span></a>
         <a href="#" id="blu1181" class="allnotes" > <img src="css/img/notes/blue11.png" height="90%" width="90%"><span class="classic"> </span></a>
        </div>


         
        <div class="divclass">
       <a href="#" id="blu19" class="allnotes" > <img src="css/img/notes/blue1.png" height="100%" width="100%"><span class="classic"> </span></a>
       <a href="#" id="blu28" class="allnotes" > <img src="css/img/notes/blue2.png"height="60%" width="60%"><span class="classic"> </span></a>
       <a href="#" id="blu37" class="allnotes" > <img src="css/img/notes/blue3.png" height="70%" width="70%"><span class="classic"> </span></a>
       <a href="#" id="blu46" class="allnotes" > <img src="css/img/notes/blue4.png" height="60%" width="60%"><span class="classic"> </span></a>
       <a href="#" id="blu55" class="allnotes" > <img src="css/img/notes/blue5.png" height="60%" width="60%"><span class="classic"> </span></a>
       <a href="#" id="blu64" class="allnotes" > <img src="css/img/notes/blue6.png"height="35%" width="35%"><span class="classic"> </span></a>
       <a href="#" id="blu73" class="allnotes" > <img src="css/img/notes/blue7.png" height="40%" width="40%"><span class="classic"> </span></a>
       <a href="#" id="blu82" class="allnotes" > <img src="css/img/notes/blue8.png" height="30%" width="30%"><span class="classic"> </span></a>
        <a href="#" id="blu91" class="allnotes" > <img src="css/img/notes/blue9.png" height="80%" width="80%"><span class="classic"> </span></a>
       <a href="#" id="blu882" class="allnotes" > <img src="css/img/notes/blue11.png"height="105%" width="105%"><span class="classic"> </span></a>
        <a href="#" id="blu116" class="allnotes" > <img src="css/img/notes/blue6.png"height="45%" width="45%"><span class="classic"> </span></a>
</div>

<div class="divclass">
     <a href="#" id="blu115" class="allnotes" > <img src="css/img/notes/blue5.png" height="95%" width="95%"><span class="classic"> </span></a>
     <a href="#" id="blu1110" class="allnotes" > <img src="css/img/notes/blue10.png" height="65%" width="65%"></a>
     <a href="#" id="blu1111" class="allnotes" > <img src="css/img/notes/blue11.png" height="135%" width="135%"><span class="classic"> </span></a>
      <a href="#" id="blu1117" class="allnotes" > <img src="css/img/notes/blue7.png" height="70%" width="70%"><span class="classic"> </span></a>
      <a href="#" id="blu1112" class="allnotes" > <img src="css/img/notes/blue2.png"height="50%" width="50%"><span class="classic"> </span></a>
       <a href="#" id="blu1116" class="allnotes" > <img src="css/img/notes/blue6.png"height="45%" width="45%"><span class="classic"> </span></a>

       <a href="#" id="blu1113" class="allnotes" > <img src="css/img/notes/blue3.png" height="50%" width="50%"><span class="classic"> </span></a>

</div>
<div class="divclass">
        <a href="#" id="blu2118" class="allnotes" > <img src="css/img/notes/blue8.png" height="30%" width="30%"><span class="classic"> </span></a>
         <a href="#" id="blu2111" class="allnotes" > <img src="css/img/notes/blue11.png" height="165%" width="165%"><span class="classic"> </span></a>
          <a href="#" id="blu2117" class="allnotes" > <img src="css/img/notes/blue7.png" height="70%" width="70%"><span class="classic"> </span></a>
          <a href="#" id="blu2110" class="allnotes" > <img src="css/img/notes/blue10.png" height="45%" width="45%"><span class="classic"> </span></a>
       <a href="#" id="blu2112" class="allnotes" > <img src="css/img/notes/blue2.png" height="55%" width="55%"><span class="classic"> </span></a>
        <a href="#" id="blu2116" class="allnotes" > <img src="css/img/notes/blue6.png" height="45%" width="45%"><span class="classic"> </span></a>
        
        <a href="#" id="blu2113" class="allnotes" > <img src="css/img/notes/blue3.png" height="45%" width="45%"><span class="classic"> </span></a>
     
        </div>
        <!-- JavaScript includes -->
        
       
</div>
    </body>
</html>
    
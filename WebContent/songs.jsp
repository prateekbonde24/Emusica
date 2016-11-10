
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
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emusica</title>
    <!-- Bootstrap core CSS -->
   <link href="css/bootstrap.css" rel="stylesheet" media="screen">
   <link href="css/song-page.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/customstyles.css">

  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
    
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="../../assets/js/html5shiv.js"></script>
      <script src="../../assets/js/respond.min.js"></script>
    <![endif]-->
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
              <li><a href="profile.jsp">Profile</a></li>
              <li class="active" ><a href="#">Songs</a></li>
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
		String query="select * from artist_song";
		Statement stat=con.createStatement();
		ResultSet rs=stat.executeQuery(query);
		ArrayList art_names =new ArrayList();
		ArrayList song_names =new ArrayList();
		ArrayList song_links =new ArrayList();
		ArrayList album=new ArrayList();
		ArrayList rating=new ArrayList();
		
		while(rs.next())
		{
			String query1="select firstname from artist where aid=?";
			PreparedStatement ps=con.prepareStatement(query1);
			ps.setString(1, rs.getString("aid"));
			ResultSet rs1=ps.executeQuery();
			rs1.next();
			art_names.add(rs1.getString("firstname"));
			song_names.add(rs.getString("songname"));
			song_links.add(rs.getString("songaddr"));
			album.add(rs.getString("playlist"));
			rating.add(rs.getString("rating"));
		}
	

%>
     <!-- CSS goes in the document HEAD or added to your external stylesheet -->
  
<div class="col-md-offset-1 col-md-8">    
      <div style="width:100%">
     
      </div>
      <div align="center" style="width:100%;margin-top:130px; padding-left:20px">
<table cellspacing='0'> <!-- cellspacing='0' is important, must stay -->

  <!-- Table Header -->
  <thead style="width:100%">
    <tr><th style="text-align:center">Select</th>
      <th style="text-align:center">Song Name</th>
      <th>Artist</th>
      <th>Album</th>
      <th>Rating</th>
    </tr>
  </thead>
  <!-- Table Header -->

  <!-- Table Body -->
  <tbody>
	<%
		for(int i=0;i<art_names.size();i++)
		{
			if(i%2==0){
	%>
    	<tr>
    <%}else{ %>
    	<tr class="even">
    <%} %>
      <td><input type="checkbox"></td>
      <td ><%=song_names.get(i) %></td>
      <td><%=art_names.get(i) %></td>
      <td><%=album.get(i) %></td>
      <td><%=rating.get(i) %></td>
    
    </tr><!-- Table Row -->
	
          <% }%>
  </tbody>
  <!-- Table Body -->

</table></div>

      </div>



  </body>
</html>

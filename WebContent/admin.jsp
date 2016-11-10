<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
history.forward();
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/adminpage.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
</head>
<body>
<div style="font-size: 20px; padding-left:40px;">

 <div align="center" style="margin-top:130px; padding-left:20px">
 Users
<table cellspacing='0'>
		<thead >
    <tr><th style="text-align:center">First Name</th>
      <th style="text-align:center">Last Name</th>
      <th>Gender</th>
      <th>Date of birth</th>
      <th>Interests</th>
         <th>Profile Pic</th>
            <th>View</th>
    </tr>
  </thead><%int i=0;
		
		String query1= "select * from user";
		Statement stat1=con.createStatement();
		ResultSet rs1=stat1.executeQuery(query1);
		while(rs1.next())
		{	if(i%2==0){
	%>
    	<tr>
    <%}else{ %>
    	<tr class="even">
    <%} %>
	<tr>
		<td><%=rs1.getString("Firstname") %></td>
		<td><%=rs1.getString("LastName") %></td>
		<td><%=rs1.getString("Gender") %></td>
		<td><%=rs1.getString("Dateofbirth") %></td>
		<td><%=rs1.getString("interests") %></td>
		<td><img src=<%=rs1.getString("ProfilePic")%> height="50px" width="60px"></td>
		<td>
			<a href="adminsong.jsp?id=<%=rs1.getString("uid")%>&type=user" class="btn btn-primary">View</a>
		</td>	
	
	</tr>
		<%i++;}%>
</table>
</div>
</div>
<br><br><br>

 <div align="center" style="margin-top:130px; padding-left:20px;padding-top:35px;">
 <br>
 <br>
 Artists
 <br>
<table cellspacing='0'>
		<thead>
    <tr><th style="text-align:center">First Name</th>
      <th style="text-align:center">Last Name</th>
      <th>Gender</th>
      <th>Date of birth</th>
      <th>Interests</th>
         <th>Profile Pic</th>
            <th>View</th>
    </tr>
  </thead><%int j=0;
		String query2= "select * from artist";
		Statement stat2=con.createStatement();
		ResultSet rs2=stat2.executeQuery(query2);
		while(rs2.next())
		{		if(j%2==0){
	%>
    	<tr>
    <%}else{ %>
    	<tr class="even">
    <%} %>

		<td><%=rs2.getString("Firstname") %></td>
		<td><%=rs2.getString("LastName") %></td>
		<td><%=rs2.getString("Gender") %></td>
		<td><%=rs2.getString("Dateofbirth") %></td>
		<td><%=rs2.getString("interests") %></td>
		<td><img src=<%=rs2.getString("ProfilePic")%> height="50px" width="60px"></td>
	<td>
			<a href="adminsong.jsp?id=<%=rs2.getString("aid")%>&type=artist" class="btn btn-primary">View</a>
		</td>	
		
	</tr>
		<%j++;}%>
				
</table>
</div>

</body>
</html>
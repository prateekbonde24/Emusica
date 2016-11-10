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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="css/adminpage.css">
</head>
<body>
Songs
<table>
		<%
		String type=request.getParameter("type");
		int id=Integer.parseInt(request.getParameter("id"));
		ResultSet rs1;
		if(type.equalsIgnoreCase("user"))
		{	
		String query1= "select * from user_song where uid="+id;
		Statement stat1=con.createStatement();
		rs1=stat1.executeQuery(query1);
		}
		else
		{
			String query1= "select * from artist_song where aid="+id;
			Statement stat1=con.createStatement();
			rs1=stat1.executeQuery(query1);
		}
		while(rs1.next())
		{%>
	<tr>
		<td><%=rs1.getString("Songname") %></td>
		<td><%=rs1.getString("songaddr") %></td>
		<td><%=rs1.getString("playlist") %></td>
		<td>
			<a href="admincomment.jsp?id=<%=rs1.getString("sid")%>&type=<%=type%>&previd=<%=id %>" class="btn btn-primary">View</a>
		</td>	
		<td>
			<a href="delete?id=<%=rs1.getString("sid")%>&type=<%=type%>&extra=song&previd=<%=id%>" class="btn btn-primary">Delete</a>
		</td>
		
	</tr>
		<%}%>
</table>
<br>
			<a href="admin.jsp" class="btn btn-primary">Back</a>
<br>		
</body>
</html>
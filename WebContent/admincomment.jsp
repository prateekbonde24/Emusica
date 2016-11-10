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
<script type="text/javascript">
history.forward();
</script>
<link rel="stylesheet" type="text/css" href="css/adminpage.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">

</head>
<body>
Comments
<table>
		<%
		String type=request.getParameter("type");
		int id=Integer.parseInt(request.getParameter("id"));
		int previd=Integer.parseInt(request.getParameter("previd"));
		ResultSet rs1;
		
			String query1= "select * from artist_comment where sid="+id;
			Statement stat1=con.createStatement();
			rs1=stat1.executeQuery(query1);
	
		while(rs1.next())
		{%>
	<tr>
		<td><%=rs1.getString("comment") %></td>
		<td><%=rs1.getString("date") %></td>
		<td>
			<a href="delete?id=<%=rs1.getString("cid")%>&type=<%=type%>&extra=comment&previd=<%=id%>" class="btn btn-primary">Delete</a>
		</td>
		
	</tr>
		<%}%>
</table>
<td>
			<a href="adminsong.jsp?id=<%=previd%>&type=<%=type%>" class="btn btn-primary">Back</a>
		</td>	
</body>
</html>
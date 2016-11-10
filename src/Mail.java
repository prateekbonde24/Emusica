
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Mail")
public class Mail extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		 Connection con;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/emusica","root","");
				String to=request.getParameter("email");
				to=to.replaceAll("%40", "@");
				String query="Select password from login where username='"+to+"'";
				Statement stat=con.createStatement();
				ResultSet rs=stat.executeQuery(query);
				if(rs.next())
				{
				String subject="Forgot Password";
				String msg="Your password is "+rs.getString("password");
				Mailsend.send(to, subject, msg);
				out.print("message has been sent successfully");
				}
				else
				{
					out.print("message has not been sent");
				}
				out.close();
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
	
	}

}

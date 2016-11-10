

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/Login1")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String emailid,password;
		String dbemail,dbpassword,dbtype;
		
		 emailid=request.getParameter("email");
		 password=request.getParameter("pass");
		System.out.println("Email"+emailid);
		 if(emailid.trim().equals("")||password.trim().equals(""))
		 {
			
			 
			 response.sendRedirect("First.jsp");
		
		 }
		 else{
		 Connection con;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/emusica","root","");
				String query="Select * from login where username like '"+emailid+"' and password like '"+password+"';";
				Statement stat=con.createStatement();
				ResultSet rs=stat.executeQuery(query);
				
				if(!rs.next())
				{
					response.sendRedirect("First.jsp");
					
				}
				
				else{
					
					dbemail=rs.getString("Username");
					dbpassword=rs.getString("Password");
					dbtype=rs.getString("Type");
					if(dbemail.equals(emailid)&&dbpassword.equals(password)&&dbtype.equalsIgnoreCase("Artist"))
					{
						String idquery="select aid from artist where username='"+emailid+"'";
						Statement idstat=con.createStatement();
						ResultSet idrs=idstat.executeQuery(idquery);
						idrs.next();
						response.sendRedirect("artist.jsp");
						HttpSession session = request.getSession();
						session.setAttribute("username", emailid);
						session.setAttribute("aid",idrs.getInt("aid"));
					}
					else if(dbemail.equals(emailid)&&dbpassword.equals(password)&&dbtype.equalsIgnoreCase("user"))
					{
						String idquery="select uid from user where username='"+emailid+"'";
						Statement idstat=con.createStatement();
						ResultSet idrs=idstat.executeQuery(idquery);
						idrs.next();
						
						response.sendRedirect("index.jsp");
						
						HttpSession session = request.getSession();
						session.setAttribute("username", emailid);
						session.setAttribute("uid",idrs.getInt("uid"));
						
					}
				}
				
				
				
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		 }
	}

}

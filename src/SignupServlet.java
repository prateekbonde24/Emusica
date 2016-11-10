

import java.io.IOException;
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

/**
 * Servlet implementation class SignupServlet
 */
@WebServlet("/Signup")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignupServlet() {
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
		
		String emailid,password,type;
		 emailid=request.getParameter("email");
		 password=request.getParameter("pass");
		 type=request.getParameter("type");
		Connection con;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/emusica","root","");
			
			String query="Select * from login where username like '"+emailid+"' and password like'"+password+"'";
			Statement stat=con.createStatement();
			ResultSet rs=stat.executeQuery(query);
			if(!rs.next())
			{
			String query2="insert into login values(?,?,?)";
			PreparedStatement ps=con.prepareStatement(query2);
			System.out.println(emailid);
			ps.setString(1, emailid);
			ps.setString(2, password);
			ps.setString(3, type);
			
			ps.executeUpdate();
			if(type.equals("Artist"))
			{
				String arquery="insert into artist values(null,'','','','','',?,null)";
				PreparedStatement arps=con.prepareStatement(arquery);
				
				arps.setString(1, emailid);
				arps.executeUpdate();
			}
			
			else
			{
				String arquery="insert into user values(null,'','','',null,'','',?)";
				PreparedStatement arps=con.prepareStatement(arquery);
				
				arps.setString(1, emailid);
				arps.executeUpdate();
			}
			}
		else{
			response.sendRedirect("First.jsp");
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.sendRedirect("First.jsp");
	 	
	}

}

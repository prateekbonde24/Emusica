

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class delete
 */
@WebServlet("/delete")
public class delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public delete() {
        super();
        // TODO Auto-generated constructor stub
    }
    Connection con;
    @Override
    public void init() throws ServletException {
    	// TODO Auto-generated method stub
    	try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/emusica","root","");
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String extra=request.getParameter("extra");
		String id=request.getParameter("id");
		String previd=request.getParameter("previd");
		String type=request.getParameter("type");
		try{
		 if(extra.equalsIgnoreCase("song"))
		{
			if(type.equalsIgnoreCase("user"))
			{
				
			String query2= "delete from user_song where sid="+id;
			Statement stat2=con.createStatement();
			stat2.execute(query2);
			
			}
			else if(type.equalsIgnoreCase("artist"))
			{
				String query2= "delete from artist_song where sid="+id;
				Statement stat2=con.createStatement();
				stat2.execute(query2);
			}
			response.sendRedirect("adminsong.jsp?id="+previd+"&type="+type);
		}
		else if(extra.equalsIgnoreCase("comment"))
		{
			if(type.equalsIgnoreCase("artist"))
			{
			String query2= "delete from artist_comment where cid="+id;
			Statement stat2=con.createStatement();
			stat2.execute(query2);
			
			}
			
			response.sendRedirect("admincomment.jsp?id="+previd+"&type="+type);
		}
		}
		catch(Exception e)
		{}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		
	}

}



import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class addcomment
 */
@WebServlet("/addcomment")
public class addcomment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addcomment() {
        super();
        // TODO Auto-generated constructor stub
    }
    Connection con;
   	public void init()
   	{
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
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
    		throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	String songid=request.getParameter("sid");
    	try{
    		String chatMsg=request.getParameter("comment");
    		int userid=Integer.parseInt(request.getParameter("myid"));
    		int sid=Integer.parseInt(songid);
    		String query="insert into artist_comment values(null,?,null,?,?)";
    		PreparedStatement ps=con.prepareStatement(query);
    		ps.setString(1,chatMsg);
    		ps.setInt(2,sid);
    		ps.setInt(3,4);
    		ps.executeUpdate();
    		response.sendRedirect("artist.jsp?id="+userid);
    }catch(Exception e){}
    }

}



import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
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
 * Servlet implementation class news
 */
@WebServlet("/news")
public class news extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public news() {
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
public void service(ServletRequest request, ServletResponse response)
		throws ServletException, IOException {
	request.setCharacterEncoding("UTF-8");
	try{
	int uid=4;
	System.out.println("My id:"+uid);
	String query1="select Firstname, Profilepic, songname, songaddr from follower inner join artist on artist.aid=follower.aid inner join artist_song on follower.aid=artist_song.aid where uid="+uid+" order by timestamp desc limit 10";
	Statement stat1=con.createStatement();
	ResultSet rs1=stat1.executeQuery(query1);
	response.setContentType("text/html;charset=GBK");
	PrintWriter out = response.getWriter();
	out.println(request.getParameter("uid"));
	while(rs1.next())
	{
		out.println(rs1.getString("Firstname")+" "+rs1.getString("Profilepic")+" "+rs1.getString("songname")+" "+rs1.getString("songaddr"));
		//System.out.println(rs1.getString("Firstname")+" "+rs1.getString("Profilepic")+" "+rs1.getString("songname")+" "+rs1.getString("songaddr"));
		
	}
		
	}
	catch(Exception e){
		e.printStackTrace();
	}
}
}

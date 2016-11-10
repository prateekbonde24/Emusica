

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
 * Servlet implementation class comments
 */
@WebServlet("/comments")
public class comments extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public comments() {
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
	String id=request.getParameter("sid");
	
	System.out.println(id);
	String query1="select comment from artist_comment where sid="+id;
	Statement stat1=con.createStatement();
	ResultSet rs1=stat1.executeQuery(query1);
	response.setContentType("text/html;charset=GBK");
	PrintWriter out = response.getWriter();
	out.println();
	while(rs1.next())
	{
		out.println(rs1.getString("comment"));
	}
		
	}
	catch(Exception e){
		e.printStackTrace();
	}
}
}

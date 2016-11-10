

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


/*
 * Servlet implementation class uploadServlet
 */
@WebServlet("/uploadServlet")
public class uploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public uploadServlet() {
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
		 // Directory where files will be saved
		String usertype="";
		
		
		String genre=request.getParameter("genre");
		String songname=request.getParameter("songname");
		
		String playlist=request.getParameter("playlistname");
		System.out.println("Genre:"+genre+"Song name:"+songname+"playlist:"+playlist);
		
		  FileItemFactory factory = new DiskFileItemFactory();

		  // Create a new file upload handler
		  ServletFileUpload upload = new ServletFileUpload(factory);

		  // Parse the request
		  List<FileItem> items = null;
		  try{
		   items = upload.parseRequest(request);
		  } catch (FileUploadException e) {
		   throw new ServletException("Exception while uploading the file");
		  }
		  String name="";
		  String filename="";
		  byte[] fileBytes=null;
		  ArrayList a=new ArrayList();
		  for (FileItem diskFileItem : items) {
		   // Exclude the form fields
		   if (diskFileItem.isFormField()) {
		    a.add(diskFileItem.getString());
		    continue;
		   }
		   else
		   {
			   name=diskFileItem.getName();
		    if(name.endsWith(".mp3"))
		   {
		    	filename=diskFileItem.getName();
		    	fileBytes = diskFileItem.get();
		  
		   }
		   else
		   {
			   response.setContentType("text/html");
				  PrintWriter out=response.getWriter();
				  out.println("Invalid song file");   
		   }
		   }
		  }
		  int id;
		  System.out.println(a);
		  usertype=a.get(0).toString();
		  if(usertype.equals("artist"))
			  id=3;
		  else
			  id=4;
		  genre=a.get(1).toString();
		  playlist=a.get(2).toString();
		  songname=a.get(4).toString();
		  String path="D:\\Yashu's files\\Workspaces\\Eclipse Projects\\WebsiteNew\\WebContent\\music\\";
		  File seshdir = new File(path+usertype);

		  if (!seshdir.exists()) {
		   seshdir.mkdirs();
		  }
	   		File file = new File(seshdir, filename);
		   FileOutputStream fileOutputStream = new FileOutputStream(file);
		   fileOutputStream.write(fileBytes);
		   fileOutputStream.flush();
		   fileOutputStream.close();
		   String addr=name.replaceAll(" ", "%20");
			
			Connection con;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/emusica","root","");
				if(usertype.equals("user"))
				{String query="insert into user_song values(null,?,?,?,?,?)";
				PreparedStatement ps=con.prepareStatement(query);
				ps.setString(1, songname);
				String address="music/"+usertype+"/"+addr;
				ps.setString(2, address);
				ps.setString(3, playlist);
				ps.setInt(4, id);
				ps.setString(5, genre);
				ps.executeUpdate();
				
				}
				else
				{
				String query="insert into "+usertype+"_song values(null,?,?,?,?,null,?,?)";
				PreparedStatement ps=con.prepareStatement(query);
				ps.setString(1, songname.replaceAll(" ", "%"));
				String address="music/"+usertype+"/"+addr;
				ps.setString(2, address);
				ps.setInt(3,id);
				ps.setString(4, playlist);
				ps.setInt(5, 0);
				ps.setString(6, genre);
				ps.executeUpdate();
				
				}
				
				Thread.sleep(3000);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(usertype.equals("user"))
			response.sendRedirect("profile.jsp");
			else
				response.sendRedirect("artist.jsp");
			
		   }
		 
	
	

}

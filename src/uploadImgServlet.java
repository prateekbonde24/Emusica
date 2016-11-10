

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
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

/**
 * Servlet implementation class uploadImgServlet
 */
@WebServlet("/uploadImgServlet")
public class uploadImgServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public uploadImgServlet() {
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
		
		
		String usertype="";
		int uid=4;
int i=0;
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
		  byte fileBytes[]=null;
		  String filename="";
		  for (FileItem diskFileItem : items) {
		   // Exclude the form fields
		   if (diskFileItem.isFormField()) {
			   if(!diskFileItem.getString().equals("Submit")&&i==0)
			   {usertype=diskFileItem.getString();
			   i++;
			   System.out.println("Usertype"+usertype);}
			   
			   continue;
		   }
		   else
		   {
				
		   name=diskFileItem.getName();
		   if(name.endsWith(".jpg")||name.endsWith(".png"))
		   { 
			   fileBytes = diskFileItem.get();
			   filename=diskFileItem.getName();
		   }
		   else
			  {
				  response.setContentType("text/html");
				  PrintWriter out=response.getWriter();
				  out.println("Invalid song file");
			  }
		   }
		   }
		  String path="D:\\Yashu's files\\Workspaces\\Eclipse Projects\\WebsiteNew\\WebContent\\images\\";
			File seshdir = new File(path+usertype);

			  if (!seshdir.exists()) {
			   seshdir.mkdirs();
			  }
			  File file = new File(seshdir,filename );
			   FileOutputStream fileOutputStream = new FileOutputStream(file);
			   fileOutputStream.write(fileBytes);
			   fileOutputStream.flush();
			   fileOutputStream.close();
			   
		    String addr=name.replaceAll(" ", "%20");
		    
			Connection con;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/emusica","root","");
				String query="update "+usertype+" set profilepic=? where username=?";
				PreparedStatement ps=con.prepareStatement(query);
				String address="images/"+usertype+"/"+addr;
				System.out.println(address);
				ps.setString(1,address);
				if(usertype.equals("user"))
				ps.setString(2, "zxcv@gmail.com");
				else
					ps.setString(2,"yashaswialladi@gmail.com");
				ps.executeUpdate();
				Thread.sleep(5000);
				
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
			if(usertype.equals("artist"))
				response.sendRedirect("artist.jsp");
			else
				response.sendRedirect("profile.jsp");
		   }
		 
	
	}



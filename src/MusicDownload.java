

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MusicDownload
 */
@WebServlet("/MusicDownload")
public class MusicDownload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MusicDownload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String filename=request.getParameter("filename");
		File f= new File("D:\\Yashu's files\\Workspaces\\Eclipse Projects\\WebsiteNew\\WebContent\\"+filename);
		response.setContentType("audio/mpeg");
		response.setContentLength((int)f.length());
		response.addHeader("Content-Disposition", "attachment; filename="+filename);
		ServletOutputStream s=response.getOutputStream();
		BufferedInputStream b=new BufferedInputStream(new FileInputStream(f));
		int bytesRead=b.read();
		while(bytesRead!=-1)
		{
			s.write(bytesRead);
			bytesRead=b.read();
		}
		s.close();
		b.close();
	}

}

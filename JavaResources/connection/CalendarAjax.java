package connection;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import connection.DBConnection;
/**
 * Servlet implementation class CalendarAjax
 */
@WebServlet("/CalendarAjax")
public class CalendarAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CalendarAjax() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String redirectURL = "Calendar/calendar.jsp";
		request.setCharacterEncoding("utf-8");
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String title = request.getParameter("title");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String id = request.getParameter("id");
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("user_id");
		try{
			con = DBConnection.getCon();
			String sql="update plan set title=?,startdate=?,enddate=?  where id=? and user_id=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1,title);
			pstmt.setString(2,startdate);
			pstmt.setString(3,enddate);
			pstmt.setString(4,id);
			pstmt.setString(5,user_id);
			pstmt.executeUpdate();
		}catch(Exception e){
			  throw new ServletException("Unable to load JDBC driver:"+ e.toString());
		}
		response.sendRedirect(redirectURL);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

package connection;

import java.sql.*;

public class DBConnection {
	public static Connection getCon() throws SQLException{
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/mycal?serverTimezone=UTC";
			con = DriverManager.getConnection(url,"root","0000");
			return con;
		}catch(ClassNotFoundException ce) {
			System.out.println(ce.getMessage());
			return null;
		}
		
	}
}
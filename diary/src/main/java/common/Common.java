package common;

import java.io.IOException;
import java.lang.ProcessBuilder.Redirect;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.http.HttpServletResponse;

public class Common {
	public Connection conn = null;
	public PreparedStatement stmt = null;
	public ResultSet rs = null; 
	public Connection DBConnection() throws ClassNotFoundException, SQLException {
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
		return conn;
	}
	
	public void msgRedirect(String url, String msg) throws IOException{
		HttpServletResponse response = null;
		response.sendRedirect(url);
	}
	
	public ResultSet sqlResult(String sql, List<String> sqlParams) throws SQLException {
		stmt = conn.prepareStatement(sql);
		for(int i = 0; i < sqlParams.size(); i++) {
			stmt.setString(i, sqlParams.get(i));
		}
		return stmt.executeQuery();
	}
	
}

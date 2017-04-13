package app.login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LogonDBBean {
	private static LogonDBBean instance = new LogonDBBean();

	public static LogonDBBean getInstance() {
		return instance;
	}

	private Connection getConnection() throws SQLException, ClassNotFoundException {
		Class.forName("org.gjt.mm.mysql.Driver");
		Connection conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/bicycle", "root", "apmsetup");
		return conn;
	}

	public int userCheck(String id, String passwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select id,passwd from enter where id=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				String rpw = rs.getString("passwd");
				if(passwd.equals(rpw)){
					System.out.println("로그인성공");
					result=1;
					
				}else if(passwd!=rpw){
					System.out.println("로그인실패");
					result=0;
				}
				
			} else {
				result=0;
			}

		} catch (ClassNotFoundException e) {
			System.out.println("Driver 클래스를 찾을 수 업석나 DB연결 안됨");

		} catch (SQLException e) {
			System.out.println(e);
		}finally{
			try{
				if(rs!=null)
					rs.close();
				if(pstmt!=null)
					pstmt.close();
				if(conn!=null)
					conn.close();
			}catch(SQLException e){
				System.out.println(e);
			}
		}

		return result;
	}	
}

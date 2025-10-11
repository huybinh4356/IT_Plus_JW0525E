package Dao.MySql_JDBC;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connection_DreamTooth {
    private static final String URL =
            "jdbc:mysql://localhost:3306/DreamToothDBDemo?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = "Huybinh2005@";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Đã kết nối DB: " + URL);
            return conn;
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Không tìm thấy Driver MySQL.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("❌ Lỗi kết nối DB:");
            System.err.println("   URL: " + URL);
            System.err.println("   USER: " + USER);
            e.printStackTrace();
        }
        return null;
    }
}

package com.yroom.flooddatainsert.DBUtil;

import java.sql.*;

public class DbUtil {
    //加载驱动
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/floodtx?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    // 数据库的用户名与密码
    static final String USER = "root";
    static final String PASS = "201314";
    Connection conn = null;
//建立链接
    public Connection getConnection() {
        try {
            // 注册 JDBC 驱动
            Class.forName(JDBC_DRIVER);
            // 打开链接
            System.out.println("连接数据库...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return conn;
    }
//关闭链接
    public void closeConnection() {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("数据库连接关闭");
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        DbUtil dbUtil = new DbUtil() ;
        dbUtil.getConnection();
    }
}


















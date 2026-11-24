package com.moneybook;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection getConnection() throws Exception {
        String url = "jdbc:mariadb://localhost:3306/moneybook_db?useUnicode=true&characterEncoding=UTF-8";
        String id = "root";
        String pw = "1234";

        Class.forName("org.mariadb.jdbc.Driver");
        return DriverManager.getConnection(url, id, pw);
    }
}

package com.student.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class databaseConnection {
    private static final String URL = "jdbc:postgresql://localhost:5432/student";
    private static final String USER = "postgres";
    private static final String PASSWORD = "Ragul";
    private static Connection connection = null;

    public static Connection getConnection() {
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError(e);
        }      
        return connection;
    }

    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

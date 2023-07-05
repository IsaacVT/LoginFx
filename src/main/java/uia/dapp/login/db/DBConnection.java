package uia.dapp.login.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection implements IDBConnection {

    private static Connection connect;

    public Connection connectDB() throws ClassNotFoundException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("Error al registrar el driver de MySQL: " + ex);
        }

        String DBUrl = "jdbc:mysql://localhost:3306/";
        String DBName = "myDBName";
        String DBUser = "myUser";
        String DBPassword = "myPassword";

        try{
            connect = DriverManager.getConnection(DBUrl + DBName,DBUser,DBPassword);
            System.out.println("Success connection");
        } catch (Exception e) {
            System.out.println(e);
            System.out.println("Fatal error connection lost");
        }

        return connect;
    }

    public void disconnectDB(Connection con) {
        try {
            con.close();
            System.out.println("Connection close correctly ");
        } catch (SQLException ex) {
            System.out.println(ex);
            System.out.println("Fatal error during connection");
        }
    }
}

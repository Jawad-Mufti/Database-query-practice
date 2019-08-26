package se.chalmers.dm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/**
 * TODO
 * 2/2 points
 */
public class ConnectionHelper {

    private static String DRIVER_CLASS = "org.postgresql.Driver";
    private static String DB_USER = "postgres";
    private static String DB_PASSWORD = "";
    private static String DB_URL = "jdbc:postgresql://localhost:5432/mydb";
    private static int EXIT_FAILURE = 1;
    
	public static Connection createPostgresConnection() {
		Connection c = null;
   	 Statement stmt = null;
   	 try {
   	 Class.forName(DRIVER_CLASS);
   	 c = DriverManager
   	 .getConnection(DB_URL, DB_USER, DB_PASSWORD);
   	 return c;
   	 } catch(Exception e) {
   		 System.err.println("Error "+e.getMessage());
   		 return null;
   	 }
   	
	}

}

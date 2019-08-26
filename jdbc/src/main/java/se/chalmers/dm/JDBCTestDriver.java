package se.chalmers.dm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBCTestDriver {
    // DB connection configuration
    private static String DRIVER_CLASS = "org.postgresql.Driver";
    private static String DB_USER = "postgres";
    private static String DB_PASSWORD = "";
    private static String DB_URL = "jdbc:postgresql://localhost:5432/mydb";
    private static int EXIT_FAILURE = 1;

    public static void main(String[] args) {
        Connection c = null;
        Statement stmt = null;
        try {
            // Setup connection +1
            Class.forName(DRIVER_CLASS);
            c = DriverManager
                    .getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Set up statement +1
            stmt = c.createStatement();
            String sql = "SELECT 7 AS test; ";

            // Execute SQL query +1
            ResultSet rs =
                    stmt.executeQuery(sql);
            rs.next();
            System.out.println(rs.getString("test"));

            // Closing connections +1
            rs.close();
            stmt.close();
            c.close();

            // Catching errors +1
        } catch (Exception e) {
            System.err.println("Error " + e.getMessage());

            /*
             * TODO read comment
             * If the application exits with a 0, it means that there where no errors encountered
             * You need 1 here to say that there's been an issue
             * You should pass EXIT_FAILURE here
              */
            System.exit(0);
        }
    }
}

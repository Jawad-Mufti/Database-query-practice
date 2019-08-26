package se.chalmers.dm;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class QueriesTestDriver {
    public static void main(String[] args) throws SQLException {
    	Connection connection = ConnectionHelper.createPostgresConnection();
        Queries queries = new Queries();
        List<User> activeUsers = queries.findActiveUsers(connection);
        List<String> quotes = queries.findSpecialQuotes(connection);
    }
}

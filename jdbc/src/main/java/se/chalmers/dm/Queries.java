package se.chalmers.dm;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Queries {

	/**
	 * TODO get points
	 * 4/4
	 */
	public List<User> findActiveUsers(Connection connection) {
		List<User> users = new ArrayList<>();
		try {
			PreparedStatement stmt = connection.prepareStatement(QueryHelper.sqlQuery("find_active_users.sql"));
			ResultSet rs = stmt.executeQuery();

			/**
			 * TODO read comment
			 * You can simplify the while loop condition
			 * rs.next() <=> rs.next() == true; These two evaluate to the
			 * same
			 */
			while (rs.next() == true) {
				User tmp = new User();
				
				tmp.setSsn(rs.getString("Ssn"));
				tmp.setName(rs.getString("Name"));
				tmp.setEmail(rs.getString("Email"));
				tmp.setActive(rs.getBoolean("isActive"));

				users.add(tmp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return users;
	}

	/**
	 * TODO get points
	 * 4/4
	 */
	public List<String> findSpecialQuotes(Connection connection) {
		List<String> quotes = new ArrayList<>();
		
		try {
			PreparedStatement stmt = connection.prepareStatement(QueryHelper.sqlQuery("find_special_quotes.sql"));
			ResultSet rs = stmt.executeQuery();
			
			while (rs.next() == true) {
				String tmp = "";
				tmp = rs.getString("content");
				quotes.add(tmp);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return quotes;
	}

}

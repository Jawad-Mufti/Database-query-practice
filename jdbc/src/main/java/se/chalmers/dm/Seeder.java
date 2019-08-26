package se.chalmers.dm;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

import com.github.javafaker.Faker;

/**
 * TODO get points
 * 16/18
 */
public class Seeder {

	private Faker faker;
	private Connection connection;
	private Random random;
	
	public Seeder(Faker faker, Connection connection, Random random) {
		this.faker = faker;
		this.connection = connection;
		this.random = random;
	}

	/**
	 * TODO read comment
	 * 1) The problem is executeQuery(sql) is used when you're expect
	 * to return something. Here you should use executeUpdate(sql)
	 * to create tables
	 * 2) SQL is correct, but why not move it to the sql files, to make
	 * the code cleaner
	 *
	 * 1/2
	 */
	public void createUserTable() {
		try {
			Statement stmt =  this.connection.createStatement();
			String query = "CREATE TABLE \"user\" ("
					+ "Ssn VARCHAR PRIMARY KEY,"
					+ "Name VARCHAR,"
					+ "Email VARCHAR,"
					+ "isActive BOOLEAN);";
			stmt.executeQuery(query);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	/**
	 * TODO get points
	 * 6/6
	 */
	public void insertFakeUsers(int i) {
		 try {        
	            for(int j = 0; j < i; j++ ) {
	                String ssn =  faker.idNumber().ssnValid();
	                String name =  faker.name().fullName() ;
	                String email = faker.internet().emailAddress();
	                boolean isActive = faker.random().nextBoolean();
	                try {
	                    connection.setAutoCommit(false);
	                    PreparedStatement stmt2 = connection.prepareStatement(QueryHelper.sqlQuery("insert_inputs.sql"));
	                    stmt2.setString(1,ssn);
	                    stmt2.setString(2,name);
	                    stmt2.setString(3,email);
	                    stmt2.setBoolean(4,isActive);
	                    stmt2.executeUpdate();
	                    connection.commit();
	                    stmt2.close();
	                }catch(Exception e) {
	                    connection.rollback();
	                }
	            }
	            
	        }catch ( Exception e ) {
	            System.err.println("Error" +e.getMessage());
	            System.exit(0);
	        }
	    }

	/**
	 * TODO read comment
	 * 1) The problem is executeQuery(sql) is used when you're expect
	 * to return something. Here you should use executeUpdate(sql)
	 * to create tables
	 * 2) SQL is correct, but why not move it to the sql files, to make
	 * the code cleaner
	 *
	 * 1/2
	 */
	public void createWebPageTable() {
		try {
			Statement stmt =  this.connection.createStatement();
			String query = "CREATE TABLE \"webpage\" ("
					+ "Url VARCHAR PRIMARY KEY,"
					+ "Author VARCHAR,"
					+ "Content VARCHAR,"
					+ "Popularity INT,"
					+ "FOREIGN KEY(Author) REFERENCES \"user\"(Ssn) );";
			stmt.executeQuery(query);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	/**
	 * TODO read comment
	 * 1) YOu could create helper/auxilary methods to store inputs to
	 * db. That way you would have cleaner  and more readable code
	 *
	 * 8/8
	 */

	public void insertFakeUsersWithWebPage(int i) {
		try {        
            for(int j = 0; j < i; j++ ) {
                String ssn =  faker.idNumber().ssnValid();
                String name =  faker.name().fullName() ;
                String email = faker.internet().emailAddress();
                boolean isActive = faker.random().nextBoolean();
                try {
                    connection.setAutoCommit(false);
                    PreparedStatement stmt2 = connection.prepareStatement(QueryHelper.sqlQuery("insert_user.sql"));
                    stmt2.setString(1,ssn);
                    stmt2.setString(2,name);
                    stmt2.setString(3,email);
                    stmt2.setBoolean(4,isActive);
                    stmt2.executeUpdate();
                    connection.commit();
                    stmt2.close();
                }catch(Exception e) {
                    connection.rollback();
                }
                try {
	                String url = faker.internet().url();
	                String author = ssn;
	                String content = faker.chuckNorris().fact();
	                int popularity = faker.random().nextInt(100);
	                PreparedStatement stmt3 = this.connection.prepareStatement(QueryHelper.sqlQuery("insert_webpage.sql"));
	                stmt3.setString(1, url);
	                stmt3.setString(2, author);
	                stmt3.setString(3, content);
	                stmt3.setInt(4, popularity);
	                stmt3.executeUpdate();
	                connection.commit();
	                stmt3.close();
                } catch(Exception e) {
                	connection.rollback();
                }
            
            }
            
        }catch ( Exception e ) {
            System.err.println("Error" +e.getMessage());
            System.exit(0);
        }
		
	}

}

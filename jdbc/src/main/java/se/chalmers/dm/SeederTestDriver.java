package se.chalmers.dm;

import com.github.javafaker.Faker;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

public class SeederTestDriver {
    public static void main(String[] args) throws SQLException {
         Faker faker = new Faker();
         Connection connection = ConnectionHelper.createPostgresConnection();
         Statement st = connection.createStatement();
         
         Random random = new Random();
         Seeder seeder = new Seeder(faker, connection, random);
         seeder.createUserTable();
         seeder.insertFakeUsers(10);
         seeder.createWebPageTable();
         seeder.insertFakeUsersWithWebPage(100);
    }
}

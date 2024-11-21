package src;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;


public class Login{
	
	public String getter;
	
	public int getVal() {
		String url = "jdbc:mysql://@localhost:3306/grocery_database";
        String user = "root";
        String password = "123456"; //just edit this to put whatever password you set for your local MySQL server 

		try { //Needed because exceptions will be encountered which is pain
			
			System.out.println(getter);
            System.out.println("Connecting to database...");
            Connection connection = DriverManager.getConnection(url, user, password);
            System.out.println("Successfully connected to database.");
            System.out.println(getter);
            PreparedStatement check=connection.prepareStatement("SELECT password FROM securitycheck WHERE password=?"); 
            check.setString(1, getter); //(1 -- first "?", <input from user>)
            ResultSet rs = check.executeQuery(); //Result checker for line 38, returns Boolean
           
            if(rs.next()) { //If true, then login successful, else false
            	connection.close();
            	return 1;
            }
            else {
            	connection.close();
            	return 0;
            } //Has to be at the end of the try block to avoid exception issues
        }
        catch (Exception e){
            System.out.println(e);
            return -1;
        }
	}
}
package src;

import java.util.*;
import java.sql.*;

public class Customer {
	public int customer_id;
	public String last_name;
	public String first_name;
	public String contact_number;
	
	public ArrayList<Integer> id_list = new ArrayList<>();
	public ArrayList<String> last_name_list = new ArrayList<>();
	public ArrayList<String> first_name_list = new ArrayList<>();
	public ArrayList<Integer> contact_list = new ArrayList<>();
	
	public Customer() {
	}
	
	public int add_customer() {
		try {
			String url = "jdbc:mysql://@localhost:3306/grocery_database";
	        String user = "root";
	        String password = "123456"; //just edit this to put whatever password you set for your local MySQL server 
	        
	        Connection connection = DriverManager.getConnection(url, user, password);
			PreparedStatement statement = connection.prepareStatement("SELECT MAX(customer_id) + 1 FROM customer");
			ResultSet result = statement.executeQuery();
			while(result.next()) {
				customer_id = result.getInt(1);
			}
			statement = connection.prepareStatement("INSERT INTO customer (customer_id, last_name, first_name, contact_number) VALUE (?, ?, ?, ?)");
			statement.setInt(1, customer_id);
			statement.setString(2, last_name);
			statement.setString(3, first_name);
			statement.setString(4, contact_number);
			statement.executeUpdate();
			
			statement.close();
			connection.close();
			System.out.println("Customer added successfully");
			return 1;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return 0;
		}
	}
	/*
	public static void main(String args[]) {
		Customer C = new Customer();
		C.last_name = "Doe";
		C.first_name = "Jane";
		C.contact_number = "09458310394";
		C.add_customer();
	}*/
}
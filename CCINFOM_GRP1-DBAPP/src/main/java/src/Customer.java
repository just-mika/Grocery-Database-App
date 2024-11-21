package src;

import java.util.*;
import java.sql.*;

public class Customer {
	public int customer_id;
	public String last_name;
	public String first_name;
	public String contact_number;
	private String sqlPassword = "12205419";
	public ArrayList<Integer> id_list = new ArrayList<>();
	public ArrayList<String> last_name_list = new ArrayList<>();
	public ArrayList<String> first_name_list = new ArrayList<>();
	public ArrayList<String> contact_list = new ArrayList<>();
	
	public Customer() {
	}
	
	public int customer_list() {
		try {
			String url = "jdbc:mysql://@localhost:3306/grocery_database";
	        String user = "root";
	        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
	        
	        Connection connection = DriverManager.getConnection(url, user, password);
			PreparedStatement statement = connection.prepareStatement("SELECT * FROM customer");
			ResultSet result = statement.executeQuery();
			
			id_list.clear();
			last_name_list.clear();
			first_name_list.clear();
			contact_list.clear();
			
			
			while(result.next()) {
				customer_id = result.getInt(1);
				last_name = result.getString(2);
				first_name = result.getString(3);
				contact_number = result.getString(4);
				
				id_list.add(customer_id);
				last_name_list.add(last_name);
				first_name_list.add(first_name);
				contact_list.add(contact_number);
			}
			
			statement.close();
			connection.close();
			System.out.println("List made successfully");
			return 1;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return 0;
		}
	}
	
	public Customer select_customer(int customer_id) {
		try {
			String url = "jdbc:mysql://@localhost:3306/grocery_database";
	        String user = "root";
	        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
	        
	        Connection connection = DriverManager.getConnection(url, user, password);
			PreparedStatement statement = connection.prepareStatement("SELECT * FROM customer WHERE customer_id = ?");
			statement.setInt(1, customer_id);
			ResultSet result = statement.executeQuery();
			
			if (result.next()) {
	            int id = result.getInt("customer_id");
	            String firstName = result.getString("first_name");
	            String lastName = result.getString("last_name");
	            String contactNo = result.getString("contact_number");

	            Customer selected = new Customer();
	            selected.customer_id = id;
	            selected.first_name = firstName;
	            selected.last_name = lastName;
	            selected.contact_number = contactNo;
	            
	            statement.close();
				connection.close();
				System.out.println("Customer selected successfully");
	            return selected;
			}
			return null;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}
	
	public int add_customer() {
		try {
			String url = "jdbc:mysql://@localhost:3306/grocery_database";
	        String user = "root";
	        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
	        
	        Connection connection = DriverManager.getConnection(url, user, password);
	        PreparedStatement statement = connection.prepareStatement("SELECT customer_id FROM customer ORDER BY customer_id");
	        ResultSet result = statement.executeQuery();

	        int expectedId = 0;
	        while (result.next()) {
	            int currentId = result.getInt("customer_id");
	            if (currentId != expectedId) {
	                break;
	            }
	            expectedId++;
	        }

	        customer_id = expectedId;
	        
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
	
	public int delete_customer(int customer_id) {
		try {
			String url = "jdbc:mysql://@localhost:3306/grocery_database";
	        String user = "root";
	        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
	        
	        Connection connection = DriverManager.getConnection(url, user, password);
			PreparedStatement statement = connection.prepareStatement("DELETE FROM customer WHERE customer_id = ?");
			statement.setInt(1, customer_id);
			
			if (statement.executeUpdate() > 0) {
				System.out.println("Customer deleted successfully");
				statement.close();
				connection.close();
				return 1;
			} else {
				System.out.println("Customer delete failed.");
				statement.close();
				connection.close();
				return 0;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return 0;
		}
	}
	
	public int update_customer(int customer_id, String first_name, String last_name, String contact_number) {
		try {
			String url = "jdbc:mysql://@localhost:3306/grocery_database";
	        String user = "root";
	        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
	        
	        Connection connection = DriverManager.getConnection(url, user, password);
			PreparedStatement statement = connection.prepareStatement("UPDATE customer SET first_name = ?, last_name = ?, contact_number = ? WHERE customer_id = ?");
			statement.setString(1, first_name);
			statement.setString(2, last_name);
			statement.setString(3, contact_number);
			statement.setInt(4, customer_id);
			
			if (statement.executeUpdate() > 0) {
				System.out.println("Customer updated successfully");
				statement.close();
				connection.close();
				return 1;
			} else {
				System.out.println("Customer Update failed.");
				statement.close();
				connection.close();
				return 0;
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return 0;
		}
	}
}
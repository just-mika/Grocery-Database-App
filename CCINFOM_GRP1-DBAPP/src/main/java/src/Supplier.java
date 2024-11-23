package src;

import java.sql.*;
import java.util.ArrayList;

public class Supplier {
	public int supplierCode;
    public String supplierName;
    private String sqlPassword = "123456";
    public ArrayList<Integer> id_list = new ArrayList<>();
    public ArrayList<String> name_list = new ArrayList<>();
    
    public Supplier() {
    	
    }
    
    public Supplier(int supplierCode, String supplierName) {
    	this.supplierCode = supplierCode;
        this.supplierName = supplierName;
    }

    public int addSupplier() {
        try {
            String url = "jdbc:mysql://localhost:3306/grocery_database"; // Change to your database URL
            String user = "root"; // Change to your MySQL username
            String password = sqlPassword; // Change to your MySQL password

            Connection connection = DriverManager.getConnection(url, user, password);

            // Get the next supplier_code (if needed, depending on auto-increment settings)
            PreparedStatement statement = connection.prepareStatement("SELECT supplier_code FROM supplier ORDER BY supplier_code DESC LIMIT 1");
            ResultSet result = statement.executeQuery();

            int nextSupplierCode = 1; // Default to 1 if no suppliers exist
            if (result.next()) {
                nextSupplierCode = result.getInt("supplier_code") + 1; // Increment supplier_code by 1
            }

            // Insert the new supplier
            statement = connection.prepareStatement(
                "INSERT INTO supplier (supplier_code, supplier_name) VALUES (?, ?)"
            );
            statement.setInt(1, nextSupplierCode); // Set the next available supplier_code
            statement.setString(2, this.supplierName); // Set the supplier name

            // Execute the insert statement
            statement.executeUpdate();

            statement.close();
            connection.close();
            System.out.println("Supplier added successfully");
            return 1; // Return 1 to indicate success
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0; // Return 0 if an error occurs
        }
    }
    
    public int updateSupplierName() {
        try {
            String url = "jdbc:mysql://localhost:3306/grocery_database";
            String user = "root";
            String password = sqlPassword;  // Replace with your MySQL password

            // Connect to the database
            Connection connection = DriverManager.getConnection(url, user, password);

            // Prepare SQL statement to update the supplier's name
            PreparedStatement statement = connection.prepareStatement(
                "UPDATE supplier SET supplier_name = ? WHERE supplier_code = ?"
            );

            // Set the parameters (the new supplier name and the supplier code to identify the row)
            statement.setString(1, supplierName);

            // Execute the update
            int rowsUpdated = statement.executeUpdate();

            // Close the connection
            statement.close();
            connection.close();

            // Return status (1 means success, 0 means failure)
            return (rowsUpdated > 0) ? 1 : 0;

        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public Supplier getSupplierByCode(int supplierCode) {
        try {
            String url = "jdbc:mysql://localhost:3306/grocery_database";
            String user = "root";
            String password = sqlPassword; // Replace with your MySQL password
            
            Connection connection = DriverManager.getConnection(url, user, password);
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM supplier WHERE supplier_code = ?");
            statement.setInt(1, supplierCode);
            ResultSet result = statement.executeQuery();
            
            if (result.next()) {
                Supplier supplier = new Supplier();
                supplier.supplierCode = result.getInt("supplier_code");
                supplier.supplierName = result.getString("supplier_name");
                
                statement.close();
                connection.close();
                return supplier;
            } else {
                statement.close();
                connection.close();
                return null; // No supplier found
            }
        } catch (Exception e) {
            System.out.println("Error fetching supplier: " + e.getMessage());
            return null;
        }
    }
    
    public int update_supplier(int supplierCode, String supplierName) {
        try {
            String url = "jdbc:mysql://localhost:3306/grocery_database";
            String user = "root";
            String password = sqlPassword; // Edit this with your MySQL password

            Connection connection = DriverManager.getConnection(url, user, password);
            PreparedStatement statement = connection.prepareStatement(
                "UPDATE supplier SET supplier_name = ? WHERE supplier_code = ?"
            );
            statement.setString(1, supplierName);
            statement.setInt(2, supplierCode);

            int rowsUpdated = statement.executeUpdate();
            statement.close();
            connection.close();

            return rowsUpdated > 0 ? 1 : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public void supplier_list() {
        try {
            String url = "jdbc:mysql://localhost:3306/grocery_database";
            String user = "root";
            String password = sqlPassword; // Edit this with your MySQL password

            Connection connection = DriverManager.getConnection(url, user, password);
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery("SELECT supplier_code, supplier_name FROM supplier");

            id_list = new ArrayList<>();
            name_list = new ArrayList<>();
            while (result.next()) {
                id_list.add(result.getInt("supplier_code"));
                name_list.add(result.getString("supplier_name"));
            }

            result.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
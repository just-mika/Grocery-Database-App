package src;

import java.sql.*;

public class Supplier {
	public int supplierCode;
    public String supplierName;
    private String sqlPassword = "123456";
    
    public Supplier() {
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
    
}
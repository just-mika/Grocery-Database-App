package src;

import java.sql.*;
import java.util.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ProductOrderBatch {
    public int batchId;
    public int quantityOrdered;
    public String dateOrdered;
    public double cost;
    public int productCode;
    public int supplierCode;
    private String sqlPassword = "123456";
    public List<Integer> batchIdList = new ArrayList<>();
    public List<Integer> quantityOrderedList = new ArrayList<>();
    public List<Timestamp> dateOrderedList = new ArrayList<>();
    public List<Double> costList = new ArrayList<>();
    public List<Integer> productCodeList = new ArrayList<>();
    public List<Integer> supplierCodeList = new ArrayList<>();
    
    public ProductOrderBatch() {
    }

    public int addProductOrderBatch() {
        try {
            String url = "jdbc:mysql://@localhost:3306/grocery_database";
            String user = "root";
            String password = sqlPassword; // Edit this with your MySQL server password
            
            Connection connection = DriverManager.getConnection(url, user, password);

            // Get the next batch ID
            PreparedStatement statement = connection.prepareStatement("SELECT batch_id FROM product_order_batch ORDER BY batch_id");
            ResultSet result = statement.executeQuery();

            int expectedId = 0;
            while (result.next()) {
                int currentId = result.getInt("batch_id");
                if (currentId != expectedId) {
                    break;
                }
                expectedId++;
            }
            batchId = expectedId;

            // Insert the new product order batch
            statement = connection.prepareStatement(
                "INSERT INTO product_order_batch (batch_id, quantity_ordered, date_ordered, cost, product_code, supplier_code) VALUES (?, ?, ?, ?, ?, ?)"
            );
            statement.setInt(1, batchId);
            statement.setInt(2, quantityOrdered);
            statement.setTimestamp(3, Timestamp.valueOf(dateOrdered));
            statement.setDouble(4, cost);
            statement.setInt(5, productCode);
            statement.setInt(6, supplierCode);

            statement.executeUpdate();

            statement.close();
            connection.close();
            System.out.println("Product Order Batch added successfully");
            return 1;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public int productOrderBatchList() {
        try {
            String url = "jdbc:mysql://localhost:3306/grocery_database";  
            String user = "root";  
            String password = "123456";  

            Connection connection = DriverManager.getConnection(url, user, password);
            
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM product_order_batch");
            ResultSet result = statement.executeQuery();

            // Clear existing lists
            batchIdList.clear();
            quantityOrderedList.clear();
            dateOrderedList.clear();
            costList.clear();
            productCodeList.clear();
            supplierCodeList.clear();

            // Populate the lists with the result set
            while (result.next()) {
                int batchId = result.getInt("batch_id");
                int quantityOrdered = result.getInt("quantity_ordered");
                Timestamp dateOrdered = result.getTimestamp("date_ordered");
                double cost = result.getDouble("cost");
                int productCode = result.getInt("product_code");
                int supplierCode = result.getInt("supplier_code");

                // Add to the respective lists
                batchIdList.add(batchId);
                quantityOrderedList.add(quantityOrdered);
                dateOrderedList.add(dateOrdered);
                costList.add(cost);
                productCodeList.add(productCode);
                supplierCodeList.add(supplierCode);
            }

            statement.close();
            connection.close();
            System.out.println("Product Order Batches list made successfully");
            return 1;  // Success
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;  // Failure
        }
    }
    
    public boolean deleteProductOrderBatch(int batchId) {
        try {
            String url = "jdbc:mysql://localhost:3306/grocery_database";  // Your DB URL
            String user = "root";  // Your DB username
            String password = "123456";  // Your DB password

            Connection connection = DriverManager.getConnection(url, user, password);
            String query = "DELETE FROM product_order_batch WHERE batch_id = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, batchId);

            int result = statement.executeUpdate();
            statement.close();
            connection.close();
            return result > 0;  // Returns true if deletion was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;  // Returns false if deletion failed
        }
    }
    
}
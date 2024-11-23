package src;

import java.sql.*;
import java.util.*;

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
        Connection connection = null;
        PreparedStatement insertBatchStmt = null;
        PreparedStatement updateStockStmt = null;
        try {
            String url = "jdbc:mysql://@localhost:3306/grocery_database";
            String user = "root";
            String password = sqlPassword; // Update with your MySQL password

            connection = DriverManager.getConnection(url, user, password);

            // Get the next batch ID
            PreparedStatement idCheckStmt = connection.prepareStatement("SELECT batch_id FROM product_order_batch ORDER BY batch_id");
            ResultSet result = idCheckStmt.executeQuery();

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
            String insertBatchQuery = "INSERT INTO product_order_batch (batch_id, quantity_ordered, date_ordered, cost, product_code, supplier_code) VALUES (?, ?, ?, ?, ?, ?)";
            insertBatchStmt = connection.prepareStatement(insertBatchQuery);
            insertBatchStmt.setInt(1, batchId);
            insertBatchStmt.setInt(2, quantityOrdered);
            insertBatchStmt.setTimestamp(3, Timestamp.valueOf(dateOrdered));
            insertBatchStmt.setDouble(4, cost);
            insertBatchStmt.setInt(5, productCode);
            insertBatchStmt.setInt(6, supplierCode);

            int rowsInserted = insertBatchStmt.executeUpdate();

            if (rowsInserted > 0) {
                // Update the quantity_in_stock in product_info
                String updateStockQuery = "UPDATE product_info SET quantity_in_stock = quantity_in_stock + ? WHERE product_code = ?";
                updateStockStmt = connection.prepareStatement(updateStockQuery);
                updateStockStmt.setInt(1, quantityOrdered);
                updateStockStmt.setInt(2, productCode);

                int rowsUpdated = updateStockStmt.executeUpdate();
                if (rowsUpdated > 0) {
                    System.out.println("Stock updated successfully.");
                } else {
                    System.out.println("Failed to update stock.");
                    return 0; // Update stock failed
                }
            }

            insertBatchStmt.close();
            idCheckStmt.close();
            connection.close();
            System.out.println("Product Order Batch added successfully");
            return 1; // Success
        } catch (Exception e) {
            e.printStackTrace();
            return 0; // Failure
        } finally {
            try {
                if (insertBatchStmt != null) insertBatchStmt.close();
                if (updateStockStmt != null) updateStockStmt.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public int productOrderBatchList() {
        try {
            String url = "jdbc:mysql://@localhost:3306/grocery_database";  
            String user = "root";  
            String password = sqlPassword;  

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
            String url = "jdbc:mysql://@localhost:3306/grocery_database";  // Your DB URL
            String user = "root";  // Your DB username
            String password = sqlPassword;  // Your DB password

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
    
    public List<Map<String, Object>> getFilteredOrderBatches(String productCode, String supplierCode, String dateOrdered) {
        List<Map<String, Object>> records = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocery_database", "root", sqlPassword)) {
            String query = "SELECT * FROM product_order_batch WHERE 1=1";
            if (productCode != null && !productCode.isEmpty()) {
                query += " AND product_code = ?";
            }
            if (supplierCode != null && !supplierCode.isEmpty()) {
                query += " AND supplier_code = ?";
            }
            if (dateOrdered != null && !dateOrdered.isEmpty()) {
                query += " AND DATE(date_ordered) = ?";
            }

            PreparedStatement statement = connection.prepareStatement(query);
            int paramIndex = 1;
            if (productCode != null && !productCode.isEmpty()) {
                statement.setInt(paramIndex++, Integer.parseInt(productCode));
            }
            if (supplierCode != null && !supplierCode.isEmpty()) {
                statement.setInt(paramIndex++, Integer.parseInt(supplierCode));
            }
            if (dateOrdered != null && !dateOrdered.isEmpty()) {
                statement.setString(paramIndex++, dateOrdered);
            }

            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Map<String, Object> record = new HashMap<>();
                record.put("batch_id", resultSet.getInt("batch_id"));
                record.put("product_code", resultSet.getInt("product_code"));
                record.put("quantity_ordered", resultSet.getInt("quantity_ordered"));
                record.put("supplier_code", resultSet.getInt("supplier_code"));
                record.put("date_ordered", resultSet.getTimestamp("date_ordered"));
                record.put("cost", resultSet.getDouble("cost"));
                records.add(record);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return records;
    }
    
    public Map<String, Object> getOrderBatchDetails(int batchId) {
        Map<String, Object> batchDetails = new HashMap<>();

        try {
            String url = "jdbc:mysql://@localhost:3306/grocery_database"; // Your DB URL
            String user = "root"; // Your DB username
            String password = sqlPassword; // Your DB password

            // Establish connection
            Connection connection = DriverManager.getConnection(url, user, password);

            // SQL query to fetch details of a specific product order batch by batch_id
            String query = "SELECT * FROM product_order_batch WHERE batch_id = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, batchId); // Set the batch_id parameter in the query

            ResultSet result = statement.executeQuery();

            if (result.next()) {
                // Fetch data from the result set and add to the map
                batchDetails.put("batch_id", result.getInt("batch_id"));
                batchDetails.put("product_code", result.getInt("product_code"));
                batchDetails.put("quantity_ordered", result.getInt("quantity_ordered"));
                batchDetails.put("supplier_code", result.getInt("supplier_code"));
                batchDetails.put("date_ordered", result.getTimestamp("date_ordered"));
                batchDetails.put("cost", result.getDouble("cost"));
            }

            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace(); // Log any errors
        }

        return batchDetails; // Return the details as a map
    }

}
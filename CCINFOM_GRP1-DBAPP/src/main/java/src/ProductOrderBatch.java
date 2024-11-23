package src;

import java.sql.*;
import java.util.ArrayList;
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
}
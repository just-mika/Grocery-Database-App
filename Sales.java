package src;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.*;
import java.time.*;
public class Sales {
	
	
	
	private String sqlPassword = "12205419";
	
	/*For Customer Items*/
	
	/*****************************************************************/
	private int itemID;
	private int quantityOrdered;
	private float total, priceItem;
	private int salesID, codeProduct;
	
	private ArrayList<Integer> item_id = new ArrayList<>();
	private ArrayList<Integer> quantity = new ArrayList<>();
	private ArrayList<Float> product_total = new ArrayList<>();
	private ArrayList<Float> price = new ArrayList<>();
	private ArrayList<Integer> productCode = new ArrayList<>();
	private ArrayList<Integer> sales_id = new ArrayList<>();
	/*****************************************************************/
	
	/*For sales_transactions*/
	
	/*****************************************************************/
	private int transactionID, customerID;
	private int totalItems;
	private float totalCost;
	private String dateOfSale;
	
	private ArrayList<Integer> transaction_id = new ArrayList<>();
	private ArrayList<Integer> total_items = new ArrayList<>();
	private ArrayList<Float> total_cost = new ArrayList<>();
	private ArrayList<String> date_of_sale = new ArrayList<>();
	private ArrayList<Integer> customer_id_list = new ArrayList<>();
	/*****************************************************************/
	
	
	public void getVals() {
		
		try {
			String url = "jdbc:mysql://@localhost:3306/grocery_database";
	        String user = "root";
	        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
	        
	        Connection connection = DriverManager.getConnection(url, user, password);
			PreparedStatement statement = connection.prepareStatement("SELECT * FROM customer_items");
			ResultSet result = statement.executeQuery();
			
			item_id.clear();
			quantity.clear();
			product_total.clear();
			price.clear();
			productCode.clear();
			sales_id.clear();
			
			
			while(result.next()) {
				itemID = result.getInt(1);
				quantityOrdered = result.getInt(2);
				total = result.getFloat(3);
				priceItem = result.getFloat(4);
				codeProduct = result.getInt(5);
				salesID = result.getInt(6);
				
				item_id.add(itemID);
				quantity.add(quantityOrdered);
				product_total.add(total);
				price.add(priceItem);
				productCode.add(codeProduct);
				sales_id.add(salesID);
			}
			
			statement = connection.prepareStatement("SELECT * FROM sales_transactions");
			result = statement.executeQuery();
			
			transaction_id.clear();
			total_items.clear();
			total_cost.clear();
			date_of_sale.clear();
			customer_id_list.clear();
			
			while(result.next()) {
				transactionID = result.getInt(1);
				totalItems = result.getInt(2);
				totalCost = result.getFloat(3);
				dateOfSale = result.getString(4);
				customerID = result.getInt(5);
				
				transaction_id.add(transactionID);
				total_items.add(totalItems);
				total_cost.add(totalCost);
				date_of_sale.add(dateOfSale);
				customer_id_list.add(customerID);
			}
			
			statement.close();
			connection.close();
			System.out.println("List made successfully");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	
	private int addOrder(int product_code, int quantityInput, float product_totalprice, float product_price, int customer_id) {
		
		try {
			String url = "jdbc:mysql://@localhost:3306/grocery_database";
	        String user = "root";
	        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
	        
	        Connection connection = DriverManager.getConnection(url, user, password);
	        PreparedStatement statement = connection.prepareStatement("SELECT item_id FROM customer_items ORDER BY item_id");
	        ResultSet result = statement.executeQuery();

	        int expectedId = 0;
	        while (result.next()) {
	            int currentId = result.getInt("item_id");
	            if (currentId != expectedId) {
	                break;
	            }
	            expectedId++;
	        }

	        itemID = expectedId;
	        
	        
	        System.out.println("done"); 
	        
	        
	        
			statement = connection.prepareStatement("INSERT INTO customer_items (item_id, quantity, product_total, price, product_code, sales_transactions_transaction_id) VALUE (?, ?, ?, ?, ?, ?)");
			statement.setInt(1, itemID);
			statement.setInt(2, quantityInput);
			statement.setFloat(3, product_totalprice);
			statement.setFloat(4, product_price);
			statement.setInt(5, product_code);
			statement.setInt(6, 0);
			statement.executeUpdate();
			
			
			statement.close();
			connection.close();
			System.out.println("Order Added successfully!");
			return 1;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return 0;
		}
	}
	
	public int CheckOut(int customer_id) {
		
		try {
		String url = "jdbc:mysql://@localhost:3306/grocery_database";
        String user = "root";
        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
        
        Connection connection = DriverManager.getConnection(url, user, password);
        PreparedStatement statement = connection.prepareStatement("SELECT transaction_id FROM sales_transactions");
        ResultSet result = statement.executeQuery();
        result = statement.executeQuery();
        
        int expectedId = 0;
        while (result.next()) {
            int currentId = result.getInt("transaction_id");
            if (currentId != expectedId) {
                break;
                
            }
            expectedId++; }
            

        transactionID = expectedId;
        
        System.out.println(transactionID);
        
        LocalDateTime currentDate = LocalDateTime.now();
        
        statement = connection.prepareStatement("INSERT INTO sales_transactions(transaction_id, total_items, total_cost, date_of_sale, customer_id) VALUE(?, ?, ?, ?, ?)");
        statement.setInt(1, transactionID);
        statement.setInt(2, 0);
		statement.setFloat(3, 0);
		statement.setTimestamp(4, Timestamp.valueOf(currentDate));
		statement.setInt(1, customer_id);
		statement.executeUpdate();
		
		
		statement = connection.prepareStatement("UPDATE customer_items SET sales_transactions_transaction_id = ? WHERE sales_transactions_transaction_id = 0");
		statement.setInt(1, transactionID);
		statement.executeUpdate();
        
		System.out.println(transactionID);
		
		getVals();
		
		totalItems = 0;
		for(int i = 0; i < transaction_id.size(); i++) {
			for(int j = 0; j < sales_id.size(); j++) {
				if(sales_id.get(j) == transaction_id.get(i)) {
					totalItems += quantity.get(j);
				}
			}
		}
		
		
		totalCost = 0;
		for(int i = 0; i < transaction_id.size(); i++) {
			for(int j = 0; j < sales_id.size(); j++) {
				if(sales_id.get(j) == transaction_id.get(i)) {
					totalCost += product_total.get(j);
				}
			}
		}
    
        
        
        statement = connection.prepareStatement("UPDATE sales_transactions SET total_items = ?, total_cost = ? WHERE transaction_id = ?");
        statement.setInt(1, totalItems);
        statement.setFloat(2, totalCost);
        statement.setInt(3, transactionID);
		statement.executeUpdate();
        
		
		statement.close();
		connection.close();
		System.out.println("Transaction Added Successfully!");
		return 1;
		
        }catch (Exception e) {
        	return 0;
        }
		
	}
	
	public int setter(int i) {
		
		getVals();
		
			
			return CheckOut(i);
		}
	
	
	public int getter(int casing, int product_code, int quantity, float product_totalprice, float product_price, int customer_id) {
		
		getVals();
		
		switch(casing){
		case 1: return addOrder(product_code, quantity, product_totalprice, product_price, customer_id);
		}
		return 0;
	}
	
	
}

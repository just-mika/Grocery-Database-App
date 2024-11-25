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
	public int itemID;
	public int quantityOrdered;
	public float total, priceItem;
	public int salesID, codeProduct;
	
	private ArrayList<Integer> item_id = new ArrayList<>();
	private ArrayList<Integer> quantity = new ArrayList<>();
	private ArrayList<Float> product_total = new ArrayList<>();
	private ArrayList<Float> price = new ArrayList<>();
	private ArrayList<Integer> productCode = new ArrayList<>();
	private ArrayList<Integer> sales_id = new ArrayList<>();
	/*****************************************************************/
	
	/*For sales_transactions*/
	
	/*****************************************************************/
	public int transactionID, customerID;
	public int totalItems;
	public float totalCost;
	public String dateOfSale;
	
	private ArrayList<Integer> transaction_id = new ArrayList<>();
	private ArrayList<Integer> total_items = new ArrayList<>();
	private ArrayList<Float> total_cost = new ArrayList<>();
	private ArrayList<String> date_of_sale = new ArrayList<>();
	private ArrayList<Integer> customer_id_list = new ArrayList<>();
	/*****************************************************************/
	
	
	public String[] paymentMethods = {"COD", "EPayment", "Card Debit/Credit"};
	
	
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
	
	
	private int addOrder(int product_code, int quantityInput, float product_totalprice, float product_price) {
		
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
	        
	        
	        
			statement = connection.prepareStatement("INSERT INTO customer_items (item_id, quantity, product_total, price, product_code, transaction_id) VALUE (?, ?, ?, ?, ?, ?)");
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
	
	public int CheckOut(int customer_id, String paymentMethod) {
		
		try {
		String url = "jdbc:mysql://@localhost:3306/grocery_database";
        String user = "root";
        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
        
        Connection connection = DriverManager.getConnection(url, user, password);
        PreparedStatement statement = connection.prepareStatement("SELECT transaction_id FROM sales_transactions ORDER BY transaction_id");
        ResultSet result = statement.executeQuery();
        result = statement.executeQuery();
        
        int expectedId = 0;
        while (result.next()) {
            int currentId = result.getInt("transaction_id");
            if (currentId != expectedId) {
                break;
            }
            expectedId+=1; 
            
        }
            

        transactionID = expectedId;
        
        System.out.println(transactionID);
        
        LocalDateTime currentDate = LocalDateTime.now();
        
        statement = connection.prepareStatement("INSERT INTO sales_transactions(transaction_id, total_items, total_cost, date_of_sale, customer_id) VALUE(?, ?, ?, ?, ?)");
        statement.setInt(1, transactionID);
        statement.setInt(2, 0);
		statement.setFloat(3, 0);
		statement.setTimestamp(4, Timestamp.valueOf(currentDate));
		statement.setInt(5, customer_id);
		statement.executeUpdate();
		
		System.out.println("done");
		
        
		System.out.println(transactionID);
		
		getVals();
		
		totalItems = 0;
		totalCost = 0;
		for(int i = 0; i < sales_id.size(); i++) {
			
			if(sales_id.get(i) == 0) {
			totalItems += quantity.get(i);
			totalCost += product_total.get(i);
			
			}
		}
		
		statement = connection.prepareStatement("UPDATE customer_items SET transaction_id = ? WHERE transaction_id = 0");
		statement.setInt(1, transactionID);
		statement.executeUpdate();
		
        
        statement = connection.prepareStatement("UPDATE sales_transactions SET total_items = ?, total_cost = ? WHERE transaction_id = ?");
        statement.setInt(1, totalItems);
        statement.setFloat(2, totalCost);
        statement.setInt(3, transactionID);
		statement.executeUpdate();
        
		statement = connection.prepareStatement("SELECT * FROM payment");
		result = statement.executeQuery();
		
		 	expectedId = 0;
	        while (result.next()) {
	            int currentId = result.getInt("payment_id");
	            if (currentId != expectedId) {
	                break;
	                
	            }
	            expectedId++; }
	        
	        int payment_id = expectedId;
	        
	        statement = connection.prepareStatement("INSERT INTO payment VALUE(?, ?, ?)");
	        statement.setInt(1, payment_id);
	        statement.setString(2, paymentMethod);
	        statement.setInt(3, transactionID);
	        statement.executeUpdate();
	        
		
		statement.close();
		connection.close();
		System.out.println("Transaction Added Successfully!");
		return 1;
		
        }catch (Exception e) {
        	
        	System.out.println(e);
        	return 0;
        }
		
	}
	
	
	private int deleteOrder(int customerid, int itemid) {
		
		try {
			String url = "jdbc:mysql://@localhost:3306/grocery_database";
	        String user = "root";
	        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
	        
	        System.out.println("Item ID: " + customerID);
	        
	        Connection connection = DriverManager.getConnection(url, user, password);
			PreparedStatement statement = connection.prepareStatement("SELECT quantity, product_total FROM customer_items WHERE item_id = ?");
			statement.setInt(1, itemID);
			ResultSet result = statement.executeQuery();
			
			System.out.println("Item ID: " + itemID);
			
			int quantity = 0, transactionid = 0, totalitems = 0;
			float totalproductcost = 0, totalcost = 0;
			
			if(result.next()) {
				quantity = result.getInt(1);
				totalproductcost = result.getInt(2);
			}
			
			System.out.println("Product Quantity: " + quantity);
			System.out.println("Product Cost: " + totalproductcost);
			
			statement = connection.prepareStatement("SELECT sales_transactions.transaction_id, sales_transactions.total_items, sales_transactions.total_cost FROM sales_transactions JOIN customer_items ON sales_transactions.transaction_id = customer_items.transaction_id WHERE sales_transactions.customer_id = ?");
			statement.setInt(1, customerID);
			result = statement.executeQuery();
			
			if(result.next()) {
				transactionid = result.getInt(1);
				totalitems = result.getInt(2);
				totalcost = result.getFloat(3);
			}
			
			System.out.println("Total Cost: " + totalcost);
			System.out.println("Total Items: " + totalitems);
			System.out.println("Item ID: " + itemID);
			
			totalcost = totalcost - totalproductcost;
			totalitems = totalitems - quantity;
			
			System.out.println("Total Cost: " + totalcost);
			System.out.println("Total Items: " + totalitems);
			
			
			
			statement = connection.prepareStatement("DELETE FROM customer_items WHERE item_id = ?");
			statement.setInt(1, itemid);
			int i = statement.executeUpdate();
			
			if(totalcost == 0 && totalitems == 0) {
				
				statement = connection.prepareStatement("DELETE FROM payment WHERE transaction_id = ?");
				statement.setInt(1, transactionid);
				statement.executeUpdate();
				
				statement = connection.prepareStatement("DELETE FROM sales_transactions WHERE transaction_id = ?");
				statement.setInt(1, transactionid);
				statement.executeUpdate();
			}
			else {
				statement = connection.prepareStatement("UPDATE sales_transactions SET total_items = ?, total_cost = ?, date_of_sale = ? WHERE transaction_id = ?");
				statement.setInt(1, totalitems);
				statement.setFloat(2, totalcost);
				LocalDateTime currentDate = LocalDateTime.now();
				statement.setTimestamp(3, Timestamp.valueOf(currentDate));
				statement.setInt(4, transactionid);
				statement.executeUpdate();
				
			}	
			
			if (i > 0) {
				System.out.println("Order deleted successfully");
				
				statement.close();
				connection.close();
				return 1;
			} else {
				System.out.println("Order delete failed.");
				statement.close();
				connection.close();
				return 0;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return 0;
		}
		
	}
	
	public int getter(int casing, int product_code, int quantity, float product_totalprice, float product_price) {
		
		getVals();
		
		System.out.println(quantity);
		
		switch(casing){
		case 1: return addOrder(product_code, quantity, product_totalprice, product_price);
		case 2: return deleteOrder(product_code, quantity);
		}
		return 0;
	}
	
	public ArrayList<Integer> integerListGetter(int check) {
		
		getVals();
		
		ArrayList<Integer> listBuffer = new ArrayList<>();
		
		switch(check) {
		case 1: listBuffer = item_id; break;
		case 2: listBuffer = quantity; break;
		case 3: listBuffer = productCode; break;
		case 4: listBuffer = sales_id; break;
		case 5: listBuffer = transaction_id; break;
		case 6: listBuffer = total_items; break;
		case 7: listBuffer = customer_id_list; break;
		}
		
		return listBuffer;
	}
	
	public ArrayList<Float> floatListGetter(int check) {
		
		getVals();
		
		ArrayList<Float> listBuffer = new ArrayList<>();
		
		switch(check) {
		case 1: listBuffer = product_total; break;
		case 2: listBuffer = price; break;
		case 3: listBuffer = total_cost; break;
		}
		
		return listBuffer;
	}
	
	
	
}

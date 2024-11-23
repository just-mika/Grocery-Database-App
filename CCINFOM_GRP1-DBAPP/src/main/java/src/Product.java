package src;

import java.util.*;
import java.sql.*;
import java.math.BigDecimal;

public class Product {
	public int product_code;
    public int quantity_in_stock;
    public BigDecimal price; 
	public String product_name;
	public String product_category;
	private String sqlPassword = "Pyxlaria&Crysalis285";
	public ArrayList<Integer> code_list = new ArrayList<>();
	public ArrayList<Integer> quantity_list = new ArrayList<>();
    public ArrayList<BigDecimal> price_list = new ArrayList<>();
	public ArrayList<String> product_name_list = new ArrayList<>();
	public ArrayList<String> product_category_list = new ArrayList<>();
	
	public Product() {
	}
	
	public Product(int productCode, String productName, BigDecimal price, String productCategory, int quantityInStock) {
        this.product_code = productCode;
        this.product_name = productName;
        this.price = price;
        this.product_category = productCategory;
        this.quantity_in_stock = quantityInStock;
    }
	
	public int product_list() {
		try {
			String url = "jdbc:mysql://@localhost:3306/grocery_database";
	        String user = "root";
	        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
	        
	        Connection connection = DriverManager.getConnection(url, user, password);
			PreparedStatement statement = connection.prepareStatement("SELECT * FROM product_info");
			ResultSet result = statement.executeQuery();
			
			code_list.clear();
            quantity_list.clear();
            price_list.clear();
            product_name_list.clear();
			product_category_list.clear();
			
			while(result.next()) {
				product_code = result.getInt(1);
				product_name = result.getString(2);
				price = result.getBigDecimal(3);
				product_category = result.getString(4);
                quantity_in_stock = result.getInt(5);
				
				code_list.add(product_code);
                product_name_list.add(product_name);
                price_list.add(price);
                product_category_list.add(product_category);
                quantity_list.add(quantity_in_stock);
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
	
	public Product select_product(int product_code) {
		try {
			String url = "jdbc:mysql://@localhost:3306/grocery_database";
	        String user = "root";
	        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
	        
	        Connection connection = DriverManager.getConnection(url, user, password);
			PreparedStatement statement = connection.prepareStatement("SELECT * FROM product_info WHERE product_code = ?");
			statement.setInt(1, product_code);
			ResultSet result = statement.executeQuery();
			
			if (result.next()) {
	            int code = result.getInt("product_code");
	            String productname = result.getString("product_name");
	            BigDecimal pricing = result.getBigDecimal("price");
	            String productcategory = result.getString("product_category");
                int quantityinstock = result.getInt("quantity_in_stock");

	            Product selected = new Product();
	            selected.product_code = code;
	            selected.product_name = productname;
	            selected.price = pricing;
	            selected.product_category = productcategory;
                selected.quantity_in_stock = quantityinstock;
	            
	            statement.close();
				connection.close();
				System.out.println("Product selected successfully");
	            return selected;
			}
			return null;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}
	
	public int add_product() {
		try {
			String url = "jdbc:mysql://@localhost:3306/grocery_database";
	        String user = "root";
	        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
	        
	        Connection connection = DriverManager.getConnection(url, user, password);
	        PreparedStatement statement = connection.prepareStatement("SELECT product_code FROM product_info ORDER BY product_code");
	        ResultSet result = statement.executeQuery();

	        int expectedId = 0;             //This code sets expected ID pls change when you can. -yuric
	        while (result.next()) {
	            int currentId = result.getInt("product_code");
	            if (currentId != expectedId) {
	                break;
	            }
	            expectedId++;
	        }

	        product_code = expectedId;
	        
			statement = connection.prepareStatement("INSERT INTO product_info (product_code, product_name, price, product_category, quantity_in_stock) VALUE (?, ?, ?, ?, ?)");
			statement.setInt(1, product_code);
			statement.setString(2, product_name);
			statement.setBigDecimal(3, price);
			statement.setString(4, product_category);
            statement.setInt(5, quantity_in_stock);
			statement.executeUpdate();
			
			statement.close();
			connection.close();
			System.out.println("Product added successfully");
			return 1;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return 0;
		}
	}
	
	public boolean delete_product(int product_code) {
		try {
			String url = "jdbc:mysql://@localhost:3306/grocery_database";
	        String user = "root";
	        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
	        
	        Connection connection = DriverManager.getConnection(url, user, password);
			PreparedStatement statement = connection.prepareStatement("DELETE FROM product_info WHERE product_code = ?");
			statement.setInt(1, product_code);
			
            int rowsAffected = statement.executeUpdate();

			
			
			if (rowsAffected > 0) {
				System.out.println("Product deleted successfully");
				statement.close();
			    connection.close();
				return true;
			} else {
				System.out.println("Product delete failed.");
				statement.close();
			    connection.close();
                return false;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}
	
	public int update_product(int product_code, String product_name, BigDecimal price, String product_category, int quantity_in_stock) {
		try {
			String url = "jdbc:mysql://@localhost:3306/grocery_database";
	        String user = "root";
	        String password = sqlPassword; //just edit this to put whatever password you set for your local MySQL server 
	        
	        Connection connection = DriverManager.getConnection(url, user, password);
			PreparedStatement statement = connection.prepareStatement("UPDATE product_info SET product_name = ?, price = ?, product_category = ?, quantity_in_stock = ? WHERE product_code = ?");
			statement.setString(1, product_name);
			statement.setBigDecimal(2, price);
			statement.setString(3, product_category);
            statement.setInt(4, quantity_in_stock);
			statement.setInt(5, product_code);
			
			if (statement.executeUpdate() > 0) {
				System.out.println("Product updated successfully");
				statement.close();
				connection.close();
				return 1;
			} else {
				System.out.println("Product Update failed.");
				statement.close();
				connection.close();
				return 0;
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return 0;
		}
	}
	
	public List<Integer> filterProductByCategory(String category) {
        List<Integer> filteredCodes = new ArrayList<>();
        for (int i = 0; i < product_category_list.size(); i++) {
            if (product_category_list.get(i).equalsIgnoreCase(category)) {
                filteredCodes.add(code_list.get(i));
            }
        }
        return filteredCodes;
    }

	public List<String> getFilteredCategories(List<Integer> filteredCodes) {
        List<String> filteredCategories = new ArrayList<>();
        for (Integer code : filteredCodes) {
            int index = code_list.indexOf(code);
            filteredCategories.add(product_category_list.get(index));
        }
        return filteredCategories;
    }
}
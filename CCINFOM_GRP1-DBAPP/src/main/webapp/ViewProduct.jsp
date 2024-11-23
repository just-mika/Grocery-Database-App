<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, src.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Products</title>
</head>
<body>
	<jsp:useBean id="P" class="src.Product" scope="session" />
    <h2>Filter and View Products</h2>
    <!-- Filter Form to Type Product Category -->
    <form action="ViewProduct.jsp" method="GET">
        <label for="product_category">Enter Product Category:</label>
        <input type="text" name="product_category" id="product_category" placeholder="Enter Category (e.g., Electronics)">
        <input type="submit" value="Filter">
    </form>
    
<%
    int status = P.product_list();  // Fetch all product order batches
    if (status == 1) {
%>
    
    <h3>Product List</h3>
    <table border="1">
        <thead>
            <tr>
                <th>Product Code</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Product Category</th>
                <th>Quantity in Stock</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Retrieve the filter value from the request
                String categoryFilter = request.getParameter("product_category");
            	
            	// If categoryFilter is not null, filter the products by category
	            List<Integer> filteredCodes = new ArrayList<>();
	            if (categoryFilter != null && !categoryFilter.isEmpty()) {
	                filteredCodes = P.filterProductByCategory(categoryFilter);
	            } else {
	                // If no filter is provided, use all products
	                filteredCodes = P.code_list;
	            }
	            
	         	// Retrieve the filtered product details based on the filtered product codes
	            List<String> filteredCategories = P.getFilteredCategories(filteredCodes);
	            
	            
		         // Display the filtered products in a table
	                if (filteredCodes != null && !filteredCodes.isEmpty()) {
	                    for (int i = 0; i < filteredCodes.size(); i++) {
	            %>
	                        <tr>
	                            <td><%= P.code_list.get(i) %></td>
					            <td><%= P.product_name_list.get(i) %></td>
					            <td><%= P.price_list.get(i) %></td>
	                            <td><%= filteredCategories.get(i) %></td>
	                            <td><%= P.quantity_list.get(i) %></td>
	                        </tr>
	            <%
	                    }
	                } else {
	            %>
	                    <tr><td colspan="5">No products found for the selected category.</td></tr>
	            <%
	                }
	            %>
        </tbody>
    </table>
<%
    } else {
%>
    <h3>No Products Found.</h3>
<%
    }
%>
<a href = "http://localhost:8082/CCINFOM_GRP1-DBAPP/ProductMgmt.jsp">View & Filter Product</a><br>
</body>
</html>

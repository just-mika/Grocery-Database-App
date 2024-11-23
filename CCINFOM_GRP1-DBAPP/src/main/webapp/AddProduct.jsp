<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>Add Product</h3><br>
	<form action="AddingProductProcess.jsp" method="post">
	
	<!-- Product Name (Text Input) -->
    Product Name: 
    <input type="text" id="product_name" name="product_name" required><br>
    
    <!-- Product Category (Text Input) -->
    Product Category: 
    <input type="text" id="product_category" name="product_category" required><br>
        
    <!-- Price (Decimal Input) -->
    Price: 
    <input type="text" id="price" name="price" pattern="\d+(\.\d{1,2})?" 
           placeholder="e.g., 123.45" title="Enter a valid price (up to 2 decimal places)" required><br>
    
    <!-- Quantity in Stock (Integer Input) -->
    Quantity in Stock: 
    <input type="number" id="quantity_in_stock" name="quantity_in_stock" required><br>
    
    <!-- Submit Button -->
    <input type="submit" value="Submit">
</form>

<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/ProductMgmt.jsp">BACK</a>
</body>
</html>
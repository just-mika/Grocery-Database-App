<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="java.util.*, src.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Values</title>
</head>
<body>
	<jsp:useBean id = "P" class="src.Product" scope="session"/>
	<%
		int product_code = Integer.parseInt(request.getParameter("product_code"));
		System.out.println(product_code);
		Product s = P.select_product(product_code);
		if(s != null) {
	%>
		<h3>Update Product Values</h3><br>
		<form action="UpdateProductProcess.jsp" method ="POST">
			<!-- Hidden field to store the product code -->
        	<input type="hidden" name="product_code" value="<%= s.product_code %>"/>
		
			<!-- Editable fields for the product -->
        	Product Name: <input type="text" id="product_name" name="product_name" value="<%= s.product_name %>" required><br>
        
        	Price: <input type="number" id="price" name="price" value="<%= s.price %>" step="0.01" required><br>
        
        	Product Category: <input type="text" id="product_category" name="product_category" value="<%= s.product_category %>" required><br>
        	
        	Quantity in Stock: <input type="number" id="quantity" name="quantity" value="<%= s.quantity_in_stock %>" required><br>
			<input type="submit" value="Update">
		</form>
	<%} else { %>
	<h3>Product not found!</h3><br>
	<%} %>
	<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/UpdateCustomer.jsp">BACK</a>
</body>
</html>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Deleting Product...</title>
</head>
<body>
	<jsp:useBean id="P" class="src.Product" scope="session" />
<%
	String productcodeStr = request.getParameter("product_code");
	System.out.println(productcodeStr);
	if (productcodeStr != null && !productcodeStr.isEmpty()) {
	    try {
	        // Parse the productcode as an integer
	        int product_code = Integer.parseInt(productcodeStr);
	        System.out.println(product_code);
	        // Call the delete_product method from the Product class
	        boolean isDeleted = P.delete_product(product_code);
	
	        // Check if the deletion was successful
	        if (isDeleted) {
%>
	            <h3>Product deleted successfully!</h3>
<%
	        } else {
%>
	            <h3>Failed to delete Product.</h3>
<%
	        }
	    } catch (NumberFormatException e) {
%>
	        <h3>Invalid Product Code provided. Please check and try again.</h3>
<%
	    }
	}
%>
<a href="DeleteProduct.jsp">Back to Product Deletion Page</a>
</body>
</html>
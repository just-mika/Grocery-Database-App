<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Updating Customer...</title>
</head>
<body>
	<jsp:useBean id="P" class="src.Product" scope="session" />
	<% 
        // Retrieve product details from the request
        int product_code = Integer.parseInt(request.getParameter("product_code"));
        String product_name = request.getParameter("product_name");
        java.math.BigDecimal price = new java.math.BigDecimal(request.getParameter("price"));
        String product_category = request.getParameter("product_category");
        int quantity_in_stock = Integer.parseInt(request.getParameter("quantity"));

        // Call the update_product method to update the database
        int status = P.update_product(product_code, product_name, price, product_category, quantity_in_stock);
        
        // Check the update status
        if (status == 1) {
    %>
            <h3>Product record updated successfully</h3>
    <%  } else { %>
            <h3>Record update failed</h3>
    <%  } %>
    <a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/UpdateProduct.jsp">BACK</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="java.util.*, java.math.BigDecimal, src.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Adding Product...</title>
</head>
<body>
	<jsp:useBean id = "P" class="src.Product" scope="session"/>
	<%
    // Retrieve parameters from the request
    int quantity_in_stock = Integer.parseInt(request.getParameter("quantity_in_stock"));
    BigDecimal price = new BigDecimal(request.getParameter("price"));
    String product_name = request.getParameter("product_name");
    String product_category = request.getParameter("product_category");

    // Assign values to the Product object (P)
    P.quantity_in_stock = quantity_in_stock;
    P.price = price;
    P.product_name = product_name;
    P.product_category = product_category;

    // Add the product using some method in class C
    int status = P.add_product();
    if (status == 1) {
%>
        <!-- Success message -->
        <p>Product added successfully!</p>
<%
    } else {
%>
        <!-- Error message -->
        <p>Failed to add product. Please try again.</p>
<%
    }
%>

	<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/ProductMgmt.jsp">BACK</a>
</body>
</html>
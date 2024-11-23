<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="java.util.*, src.*, java.time.LocalDateTime, java.time.format.DateTimeFormatter, java.util.Date"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Product Order Batch...</title>
	</head>
<body>
	 <jsp:useBean id="POB" class="src.ProductOrderBatch" scope="session"/>
    <%
    // Retrieve parameters from the request
    String dateOrderedStr = request.getParameter("date_ordered"); // Expected format: "yyyy-MM-dd HH:mm:ss"
    String costStr = request.getParameter("cost");
    String productCodeStr = request.getParameter("product_code");
    String supplierCodeStr = request.getParameter("supplier_code");
    String quantityOrderedStr = request.getParameter("quantity_ordered");

    try {
        // Parse numeric inputs
        double cost = Double.parseDouble(costStr);
        int productCode = Integer.parseInt(productCodeStr);
        int supplierCode = Integer.parseInt(supplierCodeStr);
        int quantityOrdered = Integer.parseInt(quantityOrderedStr);

        // Set POB properties
        POB.dateOrdered = dateOrderedStr;
        POB.cost = cost;
        POB.productCode = productCode;
        POB.supplierCode = supplierCode;
        POB.quantityOrdered = quantityOrdered;

        // Add product order batch and check status
        int status = POB.addProductOrderBatch();
        if (status == 1) {
%>
            <h3>Product Order Batch added successfully! Stock updated.</h3>
<%
        } else {
%>
            <h3>Failed to add Product Order Batch.</h3>
<%
        }
    } catch (Exception e) {
        e.printStackTrace(); // Log the error
%>
        <h3>Error: Invalid input. Please check the values and try again.</h3>
<%
    }
%>
    <a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/ProductOrderBatchMgmt.jsp">BACK</a>
</body>
</html>
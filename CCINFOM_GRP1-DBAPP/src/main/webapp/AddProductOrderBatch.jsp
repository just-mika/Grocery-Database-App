<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Add Product Order Batch</title>
	</head>
	<body>
		<h3>Add Product Order Batch</h3><br>
		<form action="AddingProductOrderBatchProcess.jsp" method="post">
        Quantity Ordered: <input type="text" id="quantity_ordered" name="quantity_ordered" required><br>
        Date Ordered: <input type="text" id="date_ordered" name="date_ordered" required><br>
        Cost: <input type="text" id="cost" name="cost" required><br>
        Product Code: <input type="text" id="product_code" name="product_code" required><br>
        Supplier Code: <input type="text" id="supplier_code" name="supplier_code" required><br>
        <input type="submit" value="Submit">
    </form>
    	<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/ProductOrderBatchMgmt.jsp">BACK</a>
	</body>
</html>
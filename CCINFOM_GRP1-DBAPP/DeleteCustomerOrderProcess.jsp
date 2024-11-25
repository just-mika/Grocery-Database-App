<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Deleting Customer Order</title>
</head>
<body>
	<jsp:useBean id = "S" class="src.Sales" scope="session"/>
	<%@ page import="java.math.*" %>
	
			<% 
		int customer_id = Integer.parseInt(request.getParameter("customerID"));
		int item_id = Integer.parseInt(request.getParameter("orderID"));
		
		System.out.println("Item ID: " + item_id);
		
		int status=S.getter(2, customer_id, item_id, BigDecimal.valueOf(0), BigDecimal.valueOf(0));
		if (status==1) {
	%>
		<h3>Order deleted successfully</h3>
	<%} else {%>
		<h3>Deleting Order failed</h3>
	<%} %>
			
				
		<a href="ProductSelling.jsp">BACK</a>	
			
			

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="java.util.*, src.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Confirm Delete Process</title>
</head>
<body>
	<jsp:useBean id = "C" class="src.Customer" scope="session"/>
	<%
		int customer_id = Integer.parseInt(request.getParameter("customer_id"));
		Customer s = C.select_customer(customer_id);
		if(s != null) {
	%>
		<h3>Are you sure you want to delete this customer?</h3><br>
	
		<h3>
			<%=s.customer_id + " | " +  s.last_name + ", " + s.first_name %>
		</h3>
		<form action="DeletingCustomerProcess.jsp" method = "POST">
			<input type="hidden" name="customer_id" value="<%= s.customer_id %>"/>
			<input type="submit" name="action" value="YES"/>
		</form>
		<form action="DeleteCustomer.jsp" method="GET">
			<input type="submit" name="action" value="NO"/>
		</form>
	<%} else { %>
	<h3>Customer not found!</h3><br>
	<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/DeleteCustomer.jsp">BACK</a>
	<%} %>
</body>
</html>
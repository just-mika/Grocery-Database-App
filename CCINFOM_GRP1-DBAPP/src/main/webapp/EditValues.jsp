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
	<jsp:useBean id = "C" class="src.Customer" scope="session"/>
	<%
		int customer_id = Integer.parseInt(request.getParameter("customer_id"));
		Customer s = C.select_customer(customer_id);
		if(s != null) {
	%>
		<h3>Update Customer Values</h3><br>
		<form action="UpdateCustomerProcess.jsp" method ="POST">
			<input type="hidden" name="customer_id" value="<%= s.customer_id %>"/>
			First Name: <input type="text" id = "first_name" name = "first_name" value = <%=s.first_name %>><br>
			Last Name: <input type="text" id = "last_name" name = "last_name" value = <%=s.last_name %>><br>
			Contact No: <input type="text" id = "contact_number" name = "contact_number" value = <%=s.contact_number %>><br>
			<input type="submit" value="Update">
		</form>
	<%} else { %>
	<h3>Customer not found!</h3><br>
	<%} %>
	<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/UpdateCustomer.jsp">BACK</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<jsp:useBean id = "S" class="src.Sales" scope="session"/>
	<%
		int customer_id = Integer.parseInt(request.getParameter("customer_id"));
		Customer s = C.select_customer(customer_id);
		if(s != null) {
	%>
		<h3>Update Order Values</h3><br>
		<form action="UpdateCustomerProcess.jsp" method ="POST">
			<input type="hidden" name="customer_id" value="<%= s.customer_id %>"/>
			Quantity: <input type="text" id = "quantity" name = "quantity" value = <%=s.first_name %>><br>
			Product Code: <input type="text" id = "productcode" name = "productcode" value = <%=s.last_name %>><br>
			Price: <input type="text" id = "price" name = "price" value = <%=s.contact_number %>><br>
			<input type="submit" value="Update">
		</form>
	<%} else { %>
	<h3>No new Products to be Sold!</h3><br>
	<%} %>
	<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/UpdateCustomer.jsp">BACK</a>

</body>
</html>
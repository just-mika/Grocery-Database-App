<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id = "C" class="src.Customer" scope="session"/>
	<% 
		int customer_id = Integer.parseInt(request.getParameter("customer_id"));
		int status=C.delete_customer(customer_id);
		if (status==1) {
	%>
		<h3>Customer deleted successfully</h3>
	<%} else {%>
		<h3>Delete customer failed</h3>
	<%} %>
<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/CustomerMgmt.jsp">BACK</a>
</body>
</html>
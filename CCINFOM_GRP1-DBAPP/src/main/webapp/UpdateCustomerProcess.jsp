<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="java.util.*, src.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Updating Customer...</title>
</head>
<body>
	<jsp:useBean id = "C" class="src.Customer" scope="session"/>
	<% 
		int customer_id = Integer.parseInt(request.getParameter("customer_id"));
		String first_name = request.getParameter("first_name");
		String last_name = request.getParameter("last_name");
		String contact_number = request.getParameter("contact_number");
		
		int status=C.update_customer(customer_id, first_name, last_name, contact_number);
		if (status==1) {
	%>
			<h3>Customer record updated successfully</h3>
	<%	} else {
	%>
			<h3>Record update failed</h3>
	<%  }%>
	<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/CustomerMgmt.jsp">BACK</a>
</body>
</html>
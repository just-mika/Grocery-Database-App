<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="java.util.*, src.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Adding Customer...</title>
</head>
<body>
	<jsp:useBean id = "C" class="src.Customer" scope="session"/>
	<% 
		String first_name = request.getParameter("first_name");
		String last_name = request.getParameter("last_name");
		String contact_number = request.getParameter("contact_number");
		C.first_name = first_name;
		C.last_name = last_name;
		C.contact_number = contact_number;
		int status=C.add_customer();
		if (status==1) {
	%>
			<h3>Customer added successfully</h3>
	<%	} else {
	%>
			<h3>Adding customer failed</h3>
	<%  }%>
	<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/CustomerMgmt.jsp">BACK</a>
</body>
</html>
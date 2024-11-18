<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Customer</title>
</head>
<body>
	<h3>Add Customer</h3><br>
	<form action="AddingCustomerProcess.jsp">
		First Name: <input type="text" id = "first_name" name = "first_name"><br>
		Last Name: <input type="text" id = "last_name" name = "last_name"><br>
		Contact No: <input type="text" id = "contact_number" name = "contact_number"><br>
		<input type="submit" value="Submit">
	</form>
	<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/CustomerMgmt.jsp">BACK</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="java.util.*, src.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Add Supplier</title>
</head>
<body>
	<h3>Add Supplier</h3><br>
	<form action="AddingSupplierProcess.jsp" method="post">
	Supplier Name: <input type="text" id="supplier_name" name="supplier_name" required><br>
	<input type="submit" value="Submit">
	</form>
	<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/SupplierMgmt.jsp">BACK</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="java.util.*, src.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="supplier" class="src.Supplier" scope="session"/>
<%
    // Retrieve parameters from the request
    String supplierName = request.getParameter("supplier_name");

    try {
        // Set the supplier name
        supplier.supplierName = supplierName;

        // Add the supplier and check status
        int status = supplier.addSupplier();
        if (status == 1) {
%>
            <h3>Supplier added successfully!</h3>
<%
        } else {
%>
            <h3>Failed to add Supplier.</h3>
<%
        }
    } catch (Exception e) {
        e.printStackTrace(); // Log the error
%>
        <h3>Error: Invalid input. Please check the values and try again.</h3>
<%
    }
%>
    <a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/SupplierMgmt.jsp">BACK</a>
</body>
</html>
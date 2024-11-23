<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="src.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Supplier</title>
</head>
<body>
<jsp:useBean id="S" class="src.Supplier" scope="session"/>
    <%
        int supplier_code = Integer.parseInt(request.getParameter("supplier_code"));
        Supplier supplierToEdit = S.getSupplierByCode(supplier_code); // Assuming this retrieves supplier details
        if (supplierToEdit != null) {
    %>
        <h3>Edit Supplier</h3><br>	
        <form action="UpdateSupplierProcess.jsp" method="post">
            <input type="hidden" name="supplier_code" value="<%= supplierToEdit.supplierCode %>"/>
            Supplier Name: 
            <input type="text" id="supplier_name" name="supplier_name" value="<%= supplierToEdit.supplierName %>" required><br><br>
            <input type="submit" value="Update">
        </form>
    <% } else { %>
        <h3>Supplier not found!</h3><br>
    <% } %>
    <a href="UpdateSupplier.jsp">BACK</a>
</body>
</html>
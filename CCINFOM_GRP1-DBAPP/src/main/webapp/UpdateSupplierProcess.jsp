<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="src.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Updating Supplier...</title>
</head>
<body>
<jsp:useBean id="S" class="src.Supplier" scope="session"/>
    <%
        int supplier_code = Integer.parseInt(request.getParameter("supplier_code"));
        String supplier_name = request.getParameter("supplier_name");

        int status = S.update_supplier(supplier_code, supplier_name);
        if (status == 1) {
    %>
            <h3>Supplier record updated successfully!</h3>
    <% } else { %>
            <h3>Failed to update supplier record.</h3>
    <% } %>
    <a href="UpdateSupplier.jsp">BACK</a>
</body>
</html>
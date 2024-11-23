<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="java.util.*, src.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Supplier</title>
</head>
<body>
    <h3>Update Supplier Record</h3><br>
    <jsp:useBean id="S" class="src.Supplier" scope="session"/>
    <%
        S.supplier_list(); // Assuming this method populates S.id_list and S.name_list
        if (S.id_list.size() > 0) { 
    %>
        <form action="EditSupplier.jsp">
            Suppliers: 
    		<select id="supplier_code" name="supplier_code"> 
        		<% for (int i = 0; i < S.id_list.size(); i++) { %>
            		<option value="<%= S.id_list.get(i) %>">
               		<%= S.id_list.get(i) + " | " + S.name_list.get(i) %>
            		</option>
        		<% } %>	
    		</select>
    	<input type="submit" value="Update">
        </form>
    <% } else { %>
        <h3>No suppliers in the database!</h3><br>
    <% } %>
    <a href="SupplierMgmt.jsp">BACK</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Product</title>
</head>
<body>
	<jsp:useBean id="P" class="src.Product" scope="session" />
<%
    int status = P.product_list();  // Fetch all product order batches
    if (status == 1) {
%>
	<h3>Delete Product</h3><br>
	<table border="1">
    <thead>
        <tr>
            <th>Product Code</th>
            <th>Product Name</th>
            <th>Price</th>
            <th>Product Category</th>
            <th>Quantity In Stock</th>
        </tr>
    </thead>
    <tbody>
        <% for (int i = 0; i < P.code_list.size(); i++) { %>
        <tr>
            <td><%= P.code_list.get(i) %></td>
            <td><%= P.product_name_list.get(i) %></td>
            <td><%= P.price_list.get(i) %></td>
            <td><%= P.product_category_list.get(i) %></td>
            <td><%= P.quantity_list.get(i) %></td>
            <td>
                <a href="DeletingProductProcess.jsp?product_code=<%= P.code_list.get(i) %>">Delete</a>
            </td>
        </tr>
        <% } %>
    </tbody>
</table>
<%
    } else {
%>
    <h3>No Products Found.</h3>
<%
    }
%>
	<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/CustomerMgmt.jsp">BACK</a>
</body>
</html>
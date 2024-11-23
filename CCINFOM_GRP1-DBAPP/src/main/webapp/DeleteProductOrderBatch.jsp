<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Order Batch List</title>
</head>
<body>
	<jsp:useBean id="POB" class="src.ProductOrderBatch" scope="session" />
<%
    int status = POB.productOrderBatchList();  // Fetch all product order batches
    if (status == 1) {
%>
<h3>Product Order Batches</h3>
<table border="1">
    <thead>
        <tr>
            <th>Batch ID</th>
            <th>Quantity Ordered</th>
            <th>Date Ordered</th>
            <th>Cost</th>
            <th>Product Code</th>
            <th>Supplier Code</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <% for (int i = 0; i < POB.batchIdList.size(); i++) { %>
        <tr>
            <td><%= POB.batchIdList.get(i) %></td>
            <td><%= POB.quantityOrderedList.get(i) %></td>
            <td><%= POB.dateOrderedList.get(i) %></td>
            <td><%= POB.costList.get(i) %></td>
            <td><%= POB.productCodeList.get(i) %></td>
            <td><%= POB.supplierCodeList.get(i) %></td>
            <td>
                <a href="DeletingProductOrderBatchProcess.jsp?batch_id=<%= POB.batchIdList.get(i) %>">Delete</a>
            </td>
        </tr>
        <% } %>
    </tbody>
</table>
<%
    } else {
%>
    <h3>No Product Order Batches found.</h3>
<%
    }
%>
<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/ProductOrderBatchMgmt.jsp">BACK</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, src.ProductOrderBatch" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Batch List</title>
</head>
<body>
<jsp:useBean id="POB" class="src.ProductOrderBatch" scope="session" />
  <h1>Order Batch Management</h1>

    <!-- Filter Form -->
    <form method="GET" action="ProductOrderBatchList.jsp">
        <label for="product_code">Product Code:</label>
        <input type="text" id="product_code" name="product_code">
        <label for="supplier_code">Supplier Code:</label>
        <input type="text" id="supplier_code" name="supplier_code">
        <label for="date_ordered">Date Ordered:</label>
        <input type="date" id="date_ordered" name="date_ordered">
        <button type="submit">Filter</button>
    </form>

    <%
        // Retrieve filter parameters
        String productCode = request.getParameter("product_code");
        String supplierCode = request.getParameter("supplier_code");
        String dateOrdered = request.getParameter("date_ordered");

        // Fetch filtered order batches
        List<Map<String, Object>> records = POB.getFilteredOrderBatches(productCode, supplierCode, dateOrdered);

        if (!records.isEmpty()) {
    %>
        <table border="1">
            <thead>
                <tr>
                    <th>Batch ID</th>
                    <th>Product Code</th>
                    <th>Quantity Ordered</th>
                    <th>Supplier Code</th>
                    <th>Date Ordered</th>
                    <th>Cost</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Map<String, Object> record : records) {
                %>
                    <tr>
                        <td><%= record.get("batch_id") %></td>
                        <td><%= record.get("product_code") %></td>
                        <td><%= record.get("quantity_ordered") %></td>
                        <td><%= record.get("supplier_code") %></td>
                        <td><%= record.get("date_ordered") %></td>
                        <td><%= record.get("cost") %></td>
                        <td>
                            <a href="ProductOrderBatchDetail.jsp?batch_id=<%= record.get("batch_id") %>">View</a>
                        </td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <%
        } else {
    %>
        <p>No records found for the given filters.</p>
    <%
        }
    %>
</body>
</html>
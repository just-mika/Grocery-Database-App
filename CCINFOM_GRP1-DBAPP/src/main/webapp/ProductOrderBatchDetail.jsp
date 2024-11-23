<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, src.ProductOrderBatch" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Batch Details</title>
</head>
<body>
<jsp:useBean id="POB" class="src.ProductOrderBatch" scope="session" />
     <h1>Order Batch Details</h1>

    <%
        // Retrieve the batch_id parameter from the URL as a String
        String batchIdStr = request.getParameter("batch_id");
        
        // Convert the String to an int using Integer.parseInt()
        int batchId = 0;
        try {
            batchId = Integer.parseInt(batchIdStr);
        } catch (NumberFormatException e) {
            // Handle the case where the batch_id is not a valid integer
            out.println("<p>Invalid Batch ID format. Please check the URL.</p>");
            return;  // Exit early to prevent further processing
        }

        // Get the details of the specific product order batch using the batchId
        Map<String, Object> batchDetails = POB.getOrderBatchDetails(batchId);

        if (batchDetails.isEmpty()) {
    %>
        <p>No details found for the given Batch ID.</p>
    <%
        } else {
    %>
        <table border="1">
            <tr>
                <th>Batch ID</th>
                <td><%= batchDetails.get("batch_id") %></td>
            </tr>
            <tr>
                <th>Product Code</th>
                <td><%= batchDetails.get("product_code") %></td>
            </tr>
            <tr>
                <th>Quantity Ordered</th>
                <td><%= batchDetails.get("quantity_ordered") %></td>
            </tr>
            <tr>
                <th>Supplier Code</th>
                <td><%= batchDetails.get("supplier_code") %></td>
            </tr>
            <tr>
                <th>Date Ordered</th>
                <td><%= batchDetails.get("date_ordered") %></td>
            </tr>
            <tr>
                <th>Cost</th>
                <td><%= batchDetails.get("cost") %></td>
            </tr>
        </table>
    <%
        }
    %>

    <a href="ProductOrderBatchList.jsp">Back to List</a>
</body>
</html>
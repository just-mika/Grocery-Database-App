<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Deleting Product Order Batch...</title>
</head>
<body>
	<jsp:useBean id="POB" class="src.ProductOrderBatch" scope="session" />
<%
    String batchIdStr = request.getParameter("batch_id");
    if (batchIdStr != null) {
        int batchId = Integer.parseInt(batchIdStr);

        // Delete the selected Product Order Batch
        boolean isDeleted = POB.deleteProductOrderBatch(batchId);

        if (isDeleted) {
%>
            <h3>Product Order Batch deleted successfully!</h3>
<%
        } else {
%>
            <h3>Failed to delete Product Order Batch.</h3>
<%
        }
    } else {
%>
        <h3>Error: No batch ID provided.</h3>
<%
    }
%>
<a href="DeleteProductOrderBatch.jsp">Back to Product Order Batches</a>
</body>
</html>
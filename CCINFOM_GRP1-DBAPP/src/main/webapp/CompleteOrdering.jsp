<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Completing Order</title>
</head>
<body>
<jsp:useBean id = "S" class="src.Sales" scope="session"/>

<% 
int customerID = Integer.parseInt(request.getParameter("customerID"));
String payementMethod = request.getParameter("payments");
int result = S.CheckOut(customerID, payementMethod); 

if(result == 1){

%>Successfully Checked Out! <%} else { %>
Failed to Check Out!<%} %>

<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/ProductSelling.jsp">BACK</a>

</body>
</html>
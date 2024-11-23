<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id = "S" class="src.Sales" scope="session"/>

<% 
S.getVals();
int i = Integer.parseInt(request.getParameter("customer_id"));
int result = S.CheckOut(i); 

if(result == 1){

%>Successfully Checked Out! <%} else { %>
Failed to Check Out!<%} %>

<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/ProductSelling.jsp">BACK</a>


</body>
</html>
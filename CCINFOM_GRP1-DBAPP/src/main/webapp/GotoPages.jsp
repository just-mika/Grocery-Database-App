<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%	int index = Integer.parseInt(request.getParameter("lastCheck")); 
	int index2;
		
	switch(index){
	
	case 1:%> 	<form action="UpdateCustomerOrder.jsp" method="POST">
				<input type="hidden" name = "customerID" value="<%=request.getParameter("bringCustomerID")%>">
				<input type="hidden" name = "orderID" value="<%=request.getParameter("getOrder")%>">
				<input type="submit" value="Go">
				</form>
<% 	break;

	case 2:
%>

	<form action="DeleteCustomerOrderProcess.jsp" method="POST">
	<input type="hidden" name = "customerID" value="<%=request.getParameter("bringCustomerID")%>">
	<input type="hidden" name = "orderID" value="<%=request.getParameter("getOrder")%>">
	<input type="submit" value="Go">
	</form>

<% 	break;

	case 3: %>
	
	<form action="UpdatePaymentMethod.jsp" method="POST">
	<input type="hidden" name = "customerID" value="<%=request.getParameter("bringCustomerID")%>">
	<input type="hidden" name = "orderID" value="<%=request.getParameter("getOrder")%>">
	<input type="submit" value="Go">
	</form>
	<% break; } %>

</body>
</html>
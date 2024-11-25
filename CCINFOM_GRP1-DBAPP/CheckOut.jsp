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
<jsp:useBean id = "C" class="src.Customer" scope="session"/>


<form action="CompleteOrdering.jsp" method="POST">
<% 
		C.customer_list();
		S.getVals();
	
		if (C.id_list.size() > 0){ 
	%>
		
			Select Customer: <select id = "customerID" name = "customerID">
			<%
				for(int i = 0; i < C.id_list.size(); i++){
			%>		
					<option value ="<%= C.id_list.get(i)%>">
						<%=C.id_list.get(i) + " | " +  C.last_name_list.get(i) + ", " + C.first_name_list.get(i) %>
					</option>
			<%
				}
			%>			
				
			</select><br>
			
			Payment Method: <select id = "paymentMethod" name = "payment">
			
			<%int i = 0; 
				while(i < 3) {
			%>
					<option value ="<%= S.paymentMethods[i]%>">
						<%=S.paymentMethods[i]%>
					</option>
					
					<%i++;} %>
			
			</select>
			
			<%} else {%>No Customers Added! <a href="AddCustomer.jsp">Add NEW Customer</a><%} %>	
<input type="submit">
</form>
</body>
</html>
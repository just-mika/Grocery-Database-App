<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Customer Record</title>
</head>
<body>
	<h3>Update Customer Record</h3><br>
	<jsp:useBean id = "C" class="src.Customer" scope="session"/>
	<% 
		C.customer_list();
		if (C.id_list.size() > 0){ 
	%>
		<form action="EditValues.jsp">
			Customers: <select id ="customer_id" name = "customer_id">
			<%
				for(int i = 0; i < C.id_list.size(); i++){
			%>		
					<option value ="<%= C.id_list.get(i)%>">
						<%=C.id_list.get(i) + " | " +  C.last_name_list.get(i) + ", " + C.first_name_list.get(i) %>
					</option>
			<%
				}
			%>	
			</select>
			<input type="submit" value="Update">
		</form>
	<%} else { %>
		<h3>No customers in the database!</h3><br>
	<%} %>
	<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/CustomerMgmt.jsp">BACK</a>
</body>
</html>
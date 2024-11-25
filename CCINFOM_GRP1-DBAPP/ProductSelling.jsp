<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Selling Products</title>

</head>
<body>

<jsp:useBean id = "P" class="src.Product" scope="session"/>
	<% 
		P.product_list();
	
		if (P.code_list.size() > 0){ 
	%>
		<form action="MakeSell.jsp" method=post>
			Products: <select id ="producID" name = "product_ID">
			<%
				for(int i = 0; i < P.code_list.size(); i++){
			%>		
					<option value ="<%= P.code_list.get(i)%>">
						<%="Name: " + P.product_name_list.get(i) + " | Price: " +  P.price_list.get(i) + ", Quantity Available:" + P.quantity_list.get(i)%>
					</option>
			<%
				}
			%>			
				
			</select> <br>
			
			Quantity: <input type=text name="quantity"><br><br>
			
				<input type="submit">
			</form>
	<%} else { %>
		<h3>No products in database!</h3><br>
	<%} %>
	
	



<br><br><br>
<form action="SelectCustomer.jsp" method="POST">
<input type="hidden" name="check" value="1">
<input type="submit" value="Update Order">
</form>
<br>
<form action="SelectCustomer.jsp" method="POST">
<input type="hidden" name="check" value="2">
<input type="submit" value="Delete Order">
</form>
<br>
<form action="SelectCustomer.jsp" method="POST">
<input type="hidden" name="check" value="3">
<input type="submit" value="Update Payment Method">
</form>

<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/Home.jsp">BACK</a>
</body>
</html>
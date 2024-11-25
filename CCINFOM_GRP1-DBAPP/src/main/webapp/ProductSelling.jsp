<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Selling Products</title>

</head>
<body>

<jsp:useBean id = "P" class="src.Products" scope="session"/>
	<% 
		P.getter();
	
		if (P.product_code.size() > 0){ 
	%>
		<form action="MakeSell.jsp" method=post>
			Products: <select id ="producID" name = "product_ID">
			<%
				for(int i = 0; i < P.product_code.size(); i++){
			%>		
					<option value ="<%= P.product_code.get(i)%>">
						<%="Name: " + P.product_name.get(i) + " | Price: " +  P.price.get(i) + ", Quantity Available:" + P.quantity_in_stock.get(i)%>
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
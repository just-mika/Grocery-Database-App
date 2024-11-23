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
<jsp:useBean id = "C" class="src.Customer" scope="session"/>
<jsp:useBean id = "S" class="src.Sales" scope="session"/>
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
			
			<% 
		C.customer_list();
	
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
			
			Quantity: <input type=text name="quantity"><br><br>
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
	<%} else { %>
		<h3>No products in database!</h3><br>
	<%} %>
	
	


<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/UpdateCustomerOrder.jsp">Update Order</a><br>
<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/DeletCustomerOrder.jsp">Delete Order</a><br>
<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/UpdatePaymentMethod.jsp">Update Payment Method</a><br>

<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/Home.jsp">BACK</a>
</body>
</html>
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
		if (S.id_list.size() > 0){ 
	%>
		<form action="updatingOrderPayment.jsp">
			Select New Payment Method: <select id ="productName" name = "productName">
			<%
				for(int i = 0; i < S.id_list.size(); i++){
			%>		
					<option value ="<%= S.id_list.get(i)%>">
						<%=S.id_list.get(i) + " | " +  S.last_name_list.get(i) + ", Quantity" + S.first_name_list.get(i) %>
					</option>
			<%
				}
			%>
				
			</select>
				
			<input type="submit" value="Update">
		</form>
	<%} else { %>
		<h3>No products in database!</h3><br>
	<%} %>
	<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/UpdateCustomer.jsp">BACK</a>

</body>
</html>
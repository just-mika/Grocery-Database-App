<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select Customer</title>
</head>
<body>

<jsp:useBean id = "S" class="src.Sales" scope="session"/> 
<jsp:useBean id = "C" class="src.Customer" scope="session"/>
<%@ page import="java.util.*" %>
	
	<% 
		S.getVals();
	
		ArrayList<Integer> customerID = S.integerListGetter(7);
	
		C.customer_list();
				
		int unique = 0;
		
		int check = Integer.parseInt(request.getParameter("check"));
		
		if (customerID.size() > 0){ 
	
	%>
		
		<form action="SelectOrder.jsp" method="POST">
			Select Customer with Order: <select id ="customerID" name = "customerID">
			<%
				for(int i = 0; i < C.id_list.size(); i++){
					for(int j = 0; j < customerID.size(); j++) {
						if(C.id_list.get(i) == customerID.get(j) && unique == 0) {
			%>		
						<option value ="<%=C.id_list.get(i)%>">
							<%=C.id_list.get(i) + " | " +  C.last_name_list.get(i) + ", " + C.first_name_list.get(i) %>
						</option>
			<%			unique++;
						}
						
					}
					unique = 0;
				}
			%>
				
			</select>
			<input type="hidden" name ="check2" value="<%=check%>">
				
			<input type="submit" value="Select">
		</form>
	<%} else { %>
		<h3>No products in database!</h3><br>
	<%} %>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Customers</title>
</head>
<body>
	<h3>View Customers</h3><br>
	<jsp:useBean id = "C" class="src.Customer" scope="session"/>
	
		<% 
			boolean ifSort = Boolean.parseBoolean(request.getParameter("sort"));
			String filter = request.getParameter("filter");
			System.out.println(filter);
			int status = 0;
			if(ifSort)
				status = C.sort_customers();
			else if (filter != null){
				status = C.filter_customers(filter);
			}
			else{
				status = C.customer_list();
			}
			
			if (status == 1){ 
		%>
		<form action="ViewCustomers.jsp" method = "POST">
			<input type="hidden" name="sort" value= "true"/>
			<input type="submit" name="action" value="Sort by surname"/>
		</form>
		<form action="ViewCustomers.jsp" method = "POST">
            Filter by: 
    		<select id="filter" name="filter"> 
        		<% for (char letter = 'A'; letter <= 'Z'; letter++) { %>
				    <option value="<%= Character.toString(letter) %>">
				        <%= letter %>
				    </option>
				<% } %>
    		</select>
    	<input type="submit" value="Filter">
        </form>
			<table border = "1">
				<thead>
					<tr>
						<th>Customer ID</th>
						<th>Customer Name</th>
						<th>Contact Number</th>
					</tr>
				</thead>
				<tbody>
					<% for (int i = 0; i < C.id_list.size(); i++) { %>
					<tr>
						<td><%= C.id_list.get(i) %></td>
						<td><%= C.last_name_list.get(i) + ", " + C.first_name_list.get(i)%>
						<td><%= C.contact_list.get(i) %></td>
					</tr>
					<% } %>
				</tbody>
			</table>
		<%} else { %>
			<h3>No customers in the database!</h3><br>
		<% } %>
		<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/Home.jsp">BACK</a>
</body>
</html>
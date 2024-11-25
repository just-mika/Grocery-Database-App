<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Adding Order</title>
</head>
<body>

<jsp:useBean id = "S" class="src.Sales" scope="session"/>
<jsp:useBean id = "P" class="src.Product" scope="session"/>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<% 
			int j = 0;
			int buffer = Integer.parseInt(request.getParameter("product_ID"));
			while(j < P.code_list.size() && buffer != P.code_list.get(j)){
				j++;
			}
			if(j == P.code_list.size())
				j--;
			
		int product_code = Integer.parseInt(request.getParameter("product_ID"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		BigDecimal product_totalprice = P.price_list.get(j).multiply(BigDecimal.valueOf(quantity));
		
		int status=S.getter(1, product_code, quantity, product_totalprice, P.price_list.get(j));
		if (status==1) {
	%>
			<h3>Order added successfully</h3>
			<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/ProductSelling.jsp">Add Another Order</a>
			<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/CheckOut.jsp">Check Out</a>
			
			
	<%	} else {
	%>
			<h3>Adding Order failed</h3>
			<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/ProductSelling.jsp">BACK</a>
	<%  }%>
	

</body>
</html>
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
<jsp:useBean id = "P" class="src.Products" scope="session"/>
<% 
			int j = 0;
			int buffer = Integer.parseInt(request.getParameter("product_ID"));
			while(j < P.product_code.size() && buffer != P.product_code.get(j)){
				j++;
			}
			if(j == P.product_code.size())
				j--;
			
		int product_code = Integer.parseInt(request.getParameter("product_ID"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		float product_totalprice = P.price.get(j)*Float.parseFloat(request.getParameter("quantity"));
		
		int status=S.getter(1, product_code, quantity, product_totalprice, P.price.get(j));
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
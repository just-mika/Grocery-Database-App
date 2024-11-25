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
	<jsp:useBean id = "P" class="src.Product" scope="session"/>
	<%@ page import="java.util.*" %>
	
	<%
	ArrayList<Integer> item_id = S.integerListGetter(1);
	ArrayList<Integer> quantity = S.integerListGetter(2);
	
	ArrayList<Float> product_total = S.floatListGetter(1);
	ArrayList<Float> price = S.floatListGetter(2);
	
	ArrayList<Integer> productCode = S.integerListGetter(3);
	ArrayList<Integer> salesID = S.integerListGetter(4);
	ArrayList<Integer> transactionID = S.integerListGetter(5);
	ArrayList<Integer> customerIDs = S.integerListGetter(7);
	
	P.product_list(); 
	
	int idBuffer = Integer.parseInt(request.getParameter("customerID"));
	int index = Integer.parseInt(request.getParameter("check2"));
	
	
	%>
	
	
	<form action="GotoPages.jsp" method="POST">
	
	Select Orders: <select id ="getOrder" name = "getOrder">
			<%
				int j = 0;
				for(int i = 0; i < item_id.size(); i++){
					for(int k = 0; k < transactionID.size(); k++) {
					
						if(salesID.get(i) == transactionID.get(k) && idBuffer == customerIDs.get(k)){
								j = 0;
								while(j < P.code_list.size() && P.code_list.get(j) != productCode.get(i))
								{
									j++;
								}
						%>		
								<option value ="<%= item_id.get(i)%>">
									Item ID: <%=item_id.get(i) + "|"%>
									Quantity: <%=quantity.get(i) + "|"%>
									Total Price: <%=product_total.get(i) + "|"%>
									Product Price: <%=price.get(i) + "|"%>
									Product Name: <%=P.product_name_list.get(i) + "|"%>
								</option>
				<%
								
							}
						}
					}
			%>
				
			</select>
			
				<input type="hidden" value="<%=idBuffer%>" name ="bringCustomerID">
				<input type="hidden" value="<%=index%>" name ="lastCheck">
			<input type="submit" value="Select">
			
			</form>
</body>
</html>
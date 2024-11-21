<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Process</title>
</head>
<body>
<jsp:useBean id = "L" class="src.Login" scope="session"/>
	<% 
		String password = request.getParameter("Password");

		L.getter = password;
		
		int status=L.getVal();
		if (status==1) {
	%>
			<h3>Login Successful!</h3>
			<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/Home.jsp">Proceed to Home</a>
	<%	} else {
	%>
			<h3>Login Failed</h3>
	<%  }%>
	<a href="http://localhost:8082/CCINFOM_GRP1-DBAPP/Login.jsp">BACK</a>
</body>
</html>
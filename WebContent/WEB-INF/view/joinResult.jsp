<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test = "${result > 0 }">
		<h3>회원 가입 성공</h3>
	</c:if>
	<c:if test = "${result <= 0 }">
		<h3>회원 가입 실패</h3>
	</c:if>
	<a href = "${pageContext.request.contextPath }">홈</a>
</body>
</html>
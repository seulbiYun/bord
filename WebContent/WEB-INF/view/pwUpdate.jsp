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
		<h3>비밀번호 변경 성공</h3>
	</c:if>
	<c:if test = "${result <= 0 }">
		<h3>비밀번호 변경 실패</h3>
	</c:if>
	<a href = "${pageContext.request.contextPath }">홈</a>
</body>
</html>
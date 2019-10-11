<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table,th,td{
		border:1px solid black;
		border-collapse: collapse;
	}
	th,td{
		padding:10px;
	}
</style>
</head>
<body>

	<table>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>비밀번호</th>
			<th>회원가입 날짜</th>
		</tr>
		<c:forEach var = "l" items = "${list }">
			<tr>
				<td>${l.memberId }</td>
				<td>${l.name }</td>
				<td>${l.password }</td>
				<td>${l.regdate }</td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>
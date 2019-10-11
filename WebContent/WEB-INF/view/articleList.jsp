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
		padding:5px;
	}
</style>
</head>
<body>
	<a href = "${pageContext.request.contextPath }/article/add.do">등록하기</a>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
		</tr>
		<c:forEach var = "l" items = "${list }">
			<tr>
				<td>${l.article_no }</td>
				<td><a href = "read.do?no=${l.article_no }">${l.title }</a></td>
				<td>${l.writer_id }</td>
				<td>${l.read_cnt }</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table,th,td{
		border: 1px solid black;
		border-collapse: collapse;
	}
	th, td{
		padding:5px;
	}
</style>
</head>
<body>
	<table>
		<tr>
			<th>번호</th>
			<td>${article.article_no }</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>${article.writer_id }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${article.title }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${article.content }</td>
		</tr>
		<tr>
			<td colspan="2">
				<a href = "${pageContext.request.contextPath }/article/list.do">목록</a>
				<a href = "${pageContext.request.contextPath }/article/update.do?no=${article.article_no }">수정</a>
				<a href = "${pageContext.request.contextPath }/article/delete.do?no=${article.article_no }">삭제</a>
			</td>
		</tr>
	</table>
</body>
</html>
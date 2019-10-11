<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action = "update.do" method = "post">
		<fieldset>
			<legend>게시글 수정</legend>
			<p>
				<label>번호</label>
				<input type = "text" readonly="readonly" name = "no" value = "${article.article_no }">
			</p>
			<p>
				<label>제목</label>
				<input type = "text" name = "title" value="${article.title }">
			</p>
			<p>
				<label>제목</label>
				<textarea rows="10" cols="60" name = "content">${article.content }</textarea>
			</p>
			<p>
				<input type = "submit" value = "글 수정">
			</p>
		</fieldset>
	</form>
</body>
</html>
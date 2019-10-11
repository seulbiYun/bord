<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href = "css/common.css" type ="text/css" rel = "stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src = "js/common.js"></script>
<script>
	$(function(){
		$("form").submit(function(i,obj){
			$(".error").css("display","none");
			
			var result = checkInputEmpty($("input[name]"));
			if(result == false){//빈 input태그가 존재하면
				return false;
			}
			
			var password = $("input[name = 'password']").val();//현재 비밀번호 확인
						
			var newPassword = $("input[name = 'newPassword']").val();// 새 비밀번호
			if(newPassword == password){//현재 비밀번호와 새 비밀번호가 일치할 경우
				$("input[name = 'newPassword']").next().next().css("display","inline");
				return false;
			}
			
			
			var pwReg = /^[a-z0-9]{8,20}$/i;
			if(pwReg.test(newPassword) == false){
				$("input[name = 'newPassword']").next().css("display","inline");
				return false;//전송 취소
			}
		})
	})
</script>
</head>
<body>
	<form action = "pwUpdate.do" method = "post">
		<input type = "hidden" name = "id" value = "${Auth}">
		<p>
			<label>현재 비밀번호</label>
			<input type = "password" name = "password">
			<c:if test = "${pw == true }">
				<span class = "error2">※비밀번호가 일치하지 않습니다.</span>
			</c:if>
		</p>
		<p>
			<label>새 비밀번호</label>
			<input type = "password" name = "newPassword">
			<span class = "error">※이전 비밀번호와 일치합니다.</span>
			<span class = "error">※비밀번호(영어,숫자 8~20)를 입력하세요</span>
		</p>
		<p>
			<input type = "submit" value = "암호 변경">
		</p>
	</form>
</body>
</html>
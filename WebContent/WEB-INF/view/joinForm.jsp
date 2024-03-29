<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		$("form").submit(function(){
			$(".error").css("display","none");
			
			var result = checkInputEmpty($("input[name]"));
			if(result == false){//빈 input태그가 존재하면
				return false;
			}
			
			//id확인
			var idReg = /^[a-z][a-z0-9]{5,14}$/i;
			var id = $("input[name = 'memberId']").val();
			if(idReg.test(id) == false){
				$("input[name = 'memberId']").next().css("display","inline");
				return false;//전송 취소
			}	
			//이름 확인
			var nameReg = /^[가-핳]{2,5}$/;
			var name = $("input[name = 'name']").val();
			if(nameReg.test(name) == false){
				$("input[name = 'name']").next().css("display","inline");
				return false;//전송 취소
			}
			//비밀번호 확인
			var pwReg = /^[a-z0-9]{8,20}$/i;
			var password = $("input[name = 'password']").val();
			if(pwReg.test(password) == false){
				$("input[name = 'password']").next().css("display","inline");
				return false;//전송 취소
			}
			//비밀번호 일치 확인
			var pwCheck = $("input[name = 'confirmPassword']").val();
			if(pwCheck != password){
				$("input[name = 'confirmPassword']").next().css("display","inline");
				return false;//전송 취소
			}
		})
		
		$("#idOk").click(function(){
			var id = $("input[name='memberId']").val();
			if(id == ""){
				$("input[name = 'memberId']").next().next().next().css("display","inline");
				return false;//전송 취소
			}
			$.ajax({
				url:"${pageContext.request.contextPath }/article/duplication.do",
				type:"get",
				data:{"id":$("input[name='memberId']").val()},
				dataType:"json",
				success:function(res){
					console.log(res);
					
					if(res.userid == "notnull"){
						alert("이미 존재하는 아이디입니다.");
					}else if(res.userid == "null"){
						alert("사용가능한 아이디입니다.");
					}
					
				}
			})
		})
	})
</script>
</head>
<body>
	<p>git test를 위해 내용을 추가</p>
	<form action = "join.do" method = "post">
		<fieldset>
			<legend>회원 가입</legend>
			<p>
				<label>아이디</label>
				<input type = "text" name = "memberId">
				<button id = "idOk" type = "button">중복확인</button>
				<br>
				<span class = "error">※ID(영어,숫자 6~15)를 입력하세요※첫 글자는 영어로</span>
			</p>
			<p>
				<label>이름</label>
				<input type = "text" name = "name">
				<span class = "error">※한글(2~5)를 입력하세요</span>
			</p>
			<p>
				<label>비밀번호</label>
				<input type = "text" name = "password">
				<span class = "error">※비밀번호(영어,숫자 8~20)를 입력하세요</span>
			</p>
			<p>
				<label>비밀번호 확인</label>
				<input type = "text" name = "confirmPassword">
				<span class = "error">※암호가 일치하지 않습니다.</span>
			</p>
			<p>
				<input type = "submit" value = "가입">
			</p>
		</fieldset>
	</form>
</body>
</html>
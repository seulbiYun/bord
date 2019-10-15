<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function(){
		$("#btn1").click(function(){
			$.ajax({
				url:"${pageContext.request.contextPath }/article/readJson.do",
				type:"get",
				data:{"no":$("#no").val()},
				dataType:"json",
				success:function(res){
					console.log(res);
					//게시물 번호,제목,내용,생성날짜
					var data = new Date(res.regdate);
					
					$("#result").text("번호 : " + res.article_no)
								.append("<p>제목 : " + res.title + "</p>")
								.append("<p>내용 : " + res.content + "</p>")
								.append("<p>생성날짜 : " + data.getFullYear() + "년 "
											+ (data.getMonth()+1) + "월 " 
											+ data.getDate() + "일</p>");
					
				}
				
			})
		})
		
		$("#btn2").click(function(){
			$.ajax({
				url:"${pageContext.request.contextPath}/article/listJson.do",
				type:"get",
				dataType:"json",
				success:function(res){
					console.log(res);
					//번호, 제목, 날짜
					$(res).each(function(i, obj){
						var no = obj.article_no;
						var title = obj.title;
						var data = new Date(obj.regdate);
						var sD = data.getFullYear() + "년"+ (data.getMonth()+1) + "월 " + data.getDate() + "일";
						var $li = $("<li>").append("번호 : " + no)
											.append(" | 제목 : " + title)
											.append(" | 생성날짜 : " + sD);
						
						$("#list").append($li);
					})
					
					
				}
			})
		})
		
		$("#btn3").click(function(){
			$.ajax({
				url:"${pageContext.request.contextPath}/article/memberJson.do",
				type:"get",
				data:{"id":$("#id").val()},
				dataType:"json",
				success:function(res){
					$("#result3").empty();
					console.log(res);
					
					
					
					if(res.result == "fail"){
						$("#result3").css("color","red").text("※아이디를 입력하세요※");
					}else if(res.result == "success"){
						var d = new Date(res.member.regdate);
						$("#result3").css("color","black").append("<p> result : "+res.result)
						.append("<p> 아이디 : "+res.member.memberId)
						.append("<p> 이름 : "+res.member.name)
						.append("<p> 비밀번호 : "+res.member.password)
						.append("<p> 가입날짜 : "+d.getFullYear()+"년 "+ (d.getMonth()+1) + "월 " + d.getDate() + "일");
					}
					
					
					
					
					
				}
				
			})
		})
	})
</script>
</head>
<body>
	<h1>게시글 상세 보기 데이터 가져오기</h1>
	<input type = "text" id = "no">
	<button id = "btn1">가져오기</button>
	<div id = "result">
		결과데이터
	</div>
	<hr>
	<button id = "btn2">LIST 가져오기</button>
	<ul id = "list"></ul>
	<hr>
	<input type = "text" id = "id">
	<button id = "btn3">map data 가져오기</button>
	<div id = "result3"></div>
	
</body>
</html>
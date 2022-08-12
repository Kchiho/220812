<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="vo.*,java.util.ArrayList"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="datas" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="member" class="vo.MemberVO" scope="session" />
<jsp:useBean id="boardL" class="vo.BoardLVO" scope="session" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
</head>
<body>
	<h1>
		<%
		if (member.getMid() != null) { // 로그인 상태 화면
		%>
		<a href="javascript:check()">${member.mname}</a>님, 반갑습니다! :D
		<%
		} else { // 비로그인 상태 화면
		%>
		<a>반갑습니다</a>
		<%
		}
		%>
	</h1>
	<table border="2">
		<tr>
			<th>번 호</th>
			<th>제 목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>좋아요</th>
			<th>작성일</th>
		</tr>
		<%
		for (BoardVO v : (ArrayList<BoardVO>) datas) {
		%>
		<tr>
			<th><a href="controller.jsp?action=board&bid=<%=v.getBid()%>"><%=v.getBid()%></a></th>
			<td><%=v.getTitle()%></td>
			<td><%=v.getWriter()%></td>
			<td><%=v.getBread()%></td>
			<td><%=v.getBlike()%></td>
			<td><%=v.getBdate()%></td>
		</tr>
		<%
		}
		%>
	</table>
	<hr>
	<table border="1">
		<tr>
			<td><select id="selectBox">
					<option value="writer">작성자</option>
					<option value="title">제목</option>
			</select></td>
		</tr>
		<tr>
			<td id="test"><input id="sword" type="text" name="keyword"
				required></td>
		</tr>
		<tr>
			<td colspan="2" align="right"><input type="button" value="검색하기"
				onclick="search()"></td>
		</tr>
	</table>
	<br>
	<%
	if (member.getMid() != null) { // 로그인 상태 화면
	%>
	<a href="form.jsp">새로운 글 작성하기</a>
	<br>
	<a href="controller.jsp?action=logout">로그아웃</a>
	<%
	} else { // 비로그인 상태 화면
	%>
	<a href="login.jsp">로그인</a>
	<a href="join.jsp">회원가입</a>
	<%
	}
	%>
	<script type="text/javascript">
		function search() { // 검색시 실행
			var target = document.getElementById("selectBox");
			var word = document.getElementById("sword").value;
			var value = target.options[target.selectedIndex].value; // 옵션 value 값
			if (value == "writer") {
				location.href = "controller.jsp?action=search&writer=" + word;
			} else {
				location.href = "controller.jsp?action=search&title=" + word;
			}
		}
		function check(){
			ans=prompt('비밀번호를 입력하세요.');
			if(ans=='${member.mpw}'){
				location.href="controller.jsp?action=mypage";
			}
		}
	</script>
</body>
</html>
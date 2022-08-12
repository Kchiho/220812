<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보</title>
</head>
<body>
	<form action="controller.jsp" method="post">
		<input type="hidden" name="action" value="updateM">
		<table border="2">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="mid" value="${member.mid}"
					readonly></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="mpw"
					value="${member.mpw}"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="mname"
					value="${member.mname}"></td>
			</tr>
			<tr>
				<td>역활</td>
				<td>${member.role}</td>
			</tr>
			<tr>
				<td colspan="2" align="right"><input type="submit" value="수정하기"></td>
			</tr>
		</table>
	</form>
	<a
		href="controller.jsp?action=delM&mid=${member.mid}&mpw=${member.mpw}">탈퇴하기</a>
	<br>
	<a href="index.jsp">메인으로 돌아가기</a>
</body>
</html>
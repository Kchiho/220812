<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인하기</title>
</head>
<body>
	<form action="controller.jsp" method="post">
		<input type="hidden" name="action" value="login">
		<table border="1">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="mid" required></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="mpw" required></td>
			</tr>
			<tr>
				<td><input type="submit" value="로그인하기"></td>
				<td><a href="join.jsp"><input type="button" value="회원가입하기"></a></td>
			</tr>
		</table>
		<input type="button" value="뒤로가기" onclick="goBack()">
	</form>
	<script type="text/javascript">
		function goBack() {
			window.history.back();
		}
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="vo.BoardVO,java.util.ArrayList"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@taglib tagdir="/WEB-INF/tags" prefix="kim"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색결과</title>
</head>
<body>
	<form action="controller.jsp" method="post">
		<input type="hidden" name="action" value="main">
		<table border="2">
			<tr>
				<th>번 호</th>
				<th>제 목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>좋아요</th>
				<th>작성일</th>
			</tr>
			<kim:searchResult />
			<tr>
				<td colspan="2" align="right"><input type="submit"
					value="메인으로 가기"></td>
			</tr>
		</table>
	</form>
</body>
</html>
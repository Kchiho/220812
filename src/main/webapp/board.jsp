<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글정보</title>
</head>
<script type="text/javascript">
	function del() {
		ans = confirm('정말 삭제할까요?');
		if (ans == true) {
			document.bForm.action.value = "delB";
			document.bForm.submit();
		} else {
			return;
		}
	}
	function like() {
		location.href = "controller.jsp?action=mlike&bid=${data.bid}";
	}
</script>
<form name="bForm" action="controller.jsp" method="post">
	<input type="hidden" name="action" value="updateB">
	<table border="1">
		<tr>
			<td>번호</td>
			<td><input type="text" name="bid" value="${data.bid}" readonly></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><input type="text" name="title" value="${data.title}"
				required></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><input type="text" name="content" value="${data.content}"
				required></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><input type="text" name="writer" value="${data.writer}"
				required readonly></td>
		</tr>
		<tr>
			<td>조회수</td>
			<td><input type="text" name="bread" value="${data.bread}"
				required readonly></td>
		</tr>
		<tr>
			<td>좋아요</td>
			<td><input type="text" name="blike" value="${data.blike}"
				required readonly></td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><input type="text" name="bdate" value="${data.bdate}"
				required readonly></td>
		</tr>
		<c:if test="${member.mid != null}">
			<tr>
				<td><input type="button" value="좋아요" onClick="like()"></td>
			</tr>
		</c:if>
		<c:if
			test="${member.role.equals('ADMIN') || member.mname.equals(data.writer)}">
			<tr>
				<td colspan="2" align="right"><br> <input type="submit"
					value="수정하기">&nbsp;<input type="button" value="삭제하기"
					onClick="del()"></td>
			</tr>
		</c:if>
	</table>
</form>
<body>
	<hr>
	<a href="index.jsp">메인으로 돌아가기</a>
</body>
</html>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<h1><jsp:doBody /></h1>
<c:forEach var="datas" items="${datas}">
<tr>
	<th><a href="controller.jsp?action=board&bid=${datas.bid}">${datas.bid}</a></th>
	<td>${datas.title}</td>
	<td>${datas.writer}</td>
	<td>${datas.bread}</td>
	<td>${datas.blike}</td>
	<td>${datas.bdate}</td>
</tr>
</c:forEach>
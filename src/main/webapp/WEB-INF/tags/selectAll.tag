<%@tag import="vo.BoardVO"%>
<%@ tag language="java" pageEncoding="UTF-8"%>

<jsp:useBean id="datas" class="dao.BoardDAO" />
<jsp:useBean id="bVO" class="vo.BoardVO" />
<h1><jsp:doBody /></h1>
<%
for (BoardVO v : datas.join(bVO)) {
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

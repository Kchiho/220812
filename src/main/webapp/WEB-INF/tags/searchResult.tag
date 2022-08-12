<%@tag import="vo.BoardVO"%>
<%@ tag language="java" pageEncoding="UTF-8"%>

<jsp:useBean id="datas" class="dao.BoardDAO" />
<jsp:useBean id="data" class="vo.BoardVO" />
<jsp:setProperty property="*" name="data" />
<h1><jsp:doBody /></h1>
<%
for (BoardVO v : datas.selectAlls(data)) {
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
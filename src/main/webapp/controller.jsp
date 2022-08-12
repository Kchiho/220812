<%@page import="java.util.ArrayList,vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error/error.jsp"
	import="java.util.ArrayList,vo.*"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bDAO" class="dao.BoardDAO" />
<jsp:useBean id="bVO" class="vo.BoardVO" />
<jsp:setProperty property="*" name="bVO" />
<jsp:setProperty property="*" name="bVO" />
<jsp:useBean id="mDAO" class="dao.MemberDAO" />
<jsp:useBean id="mVO" class="vo.MemberVO" />
<jsp:setProperty property="*" name="mVO" />
<jsp:useBean id="bLDAO" class="dao.BoardLDAO" />
<jsp:useBean id="bLVO" class="vo.BoardLVO" />
<jsp:setProperty property="*" name="bLVO" />
<%
// 어떤 요청을 받았는지 파악
// -> 해당 요청을 수행
String action = request.getParameter("action");
System.out.println("로그: " + action);

if (action.equals("main")) { // 메인
	ArrayList<BoardVO> datas = bDAO.join(bVO);
	request.setAttribute("datas", datas);
	pageContext.forward("main.jsp"); // forward 액션
} else if (action.equals("insert")) { // 게시글추가
	if (bDAO.insert(bVO)) {
		response.sendRedirect("controller.jsp?action=main");
	} else {
		throw new Exception("insert 오류");
	}
} else if (action.equals("search")) { // 검색
	if (bDAO.selectAlls(bVO) != null) {
		ArrayList<BoardVO> datas = bDAO.selectAlls(bVO);
		request.setAttribute("datas", datas);
		pageContext.forward("searchResult.jsp"); // forward 액션
	} else {
		throw new Exception("selectAll 오류");
	}
} else if (action.equals("updateB")) { // 게시글 변경
	if (bDAO.update(bVO)) {
		response.sendRedirect("controller.jsp?action=main");
	} else {
		throw new Exception("updateB 오류");
	}
} else if (action.equals("board")) { // 게시글 상세보기
	bDAO.updateR(bVO);
	BoardVO data = bDAO.selectOne(bVO);
	if (data == null) {
		response.sendRedirect("controller.jsp?action=main");
	}
	request.setAttribute("data", data);
	pageContext.forward("board.jsp");
} else if (action.equals("delB")) { // 게시글 삭제
	if (bDAO.delete(bVO)) {
		response.sendRedirect("controller.jsp?action=main");
	} else {
		throw new Exception("delB 오류");
	}
} else if (action.equals("login")) { // 로그인
	MemberVO member = mDAO.selectOne(mVO);
	if (member != null) {
		session.setAttribute("member", member);
		response.sendRedirect("controller.jsp?action=main");
	} else {
		throw new Exception("login 오류");
	}
} else if (action.equals("logout")) { // 로그아웃
	session.invalidate();
	response.sendRedirect("controller.jsp?action=main");
} else if (action.equals("join")) { // 회원가입
	if (mDAO.insert(mVO)) {
		response.sendRedirect("controller.jsp?action=main");
	} else {
		throw new Exception("join 오류");
	}
} else if (action.equals("updateM")) { // 회원정보 변경
	if (mDAO.update(mVO)) {
		session.invalidate(); //세션 정보 전체 제거하기
		response.sendRedirect("controller.jsp?action=main");
	} else {
		throw new Exception("updateM 오류");
	}
} else if (action.equals("delM")) { // 회원탈퇴
	MemberVO member = (MemberVO) session.getAttribute("member");
	if (member != null && mDAO.delete(member)) {
		session.invalidate();
		response.sendRedirect("controller.jsp?action=main");
	} else {
		throw new Exception("delM 오류");
	}
} else if (action.equals("mypage")) { // 마이페이지
	MemberVO member = (MemberVO) session.getAttribute("member");
	// 이후에는 selectOne을 통해서 data를 받게될예정
	if (member != null) {
		request.setAttribute("data", member);
		pageContext.forward("myPage.jsp");
	} else {
		throw new Exception("mypage 오류");
	}
} else if (action.equals("mlike")) {
	MemberVO member = (MemberVO) session.getAttribute("member");
	BoardLVO boardL = bLDAO.selectOne(bVO, member);
	if (boardL == null) {
		bLDAO.insert(bVO, member);
		boardL = bLDAO.selectOne(bVO, member);
		bDAO.updateLu(bVO);
		out.println("<script>alert('좋아요 +1');location.href='controller.jsp?action=main'</script>");
	} else {
		if (boardL.getCheckL() == 0) {
	bLDAO.update(boardL, bVO, member);
	bDAO.updateLu(bVO);
	out.println("<script>alert('좋아요 +1');location.href='controller.jsp?action=main'</script>");
		} else {
	bLDAO.update(boardL, bVO, member);
	bDAO.updateLd(bVO);
	out.println("<script>alert('좋아요 -1');location.href='controller.jsp?action=main'</script>");
		}
	}
}else if(action.equals("idcheck")){
	
}
else {
	out.println("<script>alert('action 파라미터 값이 올바르지 않습니다...');location.href='controller.jsp?action=main'</script>");
}
%>
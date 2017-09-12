<%@page import="notice.BbsManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

	<%
		request.setCharacterEncoding("UTF-8");
		String writer = request.getParameter("reply_writer");
		String content = request.getParameter("reply_content");
		String pwd = request.getParameter("reply_pwd");
		String idx_fk = request.getParameter("idx_fk");
		//널 체크 생략--알아서 구현
		BbsManager mgr = BbsManager.getInstance();
		String msg = "", url = "";
		int result = mgr.replySave(idx_fk, writer, content, pwd);
		if (result > 0) {
			msg = "꼬리글 달기 성공!";
		} else {
			msg = "꼬리글 달기 실패!";
		}
		url = "../form/main.jsp?path=bbs_content&idx=" + idx_fk;
		request.setAttribute("bbs_msg", msg);
		request.setAttribute("bbs_url", url);
	%>
	<jsp:forward page="bbs_msg.jsp" />
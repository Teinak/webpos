<%@page import="notice.BbsManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

	<%
		String idx = request.getParameter("idx");
		String pwd = request.getParameter("pwd");
		String cpage = request.getParameter("cp");
		String pageSize = request.getParameter("ps");
		if (idx == null || pwd == null || idx.trim().equals("")
				|| pwd.trim().equals("")) {
			response.sendRedirect("../form/main.jsp?path=bbs_list");
			return;
		}//if----------------------
		idx = idx.trim();
		pwd = pwd.trim();
		BbsManager mgr = BbsManager.getInstance();
		int result = mgr.deleteOk(idx, pwd);
		String msg = "", url = "";
		if (result > 0) {
			msg = "글 삭제 성공";
			url = "../form/main.jsp?path=bbs_list&cp=" + cpage + "&ps=" + pageSize;
			;
		} else {
			msg = "글 삭제 실패-비밀번호를 확인하세요";
			url = "../form/main.jsp?path=bbs_content&idx=" + idx;
		}
		request.setAttribute("bbs_msg", msg);
		request.setAttribute("bbs_url", url);
	%>
	<jsp:forward page="bbs_msg.jsp" />

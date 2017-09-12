<%@page import="notice.BbsManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cpage = request.getParameter("cp");
	String pageSize = request.getParameter("ps");
	BbsManager mgr = BbsManager.getInstance();
	int result = mgr.editOk(request);
	String msg = "", url = "";
	if (result > 0) {
		msg = "글 편집 성공";
		url = "../form/main.jsp?path=bbs_list&cp=" + cpage + "&ps=" + pageSize;
	} else {
		msg = "글 편집 실패-비밀번호를 확인하세요";
		url = "../form/main.jsp?path=bbs_edit&idx=" + request.getParameter("idx");
	}
	request.setAttribute("bbs_msg", msg);
	request.setAttribute("bbs_url", url);
%>
<jsp:forward page="bbs_msg.jsp" />
<%@page import="emp.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<jsp:useBean id="userbean" class="emp.EmpBean" />
	<jsp:setProperty name="userbean" property="*" />

	<%
		EmpMgr usermgr = new EmpMgr();
		boolean sujung = usermgr.userUpdate(userbean);
		String msg = "", url = "";
		if (sujung) {
			msg = "회원수정 성공";
			url = "../form/main.jsp";
		} else {
			msg = "회원수정 실패";
			url = "../form/main.jsp";
		}

	%>

	<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
	//window.close();
	</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="emp.*"%>

<%
	request.setCharacterEncoding("UTF-8");
	//response.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="Admin" class="emp.EmpBean" />
<jsp:setProperty property="*" name="Admin" />
<%
	/* 입력된 파라미터값 가져오기*/
	String user_id = request.getParameter("emp_id");

	/* 연산처리 */
	EmpMgr admin = new EmpMgr();

	boolean sujung = admin.adminUpdate(Admin);
	String msg = "", url = "";
	if (sujung) {
		msg = "회원수정 성공";
		url = "../form/main.jsp?path=emp_admin_jo";

	} else {
		msg = "회원수정 실패";
		url = "../form/main.jsp?path=emp_admin_jo";
	}

	//pageContext.forward(url);
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
	window.close();
</script>
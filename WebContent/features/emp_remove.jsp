<%@page import="emp.EmpMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

	<%
		String emp_no = request.getParameter("emp_no");
		EmpMgr pmgr = new EmpMgr();
		boolean re = pmgr.empDelete(Integer.parseInt(emp_no));
		if (re == true) {
	%>
	<script>
		alert("삭제되었습니다.");
		window.close();
	</script>
	<%
		} else {
	%>
	<script>
		alert("삭제실패");
		history.back();
	</script>
	<%
		}
	%>
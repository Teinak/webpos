<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="emp.*"%>
<jsp:useBean id="admin" class="emp.EmpMgr" />

<script type="text/javascript">
	function Update(eno) {
		document.update.emp_no.value = eno;
		document.update.submit();
	}
	
	function open_empupdate_popup(empno) {
		window.open('../features/emp_InfoUpdate.jsp?emp_no='+ empno, 'popup', 'width=400, height=400,left=600,top=300');
	}
</script>


<%
	// 로그인 체그및 그레이드 체크 

	if ((session.getAttribute("idKey") == null)) {
		response.sendRedirect("../index.jsp");

	}
	/* if ((session.getAttribute("gradeKey") != "1")  ) {
	 response.sendRedirect("../index.jsp");
	 System.out.println("go to.....index.jsp");
	 } else {
	 System.out.println("don't go to ...... index.jsp"); */
	if ((session.getAttribute("gradeKey")).equals("2")) {

		response.sendRedirect("../index.jsp");
	} else {
%>
<%!EmpBean Admin;%>
<%
	Vector vecList = admin.getUserInfoList();
%>
<table width="100%" border="1" style="font-size: 10pt">
	<tr>
		<td colspan="9" align="center">
			<hr width=500 color=#667788>
			 <font size=4 color=navy> <b>사 원 관 리</b>
		</font> <br>
		<hr width=500 color=#667788>
		</td>
	</tr>
	<tr align="right" bgcolor=#c9c9c9>
		<td align="center">#</td>
		<td align="center">이름</td>
		<td align="center">아이디</td>
		<td align="center">전화번호</td>
		<td align="center">주소</td>
		<td align="center">E-mail</td>
		<td align="center">홈페이지</td>
		<td align="center">등급</td>
	</tr>
	<%
		for (int i = 0; i < vecList.size(); ++i) {
				Admin = (EmpBean) vecList.get(i);
	%>
	<tr bgcolor="#FFFFFF" align="right">
		<td align="center"><%=Admin.getEmp_no()%></td>
		<td align="center"><a href="javascript:open_empupdate_popup('<%=Admin.getEmp_no()%>')"><%=Admin.getEmp_name()%></a></td>
		<td align="center"><%=Admin.getEmp_id()%></td>
		<td align="center"><%=Admin.getEmp_tel()%></td>
		<td align="center"><%=Admin.getEmp_addr()%></td>
		<td align="center"><%=Admin.getEmp_email()%></td>
		<td align="center"><%=Admin.getEmp_homepage()%></td>
		<td align="center"><%=Admin.getGrade_name()%></td>
	</tr>
	<%
		}
	%>
</table>
<% 
	}
%>
<!-- 
<form name="update" method="post"
	action="../form/main.jsp?path=emp_InfoUpdate">
	<input type="hidden" name="emp_no">
</form> -->

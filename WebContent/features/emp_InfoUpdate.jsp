<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.*,emp.*"%>
<link href="<%=request.getContextPath()%>/sub/pos_style.css" rel="stylesheet" type="text/css">
<%
	request.setCharacterEncoding("UTF-8");
	//response.setCharacterEncoding("euc-kr");
%>

<script language="JavaScript" src="../sub/script.js"></script>
<script>
	function empRemove() {
		var eno = infoUpdate.emp_no.value;
		location = "../form/main.jsp?path=emp_remove&emp_no=" + eno;
	}
</script>

<jsp:useBean id="admin" class="emp.EmpMgr" />

<%
	int eno = Integer.parseInt(request.getParameter("emp_no"));
	EmpBean Admin = admin.admingetMember(eno);
%>

<form name="infoUpdate" method="post"
	action="../features/emp_InfoUpdate_Proc.jsp">
	<table border="1" width="100%">
		<tr>
			<td colspan="2"><%=Admin.getEmp_name()%> 님의 정보를 수정합니다.</td>

		</tr>
		<tr>
			<td>번호</td>
			<td colspan="2"><input type="hidden" name="emp_no"
				value="<%=Admin.getEmp_no()%>"><%=Admin.getEmp_no()%></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type="hidden" name="emp_id"
				value="<%=Admin.getEmp_id()%>"> <%=Admin.getEmp_id()%></td>
		</tr>
		<tr>
			<td>패스워드</td>
			<td><input type="text" name="emp_pwd"
				value="<%=Admin.getEmp_pwd()%>"></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="emp_name"
				value="<%=Admin.getEmp_name()%>"></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><input type="text" name="emp_tel"
				value="<%=Admin.getEmp_tel()%>"></td>
		</tr>
		<tr>
			<td>주소</td>
			<td><input type="text" name="emp_addr" size="30"
				value="<%=Admin.getEmp_addr()%>"></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="text" name="emp_email" size="30"
				value="<%=Admin.getEmp_email()%>"></td>
		</tr>
		<tr>
			<td>홈페이지</td>
			<td><input type="text" name="emp_homepage" size="30"
				value="<%=Admin.getEmp_homepage()%>"></td>
		</tr>
		<tr>
			<td>회원등급</td>
			<td><input type="text" name="fk_grade_id" size="30"
				value="<%=Admin.getFk_grade_id()%>"></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="수정완료">
				<input type="button" value="삭제" size="10" onclick="empRemove()">
				<input type="button" value="닫기" size="10" onclick="window.close()">
			</td>
		</tr>

	</table>
</form>
<%@page import="emp.EmpBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>>
<link href="<%=request.getContextPath()%>/sub/pos_style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../sub/script.js"></script>
<link href="<%=request.getContextPath()%>/sub/pos_style.css" rel="stylesheet" type="text/css">
<jsp:useBean id="usermgr" class="emp.EmpMgr" />

<%
	request.setCharacterEncoding("UTF-8");
	if (session.getAttribute("idKey") == null) {
		response.sendRedirect("../index.jsp");
	} else {
		String emp_id = (String) session.getAttribute("idKey");
		EmpBean userbean = usermgr.getMember(emp_id);
%>
<h1 align="center">${empName} 사원정보수정</h1>
<body>
	<script language="JavaScript" src="script.js"></script>


	<FORM name="join" ACTION="../features/emp_update_proc.jsp"
		METHOD="POST" onsubmit="return chk_frm()">
		<table border="1" align="center">
			<tr>
				<td>ID</td>
				<td><input type="text" name="emp_id"
					value=<%=session.getAttribute("idKey")%> readonly="readonly">(아이디는
					8~14자리) &nbsp;</td>
			</tr>

			<tr>
				<td>PW</td>
				<td><input type="password" name="emp_pwd" size="20"></td>
			</tr>

			<tr>
				<td>PW 확인</td>
				<td><input type="password" name="emp_pwd2" size="20"></td>
			</tr>

			<tr>
				<td>이름</td>
				<td><input type="text" name="emp_name"
					value="<%=userbean.getEmp_name()%>"></td>
			</tr>

			<tr>
				<td>핸드폰 번호</td>
				<td><input type="text" name="emp_tel" maxlength="14" size="14"
					value="<%=userbean.getEmp_tel()%>">(-은 생략해주세요 )</td>
			</tr>

			<tr>
				<td>주소</td>
				<td><input type="text" name="emp_addr" size="50"
					value="<%=userbean.getEmp_addr()%>"></td>
			</tr>

			<tr>
				<td>이메일</td>
				<td><input type="text" name="emp_email" size="50"
					value="<%=userbean.getEmp_email()%>"></td>
			</tr>

			<tr>
				<td>홈페이지</td>
				<td><input type="text" name="emp_homepage" size="50"
					value="<%=userbean.getEmp_homepage()%>"></td>
			</tr>

			<tr>
				<td>INFO</td>
				<td><textarea rows="5" cols="40" name="emp_info"><%=userbean.getEmp_info()%></textarea>
				</td>
			</tr>

			<tr>
				<td colspan="2" align="center"><input type="submit" value="수정"><input
					type="reset" value="다시작성"></td>
			</tr>

		</table>
	</FORM>
	<%
		}
	%>
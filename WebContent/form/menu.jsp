<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%
	//session으로 넘어온 gradekey 값을 받아서 메뉴 분기 
	String user_grade = (String) session.getAttribute("gradeKey");
	String manage_product = "";
	String manage_emp = "";
	
	if (user_grade == null)
	{	//로그인 정보가 사원일경우
		manage_product = "";
		manage_emp =  "";
	}
	else if (user_grade.trim().equals("1"))
	{	//로그인 정보가 관리자일 경우
		manage_product = "<a class='MenuItem2' href=main.jsp?path=product_main style='font-size:9pt;'>상품관리</a>";
		manage_emp =  "<a class='MenuItem2' href=main.jsp?path=emp_admin_jo style='font-size:9pt;'>사원관리</a>";
 	}
	
%>


<table width="900">
	<tr align="center">
		<td><a href="main.jsp?path=bbs_list">공지사항</a></td>
		<td><a href="main.jsp?path=pos_main">POS</a></td>
		<td><a href="main.jsp?path=sales_report">실적</a></td>
		<!-- gradeKey에 따라 나타나는 메뉴항목 -->
		<td><%=manage_product%></td> 
		<td><%=manage_emp%></td>
	</tr>
</table>

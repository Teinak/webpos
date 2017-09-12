<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="emp.EmpMgr" %>
<jsp:useBean id="EmpMgr" class="emp.EmpMgr" />

<%
   request.setCharacterEncoding("UTF-8");
   String emp_id = request.getParameter("emp_id");
   boolean check = EmpMgr.checkId(emp_id);
%>
<html>
<head>
<title>ID중복체크</title>
<script language="JavaScript" src="script.js"></script>
<link href="<%=request.getContextPath()%>/sub/pos_style.css"
	rel="stylesheet" type="text/css">
</head>

<body >
<br>
<center>
<b><%=emp_id%></b>
<%
  if(check){
     out.println("는 이미 존재하는 ID입니다.<p>");
     
}else{    
     out.println("는 사용 가능 합니다.<p>");
  
}
%>
<a href="javascript:this.close();">닫기</a>
</center>
</body>
</html>
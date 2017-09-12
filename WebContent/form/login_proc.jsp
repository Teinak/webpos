<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.*,emp.*"%>
<jsp:useBean id="emgr" class="emp.EmpMgr" />
    
<%
	String emp_id = request.getParameter("emp_id");
	String emp_pwd = request.getParameter("emp_pwd");
	
	EmpBean ebean = emgr.loginCheck(emp_id, emp_pwd); //로그인 정보 확인
	
   if(ebean.getEmp_name() != null){
	  	   
	  session.setAttribute("idKey",emp_id); //id정보를 session으로 보냄
	  session.setAttribute("gradeKey", ebean.getFk_grade_id()); //grade_id정보를 session으로 보냄
	  session.setAttribute("empName", ebean.getEmp_name()); //이름정보를 session으로 보냄
	  session.setAttribute("empNo", ebean.getEmp_no()); //이름정보를 session으로 보냄
	  
	  response.sendRedirect("main.jsp");
   }else{
      response.sendRedirect("login_err.jsp");
   }
%>
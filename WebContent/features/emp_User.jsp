<%@page import="emp.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

	<% request.setCharacterEncoding("UTF-8"); %>
	<jsp:useBean id="userbean" class="emp.EmpBean" />
	<jsp:setProperty name="userbean" property="*" /> 
	
	<%
		System.out.println(userbean.getEmp_name());
	    EmpMgr usermgr = new EmpMgr();
		usermgr.userInsert(userbean); 
		response.sendRedirect("../index.jsp");
	%>


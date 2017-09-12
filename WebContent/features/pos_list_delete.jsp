<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="java.util.*, sales.*, emp.*, pos.*,product.*"%>
<jsp:useBean id="promgr" class="product.ProductMgr" />
<jsp:useBean id="smgr" class="sales.SalesMgr" scope="session"/>

<%
	int p_no = Integer.parseInt(request.getParameter("p_no"));
	
	smgr.clearOrder(p_no); 
	
	%>
<script type="text/javascript">
	location.href="../form/main.jsp?path=pos_main";
</script>

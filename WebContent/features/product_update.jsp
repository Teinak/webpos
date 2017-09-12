<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="product.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="productbean" class="product.ProductBean" />
<jsp:setProperty property="*" name="productbean" />

<%
	ProductMgr pmgr = new ProductMgr();
	boolean re = pmgr.productUpdate(productbean);
	if (re == true) {
%>
<script>
	alert("수정되었습니다.");
	window.close();
	location = "../form/main.jsp?path=product_main";
	
</script>
<%
	} else {
%>
<script>
	alert("수정실패");
	history.back();
</script>
<%
	}
%>
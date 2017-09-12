<%@page import="product.ProductMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

	<%
		String p_no = request.getParameter("p_no");
		ProductMgr pmgr = new ProductMgr();
		boolean re = pmgr.productDelete(Integer.parseInt(p_no));
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
<%@page import="com.oreilly.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="product.ProductMgr"%>

	<%
		request.setCharacterEncoding("UTF-8");
	%>

	<jsp:useBean id="productbean" class="product.ProductBean" />
	<jsp:setProperty property="*" name="productbean" />
	<%
		ProductMgr pmgr = new ProductMgr();
		
		
			boolean re = pmgr.productInsert(productbean);
			String msg="", url="";
			if (re == true)
			{
				msg="카테고리 등록 성공";
				url="../form/main.jsp?path=product_main";
			}else{
				msg="카테고리 등록 실패";
				url="../form/main.jsp?path=product_oreg";
			}
	%>
	<script type="text/javascript">
		alert("<%=msg%>");
		/* window.close(); */
		location.href="<%=url%>";
	</script>
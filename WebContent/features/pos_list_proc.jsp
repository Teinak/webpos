<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="java.util.*, sales.*, emp.*, pos.*,product.*"%>
<jsp:useBean id="promgr" class="product.ProductMgr" />
<jsp:useBean id="smgr" class="sales.SalesMgr" scope="session"/>

<%
	int re_pno = 0;
	String flag = request.getParameter("flag");

	if (flag.equals("barcode"))
	{
		String barcode = request.getParameter("barcode");
		ProductBean pb = new ProductBean();
		System.out.println("아아아아");
		pb = promgr.getProduct(barcode);
		re_pno = pb.getP_no();
	}
	else
	{
		re_pno = Integer.parseInt(request.getParameter("no"));
	}
	
	smgr.addOrder(re_pno); 
	
	%>
<script type="text/javascript">
	location.href="../form/main.jsp?path=pos_main";
</script>

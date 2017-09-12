<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.ArrayList,sales.SalesBean"%>
<%@ page import="java.util.List"%>
<%@ page import="sales.SalesMgr"%>
<%@ page import="sales.*,emp.*,pos.*,product.*"%>
<jsp:useBean id="smgr" class="sales.SalesMgr" scope="session"/>

<%
	request.setCharacterEncoding("UTF-8");
	int emp_no = Integer.parseInt(request.getParameter("fk_emp_no")) ;
	String s_date = request.getParameter("s_date");

	SalesMgr sMgr = new SalesMgr();
	List<SalesBean> salesList = (List<SalesBean>) session.getAttribute("salesList");
	SalesBean salesBean = null;
	
	int r_totprice = 0;
	int r_totquantity = 0;
	int price = 0;
	int quantity = 0;
	
	int size = salesList == null ? 0 : salesList.size();
	for(int i = 0; i < size; ++i ){
		salesBean = salesList.get(i);
		
		price = Integer.parseInt(salesBean.getP_price());
		quantity = Integer.parseInt(salesBean.getS_quantity());
		
		r_totprice += ( price * quantity) ;
		r_totquantity += quantity;
	}
	int r_no = sMgr.insertReceipt(s_date, String.valueOf(r_totprice) , emp_no, String.valueOf(r_totquantity));
	int s_no = sMgr.insertSales(s_date, emp_no, r_no );
	int input_p_no = sMgr.insertSalesProduct(salesList, s_no);
	
	//sMgr.insertSales(sBean);
	//sMgr.insertReceipt(sBean);
	
	//System.out.println(salesList);
	
	String msg="", url="";
	if(input_p_no >= 0){
		msg="상품판매 완료";
		url="../form/main.jsp?path=pos_main";
		//목록 비우기
		Hashtable hCart = smgr.getCartList();
		hCart.clear();
	}else{
		msg="상품판매 실패";
		url="../form/main.jsp?path=pos_main";
	}
	
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>






<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="sales.SalesMgr"%>
<%@ page import="java.util.ArrayList,sales.SalesBean"%>

<%request.setCharacterEncoding("UTF-8");%>

<script type="text/javascript" src="<c:url value='/sub/jquery.js'/>"></script>
<%
	ArrayList<SalesBean> salesList = new ArrayList<SalesBean>();
	SalesBean salesBean = null;
    SalesMgr sMgr =null;
	
	String[] p_no = request.getParameterValues("p_no");
	String[] p_name = request.getParameterValues("p_name");
	String[] p_price = request.getParameterValues("p_price");
	String[] s_quantity = request.getParameterValues("s_quantity");
	String s_date =request.getParameter("s_date");
	int fk_emp_no= Integer.parseInt(request.getParameter("emp_no"));

	for (int i = 0, size = p_no.length; i < size; ++i) {
		salesBean = new SalesBean();
        sMgr = new SalesMgr();
		salesBean.setP_no(Integer.parseInt(p_no[i]));
		salesBean.setP_name(p_name[i]);
		salesBean.setP_price(p_price[i]);
		salesBean.setS_quantity(s_quantity[i]);
        salesBean.setS_date(s_date);
        salesBean.setFk_emp_no(fk_emp_no);
		
        
        System.out.println(salesBean.toString());
        
       
        salesList.add(salesBean);
	}
	
	session.setAttribute("salesList", salesList);
%>
<form action="main.jsp" method="post">
	<table border="1" width="300">
		<tr>
			<td colspan="3">
				<h3 align="center"> 영 수 증</h3>
			</td>
		</tr>
		<tr>
			<td>근무자 :</td>
			<td colspan="3">${param.r_emp}</td>
		</tr>

		<tr>
			<td>판매일시 :</td>
			<td colspan="3">${param.s_date}</td>
		</tr>

		<tr>
			<td width="40%">품목</td>
			<td width="30%">단가</td>
			<td width="30%">수량</td>
		</tr>
		<tr>
			<td colspan="4">
				<table width="100%">
					<c:forEach items="${salesList}" var="s1">
						<tr align="center">
							<td width="40%">${s1.p_name}</td>
							<td width="30%"><fmt:formatNumber value="${s1.p_price}" /></td>
							<td width="30%"><fmt:formatNumber value="${s1.s_quantity}" /></td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>

		<tr>
			<td>총수량 :</td>
			<td colspan="2"><fmt:formatNumber value="${param.r_quantity}" /></td>
		</tr>

		<tr>
			<td>총 판매금액 :</td>
			<td colspan="2"><fmt:formatNumber value="${param.r_price}" /></td>
		</tr>
		<tr align="center">
			<td colspan="4">
			<input type="hidden" name="s_date" value="${param.s_date}">
			<input type="hidden" name="r_emp" value="${param.r_emp}"> 
			<input type="hidden" name="r_quantity" value="${param.r_quantity}"> 
			<input type="hidden" name="r_price" value="${param.r_price}">
			<input type="hidden" name="fk_emp_no" value="${param.emp_no}">
			<input type="hidden" name="path" value="receipt_proc">
			
			<input type="submit" value="확인">
			<input	type="button" value="수정" onclick="history.back()">
		</td>
		</tr>
			
	</table>
</form>



<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="java.util.*, sales.*, emp.*, pos.*,product.*"%>

<jsp:useBean id="smgr" class="sales.SalesMgr" scope="session" />
<jsp:useBean id="promgr" class="product.ProductMgr" />


<table border="1">
	<tr>
		<td>#</td>
		<td>품목명</td>
		<td>회사</td>
		<td>판매단가</td>
		<td>판매수량</td>
		<td>비고</td>
	</tr>
	<%
		int totalPrice = 0;
		Hashtable hCart = smgr.getCartList();

		if (hCart.size() == 0) {
	%>
	<tr>
		<td colspan="6" align="center">선택하신 물품이 없습니다.</td>
	</tr>
	<%
		} else {
			Enumeration hCartKey = hCart.keys();
			while (hCartKey.hasMoreElements()) {
				//주문정보
				SalesBean order = (SalesBean) hCart.get(hCartKey
						.nextElement());
				//상품정보
				ProductBean product = promgr.getProduct(order.getFk_p_no());
				int price = Integer.parseInt(product.getP_price());
				int quantity = Integer.parseInt(order.getS_quantity());
				//int subTotal = price*quantity;
				//totalPrice += price*quantity; //총금액
	%>
	<form method="post" action="pos_list_proc.jsp">
		<input type="hidden" name="flag">
		<tr>
			<td><input type="text" name="p_no" value="<%=product.getP_no()%>"></td>
			<td><input type="text" name="p_name" value="<%=product.getP_name()%>"></td>
			<td><input type="text" name="p_company" value="<%=product.getP_company()%>"></td>
			<td><input type="text" name="p_price" value="<%=price%>"></td>
			<td><input type="text" name="s_quantity" value="<%=quantity%>"></td>
			<td><input type="text" name="p_info" value="<%=product.getP_info()%>"></td>
		</tr>
	</form>
	<%
		}
		}
	%>
</table>

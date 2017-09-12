<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*, sales.*, emp.*, pos.*,product.*"%>
<jsp:useBean id="eBean" class="emp.EmpBean" />
<jsp:useBean id="smgr" class="sales.SalesMgr" scope="session" />
<jsp:useBean id="promgr" class="product.ProductMgr" />
<jsp:useBean id="pmgr" class="pos.PosMgr" />

<script src="../sub/jquery.js" type="text/javascript"></script>

<%
	String user_id = (String) session.getAttribute("idKey");
	
	SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
	Date currentTime = new Date();
	String dTime = formatter.format (currentTime);
%>
<form name="pos_form" action="main.jsp" method="post">
	<table border="1" width="100%">
		<tr>
			<td colspan="4" align="center">
				<hr width=500 color=#667788> <font size=4 color=navy> <b>P O S</b>
			</font> <br>
				<hr width=500 color=#667788>
			</td>
		</tr>
		<tr height="10%">
			<td width="25%" align="center">근무자</td>
			<td width="25%" align="center"><input type="text" name="r_emp" value="${empName}"></td>
			<td width="25%" align="center">영업일</td>
			<td width="25%" align="center"><input type="text" name="s_date" value="<%=dTime%>">
			</td>
		</tr>
		<tr height="70%">
			<td colspan="4" valign="top">
				<table width="100%">
					<tr align="center" bgcolor=#c9c9c9>
						<td width="10%">#</td>
						<td width="15%">품목명</td>
						<td width="15%">회사</td>
						<td width="15%">판매단가</td>
						<td width="15%">판매수량</td>
						<td width="15%">비고</td>
						<td width="15%">&nbsp;</td>
					</tr>
				</table>
				<table width="100%" id="productData" align="center">
					<%
						int totalPrice = 0;
						Hashtable hCart = smgr.getCartList();
						if (hCart.size() == 0) {
					%>

					<tr>
						<td colspan="7" align="center">선택하신 물품이 없습니다.</td>
					</tr>
					<%
						} else {
						Enumeration hCartKey = hCart.keys();
						while (hCartKey.hasMoreElements()) {
					//오더정보
						ProductBean pro = (ProductBean) hCart.get(hCartKey.nextElement());
					%>
					<tr class="productItem" align="center">
						<td width="10%"><input type="text" size="13" name="p_no"  value="<%=pro.getP_no()%>" ></td>
						<td width="15%"><input type="text" size="20" name="p_name"
							value="<%=pro.getP_name()%>"></td>
						<td width="15%"><input type="text" size="20" name="p_company"
							value="<%=pro.getP_company()%>"></td>
						<td width="15%"><input type="text" size="20" name="p_price"
							value="<%=pro.getP_price()%>"></td>
						<td width="15%"><input type="text" size="20" name="s_quantity"
							value="<%=pro.getP_quantity()%>"></td>
						<td width="15%"><input type="text" size="20" name="p_info"
							value="<%=pro.getP_info()%>"></td>
						<td width="15%"><button type="button" onclick="postFunc.itemDelete('<%=pro.getP_no()%>'); " style="width:120px;">삭제</button></td>
					</tr>
					<%
						}
						}
					%>
				</table>

			</td>
		</tr>
		<tr align="center" bgcolor=#c9c9c9>
			<td width="25%">총수량</td>
			<td width="25%" colspan="1"><input id="tot_quantity" type="text" name="r_quantity"></td>
			<td width="25%">합계금액</td>
			<td width="25%" colspan="1"><input id="tot_price" type="text" name="r_price">
			
			</td>
		</tr>
		<tr align="right">
			<td colspan="4">
				<input type="button" value="정산" onclick="postFunc.calcSum()"> 
				<input type="submit" value="영수증출력" /> 
				<input type="hidden" name="emp_no" value="${empNo}">
				<input type="hidden" name="path" value="receipt"> 
			</td>
		</tr>
	</table>
</form>
<form id="pos_del_form" action="../features/pos_list_delete.jsp" method="post">
	<input type="hidden" name="p_no" />
</form>

<script type="text/javascript">
	var postFunc = {
		calcSum : function() {
			var dataList = $("#productData tr.productItem");
			var tot_quantity = 0;
			var tot_price = 0;
			var quantity = 0;
			var price = 0;

			if( dataList.length == 0){
				$("#tot_quantity").val(0);
				$("#tot_price").val(0);				

			} else {
				dataList.each(function() {
					quantity = parseInt($("input[name=s_quantity]", this).val());
					price = parseInt($("input[name=p_price]", this).val());
					tot_quantity += quantity;
					tot_price += (quantity * price);
				});

				$("#tot_quantity").val(tot_quantity);
				$("#tot_price").val(tot_price);				
			}

		},
		
		itemDelete : function(p_no){
			
			var form = $("#pos_del_form");
			
			form.find("input[name=p_no]").val(p_no);
			form.submit();
		}
	};
	
	$(document).ready(function(){
		postFunc.calcSum();
	});
</script>

<table width="100%" height="100">

	<tr>
		<td align="center"><%@include file="pos_category.jsp"%>
		</td>
	</tr>
	<tr>
		<td align="center"><hr>
		</td>
	</tr>
	<tr>
		<td align="center" colspan="5" valign="top"><%@include file="pos_button.jsp"%>
		</td>
	</tr>

</table>





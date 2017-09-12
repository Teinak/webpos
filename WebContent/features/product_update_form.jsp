<%@page import="java.util.*, product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/sub/pos_style.css" rel="stylesheet" type="text/css">
<jsp:useBean id="mid_cg" class="product.MiddleCategoryMgr" />


<script type="text/javascript">
	function goRemove() {
		var pno = frm.p_no.value;
		location = "../form/main.jsp?path=product_remove&p_no=" + pno;
	}

	function open_mid_popup() {
		window.open('../features/middle_category.jsp', 'post', 'width=600, height=600,left=500,top=300');
	}
	
</script>
	<%
		int p_no = Integer.parseInt(request.getParameter("p_no"));
		ProductMgr pmgr = new ProductMgr();
		ProductBean productbean = pmgr.getProduct(p_no);
	%>
	<form action="../features/product_update.jsp" method="post" name="frm">
		<table border="1" width="100%">


			<tr>
				<td>상품번호</td>
				<td colspan="2"> 
				<input name="p_no" type="hidden" value="<%=productbean.getP_no()%>"> <%=productbean.getP_no()%></td>
			</tr>
			<tr>
				<td>소분류</td>
				<td><select name="fk_m_no">
				<%
					ArrayList<MiddleCategoryBean> mid_arr = mid_cg.categoryAll();
				%>
					<option value="">카테고리 선택</option>
				<%
					for (MiddleCategoryBean mbean : mid_arr) {
						if (mbean.getM_no() != productbean.getFk_m_no()) {
				%>
					<option value="<%= mbean.getM_no()%>"> [<%=mbean.getM_id()%>] <%=mbean.getM_name()%> </option>
				<%
					} else {
				%>
					<option value="<%= mbean.getM_no()%>" selected="selected"> [<%=mbean.getM_id()%>] <%=mbean.getM_name()%> </option>
				<%
					}//for---------
					}
				%>
				</select></td>
				<td align="center"><input type="button" value="카테고리 등록"
					name="gr_cate_in" onclick="open_mid_popup()"></td>

			</tr>
			<tr>
				<td>상품id</td>
				<td colspan="2"><input name="p_id" type="text"
					value="<%=productbean.getP_id()%>"></td>
			<tr>
			<tr>
				<td>상품이름</td>
				<td colspan="2"><input name="p_name" type="text"
					value="<%=productbean.getP_name()%>"></td>
			<tr>
			<tr>
				<td>상품가격</td>
				<td colspan="2"><input name="p_price" type="text"
					value="<%=productbean.getP_price()%>"></td>
			<tr>
			<tr>
				<td>만든이</td>
				<td colspan="2"><input name="p_author" type="text"
					value="<%=productbean.getP_author()%>"></td>
			<tr>
			<tr>
				<td>제조회사</td>
				<td colspan="2"><input name="p_company" type="text"
					value="<%=productbean.getP_company()%>"></td>
			<tr>
			<tr>
				<td>상품바코드</td>
				<td colspan="2"><input name="p_barcode" type="text"
					value="<%=productbean.getP_barcode()%>"></td>
			<tr>
				<tr>
				<td >상품재고</td>
			<td colspan="2"><input name="p_stock" type="text"
					value="<%=productbean.getP_stock()%>"></td>
		</tr>
		<!-- <td>상품이미지</td> -->
			<%-- <tr>
			<td>상품판매일자</td>
			<td><input name="p_date" type="text" value="<%=productbean.getP_date()%>"></td>
		<tr> --%>
		<tr>
			<td>상품정보</td>
			<td colspan="2"><input name="p_info" type="text" value="<%=productbean.getP_info()%>">
			</tr>
	
			<tr align="center">
			<td colspan="3">
				<input type="submit" value="수정하기">
				<input type="button" value="삭제하기" onclick="goRemove()">
			</td>
		</tr>
	</table>
	</form>

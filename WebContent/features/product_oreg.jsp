<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ page import="java.util.*, product.*"%>
<jsp:useBean id="gr_cg" class="product.GreatCategoryMgr" />
<jsp:useBean id="mid_cg" class="product.MiddleCategoryMgr" />


<script type="text/javascript">
	function insert() {
		location = "main.jsp?path=product_main";
	}

	function change2() {
		val = document.product_form.fk_g_no.value;
		val2 = document.product_form.fk_g_no.selectedIndex;
		document.g_cate_form.gno.value = val;
		document.g_cate_form.gindex.value = val2;
		document.g_cate_form.submit();
	} 

	function open_gr_popup() {
		window.open('../features/great_category.jsp', 'popup', 'width=600, height=600, left=500, top=300');
	}
	function open_mid_popup() {
		window.open('../features/middle_category.jsp', 'popup', 'width=600, height=600, left=500, top=300');
	}
</script>

<form name="g_cate_form" action="main.jsp?path=product_oreg" method="post">
	<input type="hidden" name="gindex"> <input type="hidden" name="gno">
</form>



<form name="product_form" action="../features/product_oreg_proc.jsp"
	method="post">
	<table border="1" width="400">
	<tr>
	<td colspan="3">
	<h3 align="center">상품등록</h3>
	</td>
	</tr>
		<tr>
			<td>대분류 :</td>
			<td><select name="fk_g_no" id="g_cate2" onchange="change2()">
					<%
						java.util.ArrayList<GreatCategoryBean> gr_arr = gr_cg.categoryAll();
					%>
					<option value="">카테고리 선택</option>
					<%
						if (gr_arr == null || gr_arr.size() == 0) {
												} else {
													for (GreatCategoryBean gbean : gr_arr) {
													int g_no = gbean.getG_no();
													String g_id = gbean.getG_id();
													String g_name = gbean.getG_name();
					%>
					<option value="<%=g_no%>">
						[<%=g_id%>]
						<%=g_name%>
					</option>
					<%
						}//for---------
												}
													String gindex = request.getParameter("gindex");
													if (gindex != null)
													{	
														int gi = Integer.parseInt(gindex);
					%>
					<script>
						document.getElementById("g_cate2").selectedIndex =
					<%=gi%>
						;
					</script>
					<%
						}
					%>
			</select></td>
			<td align="center"><input type="button" value="카테고리 등록"
				name="gr_cate_in" onclick="open_gr_popup()"></td>

		</tr>

		<tr>
			<td>소분류 :</td>
			<td><select name="fk_m_no">
					<%
						String gg_no = request.getParameter("gno");
						java.util.ArrayList<MiddleCategoryBean> mid_arr = mid_cg
								.followGrCategory(gg_no);
						if (mid_arr == null || mid_arr.size() == 0) {
					%>
					<option value=null>카테고리 선택</option>
					<%
						} else {
							for (MiddleCategoryBean mbean : mid_arr) {
								int m_no = mbean.getM_no();
								String m_id = mbean.getM_id();
								String m_name = mbean.getM_name();
					%>
					<option value="<%=m_no%>">
						[<%=m_id%>]
						<%=m_name%>
					</option>
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
			<td colspan="2"><input type="text" name="p_id"></td>
		</tr>

		<tr>
			<td>상품이름</td>
			<td colspan="2"><input type="text" name="p_name"></td>
		</tr>

		<tr>
			<td>상품가격</td>
			<td colspan="2"><input type="text" name="p_price">원</td>
		</tr>

		<tr>
			<td>만든이</td>
			<td colspan="2"><input type="text" name="p_author"
				maxlength="20" size="20"></td>
		</tr>

		<tr>
			<td>제조회사</td>
			<td colspan="2"><input type="text" name="p_company"></td>
		</tr>
		<tr>
			<td>바코드</td>
			<td colspan="2"><input type="text" name="p_barcode"></td>
		</tr>

		<tr>
			<td>상품재고</td>
			<td colspan="2"><input type="text" name="p_stock"></td>
		</tr>
		<tr>
		<tr>
			<td>상품정보</td>
			<td colspan="2"><input type="text" name="p_info"></td>

		</tr>
		<tr>

			<td colspan="3" align="center">&nbsp;&nbsp;&nbsp;<input
				type="submit" value="상품등록 완료">&nbsp;&nbsp;&nbsp; <input
				type="button" value="취소" onclick="insert()" name="main"></td>
		</tr>
	</table>
</form>

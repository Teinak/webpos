<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ page import="java.util.*, product.*"%>
<jsp:useBean id="gr_cg" class="product.GreatCategoryMgr" />
<jsp:useBean id="mid_cg" class="product.MiddleCategoryMgr" />
<script type="text/javascript">
	function change() {
		val = document.cate_form.g_cate.value;
		val2 = document.cate_form.g_cate.selectedIndex;
		document.g_cate_form.gno.value = val;
		document.g_cate_form.gindex.value = val2;
		document.g_cate_form.submit();
	}

	function category_click()
	{
		grno = document.cate_form.g_cate.value;
		midno = document.cate_form.m_cate.value;		
		document.btn_form.grno.value = grno;
		document.btn_form.midno.value = midno;
		document.btn_form.submit();
	}

</script>

<!-- 대분류에 따른 소분류 카테고리 값을 변경해주기 위한 hidden form -->
<form name="g_cate_form" action="main.jsp?path=pos_main" method="post">
	<input type="hidden" name="gindex"> 
	<input type="hidden" name="gno">
</form>

<form name="btn_form" action="main.jsp?path=pos_main" method="post">
	<input type="hidden" name="grno"> 
	<input type="hidden" name="midno">
</form>

<table>
<tr>
<td>
	<form name="cate_form">
		<table>
			<tr>
				<td>대분류 : </td>
				<td style="padding-right : 20px"><select name="g_cate" id="g_cate" onchange="change()">
					<%
						ArrayList<GreatCategoryBean> gr_arr = gr_cg.categoryAll();
					%>
					<option value="">카테고리 선택</option>
					<%
						for (GreatCategoryBean gbean : gr_arr) {
					%>
					<option value="<%=gbean.getG_no()%>">
						[<%=gbean.getG_id()%>]
						<%=gbean.getG_name()%>
					</option>
					<%
						}//for---------
							String gindex = request.getParameter("gindex");
							if (gindex != null)
							{	
								int gi = Integer.parseInt(gindex);
					%>
					<script>
						document.getElementById("g_cate").selectedIndex = <%=gi%>;
					</script>
					<%
						}
					%>
				</select></td>
				<td>소분류 : </td>
				<td style="padding-right : 20px">
				<select name="m_cate" >
					<%
						String gg_no = request.getParameter("gno");
						java.util.ArrayList<MiddleCategoryBean> mid_arr = mid_cg.followGrCategory(gg_no);
					%>
					<option value=null>카테고리 선택</option>
					<%
						for (MiddleCategoryBean mbean : mid_arr) {
					%>
					<option value="<%=mbean.getM_no()%>">[<%=mbean.getM_id()%>] <%=mbean.getM_name()%> </option>
					<%
						}//for---------
					%>
				</select>
				</td>
				<td style="padding-right : 100px"><input type="button" value="조회" onclick="category_click()"></td>
			</tr>
		</table>
	</form>
	</td>
	<td>
	<form name="barcode_form" action="../features/pos_list_proc.jsp" method="post">
		<table>
			<tr>
				<td>바코드조회 : </td>
				<td style="padding-right : 20px"><input type="text" name="barcode"></td>
				<td>
				<input type="hidden" name="flag" value="barcode">
				<input type="submit" value="바코드 조회"></td>
			</tr>
		</table>
	</form>
	</td>
	</tr>
</table>
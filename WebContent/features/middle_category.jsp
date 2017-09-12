<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.*, product.*"%>
<link href="<%=request.getContextPath()%>/sub/pos_style.css" rel="stylesheet" type="text/css">
<jsp:useBean id="gr_cg" class="product.GreatCategoryMgr" />
<jsp:useBean id="mid_cg" class="product.MiddleCategoryMgr" />

<script type="text/javascript">
function mid_insert()
{
	fkgno = document.mid_form.fk_g_no.value;
	if (fkgno == "")
	{
		alert("상위 카테고리가 선택되지 않았습니다.");
		return;
	}

	document.mid_form.submit();
}

function mid_update(idx)
{
	fkgno = document.getElementsByName('edit_fk_g_no')[idx].value;
	
	if (fkgno == "")
	{
		alert("상위 카테고리가 선택되지 않았습니다.");
		return;
	}
		
	mno = document.getElementsByName('edit_mno')[idx].value; 
	mid = document.getElementsByName('edit_mid')[idx].value; 
	mname = document.getElementsByName('edit_mname')[idx].value; 
	
	var returnValue = confirm(mno + "번 카테고리를 편집 하시겠습니까?");
	if (returnValue)
	{
		document.mid_up_form.m_no.value = mno;
		document.mid_up_form.m_id.value = mid;
		document.mid_up_form.m_name.value = mname;
		document.mid_up_form.fk_g_no.value = fkgno;
		document.mid_up_form.submit();
	}
	else
	{
		alert("취소 되었습니다.")
	}
}
function mid_delete(mno)
{
	var returnValue = confirm(mno + "번 카테고리를 삭제 하시겠습니까?\n하위 카테고리까지 삭제됩니다.");
	if (returnValue)
	{	
		document.mid_del_form.m_no.value = mno;
		document.mid_del_form.submit();
	}
	else
	{
		alert("취소 되었습니다.")
	}
}
</script>

<form name="mid_up_form" action="middle_category_proc.jsp" method="POST">
	<input type="hidden" name="flag" value="update">
	<input type="hidden" name="m_no">
	<input type="hidden" name="m_id">
	<input type="hidden" name="m_name">
	<input type="hidden" name="fk_g_no">
</form>

<form name="mid_del_form" action="middle_category_proc.jsp" method="POST">
	<input type="hidden" name="flag" value="delete">
	<input type="hidden" name="m_no">
</form>

<div>
	<form name="mid_form" action="middle_category_proc.jsp" method="post">
		<table border="1" width="100%">
			<tr>
				<td colspan="3" align="center">카테고리 입력</td>
			</tr>
			<tr>
				<td align="center">상위 카테고리:</td>
				<td><select name="fk_g_no">
						<%
							ArrayList<GreatCategoryBean> gr_arr = gr_cg.categoryAll();
						%>
						<option value="">카테고리 선택</option>
						<%
							for (GreatCategoryBean gbean : gr_arr) {
						%>
						<option value="<%=gbean.getG_no()%>"> [<%=gbean.getG_id()%>] <%=gbean.getG_name()%> </option>
						<%
							}//for---------
						%>
				</select></td>
			</tr>
			<tr>
				<td align="center">카테고리 id :</td>
				<td><input type="text" name="m_id"></td>
			</tr>
			<tr>
				<td align="center">카테고리 이름 :</td>
				<td><input type="text" name="m_name"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="hidden" name="flag" value="insert">
				<input type="button" name="m_confirm" value="확인" onclick="mid_insert()"> 
				<input type="reset" name="m_reset" value="취소"></td>
			</tr>
		</table>
	</form>
</div>

<div>
	<table border="1" width="100%">
		<tr align="center">
			<td>카테고리 번호</td>
			<td>상위 카테고리</td>
			<td>카테고리 id</td>
			<td>카테고리 이름</td>
			<td>편집/삭제</td>
		</tr>
		<%
			ArrayList<MiddleCategoryBean> mid_arr = mid_cg.categoryAll();
			int arr_idx = 0;
			for (MiddleCategoryBean mbean : mid_arr) {
		%>
		<tr align="center">
				<td><input type="text" name="edit_mno" value="<%=mbean.getM_no()%>" readonly></td>
				<td><select name="edit_fk_g_no">
					<option value="">카테고리 선택</option>
					<%
					for (GreatCategoryBean gbean : gr_arr) {
						if (mbean.getFk_g_no() != gbean.getG_no())	{
					%>
							<option value="<%=gbean.getG_no()%>"> [<%=gbean.getG_id()%>] <%=gbean.getG_name()%> </option>
					<%
						} else {
							%>
							<option value="<%=gbean.getG_no()%>" selected="selected"> [<%=gbean.getG_id()%>] <%=gbean.getG_name()%> </option>
							<%
						}
						}//for---------
					%>
					<script>
						document.getElementById("edit_fk_g_no_op").selectedIndex = 2;
					</script>
				</td>
				<td><input type="text" name="edit_mid" value="<%=mbean.getM_id()%>"></td>
				<td><input type="text" name="edit_mname" value="<%=mbean.getM_name()%>"></td>
				<td>
					<a href="javascript:mid_update(<%=arr_idx++%>)">편집</a>
					/
					<a href="javascript:mid_delete(<%=mbean.getM_no()%>)">삭제</a></td>
		</tr>
		<%}%>

	</table>
</div>

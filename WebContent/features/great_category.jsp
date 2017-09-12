<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/sub/pos_style.css" rel="stylesheet" type="text/css">
<%@page import="java.util.*,product.*"%>
<jsp:useBean id="gr_cg" class="product.GreatCategoryMgr" />

<script type="text/javascript">
function gr_update(idx)
{
	gno = document.getElementsByName('edit_gno')[idx].value; 
	gid = document.getElementsByName('edit_gid')[idx].value; 
	gname = document.getElementsByName('edit_gname')[idx].value; 
	
	var returnValue = confirm(gno + "번 카테고리를 편집 하시겠습니까?");
	if (returnValue)
	{
		document.gr_up_form.g_no.value = gno;
		document.gr_up_form.g_id.value = gid;
		document.gr_up_form.g_name.value = gname;
		document.gr_up_form.submit();
	}
	else
	{
		alert("취소 되었습니다.")
	}
}
function gr_delete(gno)
{
	var returnValue = confirm(gno + "번 카테고리를 삭제 하시겠습니까?\n하위 카테고리까지 삭제됩니다.");
	if (returnValue)
	{	
		document.gr_del_form.g_no.value = gno;
		document.gr_del_form.submit();
	}
	else
	{
		alert("취소 되었습니다.")
	}
}
</script>

<form name="gr_up_form" action="great_category_proc.jsp" method="POST">
	<input type="hidden" name="flag" value="update">
	<input type="hidden" name="g_no">
	<input type="hidden" name="g_id">
	<input type="hidden" name="g_name">
</form>

<form name="gr_del_form" action="great_category_proc.jsp" method="POST">
	<input type="hidden" name="flag" value="delete">
	<input type="hidden" name="g_no">
</form>

<div>
	<form name="gr_form" action="great_category_proc.jsp" method="POST">
		<table border="1" width="100%">
			<tr>
				<td colspan="3" align="center">카테고리 입력</td>
			</tr>
			<tr>
				<td align="center" width="40%">카테고리 id :</td>
				<td><input type="text" name="g_id"></td>
			</tr>
			<tr>
				<td align="center">카테고리 이름 :</td>
				<td><input type="text" name="g_name"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="submit" name="g_confirm" value="확인"> 
				<input type="reset" name="g_reset" value="취소">
				<input type="hidden" name="flag" value="insert">
				</td>
			</tr>
		</table>
	</form>
</div>

<div>
	<form name="gr_list_form">
		<table border="1" width="100%">
			<tr align="center">
				<td>카테고리 번호</td>
				<td>카테고리 id</td>
				<td>카테고리 이름</td>
				<td>편집/삭제</td>
			</tr>
		<%
			ArrayList<GreatCategoryBean> gr_arr = gr_cg.categoryAll();
			int arr_idx = 0;
			for (GreatCategoryBean gbean : gr_arr) {
		%>
			<tr align="center">
				<td><input type="text" name="edit_gno" value="<%=gbean.getG_no()%>" readonly></td>
				<td><input type="text" name="edit_gid" value="<%=gbean.getG_id()%>"></td>
				<td><input type="text" name="edit_gname" value="<%=gbean.getG_name()%>"></td>
				<td>
					<a href="javascript:gr_update(<%=arr_idx++%>)">편집</a>
					/
					<a href="javascript:gr_delete(<%=gbean.getG_no()%>)">삭제</a></td>
			</tr>
		<%}%>
		</table>
	</form>
</div>
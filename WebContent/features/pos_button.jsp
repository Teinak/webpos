<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.*, product.*"%>
<jsp:useBean id="pmgrr" class="product.ProductMgr" />

<script type="text/javascript">
	function productDetail(no) {
		document.detail_form.no.value = no;
		document.detail_form.flag.value = "";
		document.detail_form.submit();
	}
</script>
<form name="detail_form" action="../features/pos_list_proc.jsp" method="post">
	<input type="hidden" name="no"> 
	<input type="hidden" name="flag"> 
</form>
<%
	// product 버튼 만들기 위한 벡터 생성
	Vector vProList = null;
	String grno = request.getParameter("grno");
	String midno = request.getParameter("midno");
	
	if(grno != null && midno != null){
		vProList = pmgrr.getMiddleProductList(midno);
		// mid_category 상품출력
	}
	else if(grno != null && midno == null){
		vProList = pmgrr.getGreatProductList(grno);
		// mid_category 상품출력
	}else{
		vProList = pmgrr.allGetProduct();
	}
	
	
	for (int i = 0; i < vProList.size(); i++) {

		if ((i % 11) == 0) {
				//상품을 열한개씩 가로정렬
	%>
	<table>
	<tr>
		<%
			}
				ProductBean pbean = (ProductBean) vProList.get(i);
		%>
		<td>
			<table border = "1" width="75" height="50">

				<tr>
					<td align="center"><a href="javascript:productDetail('<%=pbean.getP_no()%>')"><%=pbean.getP_no()%></a></td>
				</tr>
				<tr>
					<td align="center" style="FONT-SIZE: 8pt;"><a href="javascript:productDetail('<%=pbean.getP_no()%>')"><%=pbean.getP_name()%></a></td>
				</tr>
			</table>
		</td>

		<%
			}
		%>

	</tr>
</table>




<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.*, product.*"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<!-- 스크립트 태그  -->
<script type="text/javascript">
	function insert() {
		location = "main.jsp?path=product_oreg";
	}

	function open_update_popup(pno) {
		window.open('../features/product_update_form.jsp?p_no='+ pno, 'popup', 'width=400, height=400,left=600,top=300');
	}
</script>


<!-- 상품등록 -->
<table border="1" width="100%" align="center">
	<tr>
		<td align="center" valign="middle"><hr width=500 color=#667788>
			 <font size=4 color=navy> <b>상 품 관 리</b>
			 </font> <br>
		<hr width=500 color=#667788></td>
	</tr>
	<tr>
		<td align="right"><input type="button" name="oreg" value="상품등록"
			onclick="insert()"></td>
	</tr>
</table>

<table border="1" width="100%" height="20" align="center">
	<!-- 상품목록 창 -->

	<tr align="center" bgcolor=#c9c9c9>
		<td><a style="color: red">상품번호</a></td>
		<td>카테고리</td>
		<td>상품id</td>
		<td>상품이름</td>
		<td>상품가격</td>
		<td>만든이</td>
		<td>제조회사</td>
		<td><a style="color: red">바코드</a></td>
		<td>재고</td>
		<td>입력일자</td>
		<td>정보</td>
	</tr>
<%

ProductMgr pmgr = new ProductMgr();

Vector v = pmgr.allGetProduct();
for (int i = 0; i < v.size(); i++) {
	ProductBean productbean = (ProductBean) v.get(i);
%>

	<tr align="center">
		<td><%=productbean.getP_no()%></td>
		<td><%=productbean.getM_name()%></td>
		<td><%=productbean.getP_id()%></td>
		<td><a href="javascript:open_update_popup(<%=productbean.getP_no()%>)"><%=productbean.getP_name()%></a></td>
		<td><%=productbean.getP_price()%></td>
		<td><%=productbean.getP_author()%></td>
		<td><%=productbean.getP_company()%></td>
		<td><%=productbean.getP_barcode()%></td>
		<td><%=productbean.getP_stock()%></td>

		<td><%=productbean.getP_date()%></td>
		<td><%=productbean.getP_info()%></td>
	</tr>
	<%
		}
	%>
</table>
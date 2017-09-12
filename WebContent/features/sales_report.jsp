<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="pos.*,java.util.*,sales.*,emp.*,product.*"%>
<%@page import="sales.SalesMgr"%>

<jsp:useBean id="emgr" class="emp.EmpMgr" />
<jsp:useBean id="ebean" class="emp.EmpBean" />
<jsp:useBean id="ppmgr" class="product.ProductMgr" />
<jsp:useBean id="pbean" class="product.ProductBean" />

<script type="text/javascript">

function sales_click()
	{
		vpno = document.search_form.p_no.value;
		veno = document.search_form.emp_no.value;
	
		if (vpno == "" || veno == "")
		{
			alert("조회할 품목이나 판매자가 선택되지 않았습니다.");
			return;
		}
			
		vr_date1 = document.search_form.r_date1.value;
		vr_date2 = document.search_form.r_date2.value;

		document.search_return_form.r_p_no.value = vpno;
		document.search_return_form.r_emp_no.value = veno;
		document.search_return_form.r_r_date1.value = vr_date1;
		document.search_return_form.r_r_date2.value = vr_date2;
		
		document.search_return_form.submit();
	}
</script>

<form name="search_form">
	<table border="1" width="100%">
		<tr>
			<td colspan="9">
				<h3 align="center"> 실 적 조 회</h3>
			</td>
		</tr>
	
		<tr align="center">
			<td width="100">품목</td>
			<td >
			<select name="p_no">
					<%
						Vector vpList = ppmgr.allGetProduct();
					%>
					<option value="">제품 선택</option>
					<%
						for (int i = 0; i < vpList.size(); ++i) {
							pbean = (ProductBean) vpList.get(i);
					%>
					<option value="<%=pbean.getP_no()%>"> <%=pbean.getP_name()%> </option>
					<%
						}//for---------
					%>
			</td>
			<td width="100">날짜</td>
			<td><input type="date" name="r_date1" value="2012-01-01" /> </td>
			<td width="10">~</td>
			<td> <input type="date" name="r_date2" value="2013-12-01" /> </td>
			<td width="100">판매자</td>
			<td>			
			<select name="emp_no">
					<%
						Vector veList = emgr.getUserInfoList();
					%>
					<option value="">직원 선택</option>
					<%
						for (int i = 0; i < veList.size(); ++i) {
							ebean = (EmpBean) veList.get(i);
					%>
					<option value="<%=ebean.getEmp_no()%>"> <%=ebean.getEmp_name()%> </option>
					<%
						}//for---------
					%>
			</td>
			<td>
			<input type="button" value="조회" onclick="sales_click()"></td>
		</tr>
	</table>
</form>

<form name="search_return_form" action="main.jsp?path=sales_report" method="post">

<input type="hidden" name="r_p_no">
<input type="hidden" name="r_emp_no">
<input type="hidden" name="r_r_date1">
<input type="hidden" name="r_r_date2">

</form>


<table border="1" width="100%">
	<tr align="center" bgcolor=#c9c9c9>
		<td>품목명</td>
		<td>판매자</td>
		<td>판매날짜</td>
		<td>저자</td>
		<td>금액</td>
		<td>수량</td>
	</tr>
	<%
		Vector vSales = null;
		String p_no = request.getParameter("r_p_no");
		String emp_no = request.getParameter("r_emp_no");
		String r_date1  = request.getParameter("r_r_date1");
		String r_date2  = request.getParameter("r_r_date2");
								
		if(p_no != null || emp_no != null){
			PosMgr pMgr = new PosMgr();
			PosBean posBean = new PosBean();

			//System.out.println(p_no+" "+ r_date1+" "+ r_date2+" "+ emp_no);
			vSales = pMgr.getSalesReport(Integer.parseInt(p_no), r_date1, r_date2, Integer.parseInt(emp_no));
	
			//System.out.println(" v" + vSales);
			for (int i = 0; i < vSales.size(); ++i) {
				posBean = (PosBean) vSales.get(i);
			%>
				<tr align="center">
					<td><%=posBean.getP_name()%></td>
					<td><%=posBean.getEmp_name()%></td>
					<td><%=posBean.getR_date()%></td>
					<td><%=posBean.getP_author()%></td>
					<td><%=posBean.getP_price()%></td>
					<td><%=posBean.getS_quantity()%></td>
				</tr>
			<% 
			}
		}
		else
		{
			%>
			<tr>
			<td colspan="6" align="center"> 조건을 입력하고 조회 하세요</td>
			</tr>
			<%
		}
	%>

</table>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<jsp:useBean id="gr_cg" class="product.GreatCategoryMgr" />

<!--  cate_input_ok.jsp-->  
<%
//1. 사용자가 입력한 값 받아오기
	request.setCharacterEncoding("UTF-8");
	String g_flag = request.getParameter("flag");
	int n = 0;
	String str = "", msg="", url="";	
	
	if (g_flag.equals("delete"))
	{
		str = "삭제";
		String g_no=request.getParameter("g_no");
		n = gr_cg.deletetGrCategory(Integer.parseInt(g_no));
	}
	else
	{
		String g_id = request.getParameter("g_id");
		String g_name = request.getParameter("g_name");
		
		//2. 유효성 체크
		if(g_id==null|| g_name==null || g_id.trim().equals("") || g_name.trim().equals("")){
			response.sendRedirect("great_category.jsp");
			return;
		}
		
		//3. 비즈니스 메소드 호출
		
		if(g_flag.equals("insert"))
		{
			n = gr_cg.categoryInsert(g_id.trim(), g_name.trim());
			str = "등록";
		}else if (g_flag.equals("update"))
		{
			String g_no = request.getParameter("g_no");
			n = gr_cg.updateGrCategory(Integer.parseInt(g_no), g_id.trim(), g_name.trim());
			str = "편집";
		}
		
	}//else if-----------
	
	//4. 메세지 출력
	if(n > 0){
		msg="카테고리 " + str + " 성공";
		url="../features/great_category.jsp";
	}else{
		msg="카테고리 " + str + " 실패";
		url="../features/great_category.jsp";
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
	/* window.close(); */
</script>

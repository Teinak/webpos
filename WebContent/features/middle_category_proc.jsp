<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

	<jsp:useBean id="mid_cg" class="product.MiddleCategoryMgr" />

	<%
		//1. 사용자가 입력한 값 받아오기
		request.setCharacterEncoding("UTF-8");
		
		String m_flag = request.getParameter("flag");
		int n = 0;
		String str = "", msg = "", url = "";
		
		if (m_flag.equals("delete"))
		{
			str = "삭제";
			String m_no = request.getParameter("m_no");
			n = mid_cg.deletetMidCategory(Integer.parseInt(m_no));
		}
		else
		{
			String m_id = request.getParameter("m_id");
			String m_name = request.getParameter("m_name");
			String fk_g_no = request.getParameter("fk_g_no");

			//2. 유효성 체크
			if (m_id == null || m_name == null || fk_g_no == null
					|| m_id.trim().equals("") || m_name.trim().equals("")
					|| fk_g_no.trim().equals("")) {
				response.sendRedirect("middle_category.jsp");
				return;
			}//if-----------
			
			//3. 비즈니스 메소드 호출
			if(m_flag.equals("insert"))
			{
				n = mid_cg.categoryInsert(m_id.trim(), m_name.trim(), fk_g_no.trim());
				str = "등록";
			}
			else if (m_flag.equals("update"))
			{
				String m_no = request.getParameter("m_no");
				n = mid_cg.updateMidCategory(Integer.parseInt(m_no), m_id.trim(), m_name.trim(),  fk_g_no.trim());
				str = "편집";
			}
		}
		
		if (n > 0) {
			msg="카테고리 " + str + " 성공";
			url = "../features/middle_category.jsp";
		} else {
			msg="카테고리 " + str + " 실패";
			url = "../features/middle_category.jsp";
		}
	%>
	
	<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
	</script>

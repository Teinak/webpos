<%@page import="notice.BbsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="notice.BbsManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>>

<script type="text/javascript">
	function findCheck() {
		if (find.bbsFindString.value == "") {
			alert("검색할 키워드를 입력하세요");
			find.bbsFindString.focus();
			return false;
		}//if-----
		document.find.submit();
	}//findCheck()-------------------
</script>

<%
	request.setCharacterEncoding("UTF-8");
	String type = request.getParameter("bbsFindType");
	String keyword = request.getParameter("bbsFindString");
	if (type == null || keyword == null || type.trim().equals("")
			|| keyword.trim().equals("")) {
		response.sendRedirect("../main.jsp?path=bbs_list");
		return;
	}//if------------------

	BbsManager mgr = BbsManager.getInstance();
	int totalGulCount = mgr.totalSearchGulCount(type, keyword);
	/* 페이징 처리를 위해 필요한 변수
		1> 페이지사이즈: pageSize ---ps[5개 또는 10개 
									단위로 보여주기.
		2> 총게시물수 : totalGulCount
		3> 현재 페이지: cpage ---cp[1,2 페이지 ...]
		4> 페이지수: pageCount                       
	 */
	String psStr = request.getParameter("ps");
	String cpStr = request.getParameter("cp");
	if (psStr == null || psStr.trim().equals("")) {
		psStr = "10";//페이지사이즈 기본값을 5로
	}
	if (cpStr == null || cpStr.trim().equals("")) {
		cpStr = "1";
		//디폴트: 현재 페이지를 10페이지로 지정
	}
	int pageSize = Integer.parseInt(psStr.trim());
	int cpage = Integer.parseInt(cpStr.trim());

	//페이지수 구하기
	//=총게시물수/페이지사이즈
	int pageCount = 0;
	/*if(totalGulCount % pageSize ==0){
		pageCount=totalGulCount/pageSize;
	}else{
		pageCount=totalGulCount/pageSize+1;
	}*/
	pageCount = (totalGulCount - 1) / pageSize + 1;

	//검색한 목록가져오기--각 페이지별로
	//제일 처음에는  처음의 검색 결과를 페이지크기만큼 가져올려면(만약 결과가 6개이면 1-5해서 5개 
	// 2개이면 1-2 해서 2개 추출 따라서 처음에는 목록상의 현재 페이지 2이상인경우도
	//rownum이 1번부터 페이지 크기만큼이므로 
	//1을 search()에 전달해야 하는데 cpage 가 현재 1이므로 상관 없다.
	ArrayList<BbsDTO> lst = mgr.search(type, keyword, cpage, pageSize);
%>

<table width=100% border=1>

	<td colspan="5" align="center">
		<hr width=500 color=#667788> <font size=4 color=navy> <b>WebPos
				공지사항</b>
	</font> <br> <a href="../form/main.jsp?path=bbs_write">글쓰기</a> | <a
		href="../form/main.jsp?path=bbs_list">목록보기</a>
		<hr width=500 color=#667788> <br>
	</td>
	<tr bgcolor=#c9c9c9>
		<th width=10%>순번</th>
		<th width=40%>제목</th>
		<th width=20%>글쓴이</th>
		<th width=20%>날짜</th>
		<th width=10%>조회수</th>
	</tr>
	<!-- --------------------------- -->
	<%
		if (lst == null || lst.size() == 0) {
			out.println("<tr><td colspan=5><b>");
			out.println("게시물이 없어요");
			out.println("</b></td></tr></table>");
			return;
		}//if--------------------
		for (BbsDTO dto : lst) {
			String idx = dto.getIdx();
			String subject = dto.getSubject();
			String writer = dto.getWriter();
			String writedate = dto.getWritedate().toString();
			int readnum = dto.getReadnum();
			String email = dto.getEmail();

			if (subject != null && subject.length() > 15) {
				subject = subject.substring(0, 15);
				subject += "...";
			}
			if (writer != null && writer.length() > 4) {
				writer = writer.substring(0, 4) + "...";
			}
	%>
	<tr align="center">
		<td><%=idx%></td>
		<td><a
			href="../form/main.jsp?path=bbs_content&idx=<%=idx%>&cp=<%=cpage%>&ps=<%=pageSize%>">
				<%=subject%>
		</a></td>
		<td><a href="mailto:<%=email%>"> <%=writer%>
		</a></td>
		<td><%=writedate%></td>
		<td><%=readnum%></td>
	</tr>
	<%
		}//for--------------------
	%>
	<!-- --------------------------- -->
	<tr>
		<td colspan=5 align=center>
			<hr width=100% color=#667788>
		</td>
	</tr>
	<tr>
		<td colspan=3 align=center>
			<%
				// 이전 페이지 링크--------
				if (cpage > 1) {
					//
					//이전의 검색 결과를 페이지크기만큼 가져올려면
					//rownum이cpage-1 번부터 페이지 크기만큼이므로 
					//cpage-1을 search()에 전달
			%> <a
			href="../form/main.jsp?path=bbs_search&cp=<%=cpage - 1%>&ps=<%=pageSize%>&bbsFindType=<%=type%>&bbsFindString=<%=keyword%>">
				◀◀◀ <--이전 </a> <%
 	}//if-------

 	//-------페이지------------
 	for (int i = 1; i <= pageCount; i++) {
 		if (i == cpage) {
 			out.println("<font color=blue>");
 			out.println("[" + i + "]");
 			out.println("</font>");
 		} else {
 %> <a
			href="../form/main.jsp?path=bbs_search&cp=<%=i%>&ps=<%=pageSize%>&bbsFindType=<%=type%>&bbsFindString=<%=keyword%>">
				[<%=i%>]
		</a> <%
 	}
 	}//for-------------

 	//이후 페이지 링크 걸기------
 	if (cpage < pageCount) {
 		//이후의 검색 결과를 페이지크기만큼 가져올려면
 		//rownum이cpage-1 번부터 페이지 크기만큼이므로 
 		//cpage-1을 search()에 전달
 %> <a
			href="../form/main.jsp?path=bbs_search&cp=<%=cpage + 1%>&ps=<%=pageSize%>&bbsFindType=<%=type%>&bbsFindString=<%=keyword%>">
				이후 ▶ --> </a> <%
 	}//if----------
 %>
		</td>
		<td colspan=2 align=center>총게시물수: <%=totalGulCount%></td>
	</tr>
</table>
<br>
<!-- 검색 ---------------------------- -->
<form name="find" action="main.jsp">
<table width="100%">
	<tr>
	<td align="right">
	<select name="bbsFindType">
		<option value="subject">제목</option>
		<option value="writer">글쓴이</option>
		<option value="content">글내용</option>
	</select> <input type=text size=20 name="bbsFindString">
		<input	type=button value="검색" onclick="findCheck();">
		<input type=hidden name=path value="bbs_search" ">
		</td>
		</tr>
</form>
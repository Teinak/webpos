<%@page import="notice.BbsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="notice.BbsManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%
	BbsManager mgr = BbsManager.getInstance();
		int totalGulCount = mgr.totalGulCount();

		String psStr = request.getParameter("ps");
		String cpStr = request.getParameter("cp");
		if (psStr == null || psStr.trim().equals("")) {
	psStr = "10";//페이지사이즈 기본값을 10로
		}
		if (cpStr == null || cpStr.trim().equals("")) {
	cpStr = "1";
	//디폴트: 현재 페이지를 1페이지로 지정
		}
		int pageSize = Integer.parseInt(psStr.trim());
		int cpage = Integer.parseInt(cpStr.trim());

		int pageCount = 0;
		pageCount = (int) Math.ceil((double) totalGulCount / pageSize); //13/5=3.0

		ArrayList<BbsDTO> lst = mgr.list(cpage, pageSize);
%>


<table width=100% border=1>
	<td colspan="5" align="center">
		<hr width=500 color=#667788> <font size=4 color=navy> 
		<b>WebPos 공지사항</b>
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
	<%
		if (lst == null || lst.size() == 0) { //1행1열의 테이블
	%>
		<tr onmouseover="this.style.backgroundColor='pink'"
		onmouseout="this.style.backgroundColor='white'"><td colspan=5><b>
	<%
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
		String email = dto.getEmail(); //작성자 링크 클릭할 때 이메일되도록 필요

		if (subject != null && subject.length() > 15) {
			subject = subject.substring(0, 15); //15자리수보다 크면 제목의 부분문자열로 출력
			subject += "...";
		}
		if (writer != null && writer.length() > 4) {
			writer = writer.substring(0, 4) + "...";
		}
	%>
	<td align=center><%=idx%></td>
	<td align=center>
		<%
			//레벨 수 만큼 들여쓰기(공백넣기)
							int lev = dto.getLev();
							for (int k = 0; k < lev; k++) {
								out.println("&nbsp;&nbsp;&nbsp;");
							}
							if (lev > 0) {//답글인경우
								out.println("-->");
							}
		%><!-- 글보기 페이지에 글번호와 cpage 와 pageSize 전달 --> <a
		href="../form/main.jsp?path=bbs_content&idx=<%=idx%>"><%=subject%></a>
	</td>
	<td align=center><%=writer%></td>
	<td align=center><%=writedate%></td>
	<td align=center><%=readnum%></td>
	</tr>
	<%
		}//for--------------------
	%>
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
			%> <a
			href="../form/main.jsp?path=bbs_list&cp=<%=cpage - 1%>&ps=<%=pageSize%>">
				◀◀◀ <--이전 </a> <%
 	}//if-------

     	//-------페이지 번호 목록으로 번호 직접 선택------------
     	for (int i = 1; i <= pageCount; i++) {
     		if (i == cpage) {
     			out.println("<font color=blue>");
     			out.println("[" + i + "]");
     			out.println("</font>");
     		} else {
 %> <a href="../form/main.jsp?path=bbs_list&cp=<%=i%>&ps=<%=pageSize%>">
				[<%=i%>]
		</a> <%
 	}
     	}//for-------------

     	//이후 페이지 링크 걸기------
     	if (cpage < pageCount) {//현재페이지번호가 전체페이지수보다 작다는 것은 다음페이지가 존재
 %> <a
			href="../form/main.jsp?path=bbs_list&cp=<%=cpage + 1%>&ps=<%=pageSize%>">
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
	<input type=button value="검색" onclick="findCheck();">
	<input type=hidden name=path value="bbs_search">
	</td>
	</tr>
	</table>
</form>

<!-- ------------------------------------ -->
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

<%@page import="notice.BbsDTO"%>
<%@page import="notice.BbsManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<script type="text/javascript">
	function editCheck() {
		if (edit.pwd.value == "") {
			alert("비밀번호를 입력해야 합니다.");
			edit.pwd.focus();
			return false;
		}//if---------
		document.edit.submit();
	}//editCheck()----------
</script>

	<%
		String idx = request.getParameter("idx");
		if (idx == null || idx.trim().equals("")) {
			response.sendRedirect("bbs_list.jsp");
			return;
		}//if----------
		idx = idx.trim();
		String cpage = request.getParameter("cp");
		String pageSize = request.getParameter("ps");
		BbsManager mgr = BbsManager.getInstance();
		BbsDTO dto = mgr.edit(idx);
		if (dto == null) { 
			out.println("서버 오류");
			out.println("<br><a href='bbs_list.jsp'>목록</a>");
			return;
		}//if----------
	%>

	<hr width=500 color=#667788>
	<font size=4 color=navy> <center><b>WebPos 공지사항 수정</b></center>
	</font>
	<!-- 
	<a href="../main.jsp">HOME</a>|
	<a href="bbs_write.jsp">글쓰기</a> -->
	<hr width=500 color=#667788>
	<br>
	<!-- form 시작  순번과 같은 몇개 항목은 단지 보여주고 
글쓴이, 홈페이지,비밀번호,제목,글내용,이메일(이 예제에는 빠져있음) 항목만 편집 가능하게끔-- -->
	<!-- 파일 전송을 수정하지 못하므오 bbs_editOk.jsp에서는 request 객체를 가지고 편집
  편집삭제시 비밀번호 입력밭다 일치여부 체크함-->
	<form name="edit" action="../features/bbs_editOk.jsp" method="POST">
		<input type="hidden" name="cp" value="<%=cpage%>"> <input
			type="hidden" name="ps" value="<%=pageSize%>">
		<table width=100% border=1>
			<tr>
				<td width=20% align=center class="m1"><b>순번</b></td>
				<td width=30%><input type=text name="idx"
					value="<%=dto.getIdx()%>" readonly></td>
				<td width=20% align=center class="m1"><b>작성일</b></td>
				<td width=30%><input type=text name="writedate"
					value="<%=dto.getWritedate()%>" readonly></td>
			</tr>
			<tr>
				<td width=20% align=center class="m1"><b>글쓴이</b></td>
				<td><input type=text name="writer" value="<%=dto.getWriter()%>">
				</td>
			
				<td width=20% class="m1"><b>비밀번호</b></td>
				<td width=30%><input type=password name="pwd"></td>
			</tr>
			<tr>
				<td width=20% align=center class="m1"><b>제목</b></td>
				<td colspan=3><input type=text name="subject"
					value="<%=dto.getSubject()%>" size=40></td>
			</tr>
			<tr height=100>
				<td width=20% align=center class="m1"><b>글내용</b></td>
				<td colspan=3><textarea rows="7" cols="50" name="content"><%=dto.getContent()%></textarea>
				</td>
			</tr>
			<tr class="m1">
				<td colspan=4 align=center><input type=button value="수정하기" onclick="editCheck();"></td>
			</tr>
			<tr class="m2">
				<td colspan=4 align=center>
				<a href="../form/main.jsp?path=bbs_list&cp=<%=cpage%>&ps=<%=pageSize%>">목록</a>| 
				<%-- <a href="../form/main.jsp?path=bbs_edit&idx=<%=dto.getIdx()%>&cp=<%=cpage%>&ps=<%=pageSize%>">편집</a>| --%>
				<a href="../form/main.jsp?path=bbs_delete&idx=<%=dto.getIdx()%>&cp=<%=cpage%>&ps=<%=pageSize%>">삭제</a>
				<!-- <a href="">답변</a></td> -->
			</tr>
		</table>

	</form>
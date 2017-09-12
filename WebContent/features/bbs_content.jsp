<%@page import="notice.ReplyDTO"%>
<%@page import="notice.BbsDTO"%>
<%@page import="notice.BbsManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<script type="text/javascript">
	function reply_del(no) {
		//alert(document.getElementById("p"+no).value);

		if (!document.getElementById("p" + no).value) { //if(document.delPwd.value){ //1차 버전으로 오류
			alert('비밀번호 입력하세요');
			document.getElementById("p" + no).focus();
			return false;
		}
		//document.replyDel.delPwd.value=document.getElementById("p"+no).value; //1차버전 
		//이러케 하면 첫번째 답글의 비밀번호는 reply_deleteOk.jsp넘어가지만 두번째 글부터는 반복문때문에 delPwd 이름 인식 못하는 듯하여 비번은 잘 안넘어감
		// 비번 폼컨트롤 을 반복문바깥으로  빼고(delPwd2) 그 값은 스크립트 코드에서 할당 no도 마찬가지임(no2 폼컨트롤만들자)
		document.replyDel.delPwd2.value = document.getElementById("p" + no).value;
		document.replyDel.no2.value = no;

		document.replyDel.submit();
	}

	function reply_check() {
		if (reply.reply_writer.value == "" || reply.reply_content.value == ""
				|| reply.reply_pwd.value == "") {
			alert("리플 내용,작성자,비밀번호를 \n모두 입력해야 합니다.");
			return false;
		}//if------
		document.reply.submit();
	}
</script>
<%
	String idx = request.getParameter("idx");
	if (idx == null || idx.trim().equals("")) {
		response.sendRedirect("bbs_list.jsp");
		return;
	}//if-------------------
	idx = idx.trim();

	String cpage = request.getParameter("cp");
	String pageSize = request.getParameter("ps");
	if (cpage == null || cpage.trim().equals("")) {
		cpage = "1";
	}
	if (pageSize == null || pageSize.trim().equals("")) {
		pageSize = "10";
	}

	BbsManager mgr = BbsManager.getInstance();
	boolean res = mgr.getReadnum(idx);
	if (res)
		System.out.println("조회수 증가 성공");

	//글 내용 가져오기
	BbsDTO dto = mgr.content(idx);
	if (dto == null) {
		response.sendRedirect("bbs_list.jsp");
		return;
	}//if--------------
%>

<table width="100%" border=1>
	<tr>
		<td colspan="4" align="center">
			<hr width=500 color=#667788> <font size=4 color=navy> <b>WebPos
					공지사항</b>
				<hr width=500 color=#667788> <br>
		</td>
	</tr>

	<tr>
		<td width=20% align=center class="m1"><b>순번</b></td>
		<td width=30%><%=idx%></td>
		<td width=20% align=center class="m1"><b>작성일</b></td>
		<td width=30%><%=dto.getWritedate()%></td>
	</tr>
	<tr>
		<td width=20% align=center class="m1"><b>글쓴이</b></td>
		<td><%=dto.getWriter()%></td>
		<td width=20% align=center class="m1"><b>조회수</b></td>
		<td><%=dto.getReadnum()%></td>
	</tr>
	<tr>
		<td width=20% align=center class="m1"><b>제목</b></td>
		<td colspan=3><%=dto.getSubject()%></td>
	</tr>
	<tr height=100>
		<td width=20% align=center class="m1"><b>글내용</b></td>
		<td colspan=3>
			<%
				String content = dto.getContent();
				if (content != null) { //개행문자 -> <br>
					content = content.replaceAll("\n", "<br>");
				}
				out.println(content);
			%>
		</td>
	</tr>
	<tr>
		<td colspan=4 align=center>
			<!-- 글읽기한 후에 목록은 직전에 잃었던 목록 페이지로 이동하기 위하여 다음처럼 목록페이지에서 받은 cpage와 pageSize%재전달 -->
			<a
			href="../form/main.jsp?path=bbs_list&cp=<%=cpage%>&ps=<%=pageSize%>">목록</a>|
			<a
			href="../form/main.jsp?path=bbs_edit&idx=<%=idx%>&cp=<%=cpage%>&ps=<%=pageSize%>">수정</a>|
			<a
			href="../form/main.jsp?path=bbs_delete&idx=<%=idx%>&cp=<%=cpage%>&ps=<%=pageSize%>">삭제</a>
			<!--  idx번호 글에 대한 답글을 단 후에 cpage로 돌아갈 수 있고  pageSize를 유지하며 제목을 전달하기 위하여 쿼리스트링 구성
		쿼리스트링이 복자바하면 폼을 만든후에 히든으로 파라미터 설정하고  href은 #으로 하고자바스크립트에서 onclick하면 submit하게끔 함수 정의
		-->
		</td>
	</tr>
</table>
<!-- 꼬리글 달기 폼,테이블2행 2열) 구조  
	1행: 제목
	2행:1열(작성자<br>,내용(텍스트에어리어)) 2열(패스워드입력,등록버튼)  =============--- -->

<form name="reply" action="../features/bbs_replyOk.jsp" method="POST">

	<table border="1" width="100%">
		<tr class="m1">
			<td colspan="2" align="center">R E P L Y 쓰기</td>
		</tr>
		<tr>
			<td>작성자:<input type=text name="reply_writer"><br>
				내&nbsp;&nbsp;용: <textarea name="reply_content" rows=2 cols=50></textarea></td>
			<td align="right">
				password: 
				<input type=password name="reply_pwd" size=4> <input type=button value="등록" onclick="reply_check()"> 
				<input type="hidden" name="idx_fk" value="<%=idx%>"> 
				<!-- replySave() 넘겨줄 원글의 idx --> <!-- hidden data ------------------- -->
			</td>
		</tr>
	</table>
</form>

<!-- =================================== -->
<!-- 꼬리글 목록 폼, 테이블(2행 2열)   
	1행: 제목
	2행:1열(작성자,내용,작성일) 2열(삭제할 패스워드,링크) : 2행이 꼬리글 수 만큼 반복 출력됨
	
	삭제폼이 리스팅양식과 섞여잇음
	============= -->
<form action="../features/bbs_reply_deleteOk.jsp" method="POST" name="replyDel">
	<!--  원래 1차 버전에는 이 폼태그가 아래 내용(<td width=15% class="m3">)다음의 주석 위치함
		  헌데  for에 의해 꼬리말의 폼이  여러개 반복 출력되는 경우(즉 꼬리말이 여러개임. 소스보기하면 꼬리말들의 해당 
		  폼태그가 반복출력)  reply_del(no)자바스크립트 함수에서 폼태그 name 속성으로 처리하면 동일한 폼태그 속성이 반복적으로 
		  그리고 입력태그 name 속성도  여러개 출력(소스보기확인) 따라서 어떤 폼의 태그를 사용할지 웹브라우저가 인식이 애매모호해져서
		   삭제링크 클릭해도  삭제안됨  (삭제스크립트 실행안됨)
		  name 속성의 해결책은 id로 구분 -->

	<table width=100% border="1" class="outline">
		<tr>
			<td colspan="2" align="center">REPLY LIST</td>
		</tr>
		<%
			java.util.ArrayList<ReplyDTO> replyArr = mgr.replyList(idx);
			if (replyArr == null || replyArr.size() == 0) {
				out.println("<tr><td colspan=2>");
				out.println("게시 목록 없어요");
				out.println("</td></tr>");
				//return; // if else없이  이것만 잇으면 처음에 게시 목록이 없는 경우 글쓰기 안됨(자바스크립트코드가 뒤에 위치 )
				//아마 "reply_check() 가 뒤에 잇어서 service() 를 빠져나가므로 등록버튼을 눌러도 스크립트가 
				// 인식안되는 듯 따아서 if else절로 분기해야함 (즉 return 문장대신에 else로 대체)

			} else {
				for (ReplyDTO rdto : replyArr) {
		%>
		
		<tr algin=left>
			<td width=70% class="m3">[<%=rdto.getWriter()%>]: <%=rdto.getContent()%><br>
				작성일:<%=rdto.getWritedate().toString()%>
			</td>
			<td width=30% class="m3" align="right">
				<!--  <form action="reply_deleteOk.jsp" method="POST" name="replyDel"> 삭제폼 1차버전으로 for루프 바깥으로 빼야 됨(이유는 뺀곳에서 설명) -->
				<input type="hidden" name="no" value="<%=rdto.getNo()%>"> <!-- 삭제할 해당 댓글 번호  rdto.getNo()로 no값 세팅하는 용도 -->
				<input type="hidden" name="idx" value="<%=idx%>"> <!-- 속해잇는 부모글 번호로 댓글 삭제시의 부모글번호는 문제있을때  다시 부모글페이지로 돌아오기 위한 요청파라미터로 사용  --> 
				password 
				<input type=password name="delPwd" size=4 id="p<%=rdto.getNo()%>"> <!-- id 속성값으로 고유 식별값 :  p + 글번호 , rdto.getNo()로 no값 세팅및 화면출력 용도 -->
						[ <a href="#" onclick="javascript:reply_del('<%=rdto.getNo()%>');"> <!-- 삭제할 댓글번호 no --> 삭제 </a> ] 
						<!-- </form>  1차버전으로 아래의 table태그 다음로 이동  -->
					
				<input type="hidden" name="delPwd2">
				<!-- 이런식으로 반복문 밖으로 빼자 실전송 용도-->
				<input type="hidden" name="no2">
				<!-- 이런식으로 반복문 밖으로 빼자   실전송 용도-->
			</td>
		</tr>
		<%
			}//for----------------			
			}//else-----------------
		%>
	</table>
</form>



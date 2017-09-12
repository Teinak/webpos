<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<script type="text/javascript">
	function check(){
		if(!bbs.subject.value){
			alert("제목을 입력하세요");
			bbs.subject.focus();		
			return false;
		}
		if(!bbs.writer.value){
			alert("이름을 입력하세요");
			bbs.writer.focus();
			return false;
		}
		if(!bbs.pwd.value){
			alert("비밀번호를 입력하세요");
			bbs.pwd.focus();
			return false;
		}
		if(!bbs.content.value){
			alert("글내용을 입력하세요");
			bbs.content.focus();
			return false;
		}
		document.bbs.submit();
	}
</script>

	<!-- form시작 ----------- -->
<form name="bbs" action="../features/bbs_writeOK.jsp" method="POST">
	 
	<TABLE width=100% border=2 class=outline>
	<tr>
		<td colspan="4" align="center">
			<hr width=500 color=#667788> <font size=4 color=navy> <b>WebPos
					공지사항</b>
		</font> <br> <a href="../form/main.jsp?path=bbs_list">목록보기</a>
			<hr width=500 color=#667788> <br>
		</td>
	</tr>
	
	<tr>
	<td width="20%" align="center">제목</td>
	<td width="70%" align="left">
	<input type=text name="subject" size=40>
	</td>
	</tr>
	<tr>
	<td width="20%" align="center">글쓴이</td>
	<td width="80%" align="left">
	<input type=text name="writer" size=40 value="${empName}">
	</td>
	</tr>
	
	<tr>
	<td width="20%" align="center">이메일</td>
	<td width="80%" align="left">
	<input type=text name="email" size=40>
	</td>
	</tr>
	<tr>
	<td width="20%" align="center">글내용</td>
	<td width="80%" align="left">
	<textarea rows="10" cols="50" name="content"></textarea>
	</td>
	</tr>
	<tr>
	<td width="20%" align="center">비밀번호</td>
	<td width="80%" align="left">
	<input type=password name="pwd" size=20>
	</td>
	</tr>
	<tr>
		<td colspan=2 align="center">
	<input type=button value="글쓰기" onclick="check();">
	<input type=reset value="다시 쓰기">	
		</td>
	</tr>
	
	</TABLE>
</form>
<!-- form end--------------- -->
	
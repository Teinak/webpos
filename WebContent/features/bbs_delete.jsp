<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<script type="text/javascript">
<!--
	function delCheck() {
		if (del.pwd.value == "") {
			alert("비밀번호를 입력해야 합니다.");
			del.pwd.focus();
			return false;
		}//if-----------
		if (del.pwd.value.length > 8) {
			alert("비밀번호는 8자리 이내입니다.");
			del.pwd.select();
			return false;
		}//if-------------
		document.del.submit();

	}//delCheck()------------------------
//-->
</script>

	<%
		//삭제할 글번호 받기
		String idx = request.getParameter("idx");
		if (idx == null || idx.trim().equals("")) {
	%>
	<script type="text/javascript">
		alert("잘못 들어온 경로입니다.");
		history.back();
	</script>
	<%
		return;
		}//if-----------------
		idx = idx.trim();
		String cpage = request.getParameter("cp");
		String pageSize = request.getParameter("ps");
	%>
	<form name="del" method="POST" action="../features/bbs_deleteOk.jsp">
		<center>
			<hr width=500 color=green>
			비밀번호: <input type="password" name="pwd"> <input type="hidden"
				name="idx" value="<%=idx%>"> <input type="hidden" name="cp"
				value="<%=cpage%>"> <input type="hidden" name="ps"
				value="<%=pageSize%>">
			<hr width=500 color=green>
			<input type="button" value="삭제" onclick="delCheck();"> <input
				type="reset" value="다시">
			<hr width=500 color=green>
		</center>
	</form>
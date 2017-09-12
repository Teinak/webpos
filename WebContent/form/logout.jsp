<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%session.invalidate();%> <!-- 로그아웃 -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>webPOS_logout</title>
<link href="<%=request.getContextPath()%>/sub/pos_style.css"
	rel="stylesheet" type="text/css">
</head>
<body>
<div style="margin-top:150px;">
	<table border="1" width="600" height="400" align="center">
		<tr align="center" height="20%">
			<td><h1>Logout</h1></td>
		</tr>
		<tr align="center" height="80%">
			<td>정상적으로 로그아웃 되었습니다.<br> 이용해 주셔서 감사합니다.<p>
			<a href="../index.jsp">홈으로</a>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
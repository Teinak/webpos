<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome to webPOS</title>
<link href="<%=request.getContextPath()%>/sub/pos_style.css" rel="stylesheet" type="text/css">
<style type="text/css">
#ee {
	width:100%;
	height:100%;
	background: url(sub/media/index.png) no-repeat 50% 100%;
}
</style>
</head>
<body>
<div id="ee" style="height: 600px; margin-top: 150px;">
	
	<div style="padding-left:400px;padding-top:420px;">
	<table align="center">

		<tr height="30%">
			<td align="right">

				<form name="login_form" action="form/login_proc.jsp" method="post">
					<table>
						<tr>
							<td>회원아이디</td>

							<td rowspan="2"><input type="text" name="emp_id"> <br> 
							<input type="password" name="emp_pwd">
							</td>

							<td rowspan="2">
							<input type="image" style="width: 50px; height: 45px" src="<%=request.getContextPath()%>/images/login_btn.png">
							</td>
						</tr>
						<tr>
							<td>비밀번호</td>
						</tr>
						<tr align="right">
							<td colspan="3"><a href="features/emp_register.jsp">사원가입</a></td>
						</tr>
						
					</table>
				</form>

			</td>
		</tr>

	</table>
	
	</div>
</div>
</body>
</html>
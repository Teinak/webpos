<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/sub/pos_style.css"
	rel="stylesheet" type="text/css">
	
<script language="JavaScript" src="../sub/script.js"></script>
</head>

<body>
<pre>
<!--중간 사이용 -->







</pre>
<h1 align="center">회원가입 양식</h1>


<FORM name="join" ACTION="emp_User.jsp"  METHOD="POST" onsubmit="return chk_frm()">
<table border="1"align="center">
<tr>
<td >ID</td>
<td> <input type="text" name="emp_id" maxlength="14" >
<input type="button" value="ID중복확인" onClick="idCheck(this.form.emp_id.value)"> </td>
</tr>

<tr>
<td >PW</td>
<td><input type="password" name="emp_pwd" size="20" ></td>
</tr>

 <tr>
<td >PW 확인</td>
<td><input type="password" name="emp_pwd2" size="20"></td>
</tr> 

<tr>
<td>이름</td>
<td><input type="text" name="emp_name"></td>
</tr>

<tr>
<td >핸드폰 번호</td>
<td>
<input type="text" name="emp_tel" maxlength="14" size="14">(-은 생략해주세요 )

</td>
</tr>
 
<tr>
<td >주소</td>
<td><input type="text" name="emp_addr"size="50"></td>
</tr>

<tr>
<td >이메일</td>
<td> <input type="text"name="emp_email" size="50"></td>
</tr>

<tr>
<td >홈페이지</td>
<td> <input type="text"name="emp_homepage" size="50"></td>
</tr>

<tr>
<td >INFO</td>
<td> <textarea rows="5" cols="40" name="emp_info"></textarea>
</td>
</tr>

<tr>
<td>파일올리기</td>
<td><input type="file">
</tr>

<tr>
<td colspan="2" align="center">
<input  type="submit" value="확인" name="ok" >
<input type="reset" value="다시쓰기">
</td>
</tr>

</table>
</FORM>

</body>
</html>
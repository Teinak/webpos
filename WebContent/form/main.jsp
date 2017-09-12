<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="emp.*,pos.*"%>

<%
	//세션키 없으면 로그인 화면으로 넘김
	if(session.getAttribute("idKey") == null) {
		response.sendRedirect("../index.jsp");
	}else{
%>	

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Welcome to webPOS</title>
<link href="<%=request.getContextPath()%>/sub/pos_style.css" rel="stylesheet" type="text/css">
<style type="text/css">

body {
	font-size: 12px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	color:#2C2C2C;
	background-color:#FFFFFF;
}

/* 글자색 */

p, span, li, a, td, th, tf{color:#2C2C2C;}

a, ul li {color:rgb(34, 74, 172); text-decoration:none}

a:hover { color:rgb(34, 74, 172); text-decoration:underline; }

/* 최하단 레이어 */

#holder{
	width:100%;
	height:100%;
	background: #ccc url(../sub/media/bg_test2.jpg) repeat-y 50% 0%;
	z-index:20;
}

#mini_buttons{
	width:100%;
	height:36px;
	background: #ccc url(../sub/media/header.jpg) repeat-x 50% 0%;
	z-index:20;
}

#header{
	width:1230px;
	margin: 0 auto;
	height:170px;
	clear:both;
	background-image:url(../sub/media/mytheme.png);
	position:relative;
}

#line{
	display:none;
	width:100%;
	height:5px;
	line-height:5px;
	background: #ccc url(../sub/media/line_med.jpg) repeat-y 50% 0%;
	clear:both;
}

#content{
	width:1200px;;
	min-height:auto;
	margin: 0 auto;
	background-color:#FFFFFF;
	position:relative;
	overflow:auto;
	padding: 15px;
	z-index:10;
}

#footer{
	width:100%;
	height:100%;
	background: #ccc url(../sub/media/footer.jpg) repeat-x 50% 0%;
	z-index:20;
}

/* 중단 레이어 */

#head{
	width:1024px;
	height:25px;
	margin: 0 auto;
	padding-left: 25px;
	color: rgb(255, 255, 255);
	vertical-align : middle;
	font-size: 12pt;"
}

#footline{
	width:1024px;
	height:25px;
	margin: 0 auto;
}


/* 메인 버튼 */

#buttonholder{
	width:1230px;
	height:auto;
	position:absolute;
	bottom: 0px;
	background-image:url(../sub/media/menubar.png);
	padding-top:11px;
	height:29px;
	z-index:20;
}


</style>

<title>Welcome to webPOS</title>

<script src="js/global.js" type="../sub/js/javascript"></script>
<link rel="stylesheet" href="../sub/css/global.css" type="text/css" />
<link rel="stylesheet" href="../sub/css/MenuTemplate.css" type="text/css" />
<link rel="stylesheet" href="../sub/css/EditorTemplates.css" type="text/css" />
<link rel="stylesheet" href="../sub/css/Styles.css" type="text/css" />
<link rel="stylesheet" href="../sub/css/ButtonTemplates.css" type="text/css" />


</head>
<body>
	<%
		/* EmpTimer et = new EmpTimer();
		Thread t = new Thread(et);
		t.start(); */
		/* 
		try {
			(new SerialSample()).connect("COM3");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		 */
	%>
	<div id="holder">
		<div id="mini_buttons">
			<div id="head">
				<table width="100%">
					<tr style="vertical-align: middle;">
						<td style="color: rgb(255, 255, 255); vertical-align: middle; font-size: 12pt">
							<center>
								<%@include file="top.jsp"%>
							</center>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="header">
			<div id="buttonholder">
				<ul class="ewpmenu horizontal">
					<%@include file="menu.jsp"%>
				</ul>
			</div>
		</div>
		<div id="line">
			<!-- 분리선임(안보임) -->
		</div>
		<div id="content" style="height: 600px">
			<%
					request.setCharacterEncoding("euc-kr");
					String cp = request.getParameter("path");
					if (cp == null) {
						cp = "bbs_list";
					}

					pageContext.include("../features/" + cp + ".jsp");
				%>				
		</div>
		<div id="footer">
			<div id="footline">
				<table width="100%">
					<tr>
						<td style="font-size:7pt; color: rgb(34, 74, 172); vertical-align:middle;">
						<center>
							2013 Project Team ** Inc. Trademarks belong to their respective owners. All rights reserved.
						</center>
					</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	&nbsp;

</body>
</html>
<%}%>
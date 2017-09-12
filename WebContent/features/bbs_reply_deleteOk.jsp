<%@page import="notice.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!--reply_deleteOk.jsp-->
<%
	String pwd=request.getParameter("delPwd2"); //String pwd=request.getParameter("delPwd"); 1차 버전
	String idx_fk=request.getParameter("idx");
	String no=request.getParameter("no2");
	out.println("idx_fk: "+idx_fk+", pwd: "+pwd);
	out.println("no: "+no);
	if(pwd==null||idx_fk==null||no==null||
			pwd.trim().equals("")||
			idx_fk.trim().equals("")||
			no.trim().equals("")){
		%>
		<script type="text/javascript">
		<!--
			history.back();
		//-->
		</script>		
		<%
		return;
	}//if---------------
	pwd=pwd.trim();
	idx_fk=idx_fk.trim();
	no=no.trim();
	
	///////////////
	BbsManager mgr=BbsManager.getInstance();
	int result=mgr.replyDelete(no,pwd); 
	String msg="", url="";
	if(result>0){
		msg="꼬리글 삭제 성공!"; 
	}else{ //가령 result=0인경우 비밀번호를 확인
		msg="꼬리글 삭제 실패!\\n비밀번호를 확인하세요"; //자바스크립트에 \를 인식시키기 위해 \한번 더 추가
	}
	url="../form/main.jsp?path=bbs_content&idx="+idx_fk; //댓글달 부모글의 내용페이지로
	request.setAttribute("bbs_msg",msg);
	request.setAttribute("bbs_url",url);
%>
<jsp:forward page="bbs_msg.jsp"/>













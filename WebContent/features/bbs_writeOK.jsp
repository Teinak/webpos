<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="sub.DBConnectMgr"%>
<%@page import="java.sql.Connection"%>
<%@page import="notice.BbsManager"%>

<%	
	request.setCharacterEncoding("UTF-8");

	String msg="", url=""; 
	try{
	
	BbsManager mgr=BbsManager.getInstance();	
	int result=mgr.writeOk(request);
	
	if(result>0){
		msg="글쓰기 성공!";
		url="../form/main.jsp?path=bbs_list";
	}else{
		msg="글쓰기 실패!";
		url="../form/main.jsp?path=bbs_write";			
	}
	}catch(Exception e){
		e.printStackTrace();
	}
	request.setAttribute("bbs_msg",msg);
	request.setAttribute("bbs_url",url);
%>
	<jsp:forward page="bbs_msg.jsp" />

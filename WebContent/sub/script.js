function chk_frm() {
		if (!document.join.emp_id.value) {
			window.alert('아이디를 입력하세요.');
			document.join.emp_id.focus();
			return false;
			}
		if (!document.join.emp_pwd.value) {
			window.alert('비밀번호를 입력하세요.');
			document.join.emp_pwd.focus();
			return false;
			}
		if (!document.join.emp_pwd2.value) {
			window.alert('비밀번호를 입력하세요.');
			document.join.emp_pwd2.focus();
			return false;
			}
		/*if(document.join.emp_pwd.value != document.join.emp_pwd2.value) {
			window.alert("비밀번호를 다시확인해주세요.");
			document.reg.emp_pwd.focus();
			return false;
		}*/
		        if (document.join.emp_pwd.value != document.join.emp_pwd2.value) {
				window.alert("비밀번호를 다시확인해주세요.");
				document.join.emp_pwd.value = "";
				document.join.emp_pwd2.value = "";
				document.join.emp_pwd.focus();
				return false;	
			}
		if (!document.join.emp_name.value) {
			window.alert('이름을 입력하세요.');
			document.join.emp_name.focus();
			return false;
			}
		if (!document.join.emp_tel.value) {
			window.alert('전화번호를 입력하세요.');
			document.join.emp_tel.focus();
			return false;
			}
		if (!document.join.emp_addr.value) {
			window.alert('주소를 입력해주세요.');
			document.join.emp_addr.focus();
			return false;
			}
		if (!document.join.emp_email.value) {
			window.alert('이메일을 입력하세요.');
			document.join.emp_email.focus();
			return false;
			}
		if (!document.join.emp_homepage.value) {
			window.alert('홈페이지를 입력해주세요.');
			document.join.emp_homepage.focus();
			return false;
			}
		if (!document.join.emp_info.value) {
			window.alert('info를 입력해주세요.');
			document.join.emp_info.focus();
			return false;
			}
		
	}
    function idCheck(emp_id){
    
	if(emp_id == ""){
		alert("아이디를 입력해 주세요.");
		document.join.emp_id.focus();
	}else{
		url="emp_IdCheck.jsp?emp_id=" + emp_id;
		window.open(url,"post","width=300,height=150");
	}
    }
	function ok(확인){
	if (확인){
		url="IdCheck.jsp?emp_id=";
		window.open(url,"post","width=300,height=150");
		
		
	}
    }
	

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
	/*
	 * if(document.join.emp_pwd.value != document.join.emp_pwd2.value) {
	 * window.alert("비밀번호를 다시확인해주세요."); document.reg.emp_pwd.focus(); return
	 * false; }
	 */
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
		window.alert('E-mail을 입력하세요.');
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

function change() {
	val = document.cate_form.g_cate.value;
	val2 = document.cate_form.g_cate.selectedIndex;
	document.g_cate_form.gno.value = val;
	document.g_cate_form.gindex.value = val2;
	document.g_cate_form.submit();
}

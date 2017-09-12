package emp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import sub.DBConnectMgr;

public class EmpMgr {

	// 로그인 함수
	public EmpBean loginCheck(String emp_id, String emp_pwd)
			throws SQLException {

		// pool을 바꿨으므로 확인 바람
		Connection con = DBConnectMgr.ds.getConnection(); // sub/DBConnectMgr클래스에
															// static으로 선언된
															// ds객체를 통해
															// Connection() 생성

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean loginCon = false;
		EmpBean ebean = new EmpBean();
		try {
			String strQuery = "select emp_no, emp_name, fk_grade_id from emp where emp_id = ? and emp_pwd = ?";
			pstmt = con.prepareStatement(strQuery);
			pstmt.setString(1, emp_id);
			pstmt.setString(2, emp_pwd);
			rs = pstmt.executeQuery();
			loginCon = rs.next();
			if (loginCon) {
				ebean.setEmp_no(rs.getInt("emp_no"));
				ebean.setEmp_name(rs.getString("emp_name"));
				ebean.setFk_grade_id(rs.getString("fk_grade_id"));
			}
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		} finally {
			// 반드시 닫아주자 부족하면 이클립스의 톰켓 점점버벅거림
			if (pstmt != null)
				pstmt.close(); // 자원반납 (PreparedStatement)
			if (rs != null)
				rs.close(); // 자원반납 (ResultSet)
			if (con != null)
				con.close(); // 자원반납 (Connection)
		}
		return ebean;
	}

	public boolean userInsert(EmpBean userbean) throws SQLException {// 회원가입할때
																		// 인설트
																		// 시켜주는문
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement pstmt = null;
		boolean emp_reg = false;
		try {

			String strQuery = "insert into emp(EMP_NO,EMP_ID,EMP_PWD,EMP_NAME"
					+ ",EMP_TEL,EMP_ADDR,EMP_EMAIL,EMP_HOMEPAGE,EMP_INFO,EMP_DATE,FK_GRADE_ID) values(emp_seq.nextval,?,?,?,?,?,?,?,?,to_char(sysdate, 'YY/MM/DD'),'2')";
			pstmt = con.prepareStatement(strQuery);
			pstmt.setString(1, userbean.getEmp_id());
			pstmt.setString(2, userbean.getEmp_pwd());
			pstmt.setString(3, userbean.getEmp_name());
			pstmt.setString(4, userbean.getEmp_tel());
			pstmt.setString(5, userbean.getEmp_addr());
			pstmt.setString(6, userbean.getEmp_email());
			pstmt.setString(7, userbean.getEmp_homepage());
			pstmt.setString(8, userbean.getEmp_info());

			int count = pstmt.executeUpdate();

			if (count == 1) {
				emp_reg = true;
			}

		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
		return emp_reg;
	}

	public boolean userUpdate(EmpBean userbean) throws SQLException {// 회원수정
																		// 업데이트
																		// 문 ..
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement pstmt = null;
		boolean emp_reg1 = false;
		try {

			String strQuery = "update emp set EMP_PWD=?, EMP_NAME=?, EMP_TEL =?,EMP_ADDR=?, EMP_EMAIL=?,EMP_HOMEPAGE=?,EMP_INFO=?";
			strQuery = strQuery + " where EMP_ID=? ";

			pstmt = con.prepareStatement(strQuery);
			pstmt.setString(1, userbean.getEmp_pwd());
			pstmt.setString(2, userbean.getEmp_name());
			pstmt.setString(3, userbean.getEmp_tel());
			pstmt.setString(4, userbean.getEmp_addr());
			pstmt.setString(5, userbean.getEmp_email());
			pstmt.setString(6, userbean.getEmp_homepage());
			pstmt.setString(7, userbean.getEmp_info());
			pstmt.setString(8, userbean.getEmp_id());
			int count = pstmt.executeUpdate();
			if (count == 1) {
				emp_reg1 = true;
			}
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
		return emp_reg1;
	}

	public boolean adminUpdate(EmpBean userbean) throws SQLException {// admin
																		// 업데이트
																		// 문 ...
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement pstmt = null;
		boolean emp_reg1 = false;
		try {

			String strQuery = "update emp set EMP_PWD=?, EMP_NAME=?, EMP_TEL =?,EMP_ADDR=?, EMP_EMAIL=?,EMP_HOMEPAGE=?,EMP_INFO=?, FK_GRADE_ID=?";
			strQuery = strQuery + " where EMP_NO=? ";

			pstmt = con.prepareStatement(strQuery);
			pstmt.setString(1, userbean.getEmp_pwd());
			pstmt.setString(2, userbean.getEmp_name());
			pstmt.setString(3, userbean.getEmp_tel());
			pstmt.setString(4, userbean.getEmp_addr());
			pstmt.setString(5, userbean.getEmp_email());
			pstmt.setString(6, userbean.getEmp_homepage());
			pstmt.setString(7, userbean.getEmp_info());
			pstmt.setString(8, userbean.getFk_grade_id());
			pstmt.setInt(9, userbean.getEmp_no());
			int count = pstmt.executeUpdate();
			if (count == 1) {
				emp_reg1 = true;
			}
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		}
		return emp_reg1;
	}

	public EmpBean getMember(String emp_id) throws SQLException { // 회원 수정할때 -
																	// 받아오는문
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		EmpBean userbean = null;

		try {

			String strQuery = "select * from emp where emp_id=?";
			pstmt = con.prepareStatement(strQuery);
			pstmt.setString(1, emp_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				userbean = new EmpBean();
				userbean.setEmp_id(rs.getString("emp_id"));
				userbean.setEmp_pwd(rs.getString("emp_pwd"));
				userbean.setEmp_name(rs.getString("emp_name"));
				userbean.setEmp_tel(rs.getString("emp_tel"));
				userbean.setEmp_addr(rs.getString("emp_addr"));
				userbean.setEmp_email(rs.getString("emp_email"));
				userbean.setEmp_homepage(rs.getString("emp_homepage"));
				userbean.setEmp_info(rs.getString("emp_info"));

			}
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (rs != null)
				rs.close(); // 자원반납 (ResultSet)
			if (con != null)
				con.close();
		}
		return userbean;
	}

	public EmpBean admingetMember(int eno) throws SQLException { // 회원
																	// 수정할때
																	// -
																	// 받아오는문
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		EmpBean userbean = null;

		try {

			String strQuery = "select * from emp where emp_no=?";
			pstmt = con.prepareStatement(strQuery);
			pstmt.setInt(1, eno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				userbean = new EmpBean();
				userbean.setEmp_no(rs.getInt("emp_no"));
				userbean.setEmp_id(rs.getString("emp_id"));
				userbean.setEmp_pwd(rs.getString("emp_pwd"));
				userbean.setEmp_name(rs.getString("emp_name"));
				userbean.setEmp_tel(rs.getString("emp_tel"));
				userbean.setEmp_addr(rs.getString("emp_addr"));
				userbean.setEmp_email(rs.getString("emp_email"));
				userbean.setEmp_homepage(rs.getString("emp_homepage"));
				userbean.setEmp_info(rs.getString("emp_info"));
				userbean.setFk_grade_id(rs.getString("fk_grade_id"));

			}
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (rs != null)
				rs.close(); // 자원반납 (ResultSet)
			if (con != null)
				con.close();
		}
		return userbean;
	}

	public Vector getUserInfoList() throws SQLException {
		Connection con = DBConnectMgr.ds.getConnection();
		Statement stmt = null;
		ResultSet rs = null;
		Vector vecList = new Vector();

		try {

			String sql = "select * from emp e, emp_grade g where e.fk_grade_id = g.grade_id";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				EmpBean Admin = new EmpBean();
				Admin.setEmp_no(rs.getInt("emp_no"));
				Admin.setEmp_id(rs.getString("emp_id"));
				Admin.setEmp_pwd(rs.getString("emp_pwd"));
				Admin.setEmp_name(rs.getString("emp_name"));
				Admin.setEmp_tel(rs.getString("emp_tel"));
				Admin.setEmp_addr(rs.getString("emp_addr"));
				Admin.setEmp_email(rs.getString("emp_email"));
				Admin.setEmp_homepage(rs.getString("emp_homepage"));
				Admin.setGrade_name(rs.getString("grade_name"));

				vecList.add(Admin);
			}
		} catch (Exception e) {
			System.out.println("Exception" + e);
		} finally {
			if (stmt != null)
				stmt.close();
			if (rs != null)
				rs.close(); // 자원반납 (ResultSet)
			if (con != null)
				con.close();
		}
		return vecList;
	}

	// 아이디 중복 체크
	public boolean checkId(String id) throws SQLException {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean checkCon = false;
		try {

			String strQuery = "select emp_id from emp where emp_id = ?";
			pstmt = con.prepareStatement(strQuery);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			checkCon = rs.next();

		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		} finally {
			if (pstmt != null)
				pstmt.close(); // 자원반납 (PreparedStatement)
			if (rs != null)
				rs.close(); // 자원반납 (ResultSet)
			if (con != null)
				con.close(); // 자원반납 (Connection)
		}
		return checkCon;
	}

	// 사원 삭제
	public boolean empDelete(int emp_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = DBConnectMgr.ds.getConnection();
			String strQuery = "delete emp where emp_no=?";
			pstmt = con.prepareStatement(strQuery);
			pstmt.setInt(1, emp_no);

			int count = pstmt.executeUpdate();
			if (count == 1) {
				flag = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return flag;
	}

}
//

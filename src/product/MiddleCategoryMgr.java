package product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Vector;

import sub.DBConnectMgr;

public class MiddleCategoryMgr {

	public int categoryInsert(String m_id, String m_name, String g_no)
			throws Exception {

		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement ps = null;
		int n = 0;
		try {
			m_id = categoryCheck_m_id(m_id);// m_id중복 체크
			m_name = categoryCheck_m_name(m_name);// m_name중복 체크
			if (m_id == null || m_name == null || g_no == null) {
				return n;
			}

			String sql = "insert into middle_category values(mc_seq.nextval,?,?,?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, m_id);
			ps.setString(2, m_name);
			ps.setInt(3, Integer.parseInt(g_no));

			n = ps.executeUpdate();

			return n;
		} finally {
			if (ps != null)
				ps.close(); // 자원반납 (PreparedStatement)
			if (con != null)
				con.close(); // 자원반납 (Connection)
		}
	}

	public String categoryCheck_m_id(String m_id) throws Exception {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "select * from middle_category where m_id = ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, m_id);
		rs = ps.executeQuery();
		if (rs.next())
			return null; // 중복 null
		else
			return m_id;
	}

	public String categoryCheck_m_name(String m_name) throws Exception {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "select * from middle_category where m_name = ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, m_name);
		rs = ps.executeQuery();
		if (rs.next())
			return null;
		else
			return m_name;
	}

	/** 카테고리 목록 가져오기 */
	public ArrayList<MiddleCategoryBean> categoryAll() throws Exception {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {

			String sql = "select * from middle_category order by m_no";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<MiddleCategoryBean> arr = new ArrayList<MiddleCategoryBean>();
			while (rs.next()) {
				int m_no = rs.getInt("m_no");
				String m_id = rs.getString("m_id");
				String m_name = rs.getString("m_name");
				int g_no = rs.getInt("fk_g_no");
				// 테이블 각 행의 컬럼정보를 CategoryBean객체의 속성에 저장
				MiddleCategoryBean record = new MiddleCategoryBean(m_no, m_id, m_name, g_no);
				arr.add(record);
			}
			return arr;
		} finally {
			if (ps != null)
				ps.close(); // 자원반납 (PreparedStatement)
			if (rs != null)
				rs.close(); // 자원반납 (ResultSet)
			if (con != null)
				con.close(); // 자원반납 (Connection)
		}
	}

	/** 대분류에 따른 카테고리 목록 가져오기 */
	public ArrayList<MiddleCategoryBean> followGrCategory(String g_no)
			throws Exception {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {

			String sql = "select * from middle_category where fk_g_no = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, g_no);
			rs = ps.executeQuery();
			ArrayList<MiddleCategoryBean> arr = new ArrayList<MiddleCategoryBean>();
			while (rs.next()) {
				int m_no = rs.getInt("m_no");
				String m_id = rs.getString("m_id");
				String m_name = rs.getString("m_name");
				int fk_g_no = rs.getInt("fk_g_no");
				// 테이블 각 행의 컬럼정보를 CategoryBean객체의 속성에 저장
				MiddleCategoryBean record = new MiddleCategoryBean(m_no, m_id, m_name, fk_g_no);
				arr.add(record);
			}
			return arr;
		} finally {
			if (ps != null)
				ps.close(); // 자원반납 (PreparedStatement)
			if (rs != null)
				rs.close(); // 자원반납 (ResultSet)
			if (con != null)
				con.close(); // 자원반납 (Connection)
		}
	}

	// 카테고리 삭제
	public int deletetMidCategory(int m_no) throws Exception {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement ps = null;

		int n = 0;
		try {
			String sql = "delete middle_category where m_no = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, m_no);
			n = ps.executeUpdate();
			return n;
		} catch (Exception e) {
			System.out.println("Exception" + e);
		} finally {
			if (ps != null)
				ps.close(); // 자원반납 (PreparedStatement)
			if (con != null)
				con.close(); // 자원반납 (Connection)
		}
		return n;
	}

	// 카테고리 편집
	public int updateMidCategory(int m_no, String m_id, String m_name, String fk_g_no)
			throws Exception {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement ps = null;

		int n = 0;
		try {
			String sql = "update middle_category set m_id = ? , m_name = ?, fk_g_no = ? where m_no = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, m_id);
			ps.setString(2, m_name);
			ps.setString(3, fk_g_no);
			ps.setInt(4, m_no);
			n = ps.executeUpdate();
			return n;
		} catch (Exception e) {
			System.out.println("Exception" + e);
		} finally {
			if (ps != null)
				ps.close(); // 자원반납 (PreparedStatement)
			if (con != null)
				con.close(); // 자원반납 (Connection)
		}
		return n;
	}

}

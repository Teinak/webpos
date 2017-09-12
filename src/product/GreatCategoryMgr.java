package product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import sub.DBConnectMgr;

public class GreatCategoryMgr {

	public int categoryInsert(String g_id, String g_name) throws Exception {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement ps = null;

		int n = 0;
		try {
			g_id = categoryCheckcode(g_id);// code중복 체크
			g_name = categoryCheckcname(g_name);// cname중복 체크
			if (g_id == null || g_name == null) {
				return n;
			}
			String sql = "insert into great_category values(g_seq.nextval,?,?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, g_id);
			ps.setString(2, g_name);
			n = ps.executeUpdate();
			return n;
		} finally {
			if (ps != null)
				ps.close(); // 자원반납 (PreparedStatement)
			if (con != null)
				con.close(); // 자원반납 (Connection)
		}
	}

	public String categoryCheckcode(String g_id) throws Exception {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "select * from great_category where g_id = ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, g_id);
		rs = ps.executeQuery();
		if (rs.next())
			return null; // 중복 null
		else
			return g_id;
	}

	public String categoryCheckcname(String g_name) throws Exception {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "select * from great_category where g_name = ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, g_name);
		rs = ps.executeQuery();
		if (rs.next())
			return null;
		else
			return g_name;
	}

	/** 카테고리 목록 가져오기 */
	public ArrayList<GreatCategoryBean> categoryAll() throws Exception {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "select * from great_category order by g_no";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<GreatCategoryBean> arr = new ArrayList<GreatCategoryBean>();
			while (rs.next()) {
				int g_no = rs.getInt("g_no");
				String g_id = rs.getString("g_id");
				String g_name = rs.getString("g_name");
				// 테이블 각 행의 컬럼정보를 CategoryBean객체의 속성에 저장
				GreatCategoryBean record = new GreatCategoryBean(g_no, g_id,
						g_name);
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
	}// categoryAll()--------------------

	// 카테고리 삭제
	public int deletetGrCategory(int g_no) throws Exception {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement ps = null;

		int n = 0;
		try {
			String sql = "delete great_category where g_no = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, g_no);
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

	//카테고리 편집
	public int updateGrCategory(int g_no, String g_id, String g_name) throws Exception {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement ps = null;

		int n = 0;
		try {
			String sql = "update great_category set g_id = ? , g_name = ? where g_no = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, g_id);
			ps.setString(2, g_name);
			ps.setInt(3, g_no);
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

package product;

import java.beans.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import com.oreilly.servlet.MultipartRequest;

import sub.DBConnectMgr;

public class ProductMgr {

	private DBConnectMgr pool = null;
	public MultipartRequest mr = null;

	public ProductMgr() {

	}

	// 상품 입력
	public boolean productInsert(ProductBean productbean) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = DBConnectMgr.ds.getConnection();
			String strQuery = "insert into product values(p_seq.nextval,?,?,?,?,?,?,?,'no image',sysdate,?,?)";
			pstmt = con.prepareStatement(strQuery);
			pstmt.setString(1, productbean.getP_id());
			pstmt.setString(2, productbean.getP_name());
			pstmt.setString(3, productbean.getP_price());
			pstmt.setString(4, productbean.getP_author());
			pstmt.setString(5, productbean.getP_company());
			pstmt.setString(6, productbean.getP_barcode());
			pstmt.setString(7, productbean.getP_stock());
			pstmt.setString(8, productbean.getP_info());
			pstmt.setInt(9, productbean.getFk_m_no());
			int count = pstmt.executeUpdate();

			if (count == 1) {
				flag = true;
			}

		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		} finally {
			pstmt.close();
			con.close();
		}
		return flag;
	}

	//상품 삭제
	public boolean productDelete(int p_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = DBConnectMgr.ds.getConnection();
			String strQuery = "delete product where p_no=?";
			pstmt = con.prepareStatement(strQuery);
			pstmt.setInt(1, p_no);

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

	
	//상품정보 수정
	public boolean productUpdate(ProductBean productbean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = DBConnectMgr.ds.getConnection();
			String strQuery = "update product set p_id=?, p_name=?, p_price=?, p_author=?,p_company=?, p_barcode=?, p_stock=?, p_info=?, fk_m_no=? where p_no=? ";
			
			pstmt = con.prepareStatement(strQuery);
			pstmt.setString(1, productbean.getP_id());
			pstmt.setString(2, productbean.getP_name());
			pstmt.setString(3, productbean.getP_price());
			pstmt.setString(4, productbean.getP_author());
			pstmt.setString(5, productbean.getP_company());
			pstmt.setString(6, productbean.getP_barcode());
			pstmt.setString(7, productbean.getP_stock());
			/*pstmt.setString(8, productbean.getP_image());*/
			pstmt.setString(8, productbean.getP_info());
			pstmt.setInt(9, productbean.getFk_m_no());
			pstmt.setInt(10, productbean.getP_no());
			int count = pstmt.executeUpdate();
			if (count == 1) {
				flag = true;
			}
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
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
	
	//중카테고리 체크
	public boolean fkMNoCheck(int fk_m_no){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean re = false;
		try{
			con = DBConnectMgr.ds.getConnection();
			String strQuery = "select m_name from middle_category where m_no=?";
			pstmt=con.prepareStatement(strQuery);
			pstmt.setInt(1, fk_m_no);
			rs = pstmt.executeQuery();
			re=rs.next();
		}catch(Exception e){
			System.out.println(e);
		}finally{
			try {
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return re;
	}
	
	

	// 모든상품 리스트
	public Vector allGetProduct() throws SQLException {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement ps = null;
		Statement stmt = null;
		ResultSet rs = null;
		Vector vProduct = new Vector();

		try {
			String query = "select * from product p, middle_category m where p.fk_m_no = m.m_no order by p_no desc";
			ps = con.prepareStatement(query);
			rs = ps.executeQuery();

			while (rs.next()) {
				ProductBean pbean = new ProductBean();
				pbean.setP_no(rs.getInt("p_no"));
				pbean.setP_id(rs.getString("p_id"));
				pbean.setP_name(rs.getString("p_name"));
				pbean.setP_price(rs.getString("p_price"));
				pbean.setP_author(rs.getString("p_author"));
				pbean.setP_company(rs.getString("p_company"));
				pbean.setP_barcode(rs.getString("p_barcode"));
				pbean.setP_stock(rs.getString("p_stock"));
				pbean.setP_image(rs.getString("p_image"));
				pbean.setP_date(rs.getString("p_date"));
				pbean.setP_info(rs.getString("p_info"));
				pbean.setM_name(rs.getString("m_name"));
				vProduct.add(pbean);
			}
		} catch (Exception ex) {
			System.out.println("Exception :" + ex);
		} finally {
			if (ps != null)
				ps.close(); // 자원반납 (PreparedStatement)
			if (rs != null)
				rs.close(); // 자원반납 (ResultSet)
			if (con != null)
				con.close(); // 자원반납 (Connection)
		}
		return vProduct;
	}

	// p_no로 상품하나 출력
	public ProductBean getProduct(int no) throws SQLException {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductBean pbean = null;

		try {

			String query = "select * from product where p_no=?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				pbean = new ProductBean();
				pbean.setP_no(rs.getInt("p_no"));
				pbean.setP_id(rs.getString("p_id"));
				pbean.setP_name(rs.getString("p_name"));
				pbean.setP_price(rs.getString("p_price"));
				pbean.setP_author(rs.getString("p_author"));
				pbean.setP_company(rs.getString("p_company"));
				pbean.setP_barcode(rs.getString("p_barcode"));
				pbean.setP_stock(rs.getString("p_stock"));
				pbean.setP_image(rs.getString("p_image"));
				pbean.setP_date(rs.getString("p_date"));
				pbean.setP_info(rs.getString("p_info"));
				pbean.setFk_m_no(rs.getInt("fk_m_no"));
			}
		} catch (Exception ex) {
			System.out.println("Exception :" + ex);
		} finally {
			if (pstmt != null)
				pstmt.close(); // 자원반납 (PreparedStatement)
			if (rs != null)
				rs.close(); // 자원반납 (ResultSet)
			if (con != null)
				con.close(); // 자원반납 (Connection)
		}
		return pbean;
	}

	// 바코드로 상품하나 출력
	public ProductBean getProduct(String barcode) throws SQLException {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductBean pbean = null;

		try {
			String query = "select * from product where p_barcode=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, barcode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				pbean = new ProductBean();
				pbean.setP_no(rs.getInt("p_no"));
				pbean.setP_id(rs.getString("p_id"));
				pbean.setP_name(rs.getString("p_name"));
				pbean.setP_price(rs.getString("p_price"));
				pbean.setP_author(rs.getString("p_author"));
				pbean.setP_company(rs.getString("p_company"));
				pbean.setP_barcode(rs.getString("p_barcode"));
				pbean.setP_stock(rs.getString("p_stock"));
				pbean.setP_image(rs.getString("p_image"));
				pbean.setP_date(rs.getString("p_date"));
				pbean.setP_info(rs.getString("p_info"));
				pbean.setFk_m_no(rs.getInt("fk_m_no"));
			}
		} catch (Exception ex) {
			System.out.println("Exception :" + ex);
		} finally {
			if (pstmt != null)
				pstmt.close(); // 자원반납 (PreparedStatement)
			if (rs != null)
				rs.close(); // 자원반납 (ResultSet)
			if (con != null)
				con.close(); // 자원반납 (Connection)
		}
		return pbean;
	}

	//p_id 정보로 상품하나 출력
	public ProductBean getProductByPid(String p_id) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductBean productbean = null;
		try {
			con = DBConnectMgr.ds.getConnection();
			String strQuery = "select * from product where p_id=?";
			pstmt = con.prepareStatement(strQuery);
			pstmt.setString(1, p_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				productbean = new ProductBean();
				// System.out.println("rs.getInt()"+rs.getString("p_name"));
				productbean.setP_no(rs.getInt("p_no"));
				productbean.setP_id(rs.getString("p_id"));
				productbean.setP_name(rs.getString("p_name"));
				productbean.setP_price(rs.getString("p_price"));
				productbean.setP_author(rs.getString("p_author"));
				productbean.setP_company(rs.getString("p_company"));
				productbean.setP_barcode(rs.getString("p_barcode"));
				productbean.setP_stock(rs.getString("p_stock"));
				productbean.setP_image(rs.getString("p_image"));
				productbean.setP_date(rs.getString("p_date"));
				productbean.setP_info(rs.getString("p_info"));
				productbean.setFk_m_no(rs.getInt("fk_m_no"));
			}
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
		return productbean;
	}
	
	
	
	// 소분류 상품 리스트
	public Vector getMiddleProductList(String m_code) throws SQLException {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector vProduct = new Vector();

		try {

			String query = "select * from product where fk_m_no = ? order by p_no desc";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, m_code);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductBean pbean = new ProductBean();
				pbean.setP_no(rs.getInt("p_no"));
				pbean.setP_id(rs.getString("p_id"));
				pbean.setP_name(rs.getString("p_name"));
				pbean.setP_price(rs.getString("p_price"));
				pbean.setP_author(rs.getString("p_author"));
				pbean.setP_company(rs.getString("p_company"));
				pbean.setP_barcode(rs.getString("p_barcode"));
				pbean.setP_stock(rs.getString("p_stock"));
				pbean.setP_image(rs.getString("p_image"));
				pbean.setP_date(rs.getString("p_date"));
				pbean.setP_info(rs.getString("p_info"));
				pbean.setFk_m_no(rs.getInt("fk_m_no"));
				vProduct.add(pbean);
			}
		} catch (Exception ex) {
			System.out.println("Exception :" + ex);
		} finally {
			if (pstmt != null)
				pstmt.close(); // 자원반납 (PreparedStatement)
			if (rs != null)
				rs.close(); // 자원반납 (ResultSet)
			if (con != null)
				con.close(); // 자원반납 (Connection)
		}
		return vProduct;
	}

	// gr_category 상품 출력
	public Vector getGreatProductList(String gr_code) throws SQLException {
		Connection con = DBConnectMgr.ds.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector vProduct = new Vector();

		try {

			String query = "select p_no, p_id, p_name, p_price, p_author, p_company, p_barcode, p_stock, p_stock, p_image, p_date, p_info, fk_m_no from great_category g, middle_category m, product p where g.g_no = m.fk_g_no and m.m_no = p.fk_m_no and g.g_no = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, gr_code);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductBean pbean = new ProductBean();
				pbean.setP_no(rs.getInt("p_no"));
				pbean.setP_id(rs.getString("p_id"));
				pbean.setP_name(rs.getString("p_name"));
				pbean.setP_price(rs.getString("p_price"));
				pbean.setP_author(rs.getString("p_author"));
				pbean.setP_company(rs.getString("p_company"));
				pbean.setP_barcode(rs.getString("p_barcode"));
				pbean.setP_stock(rs.getString("p_stock"));
				pbean.setP_image(rs.getString("p_image"));
				pbean.setP_date(rs.getString("p_date"));
				pbean.setP_info(rs.getString("p_info"));
				pbean.setFk_m_no(rs.getInt("fk_m_no"));
				vProduct.add(pbean);
			}
		} catch (Exception ex) {
			System.out.println("Exception :" + ex);
		} finally {
			if (pstmt != null)
				pstmt.close(); // 자원반납 (PreparedStatement)
			if (rs != null)
				rs.close(); // 자원반납 (ResultSet)
			if (con != null)
				con.close(); // 자원반납 (Connection)
		}
		return vProduct;
	}

}

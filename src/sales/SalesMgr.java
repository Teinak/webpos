package sales;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import product.ProductBean;
import product.ProductMgr;
import sub.DBConnectMgr;

public class SalesMgr {

	private Hashtable hCart = new Hashtable();// 장바구니

	public SalesMgr() {
		// TODO Auto-generated constructor stub
	}

	public void addOrder(int pno) throws SQLException {
	
		ProductMgr pmgr = new ProductMgr();
		ProductBean pbean = pmgr.getProduct(pno);
		int quantity = 1;
		
		if (hCart.containsKey(pno)) {
			ProductBean tempOrder = (ProductBean) hCart.get(pno);
			quantity += tempOrder.getP_quantity();
			tempOrder.setP_quantity(quantity);
		}
		else
		{
			pbean.setP_quantity(quantity);
			hCart.put(pno, pbean);
		}
	}
	
	public Hashtable getCartList() {
		return hCart;
	}

	public void clearOrder(int pno) {
		hCart.remove(pno); // 주문한 상품 번호를 키 값으로 삭제
	}
	
	
	//////////////////////////////////////

	public int insertReceipt(String r_date, String r_totprice, int r_emp,
			String r_totquantity) throws SQLException {
		Connection con = DBConnectMgr.ds.getConnection();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int generatedKey = -1;

		try {

			String sql = "insert into receipt (r_no, r_date, r_price, r_emp, r_quantity ) values (receipt_seq.nextval,?,?,?,?)";

			pstmt = con.prepareStatement(sql, new String[]{"r_no"});
			pstmt.setString(1, r_date);
			pstmt.setString(2, r_totprice);
			pstmt.setInt(3, r_emp);
			pstmt.setString(4, r_totquantity);

			System.out.println("날짜:" + r_date);
			System.out.println("총가격:" + r_totprice);
			System.out.println("판매자:" + r_emp);
			System.out.println("총수량:" + r_totquantity);

			pstmt.executeUpdate();

			rs = pstmt.getGeneratedKeys();

			if (rs.next()) {
				generatedKey = rs.getInt(1);
			}
		} catch (Exception ex) {
			System.out.println("Exception :" + ex);
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}

		}

		return generatedKey;
	}

	public int insertSales(String s_date, int emp_no, int r_no)
			throws SQLException {
		Connection con = DBConnectMgr.ds.getConnection();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int generatedKey = -1;

		try {
			StringBuffer sql = new StringBuffer(
					" INSERT INTO sales (s_no, s_date, fk_emp_no, fk_r_no)"
							+ " VALUES (sales_seq.nextval, ?,?,?) ");
			pstmt = con.prepareStatement(sql.toString(), new String[]{"s_no"});

			pstmt.setString(1, s_date);
			pstmt.setInt(2, emp_no);
			pstmt.setInt(3, r_no);

			pstmt.executeUpdate();

			rs = pstmt.getGeneratedKeys();

			if (rs.next()) {
				generatedKey = rs.getInt(1);
			}

			System.out.println(s_date);
			System.out.println(emp_no);
			System.out.println(r_no);

		} catch (Exception ex) {
			System.out.println("Exception :" + ex);
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

		return generatedKey;
	}

	

	public int insertSalesProduct(List<SalesBean> salesList, int s_no)
			throws SQLException {
		Connection con = DBConnectMgr.ds.getConnection();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = -1;
		SalesBean salesBean = null;

		try {
			StringBuffer sql = new StringBuffer(
					" INSERT INTO sales_product (s_no, p_no, s_quantity)"
							+ " VALUES ( ?,?,?) ");
			pstmt = con.prepareStatement(sql.toString());

			int size = salesList.size();
			for (int i = 0; i < size; ++i) {
				salesBean = salesList.get(i);

				pstmt.setInt(1, s_no);
				pstmt.setInt(2, salesBean.getP_no());
				pstmt.setString(3, salesBean.getS_quantity());

				count += pstmt.executeUpdate();
				pstmt.clearParameters();
			}

		} catch (Exception ex) {
			System.out.println("Exception :" + ex);
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

		return count;
	}
	
	public ArrayList getSales() throws SQLException {// //모든 주문 내역 목록

		Connection con = DBConnectMgr.ds.getConnection();

		Statement stmt = null;
		ResultSet rs = null;
		ArrayList list = new ArrayList();

		try {
			String sql = "select p.p_name, s.s_date , p.p_author ,p.p_price,s_quantity"
					+ " from sales s join product p on (p.p_no = s.fk_p_no)";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				SalesBean sBean = new SalesBean();
				sBean.setS_date(rs.getString("s_date"));
				sBean.setS_no(rs.getInt("s_no"));
				sBean.setP_id(rs.getString("p_id"));
				sBean.setP_name(rs.getString("p_name"));
				sBean.setP_price(rs.getString("p_price"));
				sBean.setS_quantity(rs.getString("s_quantity"));
				sBean.setR_price(rs.getString("r_price"));

				list.add(sBean);
			}
		} catch (Exception ex) {
			System.out.println("Exception :" + ex);
		} finally {
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		return list;
	}

}

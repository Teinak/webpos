package pos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import product.ProductBean;
import sub.DBConnectMgr;
import emp.EmpBean;

public class PosMgr {

	public ProductBean getProudct(Integer p_no) throws SQLException {
		Connection con = DBConnectMgr.ds.getConnection();

		PreparedStatement pstmt = null;

		ResultSet rs = null;
		ProductBean pBean = null;

		try {

			String sql = "select * from product where p_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, p_no);

			System.out.println(p_no);

			rs = pstmt.executeQuery();

			pBean = new ProductBean();

			if (rs.next()) {
				pBean.setP_no(rs.getInt("p_no"));
				pBean.setP_name(rs.getString("p_name"));
				pBean.setP_price(rs.getString("p_price"));
				pBean.setP_company(rs.getString("p_company"));
				pBean.setP_info(rs.getString("p_info"));
			}

//			System.out.println("p_no");
//			System.out.println("p_name");
//			System.out.println("p_price");

		} catch (Exception ex) {
			System.out.println("Exception :" + ex);
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
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
		return pBean;
	}

	public Vector getSalesReport(Integer p_no , String r_date1, String r_date2, Integer emp_no) throws SQLException {
		Connection con = DBConnectMgr.ds.getConnection();

		PreparedStatement pstmt = null;

		ResultSet rs = null;
		PosBean posBean = null;
		Vector v = new Vector();

		try {

			String sql = "SELECT   T3.P_NAME"+
                         "      , T5.R_DATE "+
                         "      , T4.emp_name "+
                         "      , T3.P_company"+
                         "      , T3.P_PRICE"+
                         "      , T2.S_QUANTITY" +
                         "  FROM   SALES T1"+
                         "  JOIN   SALES_PRODUCT T2"+
                         "    ON   T2.S_NO = T1.S_NO"+
                         "  JOIN   PRODUCT T3"+
                         "    ON   T3.P_NO = T2.P_NO"+
                         "  JOIN   EMP T4"+
                         "    ON   T1.FK_EMP_NO = T4.EMP_NO"+
                         "  JOIN   RECEIPT T5 " +
                         "    ON   T5.R_NO =T1.FK_R_NO "+
                         "  WHERE  T2.P_NO =?"+
                            "AND T1.S_DATE BETWEEN ? AND ?"+
                            "AND T4.EMP_NO=?" ;
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			pstmt.setString(2, r_date1);
			pstmt.setString(3, r_date2);
			pstmt.setInt(4, emp_no);

			//System.out.println(emp_no);

			rs = pstmt.executeQuery();


			while (rs.next()) {
				posBean = new PosBean();
				
				posBean.setP_name(rs.getString("p_name"));
				posBean.setR_date(rs.getString("r_date"));
				posBean.setEmp_name(rs.getString("emp_name"));
				posBean.setP_author(rs.getString("p_company"));
				posBean.setP_price(rs.getString("p_price"));
				posBean.setS_quantity(rs.getString("s_quantity"));
			
				//System.out.println(posBean);
				
				v.add(posBean);
			}
		} catch (Exception ex) {
			System.out.println("Exception :" + ex);
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
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
		return v;
	}

}

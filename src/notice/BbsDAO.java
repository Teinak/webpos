package notice;

import java.io.File;
import java.security.interfaces.DSAKey;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;

import notice.*;
import sub.DBConnectMgr;

public class BbsDAO {
	Connection con;
	// #1. 글쓰기 관련--writeOk관련
	PreparedStatement ps1;
	ResultSet rs1;
	// #1_1. 글그룹 번호 최대값 구하기-getMaxRefer관련
	PreparedStatement ps1_1;
	ResultSet rs1_1;

	// #2. 글 목록 관련--list관련
	PreparedStatement ps2;
	ResultSet rs2;

	// #2_1. 글 목록에서 총 게시물 수-totalGulCount관련
	PreparedStatement ps2_1;
	ResultSet rs2_1;

	// #3. 글 내용 보기 --content관련
	PreparedStatement ps3, ps3_1;
	ResultSet rs3;

	// #4. 글 삭제--deleteOk관련
	PreparedStatement ps4, ps4_1;
	ResultSet rs4;

	// #5. 글 편집 관련 --edit관련
	PreparedStatement ps5;
	// #5_1. 글 편집 성공 여부 관련--editOk관련
	PreparedStatement ps5_1, ps5_2;
	ResultSet rs5_1;
	// #6. 검색--search

	// #7. 답글 쓰기 성공 여부 관련--rewriteOk관련
	PreparedStatement ps7, ps7_1, ps7_2;
	ResultSet rs7;

	// #8. content에 꼬리글 쓰기---replySave
	PreparedStatement ps8;

	// #9. content에 꼬리글 목록 가져오기--replyList
	PreparedStatement ps9;
	ResultSet rs9;

	// #10.content에 꼬리글 삭제하기--replyDelete
	PreparedStatement ps10, ps10_1;
	ResultSet rs10;

	PreparedStatement ps11;
	ResultSet rs11;

	public int totalGulCount() throws SQLException {
		try {
			con = DBConnectMgr.ds.getConnection();
			String totalCount_sql = "select count(*) cnt from jsp_board";
			ps2_1 = con.prepareStatement(totalCount_sql);
			rs2_1 = ps2_1.executeQuery(totalCount_sql);
			int totalCount = 0;
			if (rs2_1.next()) {
				totalCount = rs2_1.getInt("cnt");// 칼럼 별칭 cnt로 정수 가져오기
			}// if------------
			return totalCount;

		} finally {
			if (rs2_1 != null)
				rs2_1.close();
			if (ps2_1 != null)
				ps2_1.close();
			if (con != null)
				con.close();

		}
	}

	public ArrayList<BbsDTO> list(int cpage, int pageSize)// 단답형 게시판인 경우에 페이징
															// 기능이 없으면 두 인자 불필요
			throws SQLException {
		try {
			con = DBConnectMgr.ds.getConnection();
			String sql = "select * from(select idx, writer, email,homepage,"
					+ "pwd,subject,content, writedate,readnum,filename,"
					+ "filesize,	refer,lev,sunbun, rownum rn from"
					+ "(select * from jsp_board order by refer desc, sunbun asc)"
					+ ") where rn between ? and ?";

			int start = ((cpage * pageSize) - (pageSize - 1));
			int end = cpage * pageSize;

			ps2 = con.prepareStatement(sql);
			ps2.setInt(1, start);
			ps2.setInt(2, end);
			rs2 = ps2.executeQuery();

			ArrayList<BbsDTO> arr = new ArrayList<BbsDTO>();

			while (rs2.next()) {
				String idx = rs2.getString("idx");
				String writer = rs2.getString("writer");
				String email = rs2.getString("email");
				String homepage = rs2.getString("homepage");
				String pwd = rs2.getString("pwd");
				String subject = rs2.getString("subject");
				String content = rs2.getString("content");

				java.sql.Date writedate = rs2.getDate("writedate");
				int readnum = rs2.getInt("readnum");
				String filename = rs2.getString("filename");
				int filesize = rs2.getInt("filesize");

				int refer = rs2.getInt("refer");
				int lev = rs2.getInt("lev");
				int sunbun = rs2.getInt("sunbun");
				BbsDTO dto = new BbsDTO(idx, writer, email, homepage, pwd,
						subject, content, writedate, readnum, filename,
						filesize, refer, lev, sunbun);

				arr.add(dto);

			}
			return arr;

		} finally {
			if (rs2 != null)
				rs2.close();
			if (ps2 != null)
				ps2.close();
			if (con != null)
				con.close();
		}
	}

	public int writeOk(HttpServletRequest request) throws SQLException {
		try {
			con = DBConnectMgr.ds.getConnection();
			String sql = "INSERT INTO jsp_board VALUES("
					+ "jsp_board_idx.nextval,?,?,?,?,?,?,"
					+ "SYSDATE,?,?,?,?,?,?)"; // 14개 인자
			ps1 = con.prepareStatement(sql);

			// 사용자가 입력한 값 얻어와서 ? 에 세팅
			String writer = request.getParameter("writer");
			String email = request.getParameter("email");
			String homepage = request.getParameter("homepage");
			String pwd = request.getParameter("pwd");
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");

			int readnum = 0;

			int refer = 0;
			int lev = 0;
			int sunbun = 0;
			// 답변형 로직 추가//////////////
			// 글그룹 번호(refer)를 하나씩 증가시켜줌
			int refer_max = getMaxRefer();
			refer = refer_max + 1;
			System.out.println("refer=" + refer);
			// ////////////////////////////

			// IN Parameter Setting
			ps1.setString(1, writer);
			ps1.setString(2, email);
			ps1.setString(3, homepage);
			ps1.setString(4, pwd);
			ps1.setString(5, subject);
			ps1.setString(6, content);
			ps1.setInt(7, readnum);
			ps1.setString(8, "file");
			ps1.setInt(9, 0);
			ps1.setInt(10, refer);
			ps1.setInt(11, lev);
			ps1.setInt(12, sunbun);

			int n = ps1.executeUpdate();
			return n;

		} finally {
			if (ps1 != null)
				ps1.close();
			if (con != null)
				con.close(); // 반드시 닫아주자 부족하면 이클립스의 톰켓 점점버벅거림

		}
	}

	public int getMaxRefer() throws SQLException {
		try {
			String maxRefer_sql = "select max(refer) from jsp_board";
			int refer_max = 0;
			con = DBConnectMgr.ds.getConnection();
			ps1_1 = con.prepareStatement(maxRefer_sql);
			rs1_1 = ps1_1.executeQuery();
			if (rs1_1.next()) {
				refer_max = rs1_1.getInt(1);
			}
			return refer_max;
		} finally {
			if (rs1_1 != null)
				rs1_1.close();
			if (ps1_1 != null)
				ps1_1.close();
			// 다음 코드 주석처리 안하면 getMaxRefer()를 호출하는 메소드에서 연결이 끊어지크로 excute() 메소드
			// 수행안됨
			if (con != null)
				con.close();
		}

	}

	public boolean getReadnum(String idx) throws SQLException {
		try {
			String readnum_sql = "UPDATE jsp_board SET readnum=readnum+1 WHERE idx=?"; // 기존조회수
																						// +1
			con = DBConnectMgr.ds.getConnection();
			ps3_1 = con.prepareStatement(readnum_sql);
			ps3_1.setString(1, idx);
			int n = ps3_1.executeUpdate();
			if (n > 0)
				return true;
			else
				return false;

		} finally {
			if (ps3_1 != null)
				ps3_1.close();
			if (con != null)
				con.close();
		}
	}

	public BbsDTO content(String idx) throws SQLException {
		try {
			con = DBConnectMgr.ds.getConnection();
			String content_sql = "SELECT * FROM jsp_board WHERE idx=?";
			ps3 = con.prepareStatement(content_sql);
			ps3.setString(1, idx);
			rs3 = ps3.executeQuery();
			if (rs3.next()) { // idx 기본키로 검색결과는 단일 레코드 리턴하므로 while문 사용 안함
				// String idx=rs3.getString("idx"); //idx 는 인자로 넘어므로
				String writer = rs3.getString(2);
				String email = rs3.getString(3);
				String homepage = rs3.getString(4);
				String pwd = rs3.getString(5);
				String subject = rs3.getString(6);
				String content = rs3.getString(7);

				java.sql.Date writedate = rs3.getDate(8);
				int readnum = rs3.getInt(9);
				String filename = rs3.getString(10);
				int filesize = rs3.getInt(11);

				int refer = rs3.getInt(12);
				int lev = rs3.getInt(13);
				int sunbun = rs3.getInt(14);

				BbsDTO dto = new BbsDTO(idx, writer, email, homepage, pwd,
						subject, content, writedate, readnum, filename,
						filesize, refer, lev, sunbun);
				return dto;

			}// if-----------
			return null;

		} finally {
			if (rs3 != null)
				rs3.close();
			if (ps3 != null)
				ps3.close();
			if (con != null)
				con.close();
		}
	}

	public ArrayList<ReplyDTO> replyList(String idx) throws SQLException {
		try {
			con = DBConnectMgr.ds.getConnection(); // 부모글의 글번호와 일치하는 외래키를 가지는 댓글
													// 목록
			String replyList_sql = "select * from reply "
					+ " where reply_idx_fk=? order by no desc";
			ps9 = con.prepareStatement(replyList_sql);
			ps9.setString(1, idx);
			rs9 = ps9.executeQuery();

			ArrayList<ReplyDTO> arr = new ArrayList<ReplyDTO>();

			while (rs9.next()) {
				String no = rs9.getString(1);
				String writer = rs9.getString(2);
				String pwd = rs9.getString(3);
				String content = rs9.getString(4);
				java.sql.Date writedate = rs9.getDate(5);
				int readnum = rs9.getInt(6);
				String idx_fk = rs9.getString(7);// 굳이 필요는 없지만..
				// /////////////// 꺼내온 정보를 DTO 객체화
				ReplyDTO rdto = new ReplyDTO(no, writer, pwd, content,
						writedate, readnum, idx_fk);
				arr.add(rdto);
				// //////////////
			}// while------
			return arr;

		} finally {
			if (rs9 != null)
				rs9.close();
			if (ps9 != null)
				ps9.close();
			if (con != null)
				con.close();
		}

	}

	public BbsDTO edit(String idx) throws SQLException {
		BbsDTO dto = this.content(idx); // 글내용가져오고
		return dto;
	}

	public int editOk(HttpServletRequest req) // 인자는 파일업로드가 잇다면 멀티피트리퀘스트
			throws SQLException {
		try {
			con = DBConnectMgr.ds.getConnection();
			// 1.사용자가 입력한 값 받아오기.
			String idx = req.getParameter("idx");
			System.out.println("idx=" + idx);
			String writer = req.getParameter("writer");
			String email = req.getParameter("email");
			String homepage = req.getParameter("homepage");
			String pwd = req.getParameter("pwd");
			String subject = req.getParameter("subject");
			String content = req.getParameter("content");

			// 2. 사용자가 입력한 비번과 db의 비번이
			// 일치하는지 확인
			// 3. 일치한다면 update문 실행
			String edit_pwd_sql = "SELECT pwd FROM jsp_board WHERE idx=?";
			String edit_ok_sql = "UPDATE jsp_board SET writer=?, email=?,"
					+ "subject=?,content=?," + "homepage=? where idx=?";
			ps5_1 = con.prepareStatement(edit_pwd_sql);
			ps5_1.setString(1, idx);
			rs5_1 = ps5_1.executeQuery();
			if (rs5_1.next()) {
				String dbPwd = rs5_1.getString("pwd");
				if (dbPwd != null)
					dbPwd = dbPwd.trim();
				if (pwd.equals(dbPwd)) {
					// 비번 일치...update문 수행
					ps5_2 = con.prepareStatement(edit_ok_sql);
					ps5_2.setString(1, writer);
					ps5_2.setString(2, email);
					ps5_2.setString(3, subject);
					ps5_2.setString(4, content);
					ps5_2.setString(5, homepage);
					ps5_2.setString(6, idx);

					int n = ps5_2.executeUpdate();

					return n;
				} else {
					// 비번 불일치
					return 0;
				}

			}// if------------
			return -1;// 해당 글번호가 없을 경우

		} finally {
			if (rs5_1 != null)
				rs5_1.close();
			if (ps5_1 != null)
				ps5_1.close();
			if (ps5_2 != null)
				ps5_2.close();
			if (con != null)
				con.close();
		}
	}

	public int deleteOk(String idx, String pwd) throws SQLException {
		PreparedStatement ps4_2 = null;
		try {
			con = DBConnectMgr.ds.getConnection();
			// /삭제할 비교 해당비번 가져오기////////
			String del_pwd_sql = "SELECT pwd FROM jsp_board WHERE idx=?";
			// /답변형인경우 비번이 맞다면 꼬리글을 먼저 삭제////////
			String reply_del_sql = "delete from reply where reply_idx_fk=?"; // 부모글참조키에
																				// 해당하는...
																				// (?
																				// 에는
																				// idx
																				// 대입)
			// /글 삭제 ////////
			String del_ok_sql = "DELETE FROM jsp_board WHERE idx=?";
			ps4 = con.prepareStatement(del_pwd_sql);
			ps4.setString(1, idx);
			rs4 = ps4.executeQuery();
			if (rs4.next()) { // 해당 글번호가 존재하는 경우
				String dbPwd = rs4.getString("pwd");
				if (dbPwd != null)
					dbPwd = dbPwd.trim();
				if (pwd.equals(dbPwd)) {
					// 비번이 맞다면 먼저 꼬리글을 모두
					// 삭제하자.
					con.setAutoCommit(false); // 꼬리글 원래(부모)글 삭제를 하나의 트랜잭션으로 따라서
												// 예로 부모글 삭제(가령 도중에 서버다운) 실패하면
												// 꼬리글 롤백하기위해
					// 꼬리글 삭제///////////
					ps4_2 = con.prepareStatement(reply_del_sql);
					ps4_2.setString(1, idx);
					ps4_2.executeUpdate();
					// /////////////////////

					// 원래(부모)글 삭제//////
					ps4_1 = con.prepareStatement(del_ok_sql);
					ps4_1.setString(1, idx);
					int n = ps4_1.executeUpdate();
					if (n > 0) {
						con.commit();
					} else {
						con.rollback();
					}

					return n;

				} else {
					return 0;// 비번 일치하지 않는 경우
				}

			} else {
				// 해당 글번호가 존재하지 않는 경우
				return -1;
			}

		} finally {
			if (rs4 != null)
				rs4.close();
			if (ps4 != null)
				ps4.close();
			if (ps4_1 != null)
				ps4_1.close();
			if (ps4_2 != null)
				ps4_2.close();
			if (con != null)
				con.close();
		}

	}

	public ArrayList<BbsDTO> search(String type, String keyword, int cpage,
			int pageSize) throws SQLException {
		try {
			con = DBConnectMgr.ds.getConnection();

			// ////////////////////////// //list메소드에서 내부 쿼리 where절만 수정
			String sql = "select * from(select idx, writer, email,homepage,"
					+ "pwd,subject,content, writedate,readnum,filename,"
					+ "filesize,	refer,lev,sunbun, rownum rn from"
					+ "(select * from jsp_board" + " where " + type
					+ "  like ?  order by idx desc)"
					+ ") where rn between ? and ?";

			System.out.println("sql: " + sql);

			int start = ((cpage * pageSize) - (pageSize - 1));
			int end = cpage * pageSize;

			ps2 = con.prepareStatement(sql);
			ps2.setString(1, "%" + keyword + "%"); // 5 는 sql문에서는 '5'로 대체
			ps2.setInt(2, start);
			ps2.setInt(3, end);
			rs2 = ps2.executeQuery();

			ArrayList<BbsDTO> arr = new ArrayList<BbsDTO>();

			while (rs2.next()) {
				String idx = rs2.getString("idx");
				String writer = rs2.getString("writer");
				String email = rs2.getString("email");
				String homepage = rs2.getString("homepage");
				String pwd = rs2.getString("pwd");
				String subject = rs2.getString("subject");
				String content = rs2.getString("content");

				java.sql.Date writedate = rs2.getDate("writedate");
				int readnum = rs2.getInt("readnum");
				String filename = rs2.getString("filename");
				int filesize = rs2.getInt("filesize");

				int refer = rs2.getInt("refer");
				int lev = rs2.getInt("lev");
				int sunbun = rs2.getInt("sunbun");
				BbsDTO dto = new BbsDTO(idx, writer, email, homepage, pwd,
						subject, content, writedate, readnum, filename,
						filesize, refer, lev, sunbun);
				// ////////////
				arr.add(dto);
				// /////////////
			}// while----------------
			return arr;

		} finally {
			if (rs2 != null)
				rs2.close();
			if (ps2 != null)
				ps2.close();
			if (con != null)
				con.close();
		}

	}

	public int totalSearchGulCount(String type, String keyword)
			throws SQLException {
		try {
			con = DBConnectMgr.ds.getConnection();
			String totalCount_sql = "select count(*) cnt from jsp_board"
					+ " where " + type + " like '%" + keyword + "%'"; // like
																		// '%스%'

			System.out.println("totalCount_sql: " + totalCount_sql);

			ps2_1 = con.prepareStatement(totalCount_sql);
			rs2_1 = ps2_1.executeQuery(totalCount_sql);
			int totalCount = 0;
			if (rs2_1.next()) {
				totalCount = rs2_1.getInt("cnt");
			}// if------------
			return totalCount;

		} finally {
			if (rs2_1 != null)
				rs2_1.close();
			if (ps2_1 != null)
				ps2_1.close();
			if (con != null)
				con.close();

		}
	}

	public int replySave(String idx_fk, String writer, String content,
			String pwd) // idx_fk 참조키 (부모글 idx)인자
			throws SQLException {
		try {
			con = DBConnectMgr.ds.getConnection();
			String reply_save_sql = "insert into reply values("
					+ "reply_no.nextval," + "?,?,?,sysdate,?,?)";
			ps8 = con.prepareStatement(reply_save_sql);
			ps8.setString(1, writer);
			ps8.setString(2, pwd);
			ps8.setString(3, content);
			ps8.setInt(4, 0);// readnum
			ps8.setString(5, idx_fk); // reply_idx_fk가 수치형이지만 insert into
										// reply(no,REPLY_IDX_FK)
										// values(1000,'1'); 가능

			int n = ps8.executeUpdate();
			return n;
		} finally {
			if (ps8 != null)
				ps8.close();
			if (con != null)
				con.close();
		}

	}

	public int replyDelete(String no, String pwd) throws SQLException {
		try {
			con = DBConnectMgr.ds.getConnection();
			String del_pwd_sql = "select pwd from reply where no=?"; // 글번호에
																		// 해당하는...
			String delOk_sql = "delete from reply where no=?";
			ps10 = con.prepareStatement(del_pwd_sql);
			ps10.setString(1, no);
			rs10 = ps10.executeQuery();
			if (rs10.next()) {
				String dbPwd = rs10.getString("pwd");
				if (pwd.equals(dbPwd)) {
					// 비번이 일치한다면 삭제
					ps10_1 = con.prepareStatement(delOk_sql);
					ps10_1.setString(1, no);

					int n = ps10_1.executeUpdate();
					return n;
				} else {
					return 0;
				}

			} else {
				return -1;
			}

		} finally {
			if (rs10 != null)
				rs10.close();
			if (ps10 != null)
				ps10.close();
			if (ps10_1 != null)
				ps10_1.close();
			if (con != null)
				con.close();
		}
	}
}

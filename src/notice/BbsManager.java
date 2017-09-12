package notice;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

public class BbsManager {
	private BbsManager() {

	}

	public static BbsManager getInstance() {
		BbsManager mgr = new BbsManager();
		return mgr;
	}

	public int totalGulCount() throws SQLException {
		return new BbsDAO().totalGulCount(); // BbsDAO 객체 생성하면서 메소드 호출
	}

	public ArrayList<BbsDTO> list(int cpage, int pageSize) throws SQLException {
		BbsDAO dao = new BbsDAO();
		return dao.list(cpage, pageSize);
	}

	public int writeOk(HttpServletRequest request) throws SQLException {
		BbsDAO dao = new BbsDAO();
		int result = dao.writeOk(request);
		return result;
	}

	public boolean getReadnum(String idx) throws SQLException {
		return new BbsDAO().getReadnum(idx);
	}

	public BbsDTO content(String idx) throws SQLException {
		return new BbsDAO().content(idx);
	}

	public ArrayList<ReplyDTO> replyList(String idx) throws SQLException {
		return new BbsDAO().replyList(idx);
	}

	public BbsDTO edit(String idx) throws SQLException {
		return new BbsDAO().edit(idx);
	}

	public int editOk(HttpServletRequest req) throws SQLException {
		return new BbsDAO().editOk(req);
	}

	public int deleteOk(String idx, String pwd) throws SQLException {
		return new BbsDAO().deleteOk(idx, pwd);
	}

	public ArrayList<BbsDTO> search(String type, String keyword, int cpage,
			int pageSize) throws SQLException {

		return new BbsDAO().search(type, keyword, cpage, pageSize);
	}

	public int totalSearchGulCount(String type, String keyword)
			throws SQLException {
		return new BbsDAO().totalSearchGulCount(type, keyword);
	}

	public int replySave(String idx_fk, String writer, String content,
			String pwd) throws SQLException {
		return new BbsDAO().replySave(idx_fk, writer, content, pwd);
	}

	public int replyDelete(String no, String pwd) throws SQLException {
		return new BbsDAO().replyDelete(no, pwd);
	}
}

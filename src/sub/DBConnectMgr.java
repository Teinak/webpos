package sub;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBConnectMgr {

	public static DataSource ds; // DB커넥션풀 클래스 로딩시 메모리 올라가도록
	// static 초기화 블럭을 이용하여 풀 획득
	
	// static 영역이므로 사용할때 DBConnectMgr.ds.getConnection() 처럼 불러들여 바로 사용할 수 있다.
	static {
		try {
			InitialContext ctx = new InitialContext();
			Context envCtx = (Context) ctx.lookup("java:/comp/env");
			ds = (DataSource) envCtx.lookup("jdbc/webpos");
			System.out.println("DataSource Lookup성공!");
			
		} catch (NamingException e) {
			System.err.println("lookup 실패: " + e);
		}
	}
}

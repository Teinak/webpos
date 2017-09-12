package notice;
import java.sql.Date;

public class ReplyDTO {
	private String no;//reply테이블의 자동증가 컬럼
	private String writer;
	private String pwd;
	private String content;
	private Date writedate;
	private int readnum;
	private String reply_idx_fk;
	//부모테이블[jsp_board]의 idx 참조
	
	public ReplyDTO(){
		
	}//기본 생성자-------

	public ReplyDTO(String no, String writer, String pwd, String content,
			Date writedate, int readnum, String reply_idx_fk) {
		super();
		this.no = no;
		this.writer = writer;
		this.pwd = pwd;
		this.content = content;
		this.writedate = writedate;
		this.readnum = readnum;
		this.reply_idx_fk = reply_idx_fk;
	}//인자 생성자------------

	//setter,getter------------
	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getWritedate() {
		return writedate;
	}

	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}

	public int getReadnum() {
		return readnum;
	}

	public void setReadnum(int readnum) {
		this.readnum = readnum;
	}

	public String getReply_idx_fk() {
		return reply_idx_fk;
	}

	public void setReply_idx_fk(String reply_idx_fk) {
		this.reply_idx_fk = reply_idx_fk;
	}

}///////////////////////






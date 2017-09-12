package notice;

import java.sql.Date;

public class BbsDTO {
	private String idx; //자동증가, PK int형으로 가능하지만 문자열이 편함
	private String writer;
	private String email;
	private String homepage;
	private String pwd;
	private String subject;
	private String content;
	
	private java.sql.Date writedate;
	private int readnum;//조회수
	private String filename;//첨부파일명
	private int filesize; //원래는 long이지만 나중에 필요하면 int 캐스팅하자
	
	private int refer;	//답변달 때 필요한 프로퍼티
	private int lev;	//답변달 때 필요한 프로퍼티
	private int sunbun;	//답변달 때 필요한 프로퍼티
	
	//기본 생성자---------	
	public BbsDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	//인자(기본 게시판에서 글작성할때 사용될 )생성자----------
	public BbsDTO(String idx, String writer, String email, String homepage,
			String pwd, String subject, String content) {
		super();
		this.idx = idx;
		this.writer = writer;
		this.email = email;
		this.homepage = homepage;
		this.pwd = pwd;
		this.subject = subject;
		this.content = content;
	}
//인자(모든 필드) 생성자----------
	public BbsDTO(String idx, String writer, String email, String homepage,
			String pwd, String subject, String content, Date writedate,
			int readnum, String filename, int filesize, int refer, int lev,
			int sunbun) {
		super();
		this.idx = idx;
		this.writer = writer;
		this.email = email;
		this.homepage = homepage;
		this.pwd = pwd;
		this.subject = subject;
		this.content = content;
		this.writedate = writedate;
		this.readnum = readnum;
		this.filename = filename;
		this.filesize = filesize;
		this.refer = refer;
		this.lev = lev;
		this.sunbun = sunbun;
	}
	
	
	//setter, getter-----------	
	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getHomepage() {
		return homepage;
	}

	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public java.sql.Date getWritedate() {
		return writedate;
	}

	public void setWritedate(java.sql.Date writedate) {
		this.writedate = writedate;
	}

	public int getReadnum() {
		return readnum;
	}

	public void setReadnum(int readnum) {
		this.readnum = readnum;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public int getFilesize() {
		return filesize;
	}

	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}

	public int getRefer() {
		return refer;
	}

	public void setRefer(int refer) {
		this.refer = refer;
	}

	public int getLev() {
		return lev;
	}

	public void setLev(int lev) {
		this.lev = lev;
	}

	public int getSunbun() {
		return sunbun;
	}

	public void setSunbun(int sunbun) {
		this.sunbun = sunbun;
	}


}///////////////////////////////////










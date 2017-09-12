package product;

public class MiddleCategoryBean {

	private int m_no;
	private String m_id;
	private String m_name;
	private int fk_g_no;

	public MiddleCategoryBean() {
		// TODO Auto-generated constructor stub
	}

	public MiddleCategoryBean(int m_no, String m_id, String m_name,
			int fk_g_no) {
		super();
		this.m_no = m_no;
		this.m_id = m_id;
		this.m_name = m_name;
		this.fk_g_no = fk_g_no;
	}

	public int getM_no() {
		return m_no;
	}

	public void setM_no(int m_no) {
		this.m_no = m_no;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public int getFk_g_no() {
		return fk_g_no;
	}

	public void setFk_g_no(int fk_g_no) {
		this.fk_g_no = fk_g_no;
	}

}

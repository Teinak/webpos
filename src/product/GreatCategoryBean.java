package product;

public class GreatCategoryBean {

	private int g_no;
	private String g_id;
	private String g_name;

	public GreatCategoryBean() {
		// TODO Auto-generated constructor stub
	}

	public GreatCategoryBean(int g_no, String g_id, String g_name) {
		super();
		this.g_no = g_no;
		this.g_id = g_id;
		this.g_name = g_name;
	}

	public int getG_no() {
		return g_no;
	}

	public void setG_no(int g_no) {
		this.g_no = g_no;
	}

	public String getG_id() {
		return g_id;
	}

	public void setG_id(String g_id) {
		this.g_id = g_id;
	}

	public String getG_name() {
		return g_name;
	}

	public void setG_name(String g_name) {
		this.g_name = g_name;
	}

}

package product;

public class ProductBean {

	private int p_no;
	private String p_id;
	private String p_name;
	private String p_price;
	private String p_author;
	private String p_company;
	private String p_barcode;
	private String p_stock;
	private String p_image;
	private String p_date;
	private String p_info;
	private String m_name;
	private int fk_m_no;
	private int p_quantity;

	public ProductBean() {
		// TODO Auto-generated constructor stub
	}

	public ProductBean(int p_no, String p_id, String p_name, String p_price,
			String p_author, String p_company, String p_barcode,
			String p_stock, String p_image, String p_date, String p_info,
			int fk_m_no) {
		super();
		this.p_no = p_no;
		this.p_id = p_id;
		this.p_name = p_name;
		this.p_price = p_price;
		this.p_author = p_author;
		this.p_company = p_company;
		this.p_barcode = p_barcode;
		this.p_stock = p_stock;
		this.p_image = p_image;
		this.p_date = p_date;
		this.p_info = p_info;
		this.fk_m_no = fk_m_no;
	}

	public String getM_name() {
		return m_name;
	}
	
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	
	public int getP_no() {
		return p_no;
	}

	public void setP_no(int p_no) {
		this.p_no = p_no;
	}

	public String getP_id() {
		return p_id;
	}

	public void setP_id(String p_id) {
		this.p_id = p_id;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getP_price() {
		return p_price;
	}

	public void setP_price(String p_price) {
		this.p_price = p_price;
	}

	public String getP_author() {
		return p_author;
	}

	public void setP_author(String p_author) {
		this.p_author = p_author;
	}

	public String getP_company() {
		return p_company;
	}

	public void setP_company(String p_company) {
		this.p_company = p_company;
	}

	public String getP_barcode() {
		return p_barcode;
	}

	public void setP_barcode(String p_barcode) {
		this.p_barcode = p_barcode;
	}

	public String getP_stock() {
		return p_stock;
	}

	public void setP_stock(String p_stock) {
		this.p_stock = p_stock;
	}

	public String getP_image() {
		return p_image;
	}

	public void setP_image(String p_image) {
		this.p_image = p_image;
	}

	public String getP_date() {
		return p_date;
	}

	public void setP_date(String p_date) {
		this.p_date = p_date;
	}

	public String getP_info() {
		return p_info;
	}

	public void setP_info(String p_info) {
		this.p_info = p_info;
	}

	public int getFk_m_no() {
		return fk_m_no;
	}

	public void setFk_m_no(int fk_m_no) {
		this.fk_m_no = fk_m_no;
	}

	public int getP_quantity() {
		return p_quantity;
	}

	public void setP_quantity(int p_quantity) {
		this.p_quantity = p_quantity;
	}
}

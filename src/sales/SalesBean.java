package sales;

public class SalesBean {
	private int s_no;
	private String s_quantity;
	private String s_date;
	private int fk_p_no;
	private int fk_emp_no;
	private int fk_r_no;
    private String p_id; // 제품번호
    private String p_name; //제품명
    private String p_price; //제품단가
    private String r_price;   //제품가격
    private int p_no ;
    private String p_company; 
    private String p_info; 
    private String r_quantity; 
    private String r_emp;
    
  
    
	public SalesBean() {
		// TODO Auto-generated constructor stub
	}

	public int getS_no() {
		return s_no;
	}

	public void setS_no(int s_no) {
		this.s_no = s_no;
	}

	public String getS_quantity() {
		return s_quantity;
	}

	public void setS_quantity(String s_quantity) {
		this.s_quantity = s_quantity;
	}

	public String getS_date() {
		return s_date;
	}

	public void setS_date(String s_date) {
		this.s_date = s_date;
	}

	public int getFk_p_no() {
		return fk_p_no;
	}

	public void setFk_p_no(int fk_p_no) {
		this.fk_p_no = fk_p_no;
	}

	public int getFk_emp_no() {
		return fk_emp_no;
	}

	public void setFk_emp_no(int fk_emp_no) {
		this.fk_emp_no = fk_emp_no;
	}

	public int getFk_r_no() {
		return fk_r_no;
	}

	public void setFk_r_no(int fk_r_no) {
		this.fk_r_no = fk_r_no;
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

	public String getR_price() {
		return r_price;
	}

	public void setR_price(String r_price) {
		this.r_price = r_price;
	}

	public int getP_no() {
		return p_no;
	}

	public void setP_no(int p_no) {
		this.p_no = p_no;
	}

	public String getP_company() {
		return p_company;
	}

	public void setP_company(String p_company) {
		this.p_company = p_company;
	}

	public String getP_info() {
		return p_info;
	}

	public void setP_info(String p_info) {
		this.p_info = p_info;
	}

	public String getR_quantity() {
		return r_quantity;
	}

	public void setR_quantity(String r_quantity) {
		this.r_quantity = r_quantity;
	}

	public String getR_emp() {
		return r_emp;
	}

	public void setR_emp(String r_emp) {
		this.r_emp = r_emp;
	}
    
	public String toString(){
		return "날짜:"+s_date+",수량"+s_quantity+",품목"+p_no;
	}
}

package pos;

public class PosBean {

	private int p_no;
	private String r_date1;
	private String r_date2;
	private int emp_no;
	private String p_name;
	private String emp_name;
	private String p_author;
	private String p_price;
	private String s_quantity;
	private String r_date;
	
	

	public PosBean() {
		// TODO Auto-generated constructor stub
	}


	public int getP_no() {
		return p_no;
	}


	public void setP_no(int p_no) {
		this.p_no = p_no;
	}


	public String getR_date1() {
		return r_date1;
	}


	public void setR_date1(String r_date1) {
		this.r_date1 = r_date1;
	}


	public String getR_date2() {
		return r_date2;
	}


	public void setR_date2(String r_date2) {
		this.r_date2 = r_date2;
	}


	public int getEmp_no() {
		return emp_no;
	}


	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}


	public String getP_name() {
		return p_name;
	}


	public void setP_name(String p_name) {
		this.p_name = p_name;
	}


	public String getEmp_name() {
		return emp_name;
	}


	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}


	public String getP_author() {
		return p_author;
	}


	public void setP_author(String p_author) {
		this.p_author = p_author;
	}


	public String getP_price() {
		return p_price;
	}


	public void setP_price(String p_price) {
		this.p_price = p_price;
	}


	public String getS_quantity() {
		return s_quantity;
	}


	public void setS_quantity(String s_quantity) {
		this.s_quantity = s_quantity;
	}

	
	public String getR_date() {
		return r_date;
	}


	public void setR_date(String s_date) {
		this.r_date = s_date;
	}


	public String toString(){
		return "품목명="+p_name+"/날짜="+r_date +"/저자"+  p_author+"/금액"+p_price+"/수량"+s_quantity;
	}
	
}

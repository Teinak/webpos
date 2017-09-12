package emp;

public class EmpBean {

	private int emp_no;
	private String emp_id;
	private String emp_pwd;
	private String emp_name;
	private String emp_tel;
	private String emp_addr;
	private String emp_email;
	private String emp_homepage;
	private String emp_info;
	private String emp_image;
	private String emp_date;
	private String fk_grade_id;
	private String grade_name;
	
	public EmpBean() {
		// TODO Auto-generated constructor stub
	}
	
	public EmpBean(int emp_no, String emp_id, String emp_pwd, String emp_name,
			String emp_tel, String emp_addr, String emp_email,
			String emp_homepage, String emp_info, String emp_image,
			String emp_date, String fk_grade_id) {
		super();
		this.emp_no = emp_no;
		this.emp_id = emp_id;
		this.emp_pwd = emp_pwd;
		this.emp_name = emp_name;
		this.emp_tel = emp_tel;
		this.emp_addr = emp_addr;
		this.emp_email = emp_email;
		this.emp_homepage = emp_homepage;
		this.emp_info = emp_info;
		this.emp_image = emp_image;
		this.emp_date = emp_date;
		this.fk_grade_id = fk_grade_id;
	}

	public String getGrade_name() {
		return grade_name;
	}
	
	public void setGrade_name(String grade_name) {
		this.grade_name = grade_name;
	}
	
	public int getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}

	public String getEmp_id() {
		return emp_id;
	}

	public void setEmp_id(String emp_id) {
		this.emp_id = emp_id;
	}

	public String getEmp_pwd() {
		return emp_pwd;
	}

	public void setEmp_pwd(String emp_pwd) {
		this.emp_pwd = emp_pwd;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public String getEmp_tel() {
		return emp_tel;
	}

	public void setEmp_tel(String emp_tel) {
		this.emp_tel = emp_tel;
	}

	public String getEmp_addr() {
		return emp_addr;
	}

	public void setEmp_addr(String emp_addr) {
		this.emp_addr = emp_addr;
	}

	public String getEmp_email() {
		return emp_email;
	}

	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}

	public String getEmp_homepage() {
		return emp_homepage;
	}

	public void setEmp_homepage(String emp_homepage) {
		this.emp_homepage = emp_homepage;
	}

	public String getEmp_info() {
		return emp_info;
	}

	public void setEmp_info(String emp_info) {
		this.emp_info = emp_info;
	}

	public String getEmp_image() {
		return emp_image;
	}

	public void setEmp_image(String emp_image) {
		this.emp_image = emp_image;
	}

	public String getEmp_date() {
		return emp_date;
	}

	public void setEmp_date(String emp_date) {
		this.emp_date = emp_date;
	}

	public String getFk_grade_id() {
		return fk_grade_id;
	}

	public void setFk_grade_id(String fk_grade_id) {
		this.fk_grade_id = fk_grade_id;
	}

}

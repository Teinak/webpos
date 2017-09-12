package emp;

public class GradeBean {

	private String grade_id;
	private String grade_name;

	public GradeBean() {
		// TODO Auto-generated constructor stub
	}

	public GradeBean(String grade_id, String grade_name) {
		super();
		this.grade_id = grade_id;
		this.grade_name = grade_name;
	}

	public String getGrade_id() {
		return grade_id;
	}

	public void setGrade_id(String grade_id) {
		this.grade_id = grade_id;
	}

	public String getGrade_name() {
		return grade_name;
	}

	public void setGrade_name(String grade_name) {
		this.grade_name = grade_name;
	}
	
}

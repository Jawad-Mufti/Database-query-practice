package se.chalmers.dm;

public class User {
	private String ssn;
	private String name;
	private String email;
	private boolean isActive;
	public String getSsn() {
		return ssn;
	}
	public void setSsn(String ssn) {
		this.ssn = ssn;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public boolean isActive() {
		return isActive;
	}
	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}
	@Override
	public String toString() {
		return "User [ssn=" + ssn + ", name=" + name + ", email=" + email + ", isActive=" + isActive + "]";
	}
	public void setAlltoNull() {
		this.ssn = "";
		this.email = "";
		this.name = "";
		this.isActive = false;
	}
	
}

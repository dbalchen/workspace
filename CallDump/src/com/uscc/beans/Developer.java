package com.uscc.beans;

public class Developer {
	public String userid;

	public String firstname;

	public String lastname;

	public String email;

	public String password;

	public String status;

	public String util;
	
	public String userpriority;

	public String getUserpriority() {
		return userpriority;
	}
	
	public void setUserpriority(String up)
	{
		this.userpriority = up;
	}
	
	public String getUtil() {
		return this.util;
	}

	public void setUtil(String d) {
		this.util = d;
	}

	public String getUserId() {
		return userid;
	}

	public String getStatus() {
		return status;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setUserId(String user) {
		this.userid = user;
	}

	public String getFirstName() {
		return firstname;
	}

	public void setFirstName(String fn) {
		this.firstname = fn;
	}

	public void setStatus(String d) {
		this.status = d;
	}

	public void setLastName(String ln) {
		this.lastname = ln;
	}

	public String getLastName() {
		return lastname;
	}

	public void setEmailAddress(String email) {
		this.email = email;
	}

	public String getEmailAddress() {
		return email;
	}
}

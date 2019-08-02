package com.cyient.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "Executive")
public class Executive implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@Column(name="Executive_Id")
	private String executiveId;
	

	
	@Column(name="Email_Id")
	private String emailId;
	
	@Column(name="Executive_Name")
	private String executiveName;
	
	@Column(name="Password")
	private String password;
	
	@Column(name="Mobile")
	private String mobile;	
	
	@Column(name="Region")
	private String region;
	
	@Column(name="City")
	private String city;
	
	@Column(name="Manager")
	private String manager;
	

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	@Column(name="Created_Date")
	@Temporal(TemporalType.DATE)
	private Date createdDate;
	
	public String getExecutiveId() {
		return executiveId;
	}

	public void setExecutiveId(String executiveId) {
		this.executiveId = executiveId;
	}



	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getExecutiveName() {
		return executiveName;
	}

	public void setExecutiveName(String executiveName) {
		this.executiveName = executiveName;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}	
	
	
}
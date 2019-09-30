package com.cyient.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Site_Security")
public class Site_Security implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="siteID")
	private Site siteid;
		
	@Column(name="Observations")
	private String observations;
	
	@Column(name="Security_Condition")
	private String securityCondition;
	
	@Column(name="Security_Photo1", unique = false, nullable = false, length = 16777215)
	private byte[] security_photo1;
	
	@Column(name="Security_Photo1_Name")
	private String security_photo1_name;
	
	@Column(name="Security_Photo1_Latitude")
	private String security_photo1_latitude;

	@Column(name="Security_Photo1_Longitude")
	private String security_photo1_longitude;
	
	@Column(name="Security_Photo2", unique = false, nullable = false, length = 16777215)
	private byte[] security_photo2;
	
	@Column(name="Security_Photo2_Name")
	private String security_photo2_name;	

	@Column(name="Security_Photo2_Latitude")
	private String security_photo2_latitude;

	@Column(name="Security_Photo2_Longitude")
	private String security_photo2_longitude;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Site getSiteid() {
		return siteid;
	}

	public void setSiteid(Site siteid) {
		this.siteid = siteid;
	}

	public String getObservations() {
		return observations;
	}

	public void setObservations(String observations) {
		this.observations = observations;
	}

	public String getSecurityCondition() {
		return securityCondition;
	}

	public void setSecurityCondition(String securityCondition) {
		this.securityCondition = securityCondition;
	}

	public byte[] getSecurity_photo1() {
		return security_photo1;
	}

	public void setSecurity_photo1(byte[] security_photo1) {
		this.security_photo1 = security_photo1;
	}

	public String getSecurity_photo1_name() {
		return security_photo1_name;
	}

	public void setSecurity_photo1_name(String security_photo1_name) {
		this.security_photo1_name = security_photo1_name;
	}

	public String getSecurity_photo1_latitude() {
		return security_photo1_latitude;
	}

	public void setSecurity_photo1_latitude(String security_photo1_latitude) {
		this.security_photo1_latitude = security_photo1_latitude;
	}

	public String getSecurity_photo1_longitude() {
		return security_photo1_longitude;
	}

	public void setSecurity_photo1_longitude(String security_photo1_longitude) {
		this.security_photo1_longitude = security_photo1_longitude;
	}

	public byte[] getSecurity_photo2() {
		return security_photo2;
	}

	public void setSecurity_photo2(byte[] security_photo2) {
		this.security_photo2 = security_photo2;
	}

	public String getSecurity_photo2_name() {
		return security_photo2_name;
	}

	public void setSecurity_photo2_name(String security_photo2_name) {
		this.security_photo2_name = security_photo2_name;
	}

	public String getSecurity_photo2_latitude() {
		return security_photo2_latitude;
	}

	public void setSecurity_photo2_latitude(String security_photo2_latitude) {
		this.security_photo2_latitude = security_photo2_latitude;
	}

	public String getSecurity_photo2_longitude() {
		return security_photo2_longitude;
	}

	public void setSecurity_photo2_longitude(String security_photo2_longitude) {
		this.security_photo2_longitude = security_photo2_longitude;
	}

		

}
package com.cyient.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "Survey_Wiring")
public class Site_Wiring implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;


	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@OneToMany
	@JoinColumn(name="siteID")
	private String siteid;
		
	@Column(name="Condition")
	private String condition;
			
	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	@Column(name="Comments")
	private String comments;
	
	@Column(name="Site_photo", unique = false, nullable = false, length = 16777215)
	private byte[] site_photo;
	
	@Column(name="Latitude")
	private String latitude;

		public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSiteid() {
		return siteid;
	}

	public void setSiteid(String siteid) {
		this.siteid = siteid;
	}


	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public byte[] getSite_photo() {
		return site_photo;
	}

	public void setSite_photo(byte[] site_photo) {
		this.site_photo = site_photo;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

		@Column(name="Longitude")
		private String longitude;




}
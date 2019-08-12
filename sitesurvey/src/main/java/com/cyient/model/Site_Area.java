package com.cyient.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "Site_Area")
public class Site_Area implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@Column(name="Id")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="siteID")
	private Site siteid;
		
	@Column(name="Site_Condition")
	private String siteCondition;
	
	@Column(name="Comments")
	private String comments;
	
	@Column(name="Photo_inproper", unique = false, nullable = false, length = 16777215)
	private byte[] photo_inproper;
	
	@Column(name="Photo_inproper_name")
	private String photo_inproper_name;	

	@Column(name="Photo_inproper_Latitude")
	private String photo_inproper_latitude;

	@Column(name="Photo_inproper_Longitude")
	private String photo_inproper_longitude;
	
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

	public String getSiteCondition() {
		return siteCondition;
	}

	public void setSiteCondition(String siteCondition) {
		this.siteCondition = siteCondition;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public byte[] getPhoto_inproper() {
		return photo_inproper;
	}

	public void setPhoto_inproper(byte[] photo_inproper) {
		this.photo_inproper = photo_inproper;
	}

	public String getPhoto_inproper_name() {
		return photo_inproper_name;
	}

	public void setPhoto_inproper_name(String photo_inproper_name) {
		this.photo_inproper_name = photo_inproper_name;
	}

	public String getPhoto_inproper_latitude() {
		return photo_inproper_latitude;
	}

	public void setPhoto_inproper_latitude(String photo_inproper_latitude) {
		this.photo_inproper_latitude = photo_inproper_latitude;
	}

	public String getPhoto_inproper_longitude() {
		return photo_inproper_longitude;
	}

	public void setPhoto_inproper_longitude(String photo_inproper_longitude) {
		this.photo_inproper_longitude = photo_inproper_longitude;
	}

}
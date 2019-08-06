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
@Table(name = "Site_Access")
public class Site_Access implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@Column(name="Id")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="siteID")
	private Site siteid;
		
	@Column(name="Access_Type")
	private String accessType;
	
	@Column(name="Road_Condition")
	private String roadCondition;
	
	@Column(name="Comments")
	private String comments;
	
	@Column(name="Photo_way", unique = false, nullable = false, length = 16777215)
	private byte[] photo_way;
	
	@Column(name="Photo_way_name")
	private String photo_way_name;	

	@Column(name="Latitude")
	private String latitude;

	@Column(name="Longitude")
	private String longitude;
	
	@Column(name="Photo_way2", unique = false, nullable = false, length = 16777215)
	private byte[] photo_way2;
	
	@Column(name="Photo_way_name2")
	private String photo_way_name2;	

	@Column(name="Latitude2")
	private String latitude2;

	@Column(name="Longitude2")
	private String longitude2;

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

	public String getAccessType() {
		return accessType;
	}

	public void setAccessType(String accessType) {
		this.accessType = accessType;
	}


	public String getRoadCondition() {
		return roadCondition;
	}

	public void setRoadCondition(String roadCondition) {
		this.roadCondition = roadCondition;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public byte[] getPhoto_way() {
		return photo_way;
	}

	public void setPhoto_way(byte[] photo_way) {
		this.photo_way = photo_way;
	}

	public String getPhoto_way_name() {
		return photo_way_name;
	}

	public void setPhoto_way_name(String photo_way_name) {
		this.photo_way_name = photo_way_name;
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

}
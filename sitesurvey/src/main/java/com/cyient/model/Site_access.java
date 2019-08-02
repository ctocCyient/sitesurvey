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
@Table(name = "Site_access")
public class Site_access implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;


	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@OneToMany
	@JoinColumn(name="siteID")
	private String siteid;
		
	@Column(name="Access_Type")
	private String accessType;
	
	@Column(name="Condition")
	private String condition;
	
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

		public String getAccessType() {
			return accessType;
		}

		public void setAccessType(String accessType) {
			this.accessType = accessType;
		}

		public String getCondition() {
			return condition;
		}

		public void setCondition(String condition) {
			this.condition = condition;
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

		public static long getSerialversionuid() {
			return serialVersionUID;
		}
	 



}
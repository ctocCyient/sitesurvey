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
@Table(name = "Survey_Wiring")
public class Site_Wiring implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;


	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="siteID")
	private Site siteid;
		
	@Column(name="Wiring_Condition")
	private String wiringCondition;

	@Column(name="Comments")
	private String comments;
	
	@Column(name="Site_photo1", unique = false, nullable = false, length = 16777215)
	private byte[] site_photo1;
	
	@Column(name="Site_Photo_name1")
	private String sitePhotoName1;	
	
	@Column(name="Site_Latitude1")
	private String siteLatitude1;
	
	@Column(name="Site_Longitude1")
	private String SiteLongitude1;
	
	@Column(name="Site_photo2", unique = false, nullable = false, length = 16777215)
	private byte[] site_photo2;
	
	@Column(name="Site_Photo_name2")
	private String sitePhotoName2;	
	
	@Column(name="Site_Latitude2")
	private String siteLatitude2;
	
	@Column(name="Site_Longitude2")
	private String SiteLongitude2;


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


	public String getWiringCondition() {
		return wiringCondition;
	}

	public void setWiringCondition(String wiringCondition) {
		this.wiringCondition = wiringCondition;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public byte[] getSite_photo1() {
		return site_photo1;
	}

	public void setSite_photo1(byte[] site_photo1) {
		this.site_photo1 = site_photo1;
	}

	public String getSitePhotoName1() {
		return sitePhotoName1;
	}

	public void setSitePhotoName1(String sitePhotoName1) {
		this.sitePhotoName1 = sitePhotoName1;
	}

	public String getSiteLatitude1() {
		return siteLatitude1;
	}

	public void setSiteLatitude1(String siteLatitude1) {
		this.siteLatitude1 = siteLatitude1;
	}

	public String getSiteLongitude1() {
		return SiteLongitude1;
	}

	public void setSiteLongitude1(String siteLongitude1) {
		SiteLongitude1 = siteLongitude1;
	}

	public byte[] getSite_photo2() {
		return site_photo2;
	}

	public void setSite_photo2(byte[] site_photo2) {
		this.site_photo2 = site_photo2;
	}

	public String getSitePhotoName2() {
		return sitePhotoName2;
	}

	public void setSitePhotoName2(String sitePhotoName2) {
		this.sitePhotoName2 = sitePhotoName2;
	}

	public String getSiteLatitude2() {
		return siteLatitude2;
	}

	public void setSiteLatitude2(String siteLatitude2) {
		this.siteLatitude2 = siteLatitude2;
	}

	public String getSiteLongitude2() {
		return SiteLongitude2;
	}

	public void setSiteLongitude2(String siteLongitude2) {
		SiteLongitude2 = siteLongitude2;
	}
}
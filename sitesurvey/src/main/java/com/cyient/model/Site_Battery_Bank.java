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
@Table(name = "Site_Battery_Bank")
public class Site_Battery_Bank implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;


	@Id
	@Column(name="Id")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="siteID")
	private Site siteid;
	
	@Column(name="Manufacturer")
	private String Manufacturer;
	
	@Column(name="Type")
	private String type;
	
	@Column(name="Manufacture_Date")
	@Temporal(TemporalType.DATE)
	private Date manufacturedDate;
	
	@Column(name="Number_of_batteries")
	private Integer number_of_batteries;
	
	@Column(name="Number_of_working_Module_rating")
	private Integer number_of_working_Module_rating;
	
	@Column(name="Overall_Condition")
	private String overallCondition;
	
	@Column(name="Comments")
	private String comments;
	
	@Column(name="Tag_observed")
	private String tag_observed;

	@Column(name="Tag_photo1", unique = false, nullable = false, length = 16777215)
	private byte[] tag_photo1;
	
	@Column(name="Tag_photo1_Name")
	private String tag_photo1_Name;
	
	@Column(name="Tag_photo1_Latitude")
	private String tag_photo1_latitude;
	
	@Column(name="Tag_photo1_Longitude")
	private String tag_photo1_longitude;

	@Column(name="Tag_photo_2", unique = false, nullable = false, length = 16777215)
	private byte[] tag_photo_2;
	
	@Column(name="Tag_photo2_Name")
	private String tag_photo2_Name;
	
	@Column(name="Tag_photo_Latitude_2")
	private String tag_photo_latitude_2;
	
	@Column(name="Tag_photo_Longitude_2")
	private String tag_photo_longitude_2;
	
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

	public String getManufacturer() {
		return Manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		Manufacturer = manufacturer;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Date getManufacturedDate() {
		return manufacturedDate;
	}

	public void setManufacturedDate(Date manufacturedDate) {
		this.manufacturedDate = manufacturedDate;
	}

	public Integer getNumber_of_batteries() {
		return number_of_batteries;
	}

	public void setNumber_of_batteries(Integer number_of_batteries) {
		this.number_of_batteries = number_of_batteries;
	}

	public Integer getNumber_of_working_Module_rating() {
		return number_of_working_Module_rating;
	}

	public void setNumber_of_working_Module_rating(Integer number_of_working_Module_rating) {
		this.number_of_working_Module_rating = number_of_working_Module_rating;
	}


	public String getOverallCondition() {
		return overallCondition;
	}

	public void setOverallCondition(String overallCondition) {
		this.overallCondition = overallCondition;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getTag_observed() {
		return tag_observed;
	}

	public void setTag_observed(String tag_observed) {
		this.tag_observed = tag_observed;
	}

	public byte[] getTag_photo1() {
		return tag_photo1;
	}

	public void setTag_photo1(byte[] tag_photo1) {
		this.tag_photo1 = tag_photo1;
	}

	public String getTag_photo1_Name() {
		return tag_photo1_Name;
	}

	public void setTag_photo1_Name(String tag_photo1_Name) {
		this.tag_photo1_Name = tag_photo1_Name;
	}

	public String getTag_photo1_latitude() {
		return tag_photo1_latitude;
	}

	public void setTag_photo1_latitude(String tag_photo1_latitude) {
		this.tag_photo1_latitude = tag_photo1_latitude;
	}

	public String getTag_photo1_longitude() {
		return tag_photo1_longitude;
	}

	public void setTag_photo1_longitude(String tag_photo1_longitude) {
		this.tag_photo1_longitude = tag_photo1_longitude;
	}

	public byte[] getTag_photo_2() {
		return tag_photo_2;
	}

	public void setTag_photo_2(byte[] tag_photo_2) {
		this.tag_photo_2 = tag_photo_2;
	}

	public String getTag_photo2_Name() {
		return tag_photo2_Name;
	}

	public void setTag_photo2_Name(String tag_photo2_Name) {
		this.tag_photo2_Name = tag_photo2_Name;
	}

	public String getTag_photo_latitude_2() {
		return tag_photo_latitude_2;
	}

	public void setTag_photo_latitude_2(String tag_photo_latitude_2) {
		this.tag_photo_latitude_2 = tag_photo_latitude_2;
	}

	public String getTag_photo_longitude_2() {
		return tag_photo_longitude_2;
	}

	public void setTag_photo_longitude_2(String tag_photo_longitude_2) {
		this.tag_photo_longitude_2 = tag_photo_longitude_2;
	}
}

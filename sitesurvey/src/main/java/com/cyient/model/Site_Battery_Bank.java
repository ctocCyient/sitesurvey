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
@Table(name = "Site_Battery_Bank")
public class Site_Battery_Bank implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;


	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@OneToMany
	@JoinColumn(name="siteID")
	private String siteid;
	
	@Column(name="Manufacturer")
	private String Manufacturer;
	
	@Column(name="Type")
	private String type;
	
	@Column(name="Manufacture _Date")
	@Temporal(TemporalType.DATE)
	private Date manufacturedate;
	
	@Column(name="Number_of_batteries")
	private Integer number_of_batteries;
	
	@Column(name="Number_of_working_Module_rating")
	private Integer number_of_working_Module_rating;
	
	@Column(name="Condition")
	private String condition;
	
	@Column(name="Comments")
	private String comments;
	
	@Column(name="Tag_photo", unique = false, nullable = false, length = 16777215)
	private byte[] tag_photo;
	
	@Column(name="Tag_photo_Latitude")
	private String tag_photo_latitude;
	
	@Column(name="Tag_photo_Longitude")
	private String tag_photo_longitude;

	@Column(name="Tag_photo_1", unique = false, nullable = false, length = 16777215)
	private byte[] tag_photo_1;
	
	@Column(name="Tag_photo_Latitude_1")
	private String tag_photo_latitude_1;
	
	@Column(name="Tag_photo_Longitude_1")
	private String tag_photo_longitude_1;

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

	public Date getManufacturedate() {
		return manufacturedate;
	}

	public void setManufacturedate(Date manufacturedate) {
		this.manufacturedate = manufacturedate;
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

	public byte[] getTag_photo() {
		return tag_photo;
	}

	public void setTag_photo(byte[] tag_photo) {
		this.tag_photo = tag_photo;
	}

	public String getTag_photo_latitude() {
		return tag_photo_latitude;
	}

	public void setTag_photo_latitude(String tag_photo_latitude) {
		this.tag_photo_latitude = tag_photo_latitude;
	}

	public String getTag_photo_longitude() {
		return tag_photo_longitude;
	}

	public void setTag_photo_longitude(String tag_photo_longitude) {
		this.tag_photo_longitude = tag_photo_longitude;
	}

	public byte[] getTag_photo_1() {
		return tag_photo_1;
	}

	public void setTag_photo_1(byte[] tag_photo_1) {
		this.tag_photo_1 = tag_photo_1;
	}

	public String getTag_photo_latitude_1() {
		return tag_photo_latitude_1;
	}

	public void setTag_photo_latitude_1(String tag_photo_latitude_1) {
		this.tag_photo_latitude_1 = tag_photo_latitude_1;
	}

	public String getTag_photo_longitude_1() {
		return tag_photo_longitude_1;
	}

	public void setTag_photo_longitude_1(String tag_photo_longitude_1) {
		this.tag_photo_longitude_1 = tag_photo_longitude_1;
	}


	







}
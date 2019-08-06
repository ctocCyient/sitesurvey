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
@Table(name = "Site_Cabinet")
public class Site_Cabinet implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;


	@Id
	@Column(name="Id")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="siteID")
	private Site siteid;
	
	@Column(name="CabinetCondition")
	private String cabinetCondition;
	
	@Column(name="CabinetManufacturer")
	private String cabinetManufacturer;
	
	@Column(name="Type")
	private String type ;
	
	@Column(name="Dimensions")
	private String dimensions;
		
	@Column(name="Comments")
	private String comments;
	
	@Column(name="Photo_1", unique = false, nullable = false, length = 16777215)
	private byte[] photo_1;
	
	@Column(name="Photo_1_Name")
	private String Photo_1_Name;
	
	@Column(name="Photo_1_Latitude")
	private String Photo_1_latitude;
	
	@Column(name="Photo_1_Longitude")
	private String Photo_1_longitude;
	
	@Column(name="Photo_2", unique = false, nullable = false, length = 16777215)
	private byte[] photo_2;
	
	@Column(name="Photo_2_Name")
	private String Photo_2_Name;
	
	@Column(name="Photo_2_Latitude")
	private String Photo_2_latitude;
	
	@Column(name="Photo_2_Longitude")
	private String Photo_2_longitude;

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

	public String getCabinetCondition() {
		return cabinetCondition;
	}

	public void setCabinetCondition(String cabinetCondition) {
		this.cabinetCondition = cabinetCondition;
	}

	public String getCabinetManufacturer() {
		return cabinetManufacturer;
	}

	public void setCabinetManufacturer(String cabinetManufacturer) {
		this.cabinetManufacturer = cabinetManufacturer;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDimensions() {
		return dimensions;
	}

	public void setDimensions(String dimensions) {
		this.dimensions = dimensions;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public byte[] getPhoto_1() {
		return photo_1;
	}

	public void setPhoto_1(byte[] photo_1) {
		this.photo_1 = photo_1;
	}

	public String getPhoto_1_latitude() {
		return Photo_1_latitude;
	}

	public void setPhoto_1_latitude(String photo_1_latitude) {
		Photo_1_latitude = photo_1_latitude;
	}

	public String getPhoto_1_longitude() {
		return Photo_1_longitude;
	}

	public void setPhoto_1_longitude(String photo_1_longitude) {
		Photo_1_longitude = photo_1_longitude;
	}

	public byte[] getPhoto_2() {
		return photo_2;
	}

	public void setPhoto_2(byte[] photo_2) {
		this.photo_2 = photo_2;
	}

	public String getPhoto_2_latitude() {
		return Photo_2_latitude;
	}

	public void setPhoto_2_latitude(String photo_2_latitude) {
		Photo_2_latitude = photo_2_latitude;
	}

	public String getPhoto_2_longitude() {
		return Photo_2_longitude;
	}

	public void setPhoto_2_longitude(String photo_2_longitude) {
		Photo_2_longitude = photo_2_longitude;
	}

	public String getPhoto_1_Name() {
		return Photo_1_Name;
	}

	public void setPhoto_1_Name(String photo_1_Name) {
		Photo_1_Name = photo_1_Name;
	}

	public String getPhoto_2_Name() {
		return Photo_2_Name;
	}

	public void setPhoto_2_Name(String photo_2_Name) {
		Photo_2_Name = photo_2_Name;
	}

}
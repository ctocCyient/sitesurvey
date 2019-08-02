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
@Table(name = "Site_SMPS")
public class Site_SMPS implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;


	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@OneToMany
	@JoinColumn(name="siteID")
	private String siteid;
	
	@Column(name="Manufacturer")
	private String Manufacturer;
	
	@Column(name="Capacity")
	private String capacity;
	
	@Column(name="DGrunhours")
	private int DGrunhours ;
	
	@Column(name="DG_photo", unique = false, nullable = false, length = 16777215)
	private byte[] gdphoto;
	
	@Column(name="DG_photo_Latitude")
	private String dg_photo_latitude;
	
	@Column(name="DG_photo_Longitude")
	private String dg_photo_longitude;
	
	@Column(name="Fuellevel")
	private String fuellevel;
	
	@Column(name="Fuellevel_photo", unique = false, nullable = false, length = 16777215)
	private byte[] fuellevel_photo;
	
	@Column(name="Fuellevel_Latitude")
	private String fuellevel_latitude;
	
	@Column(name="Fuellevel_Longitude")
	private String fuellevel_longitude;
		
	@Column(name="Condition")
	private String condition;
	
	@Column(name="Comments")
	private String comments;
	
	@Column(name="DG_inproper_1", unique = false, nullable = false, length = 16777215)
	private byte[] dg_inproper_1;
	
	@Column(name="DG_inproper_1_Latitude")
	private String dg_inproper_1_latitude;
	
	@Column(name="DG_inproper_1_Longitude")
	private String dg_inproper_1_longitude;
	
	@Column(name="DG_inproper_2", unique = false, nullable = false, length = 16777215)
	private byte[] dg_inproper_2;
	
	@Column(name="DG_inproper_2_Latitude")
	private String dg_inproper_2_latitude;
	
	@Column(name="DG_inproper_2_Longitude")
	private String dg_inproper_2_longitude;
	
	@Column(name="Assettagnumber")
	private String assettagnumber;
	
	@Column(name="Tag_photo", unique = false, nullable = false, length = 16777215)
	private byte[] tag_photo;
	
	@Column(name="Tag_photo_Latitude")
	private String tag_photo_latitude;
	
	@Column(name="Tag_photo_Longitude")
	private String tag_photo_longitude;

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

	public String getCapacity() {
		return capacity;
	}

	public void setCapacity(String capacity) {
		this.capacity = capacity;
	}

	public int getDGrunhours() {
		return DGrunhours;
	}

	public void setDGrunhours(int dGrunhours) {
		DGrunhours = dGrunhours;
	}

	public byte[] getGdphoto() {
		return gdphoto;
	}

	public void setGdphoto(byte[] gdphoto) {
		this.gdphoto = gdphoto;
	}

	public String getDg_photo_latitude() {
		return dg_photo_latitude;
	}

	public void setDg_photo_latitude(String dg_photo_latitude) {
		this.dg_photo_latitude = dg_photo_latitude;
	}

	public String getDg_photo_longitude() {
		return dg_photo_longitude;
	}

	public void setDg_photo_longitude(String dg_photo_longitude) {
		this.dg_photo_longitude = dg_photo_longitude;
	}

	public String getFuellevel() {
		return fuellevel;
	}

	public void setFuellevel(String fuellevel) {
		this.fuellevel = fuellevel;
	}

	public byte[] getFuellevel_photo() {
		return fuellevel_photo;
	}

	public void setFuellevel_photo(byte[] fuellevel_photo) {
		this.fuellevel_photo = fuellevel_photo;
	}

	public String getFuellevel_latitude() {
		return fuellevel_latitude;
	}

	public void setFuellevel_latitude(String fuellevel_latitude) {
		this.fuellevel_latitude = fuellevel_latitude;
	}

	public String getFuellevel_longitude() {
		return fuellevel_longitude;
	}

	public void setFuellevel_longitude(String fuellevel_longitude) {
		this.fuellevel_longitude = fuellevel_longitude;
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

	public byte[] getDg_inproper_1() {
		return dg_inproper_1;
	}

	public void setDg_inproper_1(byte[] dg_inproper_1) {
		this.dg_inproper_1 = dg_inproper_1;
	}

	public String getDg_inproper_1_latitude() {
		return dg_inproper_1_latitude;
	}

	public void setDg_inproper_1_latitude(String dg_inproper_1_latitude) {
		this.dg_inproper_1_latitude = dg_inproper_1_latitude;
	}

	public String getDg_inproper_1_longitude() {
		return dg_inproper_1_longitude;
	}

	public void setDg_inproper_1_longitude(String dg_inproper_1_longitude) {
		this.dg_inproper_1_longitude = dg_inproper_1_longitude;
	}

	public byte[] getDg_inproper_2() {
		return dg_inproper_2;
	}

	public void setDg_inproper_2(byte[] dg_inproper_2) {
		this.dg_inproper_2 = dg_inproper_2;
	}

	public String getDg_inproper_2_latitude() {
		return dg_inproper_2_latitude;
	}

	public void setDg_inproper_2_latitude(String dg_inproper_2_latitude) {
		this.dg_inproper_2_latitude = dg_inproper_2_latitude;
	}

	public String getDg_inproper_2_longitude() {
		return dg_inproper_2_longitude;
	}

	public void setDg_inproper_2_longitude(String dg_inproper_2_longitude) {
		this.dg_inproper_2_longitude = dg_inproper_2_longitude;
	}

	public String getAssettagnumber() {
		return assettagnumber;
	}

	public void setAssettagnumber(String assettagnumber) {
		this.assettagnumber = assettagnumber;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}	



	
	







}
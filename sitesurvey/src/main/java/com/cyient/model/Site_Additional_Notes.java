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
@Table(name = "Site_Additional_Notes")
public class Site_Additional_Notes implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@Column(name="Id")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="siteID")
	private Site siteid;
		
	@Column(name="Observations")
	private String observations;
	
	@Column(name="Site_Photo1", unique = false, nullable = false, length = 16777215)
	private byte[] site_photo1;
	
	@Column(name="Site_Photo1_Name")
	private String site_photo1_name;
	
	@Column(name="Site_Photo1_Latitude")
	private String site_photo1_latitude;

	@Column(name="Site_Photo1_Longitude")
	private String site_photo1_longitude;
	
	@Column(name="Site_Photo2", unique = false, nullable = false, length = 16777215)
	private byte[] site_photo2;
	
	@Column(name="Site_Photo2_Name")
	private String site_photo2_name;	

	@Column(name="Site_Photo2_Latitude")
	private String site_photo2_latitude;

	@Column(name="Site_Photo2_Longitude")
	private String site_photo2_longitude;

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

	public byte[] getSite_photo1() {
		return site_photo1;
	}

	public void setSite_photo1(byte[] site_photo1) {
		this.site_photo1 = site_photo1;
	}

	public String getSite_photo1_name() {
		return site_photo1_name;
	}

	public void setSite_photo1_name(String site_photo1_name) {
		this.site_photo1_name = site_photo1_name;
	}

	public String getSite_photo1_latitude() {
		return site_photo1_latitude;
	}

	public void setSite_photo1_latitude(String site_photo1_latitude) {
		this.site_photo1_latitude = site_photo1_latitude;
	}

	public String getSite_photo1_longitude() {
		return site_photo1_longitude;
	}

	public void setSite_photo1_longitude(String site_photo1_longitude) {
		this.site_photo1_longitude = site_photo1_longitude;
	}

	public byte[] getSite_photo2() {
		return site_photo2;
	}

	public void setSite_photo2(byte[] site_photo2) {
		this.site_photo2 = site_photo2;
	}

	public String getSite_photo2_name() {
		return site_photo2_name;
	}

	public void setSite_photo2_name(String site_photo2_name) {
		this.site_photo2_name = site_photo2_name;
	}

	public String getSite_photo2_latitude() {
		return site_photo2_latitude;
	}

	public void setSite_photo2_latitude(String site_photo2_latitude) {
		this.site_photo2_latitude = site_photo2_latitude;
	}

	public String getSite_photo2_longitude() {
		return site_photo2_longitude;
	}

	public void setSite_photo2_longitude(String site_photo2_longitude) {
		this.site_photo2_longitude = site_photo2_longitude;
	}
	
}
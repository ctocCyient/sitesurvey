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
@Table(name = "Site_Cabinet")
public class Site_Cabinet implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;


	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@OneToMany
	@JoinColumn(name="siteID")
	private String siteid;
	
	@Column(name="CabinetManufacturer")
	private String cabinetManufacturer;
	
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


	
	







}
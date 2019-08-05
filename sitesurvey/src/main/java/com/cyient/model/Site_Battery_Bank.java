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
	
	@Column(name="Tag_observed")
	private String tag_observed;
	
	@Column(name="Tag", unique = false, nullable = false, length = 16777215)
	private byte[] tag;
		
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


}
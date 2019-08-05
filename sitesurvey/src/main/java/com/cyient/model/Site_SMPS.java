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
	
	@Column(name="Model")
	private String model;
	
	@Column(name="Manufacture _Date")
	@Temporal(TemporalType.DATE)
	private Date manufacturedate;
	
	@Column(name="Module_rating")
	private Integer module_rating;
	
	@Column(name="Number_of_working_Module_rating")
	private Integer number_of_working_Module_rating;
	
	@Column(name="Condition")
	private String condition;
	
	@Column(name="Comments")
	private String comments;
	

	@Column(name="Observation_1", unique = false, nullable = false, length = 16777215)
	private byte[] observation_1;
	
	@Column(name="Observation_1_Latitude")
	private String observation_1_latitude;
	
	@Column(name="Observation_1_Longitude")
	private String observation_1_longitude;
	
	@Column(name="Observation_2", unique = false, nullable = false, length = 16777215)
	private byte[] observation_2;
	
	@Column(name="Observation_2_Latitude")
	private String observation_2_latitude;
	
	@Column(name="Observation_2_Longitude")
	private String observation_2_longitude;

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



	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public Date getManufacturedate() {
		return manufacturedate;
	}

	public void setManufacturedate(Date manufacturedate) {
		this.manufacturedate = manufacturedate;
	}

	public Integer getModule_rating() {
		return module_rating;
	}

	public void setModule_rating(Integer module_rating) {
		this.module_rating = module_rating;
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

	public byte[] getObservation_1() {
		return observation_1;
	}

	public void setObservation_1(byte[] observation_1) {
		this.observation_1 = observation_1;
	}

	public String getObservation_1_latitude() {
		return observation_1_latitude;
	}

	public void setObservation_1_latitude(String observation_1_latitude) {
		this.observation_1_latitude = observation_1_latitude;
	}

	public String getObservation_1_longitude() {
		return observation_1_longitude;
	}

	public void setObservation_1_longitude(String observation_1_longitude) {
		this.observation_1_longitude = observation_1_longitude;
	}

	public byte[] getObservation_2() {
		return observation_2;
	}

	public void setObservation_2(byte[] observation_2) {
		this.observation_2 = observation_2;
	}

	public String getObservation_2_latitude() {
		return observation_2_latitude;
	}

	public void setObservation_2_latitude(String observation_2_latitude) {
		this.observation_2_latitude = observation_2_latitude;
	}

	public String getObservation_2_longitude() {
		return observation_2_longitude;
	}

	public void setObservation_2_longitude(String observation_2_longitude) {
		this.observation_2_longitude = observation_2_longitude;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}









}
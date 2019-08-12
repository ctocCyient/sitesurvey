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
@Table(name = "Site_SMPS")
public class Site_SMPS implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;


	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="siteID")
	private Site siteid;
	
	@Column(name="Manufacturer")
	private String Manufacturer;
	
	@Column(name="Model")
	private String model;
	
	@Column(name="Manufactured_Date")
	@Temporal(TemporalType.DATE)
	private Date manufacturedDate;
	
	@Column(name="Module_rating")
	private int module_rating;
	
	@Column(name="Number_of_working_Module_rating")
	private int number_of_working_Module_rating;
	
	@Column(name="SMPS_Condition")
	private String smpsCondition;
	
	@Column(name="Comments")
	private String comments;
	
	@Column(name="Observation_1", unique = false, nullable = false, length = 16777215)
	private byte[] observation_1;
	
	@Column(name="Observation_1_Name")
	private String Observation_1_Name;
	
	@Column(name="Observation_1_Latitude")
	private String observation_1_latitude;
	
	@Column(name="Observation_1_Longitude")
	private String observation_1_longitude;
	
	@Column(name="Observation_2", unique = false, nullable = false, length = 16777215)
	private byte[] observation_2;
	
	@Column(name="Observation_2_Name")
	private String observation_2_Name;
	
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

	public Site getSiteid() {
		return siteid;
	}

	public void setSiteid(Site siteid) {
		this.siteid = siteid;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public Date getManufacturedDate() {
		return manufacturedDate;
	}

	public void setManufacturedDate(Date manufacturedDate) {
		this.manufacturedDate = manufacturedDate;
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

	
	public String getManufacturer() {
		return Manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		Manufacturer = manufacturer;
	}

	public String getSmpsCondition() {
		return smpsCondition;
	}

	public void setSmpsCondition(String smpsCondition) {
		this.smpsCondition = smpsCondition;
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

	public String getObservation_1_Name() {
		return Observation_1_Name;
	}

	public void setObservation_1_Name(String observation_1_Name) {
		Observation_1_Name = observation_1_Name;
	}

	public String getObservation_2_Name() {
		return observation_2_Name;
	}

	public void setObservation_2_Name(String observation_2_Name) {
		this.observation_2_Name = observation_2_Name;
	}

	public void setModule_rating(int module_rating) {
		this.module_rating = module_rating;
	}

	public void setNumber_of_working_Module_rating(int number_of_working_Module_rating) {
		this.number_of_working_Module_rating = number_of_working_Module_rating;
	}

}
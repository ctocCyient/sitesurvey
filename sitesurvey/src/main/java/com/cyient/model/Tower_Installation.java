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
@Table(name = "Tower_Installation")
public class Tower_Installation implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="siteID")
	private Site siteid;
		
	@Column(name="Tower_Type")
	private String towerType;
	
	@Column(name="Observation_Notes")
	private String observationNotes;
	
	@Column(name="Virtual_Inspection")
	private String virtualInspection;
	
	@Column(name="Virtual_Inspection_2")
	private String virtualInspection2;
	
	@Column(name="Comments")
	private String comments;
	
	@Column(name="RF_Antenna_Num")
	private int noofRFAntennas;
	
	@Column(name="MW_Antenna_Num")
	private int noofMWAntenna;
	
	@Column(name="RRH_Num")
	private int noofRRH;
	
	@Column(name="Tower_Photo1", unique = false, nullable = false, length = 16777215)
	private byte[] tower_photo1;
	
	@Column(name="Tower_Photo1_Name")
	private String tower_photo1_name;
	

	@Column(name="Tower_Photo1_Latitude")
	private String tower_photo1_latitude;

	@Column(name="Tower_Photo1_Longitude")
	private String tower_photo1_longitude;
	
	@Column(name="Tower_Photo2", unique = false, nullable = false, length = 16777215)
	private byte[] tower_photo2;
	
	@Column(name="Tower_Photo2_Name")
	private String tower_photo2_name;
	

	@Column(name="Tower_Photo2_Latitude")
	private String tower_photo2_latitude;

	@Column(name="Tower_Photo2_Longitude")
	private String tower_photo2_longitude;
	
	
	@Column(name="Tower_Photo3", unique = false, nullable = false, length = 16777215)
	private byte[] tower_photo3;
	
	@Column(name="Tower_Photo3_Name")
	private String tower_photo3_name;
	

	@Column(name="Tower_Photo3_Latitude")
	private String tower_photo3_latitude;

	@Column(name="Tower_Photo3_Longitude")
	private String tower_photo3_longitude;
	
	@Column(name="Tower_Photo4", unique = false, nullable = false, length = 16777215)
	private byte[] tower_photo4;
	
	@Column(name="Tower_Photo4_Name")
	private String tower_photo4_name;
	
	@Column(name="Tower_Photo4_Latitude")
	private String tower_photo4_latitude;

	@Column(name="Tower_Photo4_Longitude")
	private String tower_photo4_longitude;

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

	public String getTowerType() {
		return towerType;
	}

	public void setTowerType(String towerType) {
		this.towerType = towerType;
	}

	public String getObservationNotes() {
		return observationNotes;
	}

	public void setObservationNotes(String observationNotes) {
		this.observationNotes = observationNotes;
	}

	public String getVirtualInspection() {
		return virtualInspection;
	}

	public void setVirtualInspection(String virtualInspection) {
		this.virtualInspection = virtualInspection;
	}

	public String getVirtualInspection2() {
		return virtualInspection2;
	}

	public void setVirtualInspection2(String virtualInspection2) {
		this.virtualInspection2 = virtualInspection2;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public int getNoofRFAntennas() {
		return noofRFAntennas;
	}

	public void setNoofRFAntennas(int noofRFAntennas) {
		this.noofRFAntennas = noofRFAntennas;
	}

	public int getNoofMWAntenna() {
		return noofMWAntenna;
	}

	public void setNoofMWAntenna(int noofMWAntenna) {
		this.noofMWAntenna = noofMWAntenna;
	}

	public int getNoofRRH() {
		return noofRRH;
	}

	public void setNoofRRH(int noofRRH) {
		this.noofRRH = noofRRH;
	}

	public byte[] getTower_photo1() {
		return tower_photo1;
	}

	public void setTower_photo1(byte[] tower_photo1) {
		this.tower_photo1 = tower_photo1;
	}

	public String getTower_photo1_name() {
		return tower_photo1_name;
	}

	public void setTower_photo1_name(String tower_photo1_name) {
		this.tower_photo1_name = tower_photo1_name;
	}

	public String getTower_photo1_latitude() {
		return tower_photo1_latitude;
	}

	public void setTower_photo1_latitude(String tower_photo1_latitude) {
		this.tower_photo1_latitude = tower_photo1_latitude;
	}

	public String getTower_photo1_longitude() {
		return tower_photo1_longitude;
	}

	public void setTower_photo1_longitude(String tower_photo1_longitude) {
		this.tower_photo1_longitude = tower_photo1_longitude;
	}

	public byte[] getTower_photo2() {
		return tower_photo2;
	}

	public void setTower_photo2(byte[] tower_photo2) {
		this.tower_photo2 = tower_photo2;
	}

	public String getTower_photo2_name() {
		return tower_photo2_name;
	}

	public void setTower_photo2_name(String tower_photo2_name) {
		this.tower_photo2_name = tower_photo2_name;
	}

	public String getTower_photo2_latitude() {
		return tower_photo2_latitude;
	}

	public void setTower_photo2_latitude(String tower_photo2_latitude) {
		this.tower_photo2_latitude = tower_photo2_latitude;
	}

	public String getTower_photo2_longitude() {
		return tower_photo2_longitude;
	}

	public void setTower_photo2_longitude(String tower_photo2_longitude) {
		this.tower_photo2_longitude = tower_photo2_longitude;
	}

	public byte[] getTower_photo3() {
		return tower_photo3;
	}

	public void setTower_photo3(byte[] tower_photo3) {
		this.tower_photo3 = tower_photo3;
	}

	public String getTower_photo3_name() {
		return tower_photo3_name;
	}

	public void setTower_photo3_name(String tower_photo3_name) {
		this.tower_photo3_name = tower_photo3_name;
	}

	public String getTower_photo3_latitude() {
		return tower_photo3_latitude;
	}

	public void setTower_photo3_latitude(String tower_photo3_latitude) {
		this.tower_photo3_latitude = tower_photo3_latitude;
	}

	public String getTower_photo3_longitude() {
		return tower_photo3_longitude;
	}

	public void setTower_photo3_longitude(String tower_photo3_longitude) {
		this.tower_photo3_longitude = tower_photo3_longitude;
	}

	public byte[] getTower_photo4() {
		return tower_photo4;
	}

	public void setTower_photo4(byte[] tower_photo4) {
		this.tower_photo4 = tower_photo4;
	}

	public String getTower_photo4_name() {
		return tower_photo4_name;
	}

	public void setTower_photo4_name(String tower_photo4_name) {
		this.tower_photo4_name = tower_photo4_name;
	}

	public String getTower_photo4_latitude() {
		return tower_photo4_latitude;
	}

	public void setTower_photo4_latitude(String tower_photo4_latitude) {
		this.tower_photo4_latitude = tower_photo4_latitude;
	}

	public String getTower_photo4_longitude() {
		return tower_photo4_longitude;
	}

	public void setTower_photo4_longitude(String tower_photo4_longitude) {
		this.tower_photo4_longitude = tower_photo4_longitude;
	}

		


}
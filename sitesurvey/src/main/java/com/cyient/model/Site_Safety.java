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
@Table(name = "Site_Safety")
public class Site_Safety implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="siteID")
	private Site siteid;
		
	@Column(name="Extinguishers_Availability")
	private String extinguishersAvailability;
	
	 @Column(name="Extinguishers_Due_Date")
	 @Temporal(TemporalType.DATE)
	private Date extinguishersDueDate;
	
	@Column(name="Safety_Photo1", unique = false, nullable = false, length = 16777215)
	private byte[] safety_photo1;
	
	@Column(name="Safety_Photo1_Name")
	private String safety_photo1_name;
	
	@Column(name="Safety_Photo1_Latitude")
	private String safety_photo1_latitude;

	@Column(name="Safety_Photo1_Longitude")
	private String safety_photo1_longitude;
	
	@Column(name="Aviation_Lights")
	private String aviationLights;

	@Column(name="Lightning_Arrestor")
	private String lightningArrestor;
	
	@Column(name="RTT_RTP_Locations")
	private String rtt_rtp_locations;
	
	
	@Column(name="Safety_Photo2", unique = false, nullable = false, length = 16777215)
	private byte[] safety_photo2;
	
	@Column(name="Safety_Photo2_Name")
	private String safety_photo2_name;	

	@Column(name="Safety_Photo2_Latitude")
	private String safety_photo2_latitude;

	@Column(name="Safety_Photo2_Longitude")
	private String safety_photo2_longitude;
	
	@Column(name="Stairs_Ladders_Condition")
	private String stairsLaddersCondition;

	@Column(name="Safety_Photo3", unique = false, nullable = false, length = 16777215)
	private byte[] safety_photo3;
	
	@Column(name="Safety_Photo3_Name")
	private String safety_photo3_name;
	
	@Column(name="Safety_Photo3_Latitude")
	private String safety_photo3_latitude;

	@Column(name="Safety_Photo3_Longitude")
	private String safety_photo3_longitude;
	
	@Column(name="Safe_Climb_Device")
	private String safeClimbDevice;
	
	@Column(name="Anti_Climb_Protection")
	private String antiClimbProtection;
	
	@Column(name="Site_Fire_Clear")
	private String siteFireClear;
	
	@Column(name="Safety_Photo4", unique = false, nullable = false, length = 16777215)
	private byte[] safety_photo4;
	
	@Column(name="Safety_Photo4_Name")
	private String safety_photo4_name;	

	@Column(name="Safety_Photo4_Latitude")
	private String safety_photo4_latitude;

	@Column(name="Safety_Photo4_Longitude")
	private String safety_photo4_longitude;
	
	@Column(name="Oil_Spills_DG")
	private String oilSpillsDG;
	
	@Column(name="Safety_Signage")
	private String safetySignage;
	
	@Column(name="Safety_Photo5", unique = false, nullable = false, length = 16777215)
	private byte[] safety_photo5;
	
	@Column(name="Safety_Photo5_Name")
	private String safety_photo5_name;
	
	@Column(name="Safety_Photo5_Latitude")
	private String safety_photo5_latitude;

	@Column(name="Safety_Photo5_Longitude")
	private String safety_photo5_longitude;
	
	@Column(name="Observations")
	private String observations;
	
	@Column(name="Safety_Photo6", unique = false, nullable = false, length = 16777215)
	private byte[] safety_photo6;
	
	@Column(name="Safety_Photo6_Name")
	private String safety_photo6_name;	

	@Column(name="Safety_Photo6_Latitude")
	private String safety_photo6_latitude;

	@Column(name="Safety_Photo6_Longitude")
	private String safety_photo6_longitude;
	
	@Column(name="Safety_Photo7", unique = false, nullable = false, length = 16777215)
	private byte[] safety_photo7;
	
	@Column(name="Safety_Photo7_Name")
	private String safety_photo7_name;
	
	@Column(name="Safety_Photo7_Latitude")
	private String safety_photo7_latitude;

	@Column(name="Safety_Photo7_Longitude")
	private String safety_photo7_longitude;

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

	public String getExtinguishersAvailability() {
		return extinguishersAvailability;
	}

	public void setExtinguishersAvailability(String extinguishersAvailability) {
		this.extinguishersAvailability = extinguishersAvailability;
	}

	public Date getExtinguishersDueDate() {
		return extinguishersDueDate;
	}

	public void setExtinguishersDueDate(Date extinguishersDueDate) {
		this.extinguishersDueDate = extinguishersDueDate;
	}

	public byte[] getSafety_photo1() {
		return safety_photo1;
	}

	public void setSafety_photo1(byte[] safety_photo1) {
		this.safety_photo1 = safety_photo1;
	}

	public String getSafety_photo1_name() {
		return safety_photo1_name;
	}

	public void setSafety_photo1_name(String safety_photo1_name) {
		this.safety_photo1_name = safety_photo1_name;
	}

	public String getSafety_photo1_latitude() {
		return safety_photo1_latitude;
	}

	public void setSafety_photo1_latitude(String safety_photo1_latitude) {
		this.safety_photo1_latitude = safety_photo1_latitude;
	}

	public String getSafety_photo1_longitude() {
		return safety_photo1_longitude;
	}

	public void setSafety_photo1_longitude(String safety_photo1_longitude) {
		this.safety_photo1_longitude = safety_photo1_longitude;
	}

	public String getAviationLights() {
		return aviationLights;
	}

	public void setAviationLights(String aviationLights) {
		this.aviationLights = aviationLights;
	}

	public String getLightningArrestor() {
		return lightningArrestor;
	}

	public void setLightningArrestor(String lightningArrestor) {
		this.lightningArrestor = lightningArrestor;
	}

	public String getRtt_rtp_locations() {
		return rtt_rtp_locations;
	}

	public void setRtt_rtp_locations(String rtt_rtp_locations) {
		this.rtt_rtp_locations = rtt_rtp_locations;
	}

	public byte[] getSafety_photo2() {
		return safety_photo2;
	}

	public void setSafety_photo2(byte[] safety_photo2) {
		this.safety_photo2 = safety_photo2;
	}

	public String getSafety_photo2_name() {
		return safety_photo2_name;
	}

	public void setSafety_photo2_name(String safety_photo2_name) {
		this.safety_photo2_name = safety_photo2_name;
	}

	public String getSafety_photo2_latitude() {
		return safety_photo2_latitude;
	}

	public void setSafety_photo2_latitude(String safety_photo2_latitude) {
		this.safety_photo2_latitude = safety_photo2_latitude;
	}

	public String getSafety_photo2_longitude() {
		return safety_photo2_longitude;
	}

	public void setSafety_photo2_longitude(String safety_photo2_longitude) {
		this.safety_photo2_longitude = safety_photo2_longitude;
	}

	public String getStairsLaddersCondition() {
		return stairsLaddersCondition;
	}

	public void setStairsLaddersCondition(String stairsLaddersCondition) {
		this.stairsLaddersCondition = stairsLaddersCondition;
	}

	public byte[] getSafety_photo3() {
		return safety_photo3;
	}

	public void setSafety_photo3(byte[] safety_photo3) {
		this.safety_photo3 = safety_photo3;
	}

	public String getSafety_photo3_name() {
		return safety_photo3_name;
	}

	public void setSafety_photo3_name(String safety_photo3_name) {
		this.safety_photo3_name = safety_photo3_name;
	}

	public String getSafety_photo3_latitude() {
		return safety_photo3_latitude;
	}

	public void setSafety_photo3_latitude(String safety_photo3_latitude) {
		this.safety_photo3_latitude = safety_photo3_latitude;
	}

	public String getSafety_photo3_longitude() {
		return safety_photo3_longitude;
	}

	public void setSafety_photo3_longitude(String safety_photo3_longitude) {
		this.safety_photo3_longitude = safety_photo3_longitude;
	}

	public String getSafeClimbDevice() {
		return safeClimbDevice;
	}

	public void setSafeClimbDevice(String safeClimbDevice) {
		this.safeClimbDevice = safeClimbDevice;
	}

	public String getAntiClimbProtection() {
		return antiClimbProtection;
	}

	public void setAntiClimbProtection(String antiClimbProtection) {
		this.antiClimbProtection = antiClimbProtection;
	}

	public String getSiteFireClear() {
		return siteFireClear;
	}

	public void setSiteFireClear(String siteFireClear) {
		this.siteFireClear = siteFireClear;
	}

	public byte[] getSafety_photo4() {
		return safety_photo4;
	}

	public void setSafety_photo4(byte[] safety_photo4) {
		this.safety_photo4 = safety_photo4;
	}

	public String getSafety_photo4_name() {
		return safety_photo4_name;
	}

	public void setSafety_photo4_name(String safety_photo4_name) {
		this.safety_photo4_name = safety_photo4_name;
	}

	public String getSafety_photo4_latitude() {
		return safety_photo4_latitude;
	}

	public void setSafety_photo4_latitude(String safety_photo4_latitude) {
		this.safety_photo4_latitude = safety_photo4_latitude;
	}

	public String getSafety_photo4_longitude() {
		return safety_photo4_longitude;
	}

	public void setSafety_photo4_longitude(String safety_photo4_longitude) {
		this.safety_photo4_longitude = safety_photo4_longitude;
	}

	public String getOilSpillsDG() {
		return oilSpillsDG;
	}

	public void setOilSpillsDG(String oilSpillsDG) {
		this.oilSpillsDG = oilSpillsDG;
	}

	public String getSafetySignage() {
		return safetySignage;
	}

	public void setSafetySignage(String safetySignage) {
		this.safetySignage = safetySignage;
	}

	public byte[] getSafety_photo5() {
		return safety_photo5;
	}

	public void setSafety_photo5(byte[] safety_photo5) {
		this.safety_photo5 = safety_photo5;
	}

	public String getSafety_photo5_name() {
		return safety_photo5_name;
	}

	public void setSafety_photo5_name(String safety_photo5_name) {
		this.safety_photo5_name = safety_photo5_name;
	}

	public String getSafety_photo5_latitude() {
		return safety_photo5_latitude;
	}

	public void setSafety_photo5_latitude(String safety_photo5_latitude) {
		this.safety_photo5_latitude = safety_photo5_latitude;
	}

	public String getSafety_photo5_longitude() {
		return safety_photo5_longitude;
	}

	public void setSafety_photo5_longitude(String safety_photo5_longitude) {
		this.safety_photo5_longitude = safety_photo5_longitude;
	}

	public String getObservations() {
		return observations;
	}

	public void setObservations(String observations) {
		this.observations = observations;
	}

	public byte[] getSafety_photo6() {
		return safety_photo6;
	}

	public void setSafety_photo6(byte[] safety_photo6) {
		this.safety_photo6 = safety_photo6;
	}

	public String getSafety_photo6_name() {
		return safety_photo6_name;
	}

	public void setSafety_photo6_name(String safety_photo6_name) {
		this.safety_photo6_name = safety_photo6_name;
	}

	public String getSafety_photo6_latitude() {
		return safety_photo6_latitude;
	}

	public void setSafety_photo6_latitude(String safety_photo6_latitude) {
		this.safety_photo6_latitude = safety_photo6_latitude;
	}

	public String getSafety_photo6_longitude() {
		return safety_photo6_longitude;
	}

	public void setSafety_photo6_longitude(String safety_photo6_longitude) {
		this.safety_photo6_longitude = safety_photo6_longitude;
	}

	public byte[] getSafety_photo7() {
		return safety_photo7;
	}

	public void setSafety_photo7(byte[] safety_photo7) {
		this.safety_photo7 = safety_photo7;
	}

	public String getSafety_photo7_name() {
		return safety_photo7_name;
	}

	public void setSafety_photo7_name(String safety_photo7_name) {
		this.safety_photo7_name = safety_photo7_name;
	}

	public String getSafety_photo7_latitude() {
		return safety_photo7_latitude;
	}

	public void setSafety_photo7_latitude(String safety_photo7_latitude) {
		this.safety_photo7_latitude = safety_photo7_latitude;
	}

	public String getSafety_photo7_longitude() {
		return safety_photo7_longitude;
	}

	public void setSafety_photo7_longitude(String safety_photo7_longitude) {
		this.safety_photo7_longitude = safety_photo7_longitude;
	}

}
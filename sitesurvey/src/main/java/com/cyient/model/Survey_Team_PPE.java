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
@Table(name = "Survey_Team_PPE")
public class Survey_Team_PPE implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;


	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="siteID")
	private Site siteid;
		
	@Column(name="PPE")
	private String ppe;
	
	@Column(name="Photo_survey_team", unique = false, nullable = false, length = 16777215)
	private byte[] photoSurveyTeam;
	
	@Column(name="Technician_Name")
	private String technicianName;
	
	@Column(name="Technician_Wearing")
	private String technicianWearing;

	@Column(name="Photo_Technician_Team", unique = false, nullable = false, length = 16777215)
	private byte[] photoTechnicianTeam;
		
	@Column(name="Rigger_Name")
	private String rigger_Name;
	
	@Column(name="Rigger_Wearing")
	private String rigger_Wearing;
	
	@Column(name="Photo_Rigger_Team", unique = false, nullable = false, length = 16777215)
	private byte[] photoRiggerTeam;

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

	public String getPpe() {
		return ppe;
	}

	public void setPpe(String ppe) {
		this.ppe = ppe;
	}

	public byte[] getPhotoSurveyTeam() {
		return photoSurveyTeam;
	}

	public void setPhotoSurveyTeam(byte[] photoSurveyTeam) {
		this.photoSurveyTeam = photoSurveyTeam;
	}

	public String getTechnicianName() {
		return technicianName;
	}

	public void setTechnicianName(String technicianName) {
		this.technicianName = technicianName;
	}

	public String getTechnicianWearing() {
		return technicianWearing;
	}

	public void setTechnicianWearing(String technicianWearing) {
		this.technicianWearing = technicianWearing;
	}

	public byte[] getPhotoTechnicianTeam() {
		return photoTechnicianTeam;
	}

	public void setPhotoTechnicianTeam(byte[] photoTechnicianTeam) {
		this.photoTechnicianTeam = photoTechnicianTeam;
	}

	public String getRigger_Name() {
		return rigger_Name;
	}

	public void setRigger_Name(String rigger_Name) {
		this.rigger_Name = rigger_Name;
	}

	public String getRigger_Wearing() {
		return rigger_Wearing;
	}

	public void setRigger_Wearing(String rigger_Wearing) {
		this.rigger_Wearing = rigger_Wearing;
	}

	public byte[] getPhotoRiggerTeam() {
		return photoRiggerTeam;
	}

	public void setPhotoRiggerTeam(byte[] photoRiggerTeam) {
		this.photoRiggerTeam = photoRiggerTeam;
	}


}
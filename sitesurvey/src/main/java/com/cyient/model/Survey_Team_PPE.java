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
@Table(name = "Survey_Team_PPE")
public class Survey_Team_PPE implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;


	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@OneToMany
	@JoinColumn(name="siteID")
	private String siteid;
		
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


}
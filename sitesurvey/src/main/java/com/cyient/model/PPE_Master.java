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
public class PPE_Master implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;


	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@Column(name="PPE")
	private String ppe;
	
	@Column(name="Photo_survey_team", unique = false, nullable = false, length = 16777215)
	private byte[] photoSurveyTeam;
	
	@Column(name="PhotoName")
	private String photoName;
	
	@Column(name="Photo", unique = false, nullable = false, length = 16777215)
	private byte[] photo;

	
}
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
@Table(name = "Cabinet_Master")
public class Cabinet_Master implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;


	@Id
	@Column(name="Id")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@Column(name="CabinetManufacturer")
	private String cabinetManufacturer;
	
	@Column(name="Type")
	private String type ;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCabinetManufacturer() {
		return cabinetManufacturer;
	}

	public void setCabinetManufacturer(String cabinetManufacturer) {
		this.cabinetManufacturer = cabinetManufacturer;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
}
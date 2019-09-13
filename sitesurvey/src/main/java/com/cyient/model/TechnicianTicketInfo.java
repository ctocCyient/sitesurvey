package com.cyient.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "TechnicianTicketInfo")
public class TechnicianTicketInfo implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@Column(name="Id")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@Column(name="Technician_Id")
	private String technicianId;
	
	@Column(name="Technician_Name")
	private String technicianName;
	
	@Column(name="Ticket_Num")
	private String ticketNum;
	
	@Column(name="siteIds",length=16777215)
	private String siteids;
	
	@Column(name="siteID")
	private String siteid;
	
	@Column(name="Region")
	private String region;
	
	@Column(name="Manager")
	private String manager;
	
	@Column(name="State")
	private String state;
	
	@Column(name="District")
	private String district;
	
	@Column(name="City")
	private String city;
	
	@Column(name="Status")
	private String status;
	
	@Column(name="Ticket_Description")
	private String ticketDescription;
	
	@Column(name="Open_Date")
	@Temporal(TemporalType.DATE)
	private Date openDate;
	
	@Column(name="Open_Time")
	@Temporal(TemporalType.TIME)
	private Date openTime;
	
	@Column(name="Closed_Date")
	@Temporal(TemporalType.DATE)
	private Date closedDate;
	
	@Column(name="Closed_Time")
	@Temporal(TemporalType.TIME)
	private Date closedTime;
	
	@Column(name="Comments")
	private String comments;
	
	@Column(name="Remarks")
	private String remarks;
	
	@Column(name="Site_Flag")
	private String siteFlag;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSiteFlag() {
		return siteFlag;
	}

	public void setSiteFlag(String siteFlag) {
		this.siteFlag = siteFlag;
	}

	public String getTechnicianId() {
		return technicianId;
	}

	public void setTechnicianId(String technicianId) {
		this.technicianId = technicianId;
	}

	public String getTechnicianName() {
		return technicianName;
	}

	public void setTechnicianName(String technicianName) {
		this.technicianName = technicianName;
	}

	public String getSiteids() {
		return siteids;
	}

	public void setSiteids(String siteids) {
		this.siteids = siteids;
	}

	public String getTicketNum() {
		return ticketNum;
	}

	public void setTicketNum(String ticketNum) {
		this.ticketNum = ticketNum;
	}

	public String getSiteid() {
		return siteid;
	}

	public void setSiteid(String siteid) {
		this.siteid = siteid;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTicketDescription() {
		return ticketDescription;
	}

	public void setTicketDescription(String ticketDescription) {
		this.ticketDescription = ticketDescription;
	}

	public Date getOpenDate() {
		return openDate;
	}

	public void setOpenDate(Date openDate) {
		this.openDate = openDate;
	}

	public Date getOpenTime() {
		return openTime;
	}

	public void setOpenTime(Date openTime) {
		this.openTime = openTime;
	}

	public Date getClosedDate() {
		return closedDate;
	}

	public void setClosedDate(Date closedDate) {
		this.closedDate = closedDate;
	}

	public Date getClosedTime() {
		return closedTime;
	}

	public void setClosedTime(Date closedTime) {
		this.closedTime = closedTime;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
}
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
@Table(name = "Ticketing")
public class Ticketing implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name="Id")
	private int id;
	
	@Column(name="Ticket_Num")
	private String ticketNum;

	@Column(name="Region")
	private String region;
	
	@Column(name="State")
	private String state;
	
	@Column(name="District")
	private String district;
	
	@Column(name="City")
	private String city;	
	
	@Column(name="siteIds",length=16777215)
	private String siteids;
	
	@Column(name="siteID")
	private String siteid;
	
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
	
	@Column(name="Status")
	private String status;
	
	@Column(name="Site_Status")
	private String siteStatus;
	
	@Column(name="Comments")
	private String comments;
	
	@Column(name="Remarks")
	private String remarks;


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
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

	public String getSiteStatus() {
		return siteStatus;
	}

	public void setSiteStatus(String siteStatus) {
		this.siteStatus = siteStatus;
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

	public String getSiteid() {
		return siteid;
	}

	public void setSiteid(String siteid) {
		this.siteid = siteid;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
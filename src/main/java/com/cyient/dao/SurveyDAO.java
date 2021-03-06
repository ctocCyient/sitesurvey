package com.cyient.dao;

import java.util.List;

import javax.transaction.Transactional;

import com.cyient.model.Regions;
import com.cyient.model.Site;
import com.cyient.model.Technician;
<<<<<<< HEAD
import com.cyient.model.Ticketing;
import com.cyient.model.User;


public interface SurveyDAO {
	
	@Transactional
	public void addUser(User user);
	
	@Transactional
	public User getAllUsersOnCriteria(String username,String password,String type);
	
	@Transactional
	public void addSite(Site site);
	
	@Transactional
	public List<Regions> getRegions();
	
	@Transactional
	public List<Regions> getStates(String region);
	
	@Transactional
	public List<Regions> getDistricts(String region,String state);
	
	@Transactional
	public List<Regions> getCities(String region,String state,String district);
	
	@Transactional
	public String getUserName(String role, String username);

	@Transactional
	public List<User> getManager(String region);
	
	@Transactional
	public List<Site> getSiteId();

	@Transactional
	public String getManagerId(String managerName);
	
	@Transactional
	 public List<User> getManagerDetails(String managerId);
	
	@Transactional
	public List<Ticketing> getTicketId();
	
	@Transactional
	public void addTechnician(Technician technician);
	
	@Transactional
	public void addTechnicianIntoUsers(User user);
=======
import com.cyient.model.TechnicianTicketInfo;
import com.cyient.model.Ticketing;
import com.cyient.model.Track_Users;
import com.cyient.model.User;


public interface SurveyDAO {
	
	@Transactional
	public void addUser(User user);
	
	@Transactional
	public List<User> getAllUsersOnCriteria(String username,String password,String type);
	
	@Transactional
	public void addSite(Site site);
	
	@Transactional
	public List<Regions> getRegions();
	
	@Transactional
	public List<Regions> getStates(String region);
	
	@Transactional
	public List<Regions> getDistricts(String region,String state);
	
	@Transactional
	public List<Regions> getCities(String region,String state,String district);
	
	@Transactional
	public List<Site> getSiteIdsForRegion(String region, String state, String district, String city);

	
	@Transactional
	public String getUserName(String role, String username);

	@Transactional
	public List<User> getManager(String region);
	
	@Transactional
	public List<Site> getSiteId();

	@Transactional
	public String getManagerId(String managerName);
	
	@Transactional
	 public List<User> getManagerDetails(String managerId);
	
	@Transactional
	public List<Ticketing> getTicketId();
	
	@Transactional
	public void addTechnician(Technician technician);
	
	@Transactional
	public void addTechnicianIntoUsers(User user);

	@Transactional
	public List<Ticketing> openTicketsData();

	@Transactional
	public List<TechnicianTicketInfo> assignedTicketsData();

	@Transactional
	public List<TechnicianTicketInfo> historyTicketsData();

	@Transactional
	public List<Ticketing> getAllTicketsData();

	@Transactional
	public List<Technician> getUnassignedTechniciansData(String region, String city);

	@Transactional
	public List<TechnicianTicketInfo> managerOpenTickets(String username,String region,String city);
	
	@Transactional
	public List<TechnicianTicketInfo> managerClosedTickets(String username);
	
	@Transactional
	public List<Technician> getManagerTechnicians(String username);

	@Transactional
	public List<TechnicianTicketInfo> techAssignedTicketsData(String username);
	
	@Transactional
	public List<TechnicianTicketInfo> techClosedTicketsData(String username);

	@Transactional
	public String assignTechnician(TechnicianTicketInfo technicianTicket);

	@Transactional
	public String updateTicketingStatus(String ticketId);

	@Transactional
	public Technician getTechniciansData(String technicianId);

	@Transactional
	public List<Ticketing> getTicketsData(String ticketNum);

	@Transactional
	public String saveTrackuser(Track_Users trackuser);

	@Transactional
	public void addTicket(Ticketing ticket);
>>>>>>> branch 'master' of https://github.com/ctocCyient/sitesurvey

}

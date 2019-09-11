package com.cyient.dao;

import java.util.List;

import javax.transaction.Transactional;

import com.cyient.model.Battery_Bank_Master;
import com.cyient.model.Regions;
import com.cyient.model.Site;

import com.cyient.model.Site_Access;
import com.cyient.model.Site_Area;
import com.cyient.model.Site_Battery_Bank;
import com.cyient.model.Site_Cabinet;
import com.cyient.model.Site_Generator;
import com.cyient.model.Site_SMPS;
import com.cyient.model.Site_Wiring;
import com.cyient.model.Technician;
import com.cyient.model.TechnicianTicketInfo;
import com.cyient.model.Ticketing;
import com.cyient.model.Tower_Installation;
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
	public void addGenerator(Site_Generator generator);
	
	@Transactional
	public void addSiteAccess(Site_Access siteacc);
	
	@Transactional
	public void addSiteArea(Site_Area sitearea);
	
	@Transactional
	public void addSitePowering(Site_Wiring powerwire);
		
	@Transactional
	public void addSMPS(Site_SMPS smps);

	public void addBB(Site_Battery_Bank BB);
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
	public List<Ticketing> managerOpenTickets(String username,String region,String city);
	
	@Transactional
	public List<TechnicianTicketInfo> managerClosedTickets(String username);
	
	@Transactional
	public List<Technician> getManagerTechnicians(String username);

	@Transactional
	public List<TechnicianTicketInfo> techAssignedTicketsData(String username);
	
	@Transactional
	public List<TechnicianTicketInfo> techAcceptedTicketsData(String username);
	
	@Transactional
	public List<TechnicianTicketInfo> techClosedTicketsData(String username);

	@Transactional
	public String assignTechnician(TechnicianTicketInfo technicianTicket);

	@Transactional
	public String updateTicketingStatus(String ticketId, String siteId);

	@Transactional
	public Technician getTechniciansData(String technicianId);

	@Transactional
	public List<Ticketing> getTicketsData(String ticketNum);

	@Transactional
	public String saveTrackuser(Track_Users trackuser);

	@Transactional
	public void addTicket(Ticketing ticket);

	@Transactional
	public List<User> getRoles(String userName);
	
	@Transactional
	public String saveTechStatus(String ticketId, String techStatus,String techId, String commentsData, String remarksData);

	@Transactional
	public List<TechnicianTicketInfo> managerNotAcceptedTickets(String username);

	@Transactional
	public List<Site> getSiteDetails(String siteId);

	 @Transactional
	 public List<Battery_Bank_Master> getBBManufacturer();
		
		@Transactional
		public List<Site_Cabinet> getCabinetManufacturer(); 
		
		@Transactional
		public void addCabinet(Site_Cabinet BB);
		
	 @Transactional
	 public String saveTowerInstallation(Tower_Installation towerinstallation);

}

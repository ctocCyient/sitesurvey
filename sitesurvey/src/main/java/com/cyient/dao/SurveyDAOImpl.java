package com.cyient.dao;

import java.util.Calendar;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cyient.model.Battery_Bank_Master;
import com.cyient.model.Cabinet_Master;
import com.cyient.model.Regions;
import com.cyient.model.Site;
import com.cyient.model.Site_Access;
import com.cyient.model.Site_Additional_Notes;
import com.cyient.model.Site_Area;
import com.cyient.model.Site_Generator;
import com.cyient.model.Site_SMPS;
import com.cyient.model.Site_Wiring;
import com.cyient.model.Survey_Team_PPE;
import com.cyient.model.Site_Safety;
import com.cyient.model.Site_Security;
import com.cyient.model.Site_Battery_Bank;
import com.cyient.model.Site_Cabinet;
import com.cyient.model.Technician;
import com.cyient.model.TechnicianTicketInfo;
import com.cyient.model.Ticketing;
import com.cyient.model.Tower_Installation;
import com.cyient.model.Track_Users;

import com.cyient.model.User;


@Repository
public class SurveyDAOImpl implements SurveyDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public void addUser(User user) {
		sessionFactory.getCurrentSession().saveOrUpdate(user);
	}
	
	public void addTicket(Ticketing ticket){
		
		sessionFactory.getCurrentSession().saveOrUpdate(ticket);
		//System.out.println("ADDEDDDDSDGF");
	}
	

	
	@SuppressWarnings("unchecked")
	public List<User> getAllUsersOnCriteria(String username,String password,String type) {
        Criteria c = sessionFactory.getCurrentSession().createCriteria(User.class);
        c.add(Restrictions.eq("username",username));
        c.add(Restrictions.eq("password",password));
		c.add(Restrictions.eq("role",type));
		System.out.println(c.list());
        return c.list();
	}
	public void addSiteAccess(Site_Access siteacc) {
		sessionFactory.getCurrentSession().saveOrUpdate(siteacc);
	}
	public void addSiteArea(Site_Area sitearea) {
		sessionFactory.getCurrentSession().saveOrUpdate(sitearea);
	}
	public void addSitePowering(Site_Wiring sitewiring) {
		sessionFactory.getCurrentSession().saveOrUpdate(sitewiring);
	}
	public void addSite(Site site) {
		sessionFactory.getCurrentSession().saveOrUpdate(site);
	}

	public void updateSiteAccess(Site_Access upsiteacc) {
		sessionFactory.getCurrentSession().update(upsiteacc);
	}
	public void addGenerator(Site_Generator generator){	
		sessionFactory.getCurrentSession().saveOrUpdate(generator);
	}
	
	public void addSMPS(Site_SMPS smps){
		sessionFactory.getCurrentSession().saveOrUpdate(smps);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Regions> getRegions() {
		//return sessionFactory.getCurrentSession().createQuery("from Regions").list();
		 return sessionFactory.getCurrentSession().createCriteria(Regions.class)         	      
       	      .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)  
       	      .list();  
	}

	
	@SuppressWarnings("unchecked")
	public List<Battery_Bank_Master> getBBManufacturer() {
		//return sessionFactory.getCurrentSession().createQuery("from Regions").list();
		 return sessionFactory.getCurrentSession().createCriteria(Battery_Bank_Master.class)         	      
       	      .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)  
       	      .list();  
	}
	
	

	@SuppressWarnings("unchecked")
	public List<Cabinet_Master> getCabinetManufacturer() {
		//return sessionFactory.getCurrentSession().createQuery("from Regions").list();
		 return sessionFactory.getCurrentSession().createCriteria(Cabinet_Master.class)         	      
       	      .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)  
       	      .list();  
	}
	
	@SuppressWarnings("unchecked")
	public List<Regions> getStates(String region) {		
		//return sessionFactory.getCurrentSession().createQuery("select distinct state from Regions where region='"+region+"'").list();	        
	        return sessionFactory.getCurrentSession().createCriteria(Regions.class)  
	        	      .add(Restrictions.eq("region", region))  
	        	      .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();
	        
	}

	@SuppressWarnings("unchecked")
	public List<Regions> getDistricts(String region, String state) {

	//	return sessionFactory.getCurrentSession().createQuery("select region from Regions").list();
		
		return sessionFactory.getCurrentSession().createCriteria(Regions.class)
				.add(Restrictions.eq("region", region))
				.add(Restrictions.eq("state",state))
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();

	}

	@SuppressWarnings("unchecked")
	public List<Regions> getCities(String region, String state, String district) {

		  return sessionFactory.getCurrentSession().createCriteria(Regions.class)  
        	      .add(Restrictions.eq("region", region))  
        	      .add(Restrictions.eq("state", state))  
        	      .add(Restrictions.eq("district", district))  
        	      .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)  
        	      .list();  
	} 
	
	@SuppressWarnings("unchecked")
	public List<Site> getSiteIdsForRegion(String region, String state, String district, String city){
		
		return sessionFactory.getCurrentSession().createCriteria(Site.class)
				.add(Restrictions.eq("region", region))
				.add(Restrictions.eq("state", state))
				.add(Restrictions.eq("district", district))
				.add(Restrictions.eq("city", city))
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				.list();
		
	}
	
	
	@SuppressWarnings("unchecked")
	public String getUserName(String role, String username) {
		    Criteria c = sessionFactory.getCurrentSession().createCriteria(User.class);
	        c.add(Restrictions.eq("username",username));
	        c.add(Restrictions.eq("role",role));
			List<User> userlist = c.list();
			Integer count = userlist.size();
			//Integer count = (Integer)c.uniqueResult();

			if(count!=0)
			{
				return "Exists";
			}
			else
			{
      	      return "New";
			}
	}

	@SuppressWarnings("unchecked")
	public List<Site> getSiteId() {
		  return sessionFactory.getCurrentSession().createQuery("select siteid from Site where siteid=(select max(siteid) from Site)").list();

	} 

	@SuppressWarnings("unchecked")
	public List<User> getManager(String region){
		return sessionFactory.getCurrentSession().createCriteria(User.class)
				.add(Restrictions.eq("region", region))
				.add(Restrictions.eq("role", "Manager"))
				.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();
	}
	
	
	@SuppressWarnings("unchecked")
	public String getManagerId(String managerName) {
		List<User> list=sessionFactory.getCurrentSession().createQuery("select distinct emailId from User where username='"+managerName+"'").list();
		return list.toString();
	}
	
	@SuppressWarnings("unchecked")
	public List<User> getManagerDetails(String managerId){
		return sessionFactory.getCurrentSession().createQuery("from User where username='"+managerId+"'").list();
		
	}
	
	@SuppressWarnings("unchecked")
	public List<Ticketing> getTicketId(){		
		return sessionFactory.getCurrentSession().createQuery("select ticketNum from Ticketing where id=(select max(id) from Ticketing)").list();
	}

	public void addTechnician(Technician technician) {
		sessionFactory.getCurrentSession().saveOrUpdate(technician);
	}
	
	public void addTechnicianIntoUsers(User technician){
		sessionFactory.getCurrentSession().saveOrUpdate(technician);
	}
	
	@SuppressWarnings("unchecked")
	public List<Ticketing> openTicketsData() {
		return sessionFactory.getCurrentSession().createQuery("FROM Ticketing where ticketStatus='Open'").list();
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> assignedTicketsData() {
		return sessionFactory.getCurrentSession().createQuery("FROM TechnicianTicketInfo where ticketStatus='Assigned' or ticketStatus='Accepted' or ticketStatus='InProgress'").list();
	}
	
	

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> historyTicketsData() {
		return sessionFactory.getCurrentSession().createQuery("FROM TechnicianTicketInfo where ticketStatus='Closed'").list();
	}

	@SuppressWarnings("unchecked")
	public List<Ticketing> getAllTicketsData() {
		return sessionFactory.getCurrentSession().createQuery("FROM Ticketing").list();
	} 
	
	@SuppressWarnings("unchecked")
	public List<Technician> getUnassignedTechniciansData(String region,String city){
		return sessionFactory.getCurrentSession().createQuery("FROM Technician where region='"+region+"' and city ='"+city+"'").list();
		//return sessionFactory.getCurrentSession().createQuery("FROM Executive where region='"+region+"' and city ='"+city+"' and executiveId NOT IN (SELECT executiveId FROM ExecutiveTicketInfo)").list();
	}

	@SuppressWarnings("unchecked")
	public List<Ticketing> managerOpenTickets(String username,String region,String city) {
		return sessionFactory.getCurrentSession().createQuery("from Ticketing where ticketStatus='Open' or ticketStatus='Not Accepted' and region='"+region+"' and city ='"+city+"'").list();	
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> managerClosedTickets(String username) {
		return sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where manager='"+username+"' and ticketStatus='Closed'").list();	
	}
	
	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> managerNotAcceptedTickets(String username) {
		return sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where manager='"+username+"' and ticketStatus='Not Accepted'").list();	
	}

	@SuppressWarnings("unchecked")
	public List<Technician> getManagerTechnicians(String username) {
		return sessionFactory.getCurrentSession().createQuery("from Technician where manager='"+username+"'").list();
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> techAssignedTicketsData(String username) {
		return sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where ticketStatus='Assigned' and technicianId='"+username+"'").list();
	}	

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> techAcceptedTicketsData(String username) {
		return sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where technicianId='"+username+"' and (ticketStatus='Accepted' or ticketStatus='InProgress')").list();
	}
	
	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> techNotAcceptedTickets(String username) {
		System.out.println("not accepted : "+sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where technicianId='"+username+"' and ticketStatus='Not Accepted'").list());
		return sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where technicianId='"+username+"' and ticketStatus='Not Accepted'").list();	
	}
	
	

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> techClosedTicketsData(String username) {
		return sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where ticketStatus='Closed' and technicianId='"+username+"'").list();
	}

	public String assignTechnician(TechnicianTicketInfo technicianTicket) {
		sessionFactory.getCurrentSession().saveOrUpdate(technicianTicket);
		return "Assigned";
	}

	
	public String updateTicketingStatus(String ticketId,String siteId) {
		 Query q1 = sessionFactory.getCurrentSession().createQuery("from Ticketing where ticketNum ='"+ticketId+"' and siteid='"+siteId+"'");
		
		// System.out.println("Tcoetknknf123"+(Ticketing)q1.list().get(0));
		// for(int i=0;i<q1.list().size();i++){
		 Ticketing ticketing = (Ticketing)q1.list().get(0);		
		// System.out.println("ticketId"+ticketing.getId());
		 ticketing.setTicketStatus("Assigned");	
		 
		 sessionFactory.getCurrentSession().update(ticketing);	
		// }
		return "Assigned";
	}

	public Technician getTechniciansData(String technicianId) {
		return (Technician) sessionFactory.getCurrentSession().get(Technician.class, technicianId);
	}

	@SuppressWarnings("unchecked")
	public List<Ticketing> getTicketsData(String ticketNum) {
		return sessionFactory.getCurrentSession().createQuery("from Ticketing where ticketNum='"+ticketNum+"'").list();
	}

	public String saveTrackuser(Track_Users trackuser) {
		sessionFactory.getCurrentSession().saveOrUpdate(trackuser);
		return "Success";

	}
	
	@SuppressWarnings("unchecked")
	public List<User> getRoles(String userName) {
		return sessionFactory.getCurrentSession().createQuery("select role from User where username='"+userName+"'").list();
	}
	
	public String saveTechStatus(String ticketId, String techStatus,String techId,String commentsData,String remarksData) {
		 Query q1 = sessionFactory.getCurrentSession().createQuery("from Ticketing where ticketNum ='"+ticketId+"'");
		 for(int i=0;i<q1.list().size();i++){
			 Ticketing ticketing = (Ticketing)q1.list().get(i);
			 ticketing.setTicketStatus(techStatus);
			 ticketing.setComments(commentsData);
			 ticketing.setRemarks(remarksData);
		
			 sessionFactory.getCurrentSession().update(ticketing);
		 
		 }
		
		 
		 Query q2 = sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where ticketNum ='"+ticketId+"' and technicianId='"+techId+"'");
		 
		 for(int i=0;i<q2.list().size();i++){
		 TechnicianTicketInfo technicianTicketInfo = (TechnicianTicketInfo)q2.list().get(i);
		 
		 technicianTicketInfo.setTicketStatus(techStatus);
		 technicianTicketInfo.setComments(commentsData);
		 technicianTicketInfo.setRemarks(remarksData);
	
		 sessionFactory.getCurrentSession().update(technicianTicketInfo);
		 }
		return techStatus;
	}

	@SuppressWarnings("unchecked")
	public List<Site> getSiteDetails(String siteId) {
		return sessionFactory.getCurrentSession().createQuery("from Site where siteid='"+siteId+"'").list();

	}

	public void addBB(Site_Battery_Bank BB) {
		System.out.println("DAO BB id"+BB.getId());
		sessionFactory.getCurrentSession().saveOrUpdate(BB);
		
	}

	public void addCabinet(String updatetype,Site_Cabinet BB) {
		if(updatetype.split(";")[0].contains("Existing"))
		{		
		BB.setId(Integer.parseInt(updatetype.split(";")[1]));
		sessionFactory.getCurrentSession().saveOrUpdate(BB);
		}
		else
		{
			sessionFactory.getCurrentSession().saveOrUpdate(BB);
		}
	}

	@SuppressWarnings("unchecked")
	public List<Site_Battery_Bank> getBB(String Siteid) {
		Criteria c = sessionFactory.getCurrentSession().createCriteria(Site_Battery_Bank.class);
		Site s = new Site();
		s.setSiteid(Siteid);
        c.add(Restrictions.eq("siteid",s));
		List<Site_Battery_Bank> userlist = c.list();
		return 	userlist;
	}
	
	@SuppressWarnings("unchecked")
	public List<Site_Cabinet> getCabinet(String Siteid) {
		Criteria c = sessionFactory.getCurrentSession().createCriteria(Site_Cabinet.class);
		Site s = new Site();
		s.setSiteid(Siteid);
        c.add(Restrictions.eq("siteid",s));
		List<Site_Cabinet> userlist = c.list();
		return 	userlist;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Site_SMPS> getSMPSDetails(String siteId)
	{
		return sessionFactory.getCurrentSession().createQuery("from Site_SMPS where siteid='"+siteId+"'").list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Site_Generator> getGeneratorDetails(String siteId)
	{
		return sessionFactory.getCurrentSession().createQuery("from Site_Generator where siteid='"+siteId+"'").list();
	}
	

	@SuppressWarnings("unchecked")
	public List<Ticketing> getCustomerlist() {
		return sessionFactory.getCurrentSession().createQuery("from Ticketing").list();
	}

	@Override
	public void updateSiteDetails(String state,String siteId,String lati,String longi) {

		 Query q1 = sessionFactory.getCurrentSession().createQuery("from Site where siteid ='"+siteId+"'");

		 Site siteData = (Site)q1.list().get(0);
		 
		siteData.setState(state);
		siteData.setLatitude(lati);		
		siteData.setLongitude(longi);
	
		 sessionFactory.getCurrentSession().update(siteData);
		
	}

	@Override
	public void addSiteSurveyPPE(Survey_Team_PPE surveyTeamPPE) {
		sessionFactory.getCurrentSession().saveOrUpdate(surveyTeamPPE);			
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Survey_Team_PPE> getSurveyTeamDetails(String selectedSiteId) {
		return sessionFactory.getCurrentSession().createQuery("from Survey_Team_PPE where siteid='"+selectedSiteId+"'").list();		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TechnicianTicketInfo> managerAssignedTickets(String username) {
		return sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where manager='"+username+"' and (ticketStatus='Assigned' or ticketStatus='Accepted' or ticketStatus='InProgress')").list();	
	}

	@Override
	public String updateSiteStatus(String siteId,String ticketId) {

		 Query q1 = sessionFactory.getCurrentSession().createQuery("from Ticketing where siteid ='"+siteId+"' and ticketNum='"+ticketId+"'");

		
		 for(int i=0;i<q1.list().size();i++){
			 Ticketing ticket = (Ticketing)q1.list().get(i);
			
				ticket.setTicketStatus("InProgress");
				ticket.setSurveyStatus("InProgress");
	
				sessionFactory.getCurrentSession().update(ticket);
		 }
		 
		 Query q2 = sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where siteid ='"+siteId+"' and ticketNum='"+ticketId+"'");

		
		 for(int i=0;i<q2.list().size();i++){
			 TechnicianTicketInfo ticketInfo = (TechnicianTicketInfo)q2.list().get(i);
			
				ticketInfo.setTicketStatus("InProgress");
				ticketInfo.setSurveyStatus("InProgress");
	
				sessionFactory.getCurrentSession().update(ticketInfo);
		 }
		return "Updated";
	}	
	


	public String saveTowerInstallation(Tower_Installation tower) {
		sessionFactory.getCurrentSession().saveOrUpdate(tower);
			return "Saved";	
	}

	public String storeSitesecurity(Site_Security ss) {
		sessionFactory.getCurrentSession().saveOrUpdate(ss);
		return "Saved";
	}

	public String storeSiteSafety(Site_Safety sf) {
		sessionFactory.getCurrentSession().saveOrUpdate(sf);
		return "Saved";
	}

	public String storeSiteAdditional(Site_Additional_Notes sa) {
		sessionFactory.getCurrentSession().saveOrUpdate(sa);
		return "Saved";
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<Tower_Installation> fetchTowerDetails(String siteid) {
		return sessionFactory.getCurrentSession().createQuery("from Tower_Installation  where siteid ='"+siteid+"'").list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Site_Security> getSecurityDetails(String siteId) {
		return sessionFactory.getCurrentSession().createQuery("from Site_Security where siteid='"+siteId+"'").list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Site_Safety> getSafetyDetails(String siteId){		
		return sessionFactory.getCurrentSession().createQuery("from Site_Safety where siteid='"+siteId+"'").list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Site_Additional_Notes> getSiteAddDetails(String siteId) {
		return sessionFactory.getCurrentSession().createQuery("from Site_Additional_Notes where siteid='"+siteId+"'").list();
	}

	@SuppressWarnings("unchecked")	
	public List<Site_Access> getSiteAccDetails(String siteId) {
		return sessionFactory.getCurrentSession().createQuery("from Site_Access where siteid='"+siteId+"'").list();
	}

	@SuppressWarnings("unchecked")
	public List<Site_Area> getSiteArDetails(String siteId) {
		return sessionFactory.getCurrentSession().createQuery("from Site_Area where siteid='"+siteId+"'").list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Site_Wiring> getPowerWiringDetails(String siteId) {
		return sessionFactory.getCurrentSession().createQuery("from Site_Wiring where siteid='"+siteId+"'").list();
	}
	
	
	@Override
	public String updateClosedSurveyStatus(String ticketId,String siteId) {
	//	System.out.println("TICKET "+ticketId);
		
		//Calendar cal = Calendar.getInstance();
		try{
			 Query q = sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where siteid ='"+siteId+"' and ticketNum='"+ticketId+"'");
			 TechnicianTicketInfo technicianTicket = (TechnicianTicketInfo)q.list().get(0);
			 
			 technicianTicket.setSurveyStatus("Completed");
	//		 technicianTicket.setClosedDate(cal.getTime());
	//		 technicianTicket.setClosedTime(cal.getTime());
			
			 sessionFactory.getCurrentSession().update(technicianTicket);
			 
			 Query q1 = sessionFactory.getCurrentSession().createQuery("from Ticketing where ticketNum ='"+ticketId+"' and siteid ='"+siteId+"'");
			 Ticketing ticketing = (Ticketing)q1.list().get(0);
			 
			 ticketing.setSurveyStatus("Completed");
	//		ticketing.setClosedDate(cal.getTime());
	//		ticketing.setClosedTime(cal.getTime());
		
			
			 sessionFactory.getCurrentSession().update(ticketing);
		}
		catch(Exception e){
			System.out.println(e);
		}
		 
		return "Updated";
	
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Site> ValidateLatLong(String latitude, String longitude) {		
		Criteria c = sessionFactory.getCurrentSession().createCriteria(Site.class);
        c.add(Restrictions.eq("latitude",latitude));
        c.add(Restrictions.eq("longitude",longitude));
        return c.list();
	}
	
}
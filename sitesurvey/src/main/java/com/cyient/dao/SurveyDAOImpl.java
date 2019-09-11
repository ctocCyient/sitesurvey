package com.cyient.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cyient.model.Regions;
import com.cyient.model.Site;
import com.cyient.model.Site_Generator;
import com.cyient.model.Site_SMPS;
import com.cyient.model.Technician;
import com.cyient.model.TechnicianTicketInfo;
import com.cyient.model.Ticketing;

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
		System.out.println("ADDEDDDDSDGF");
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

	public void addSite(Site site) {
		sessionFactory.getCurrentSession().saveOrUpdate(site);
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
		// TODO Auto-generated method stub
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
		return sessionFactory.getCurrentSession().createQuery("FROM Ticketing where status='Open'").list();
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> assignedTicketsData() {
		return sessionFactory.getCurrentSession().createQuery("FROM TechnicianTicketInfo where status='Assigned'").list();
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> historyTicketsData() {
		return sessionFactory.getCurrentSession().createQuery("FROM TechnicianTicketInfo where status='Closed'").list();
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
		return sessionFactory.getCurrentSession().createQuery("from Ticketing where status='Open' or status='Not Accepted' and region='"+region+"' and city ='"+city+"'").list();	
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> managerClosedTickets(String username) {
		return sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where manager='"+username+"' and status='Closed'").list();	
	}
	
	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> managerNotAcceptedTickets(String username) {
		return sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where manager='"+username+"' and status='Not Accepted'").list();	
	}

	@SuppressWarnings("unchecked")
	public List<Technician> getManagerTechnicians(String username) {
		return sessionFactory.getCurrentSession().createQuery("from Technician where manager='"+username+"'").list();
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> techAssignedTicketsData(String username) {
		return sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where status='Assigned' and technicianId='"+username+"'").list();
	}	

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> techAcceptedTicketsData(String username) {
		return sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where status='Accepted' and technicianId='"+username+"'").list();
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> techClosedTicketsData(String username) {
		return sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where status='Closed' and technicianId='"+username+"'").list();
	}

	public String assignTechnician(TechnicianTicketInfo technicianTicket) {
		sessionFactory.getCurrentSession().saveOrUpdate(technicianTicket);
		return "Assigned";
	}

	
	public String updateTicketingStatus(String ticketId,String siteId) {
		 Query q1 = sessionFactory.getCurrentSession().createQuery("from Ticketing where ticketNum ='"+ticketId+"' and siteid='"+siteId+"'");
		
		// System.out.println("Tcoetknknf123"+(Ticketing)q1.list().get(0));
		 
		 Ticketing ticketing = (Ticketing)q1.list().get(0);		
		// System.out.println("ticketId"+ticketing.getId());
		 ticketing.setStatus("Assigned");	
		 sessionFactory.getCurrentSession().update(ticketing);		
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
			 
			 ticketing.setStatus(techStatus);
			 ticketing.setComments(commentsData);
			 ticketing.setRemarks(remarksData);
		
			 sessionFactory.getCurrentSession().update(ticketing);
		 
		 }
		
		 
		 Query q2 = sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where ticketNum ='"+ticketId+"' and technicianId='"+techId+"'");
		 
		 for(int i=0;i<q2.list().size();i++){
		 TechnicianTicketInfo technicianTicketInfo = (TechnicianTicketInfo)q2.list().get(i);
		 
		 technicianTicketInfo.setStatus(techStatus);
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

}
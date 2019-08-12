package com.cyient.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cyient.model.Regions;
import com.cyient.model.Site;
import com.cyient.model.Technician;
import com.cyient.model.TechnicianTicketInfo;
import com.cyient.model.Ticketing;
import com.cyient.model.User;


@Repository
public class SurveyDAOImpl implements SurveyDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public void addUser(User user) {
		sessionFactory.getCurrentSession().saveOrUpdate(user);
	}
	
	public User getAllUsersOnCriteria(String username,String password,String type) {
        Criteria c = sessionFactory.getCurrentSession().createCriteria(User.class);
        c.add(Restrictions.eq("username",username));
        c.add(Restrictions.eq("password",password));
		c.add(Restrictions.eq("role",type));
		System.out.println(c.list());
        return (User)c.uniqueResult();
	}

	public void addSite(Site site) {
		sessionFactory.getCurrentSession().saveOrUpdate(site);
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
		return sessionFactory.getCurrentSession().createQuery("FROM TechnicianTicketInfo where status='InProgress'").list();
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
}
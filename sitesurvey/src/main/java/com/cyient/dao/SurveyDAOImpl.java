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
import com.cyient.model.Ticketing;
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
		System.out.println("getRegions" );
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

}
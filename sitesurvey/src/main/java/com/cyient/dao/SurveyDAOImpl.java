package com.cyient.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cyient.model.Regions;
import com.cyient.model.Site;
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
	        	      .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)  
	        	      .list();  
	}

	@SuppressWarnings("unchecked")
	public List<Regions> getDistricts(String region, String state) {
		  return sessionFactory.getCurrentSession().createCriteria(Regions.class)  
        	      .add(Restrictions.eq("region", region))  
        	      .add(Restrictions.eq("state", state))  
        	      .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)  
        	      .list();  
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
	
}
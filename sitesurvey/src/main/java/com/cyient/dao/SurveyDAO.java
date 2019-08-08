package com.cyient.dao;

import java.util.List;

import javax.transaction.Transactional;

import com.cyient.model.Regions;
import com.cyient.model.Site;
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
	
	
}

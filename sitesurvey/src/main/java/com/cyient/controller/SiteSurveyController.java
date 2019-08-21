package com.cyient.controller;


import java.io.IOException;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cyient.dao.SurveyDAO;

import com.cyient.model.Regions;
import com.cyient.model.Site;
import com.cyient.model.Technician;
import com.cyient.model.Track_Users;
import com.cyient.model.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;



@Controller
public class SiteSurveyController {
	private static final Logger logger = Logger
			.getLogger(SiteSurveyController.class);

	public SiteSurveyController() {

		System.out.println("SiteSurveyController()");
	}
	@Autowired
	private SurveyDAO surveyDAO;
	
	private Integer Session_counter = 0;
	
	
	
	@RequestMapping(value = "/")
	public ModelAndView viewIndex(ModelAndView model) throws IOException {
		User user = new User();
		model.addObject("User", user);
		model.setViewName("index");
		return model;
	}
	
	@RequestMapping(value = "/validateUser", method = RequestMethod.POST)

    public ModelAndView checkUser(@ModelAttribute User user,ModelAndView model, HttpSession session,HttpServletRequest request) throws SocketException {


		System.out.println("Usernaem"+user.getUsername()+"Password"+user.getPassword()+"Role:"+user.getRole());

		List<User> userList = surveyDAO.getAllUsersOnCriteria(user.getUsername(),user.getPassword(),user.getRole());        
           if(userList.size()!=0)

           {
                  return new ModelAndView("redirect:/");
           }
           else
           {      
        	  Session_counter = Session_counter + 1;
        	  session=request.getSession();
        	  session.setAttribute("userName",user.getUsername());
			  session.setAttribute("password",user.getPassword());
        	  session.setAttribute("userRole",user.getRole());
        	  System.out.println(user.getUsername());
        	  System.out.println(user.getName());

        	  Enumeration e = NetworkInterface.getNetworkInterfaces();
        	  while(e.hasMoreElements())
        	  {
        	      NetworkInterface n = (NetworkInterface) e.nextElement();
        	      Enumeration ee = n.getInetAddresses();
        	      while (ee.hasMoreElements())
        	      {
        	          InetAddress i = (InetAddress) ee.nextElement();
        	          System.out.println(i.getHostAddress());
        	      }
        	  } 
        	  
	              model.setViewName("homePage");
	              return model;
           }
    }	
	
	@RequestMapping(value = "/validateUserAjax", method = RequestMethod.GET)
	@ResponseBody
    public String validateUserAjax(HttpServletRequest request) {
		String username=request.getParameter("username");
    	String password=request.getParameter("password");
    	String role=request.getParameter("role");
    	try
    	{
    		List<User> userList = surveyDAO.getAllUsersOnCriteria(username,password,role);	
    		String userName=null,roleType=null;
			for(User user:userList)
    		{
    			userName=user.getUsername();
    			roleType=user.getRole();
    		}
	    	if(userName.equals(username) & roleType.equals(role))
	    	{
	    		
	    		 Gson gsonBuilder = new GsonBuilder().create();
	        	   String userJson = gsonBuilder.toJson(userList);
		              return userJson.toString();	    	
	    	}
	    	else
	    	{
	    		return "failure";
	    	}
    	}
    	catch(Exception e)
    	{
    		return "failure";
    	}
    }	
	
	@RequestMapping(value = "/saveLoginInfo", method = RequestMethod.GET)
	@ResponseBody
	public String TrackUser(ModelAndView model,HttpServletRequest request) {
		String Uname= request.getParameter("UserName");
		String CurrentIP= request.getParameter("CurrentIP");
		String Type= request.getParameter("Type");
		String Time= request.getParameter("Time");
		
		System.out.println("user + ip"+Uname  +CurrentIP);
		Track_Users trackuser= new Track_Users();
		trackuser.setUsername(Uname);
		trackuser.setCurrentip(CurrentIP);
		trackuser.setTime2(Time);
		trackuser.setType(Type);
		String status=surveyDAO.saveTrackuser(trackuser);
		return status;
	}
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView redirectHome(ModelAndView model) {
		model.setViewName("homePage");
		return model;
	}

	@RequestMapping(value = "/saveUser", method = RequestMethod.POST)
	public ModelAndView saveUser(@ModelAttribute User user,RedirectAttributes redirectAttributes) {
		String status="User Added Successfully";
		if (user.getUsername() !=null) { 
			surveyDAO.addUser(user);
		} 
		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newUser");
	}

	/*@RequestMapping(value = "/newTechnician", method = RequestMethod.GET)
	public ModelAndView newTechnician(ModelAndView model) {
		Technician technician = new Technician();
		model.addObject("Technician", technician);
		model.setViewName("technicianReg");
		return model;
	}*/


	@RequestMapping(value = "/logout")
	 public String logout(@ModelAttribute User user, HttpSession session,HttpServletRequest request) {
          	  session.removeAttribute("userName");
              return "redirect:/";
	 }
	
	
}

package com.cyient.controller;


import java.io.IOException;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cyient.dao.SurveyDAO;

import com.cyient.model.Regions;
import com.cyient.model.Site;
import com.cyient.model.Technician;
import com.cyient.model.Track_Users;
import com.cyient.model.User;
import com.fasterxml.classmate.Filter;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
@SessionAttributes("user")
public class SiteSurveyController {
	private static final Logger logger = Logger
			.getLogger(SiteSurveyController.class);

	public SiteSurveyController() {

		System.out.println("SiteSurveyController()");
	}
	@Autowired
	private SurveyDAO surveyDAO;
	
	private Integer Session_counter = 0;
	
	@ModelAttribute("user")
	   public User setUpUserForm() {
	      return new User();
	   }
	
	
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
           if(userList.size()==0)

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

        	  session.setAttribute(";",user.getRole());
        	  System.out.println("user>>>>>>>>>>"+user.getUsername());
        	  System.out.println("Name>>>>>>>>"+user.getName());

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
		return model;
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
	public ModelAndView redirectHome(ModelAndView model,@SessionAttribute("user")User user) {
		
		System.out.println("home user>>>>."+user.getUsername());
		if(user.equals(null)){
		//if(user.getUsername().isEmpty()){
		
			model.setViewName("index");
		}
		
		else{
		model.setViewName("homePage");
		}
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
	 public String logout(@ModelAttribute User user, HttpSession session,HttpServletRequest request,HttpServletResponse httpResponse) {
          	  session.removeAttribute("userName");
          	  request.getSession().invalidate();
          	  request.getSession().removeAttribute("userName");
          	//httpResponse.setHeader("Cache-Control", "private,no-store,no-cache");

              return "redirect:/";
	 }

	
	
	
}

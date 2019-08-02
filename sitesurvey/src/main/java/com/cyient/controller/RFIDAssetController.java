package com.cyient.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cyient.dao.SurveyDAO;
import com.cyient.model.Executive;
import com.cyient.model.Site;
import com.cyient.model.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
public class RFIDAssetController {
	private static final Logger logger = Logger
			.getLogger(RFIDAssetController.class);

	public RFIDAssetController() {
		System.out.println("RFIDAssetController()");
		 
	}

	@Autowired
	private SurveyDAO surveyDAO;
	
	@RequestMapping(value = "/")
	public ModelAndView listEmployee(ModelAndView model) throws IOException {
		User user = new User();
		model.addObject("User", user);
		model.setViewName("index");
		return model;
	}
	
	@RequestMapping(value = "/newUser", method = RequestMethod.GET)
	public ModelAndView newContact(ModelAndView model) {
		User user = new User();
		model.addObject("User", user);
		model.setViewName("userReg");
		return model;
	}
	


	@RequestMapping(value = "/newExecutive", method = RequestMethod.GET)
	public ModelAndView newExecutive(ModelAndView model) {
		Executive executive = new Executive();
		model.addObject("Executive", executive);
		model.setViewName("executiveReg");
		return model;
	}
	
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView newRedirectHome(ModelAndView model) {
		model.setViewName("homePage");
		return model;
	}
	
	@RequestMapping(value = "/saveUser", method = RequestMethod.POST)
	public ModelAndView saveUser(@ModelAttribute User user,RedirectAttributes redirectAttributes) {
		String status="User Added Sucessfully";
		if (user.getUsername() !=null) { 
			surveyDAO.addUser(user);
		} 
		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newUser");
	}
	
	
	@RequestMapping(value = "/newSite", method = RequestMethod.GET)
	public ModelAndView newSite(ModelAndView model) {
		Site site = new Site();
		model.addObject("Site", site);
		model.setViewName("userSite");
		return model;
	}
	
	@RequestMapping(value = "/saveSite", method = RequestMethod.POST)
	public ModelAndView saveSiter(@ModelAttribute Site site,RedirectAttributes redirectAttributes) {
		String status="User Added Sucessfully";
		if (site.getSiteid() !=null) { 
			surveyDAO.addSite(site);
		} 
		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newSite");
	}
	
	
	
	
	
	@RequestMapping(value = "/validateUser", method = RequestMethod.POST)
    public ModelAndView checkUser(@ModelAttribute User user,ModelAndView model, HttpSession session,HttpServletRequest request) {
           User resp = surveyDAO.getAllUsersOnCriteria(user.getUsername(),user.getPassword(),user.getType());        
           if(resp==null)
           {
                  return new ModelAndView("redirect:/");
           }
           else
           {      
        	  session=request.getSession();
        	  session.setAttribute("userName",user.getUsername());
        	  session.setAttribute("personName",user.getName());
			  session.setAttribute("password",user.getPassword());
        	  session.setAttribute("userRole",user.getType());
        	  System.out.println(user.getUsername());
        	  System.out.println(user.getName());
        	         	   
	              model.setViewName("homePage");
	              return model;
           }

    }	
	
		
	
	 @RequestMapping(value = "/logout")
	 public String logout(@ModelAttribute User user, HttpSession session,HttpServletRequest request) {
          	  session.removeAttribute("userName");
              return "redirect:/";
	 }

	
	 
}

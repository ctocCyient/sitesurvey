package com.cyient.controller;


import java.io.IOException;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cyient.dao.SurveyDAO;
import com.cyient.model.Technician;
import com.cyient.model.User;

@Controller
public class SiteSurveyController {
	private static final Logger logger = Logger
			.getLogger(SiteSurveyController.class);

	public SiteSurveyController() {
		System.out.println("SiteSurveyController()");
	}

	@Autowired
	private SurveyDAO surveyDAO;
	
	@RequestMapping(value = "/")
	public ModelAndView viewIndex(ModelAndView model) throws IOException {
		User user = new User();
		model.addObject("User", user);
		model.setViewName("index");
		return model;
	}
	
	
	@RequestMapping(value = "/validateUser", method = RequestMethod.POST)
    public ModelAndView checkUser(@ModelAttribute User user,ModelAndView model, HttpSession session,HttpServletRequest request) {
		System.out.println("Usernaem"+user.getUsername()+"Password"+user.getPassword()+"Role:"+user.getRole());
           User resp = surveyDAO.getAllUsersOnCriteria(user.getUsername(),user.getPassword(),user.getRole());        
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
        	  session.setAttribute("userRole",user.getRole());
        	  System.out.println(user.getUsername());
        	  System.out.println(user.getName());
        	         	   
	              model.setViewName("homePage");
	              return model;
           }
    }	
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView redirectHome(ModelAndView model) {
		model.setViewName("homePage");
		return model;
	}
	

	/*@RequestMapping(value = "/getUserName", method = RequestMethod.GET)
	public String getUserName(HttpServletRequest request) {		
		System.out.println(surveyDAO.getUserName(request.getParameter("role"),request.getParameter("username")));
		return surveyDAO.getUserName(request.getParameter("role"),request.getParameter("username"));
	}*/

	
	
	@RequestMapping(value = "/saveUser", method = RequestMethod.POST)
	public ModelAndView saveUser(@ModelAttribute User user,RedirectAttributes redirectAttributes) {
		String status="User Added Successfully";
		if (user.getUsername() !=null) { 
			surveyDAO.addUser(user);
		} 
		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newUser");
	}
	
	
	@RequestMapping(value = "/logout")
	 public String logout(@ModelAttribute User user, HttpSession session,HttpServletRequest request) {
          	  session.removeAttribute("userName");
              return "redirect:/";
	 }
	
	
	
	
}

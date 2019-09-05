
package com.cyient.controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jboss.logging.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cyient.dao.SurveyDAO;
import com.cyient.model.Regions;
import com.cyient.model.Site;
import com.cyient.model.Survey_Team_PPE;
import com.cyient.model.Technician;
import com.cyient.model.TechnicianTicketInfo;
import com.cyient.model.Ticketing;
import com.cyient.model.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
public class FTSurveyController {
	private static final Logger logger = Logger
			.getLogger(ManagerFTController.class);

	public FTSurveyController() {
		System.out.println("FTSurveyController()");
		 
	}

	@Autowired
	private SurveyDAO surveyDAO;
		
	 @RequestMapping(value = "/siteDetails")
		public ModelAndView siteDetails(ModelAndView model) throws IOException {
		 Site site=new Site();
		 model.addObject("SiteDetails", site);
			model.setViewName("siteDetails");
			return model;
	}
	 
	 @ModelAttribute("PPEList")
	   public List<String> getPPEList() {
	      List<String> PPEList = new ArrayList<String>();
	      PPEList.add("High visibility vest");
	      PPEList.add("Safety shoes");
	      PPEList.add("Hard hat");
	      return PPEList;
	   }
	 
	 @ModelAttribute("riggerPPEList")
	   public List<String> getRiggerPPEList() {
	      List<String> riggerPPEList = new ArrayList<String>();
	      riggerPPEList.add("High visibility vest");
	      riggerPPEList.add("Safety shoes");
	      riggerPPEList.add("Hard hat");
	      riggerPPEList.add("Use of rigging equipment");
	      return riggerPPEList;
	   }
	 
	 @RequestMapping(value = "/surveyTeamPPE")
		public ModelAndView surveyTeamPPE(ModelAndView model) throws IOException {
		 Survey_Team_PPE surveyTeamPPE=new Survey_Team_PPE();
		 model.addObject("SurveyTeamPPE", surveyTeamPPE);
			model.setViewName("surveyTeamPPE");
			return model;
	}
	
}

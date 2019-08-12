//package com.cyient.controller;
//
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.LinkedHashSet;
//import java.util.List;
//import java.util.Map;
//import java.util.stream.Collectors;
//
//import javax.mail.MessagingException;
//import javax.mail.internet.MimeMessage;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//
//import org.jboss.logging.Logger;
//import org.json.JSONArray;
//import org.json.JSONObject;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.mail.javamail.JavaMailSender;
//import org.springframework.mail.javamail.MimeMessageHelper;
//import org.springframework.mail.javamail.MimeMessagePreparator;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import com.cyient.dao.SurveyDAO;
//import com.cyient.model.Regions;
//import com.cyient.model.Site;
//import com.cyient.model.Technician;
//import com.cyient.model.TechnicianTicketInfo;
//import com.cyient.model.Ticketing;
//import com.cyient.model.User;
//import com.google.gson.Gson;
//import com.google.gson.GsonBuilder;
//
//@Controller
//public class ManagerFTController {
//	private static final Logger logger = Logger
//			.getLogger(ManagerFTController.class);
//
//	public ManagerFTController() {
//		System.out.println("ManagerFTController()");
//		 
//	}
//
//	@Autowired
//	private SurveyDAO surveyDAO;
//	
//	
//	 @RequestMapping(value = "/managerOpenTickets")
//		public ModelAndView managerTotalTickets(ModelAndView model) throws IOException {
//			model.setViewName("managerOpenTickets");
//			return model;
//		}
//		
//		@RequestMapping(value = "/techniciansList")
//		public ModelAndView techniciansList(ModelAndView model) throws IOException {
//			model.setViewName("techniciansList");
//			return model;
//		}
//		
//
//		@RequestMapping(value="managerTicketsCount", method = RequestMethod.GET)
//	    @ResponseBody
//	    public String managerTicketsCount(ModelAndView model,HttpServletRequest request) {
//			String username=request.getParameter("username");
//			List listData=new ArrayList();
//			List<TechnicianTicketInfo> listOpen = surveyDAO.managerTotalTicketsCount(username);			 
//			   listData.add(listOpen);
//			   System.out.println(listData);
//			   Gson gsonBuilder = new GsonBuilder().create();
//			   String openJson = gsonBuilder.toJson(listData);
//		          return openJson.toString();
//	    }
//	    
//	    @RequestMapping(value="getManagerTechnicians", method = RequestMethod.GET)
//	    @ResponseBody
//	    public String getManagerTechnicians(ModelAndView model,HttpServletRequest request) {
//	    	String username=request.getParameter("username");
//			List<Technician> listClosed = surveyDAO.getManagerTechnicians(username);
//		        	   Gson gsonBuilder = new GsonBuilder().create();
//	        	   String closedJson = gsonBuilder.toJson(listClosed);
//		              return closedJson.toString();
//	    }
//	    
//
//		@RequestMapping(value="getManagerTotalTickets", method = RequestMethod.GET)
//	    @ResponseBody
//	    public String getManagerTotalTickets(ModelAndView model,HttpServletRequest request) {
//			String username=request.getParameter("username");
//			System.out.println("USER"+username);
//			List<TechnicianTicketInfo> listTotal = surveyDAO.managerTotalTickets(username);
//			  	   Gson gsonBuilder = new GsonBuilder().create();
//	        	   String totalJson = gsonBuilder.toJson(listTotal);
//		              return totalJson.toString();
//	    }
//		
//		
//	@RequestMapping(value = "/technicianAssignedTickets")
//	public ModelAndView technicianAssignedTickets(ModelAndView model) throws IOException {
//		model.setViewName("technicianAssignedTickets");
//		return model;
//	}
//
//	@RequestMapping(value = "/technicianClosedTickets")
//	public ModelAndView technicianClosedTickets(ModelAndView model) throws IOException {
//		model.setViewName("technicianClosedTickets");
//		return model;
//	}
//	@RequestMapping(value="getTechnicianAssignedTickets", method = RequestMethod.GET)
//    @ResponseBody
//    public String  getTechnicianAssignedTicketsData(HttpServletRequest request) {
//		String username=request.getParameter("username");
//		System.out.println("username:"+username);
//		List<Ticketing> listExecOpen = surveyDAO.getTechAssignedTicketsData(username);		
//        	   Gson gsonBuilder = new GsonBuilder().create();
//        	   String execOpenJson = gsonBuilder.toJson(listExecOpen);
//        	   System.out.println(execOpenJson);
//	              return execOpenJson.toString();
//    }
//	
//	@RequestMapping(value="getTechncianClosedTickets", method = RequestMethod.GET)
//    @ResponseBody
//    public String  getTechncianClosedTicketsData(HttpServletRequest request) {
//		String username=request.getParameter("username");
//		System.out.println("username:"+username);
//		List<Ticketing> listExecClosed = surveyDAO.getTechClosedTicketsData(username);		
//        	   Gson gsonBuilder = new GsonBuilder().create();
//        	   String execClosedJson = gsonBuilder.toJson(listExecClosed);
//	              return execClosedJson.toString();
//    }
//	
//	@RequestMapping(value="getTechTicketsCount", method = RequestMethod.GET)
//    @ResponseBody
//    public String  execTicketsCount(ModelAndView model,HttpServletRequest request) {
//		String username=request.getParameter("username");
//		List listData=new ArrayList();
//		List<Ticketing> listOpen = surveyDAO.getTechAssignedTicketsData(username);		              
//	    List<Ticketing> listOpen1 = surveyDAO.getTechClosedTicketsData(username);			 
//		   listData.add(listOpen);
//		   listData.add(listOpen1);
//		   System.out.println(listData);
//		   Gson gsonBuilder = new GsonBuilder().create();
//		   String openJson = gsonBuilder.toJson(listData);
//	          return openJson.toString();
//    }
//	
//}

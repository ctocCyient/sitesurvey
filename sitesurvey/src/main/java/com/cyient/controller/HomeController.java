package com.cyient.controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jboss.logging.Logger;
import org.json.JSONArray;
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
import com.cyient.model.Technician;
import com.cyient.model.TechnicianTicketInfo;
import com.cyient.model.Ticketing;
import com.cyient.model.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
public class HomeController {
	private static final Logger logger = Logger
			.getLogger(HomeController.class);

	public HomeController() {
		System.out.println("HomeController()");
		 
	}

	@Autowired
	private SurveyDAO surveyDAO;
	
	@Autowired
	private JavaMailSender mailSender;
	
	String selectedTechnicianId=null;
	String selectedSiteId=null;
	
	@RequestMapping(value = "/openTickets")
	public ModelAndView openTickets(ModelAndView model) throws IOException {
		model.setViewName("openTickets");
		return model;
	}
	
	@RequestMapping(value = "/assignedTickets")
	public ModelAndView assignedTickets(ModelAndView model) throws IOException {
		model.setViewName("assignedTickets");
		return model;
	}
	
	@RequestMapping(value = "/historyTickets")
	public ModelAndView historyTickets(ModelAndView model) throws IOException {
		model.setViewName("historyTickets");
		return model;
	}
		
	@RequestMapping(value = "/totalTickets")
	public ModelAndView totalTickets(ModelAndView model) throws IOException {
		model.setViewName("totalTickets");
		return model;
	}
	
	@RequestMapping(value = "/newTicket")
	public ModelAndView newTicket(ModelAndView model) throws IOException {
		Ticketing ticketing=new Ticketing();
		model.addObject("Ticketing", ticketing);
		model.setViewName("createTicket");
		return model;
	}
	
//	@RequestMapping(value = "/saveTechnician", method = RequestMethod.POST)
//	public ModelAndView saveTechnician(@ModelAttribute final Technician technician,RedirectAttributes redirectAttributes) throws MessagingException {
//		String status="Technician Added Successfully";
//		final JSONArray json=new JSONArray();
//			String managerId=null;
//			User user=new User();
//			user.setUsername(technician.getTechnicianId());
//			user.setName(technician.getTechnicianName());
//			user.setEmailId(technician.getEmailId());
//			user.setMobileNumber(technician.getMobile());
//			user.setPassword(technician.getPassword());
//			user.setRegion(technician.getRegion());
//			user.setCreatedDate(technician.getCreatedDate());
//			user.setRole("FieldTechnician");
//    	   surveyDAO.addTechnician(technician);
//    	   surveyDAO.addTechnicianIntoUsers(user);
//		   managerId=surveyDAO.getManagerId(technician.getManager());
//		   final String managerName=technician.getManager();
//		   final String managerEmailId=managerId.substring(1, managerId.length()-1);
//		   System.out.println("mail::::"+mailSender);
//        	List<User> ManagerDetails=surveyDAO.getManagerDetails(technician.getManager());
//		   
//			for(User det:ManagerDetails)
//			{
//				json.add(det.getName());
//				json.add(det.getUsername());
//				json.add(det.getPassword());
//			}
//
//		      mailSender.send(new MimeMessagePreparator() {
//		    	  public void prepare(MimeMessage mimeMessage) throws MessagingException {		    		
//		    	    MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
//		    	    message.setFrom("Neeraja.Chaparala@cyient.com");
//		    	    message.setTo(managerEmailId);
//		    	    message.setSubject("Acceptance of Feild Technician Creation");	    	 
//		    	  // message.setText("Dear <b>" + managerName +"</b> ,<br><br> Ticket with Id <b>" +selectedTicketNum+" </b> is assigned. Tikcet Details are:<br> Severity: <b>"+severity+ "</b> <br>Ticket Description: <b>" + ticketDesc+"</b><br>Customer ID <b>"+customerId+"</b> . <br> Please <a href='http://172.16.53.79:8080/RFIDAssetTracking/'>login</a> for other details", true);
//		    	    message.setText("Dear <b>" + json.get(0) +"</b> ,<br><br> A new Technician created under your region with details:<br><b>Tehnician Id: </b>"+technician.getTechnicianId()+"<br><b>Technician Name: </b>"+technician.getTechnicianName()+"<br><b>Region: </b> "+technician.getRegion()+"<br><br>Please <a href='http://ctoceu.cyient.com:3290/RFIDAssetTracking/'>login</a> for other details with credetials:<br> <b>Username</b>: "+json.get(1)+"<br><b>Password</b>:"+json.get(2)+"", true);
//		    	  }
//		    	});
//		      redirectAttributes.addFlashAttribute("status", status);
//				return new ModelAndView("redirect:/newTechnician");
//	}
//	                                                                                                                                                                                                                                                                                   
//   @RequestMapping(value="getUnassignedTechnicians", method = RequestMethod.GET)
//    @ResponseBody
//    public String  getTechniciansData(ModelAndView model,HttpServletRequest request) {
//    	 String region=request.getParameter("region");
//    	 String city=request.getParameter("city");
//    	 System.out.println("city :::"+city);
//		List<Technician> listTechnicians = surveyDAO.getUnassignedTechniciansData(region,city);
//		System.out.println(listTechnicians);
//	   Gson gsonBuilder = new GsonBuilder().create();
//	   String techniciansJson = gsonBuilder.toJson(listTechnicians);
//          return techniciansJson.toString();
//    }
//    
//   @RequestMapping(value = "/saveCreatedTicket", method = RequestMethod.POST)
//	public ModelAndView saveTicket(@ModelAttribute Ticketing ticket,RedirectAttributes redirectAttributes) {
//	
//		rfidDAO.addTicket(ticket);
//		String status="Ticket Created Successfully";
//		redirectAttributes.addFlashAttribute("status", status);
//		return new ModelAndView("redirect:/newTicket");
//	}
//   
//    @RequestMapping(value="/assignTechnician", method = RequestMethod.GET)
//    @ResponseBody
//	public String assignTechnician(HttpServletRequest request) throws MessagingException {	
//    	
//    	 selectedTechnicianId=request.getParameter("technicianId");
//    	 
//    	 Technician TechniciansData = surveyDAO.getTechniciansData(selectedTechnicianId);
//    	 System.out.println("technicians: "+TechniciansData);
//    	 String ticketId = null;
//    	 selectedTicketNum=request.getParameter("ticketId");
//    	 
//    	 List<Ticketing> ticketData = surveyDAO.getTicketsData(selectedTicketNum);
//    	 System.out.println("Tickets: "+ticketData);
//    	 TechnicianTicketInfo technicianTicket=new  TechnicianTicketInfo();
//    	 
//    	 technicianTicket.setTechnicianId(TechniciansData.getTechnicianId());
//    	 technicianTicket.setTechnicianName(TechniciansData.getTechnicianName());
//    	 technicianTicket.setRegion(TechniciansData.getRegion());
//    	 technicianTicket.setManager(TechniciansData.getManager());
//    	 technicianTicket.setCity(TechniciansData.getCity());
//    	
//    	 
//    	 for(Ticketing ticket : ticketData)
//	      {
//    		 ticketId=ticket.getTicketNum();
//    		 //Customer custId = ticket.getCustomer().getCustomerId();
//    		 technicianTicket.setCustomer(ticket.getCustomer());
//    		 technicianTicket.setUniqueId(surveyDAO.ASCIItoHEX(ticket.getUniqueId()));
//        	 technicianTicket.setTicketNum(ticket.getTicketNum());
//        	 technicianTicket.setTicketDescription(ticket.getTicketDescription());        	   	 
//        	 technicianTicket.setSeverity(ticket.getSeverity());
//        	 technicianTicket.setTicketType(ticket.getTicketType());
//        	 
//	      }
//    	
//    	 if (technicianTicket.getCustomer() != null) { 
//			String status=surveyDAO.assignTechnician(technicianTicket);
//			String StatusUpdate=surveyDAO.updateTicketingStatus(ticketId);
//			if(status.equalsIgnoreCase("Assigned")&&StatusUpdate.equalsIgnoreCase("Assigned"))
//			{
//				sendEmail();
//			}
//    	 }
//    	
//    	return "Assigned";		
//	}
//    
//    
//    @RequestMapping(value = "/sendEmail")
//  	public String sendEmail() throws MessagingException {
//  	     
//        mailSender.send(new MimeMessagePreparator() {
//      	  public void prepare(MimeMessage mimeMessage) throws MessagingException {
//      		  
//      		  String severity=null,ticketType=null;
//  			
//      		  
//      		  Technician technicianData = surveyDAO.getTechniciansData(selectedTechnicianId);
//      		  
//      		  List<Ticketing> ticketData = surveyDAO.getTicketsData(selectedTicketNum);
//      		  
//      		  for(Ticketing ticket : ticketData)
//      	      {
//          		 
//              	 ticketType=ticket.getTicketType();           	 
//              	 severity=ticket.getSeverity();
//      	      }
//      	      
//      	    MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
//      	    message.setTo(technicianData.getEmailId());
//      	    message.setSubject("Ticket Information");	    	 
//      	    message.setText("Dear <b>" + technicianData.getTechnicianName() +"</b> ,<br><br> Site with Id "+selectedSiteId+" is assigned for Survey . <br><br> Please <a href='http://ctoceu.cyient.com:3290/RFIDAssetTracking/'>login</a> for other details", true);
//      	    
//      	  }
//      	});
//  		
//  		return "Mail Sent";
//  	}
//      
    
    
	
	@RequestMapping(value = "/newSite", method = RequestMethod.GET)
	public ModelAndView newSite(ModelAndView model) {
		Site site = new Site();
		model.addObject("Site", site);
		model.setViewName("addSite");
		return model;
	}
	
	@RequestMapping(value = "/saveSite", method = RequestMethod.POST)
	public ModelAndView saveSiter(@ModelAttribute Site site,RedirectAttributes redirectAttributes) {
		String status="Site Added Successfully";
		if (site.getSiteid() !=null) { 
			surveyDAO.addSite(site);
		} 
		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newSite");
	}
	
	
	@ModelAttribute("regionsList")
	   public Map<String, String> getRegions() {
	      Map<String, String> regionsMap = new HashMap<String, String>();
	      List<Regions> regions = surveyDAO.getRegions();
	      for(Regions region : regions)
	      {
	    	  regionsMap.put(region.getRegion(), region.getRegion());
	      }
	      System.out.println("RegionsData "+regionsMap);
	      return regionsMap;
	   }
	
	 
	 @RequestMapping(value="getStates", method = RequestMethod.GET)
	    @ResponseBody
	    public String getStates(ModelAndView model,HttpServletRequest request) {
			String selectedRegion=request.getParameter("selectedRegion");		
			//List<Regions> listStates = surveyDAO.getStates(selectedRegion);
			 List<Regions> regions = surveyDAO.getStates(selectedRegion);
			 List<String> listStates = new ArrayList<String>();
		      for(Regions region : regions)
		      {
		    	  listStates.add(region.getState());
		      }
			  	   Gson gsonBuilder = new GsonBuilder().create();
	        	   String statesJson = gsonBuilder.toJson(listStates);
	        	   System.out.println("StatesJSON"+statesJson);
		              return statesJson.toString();
	    }
	 
	 @RequestMapping(value="getDistricts", method = RequestMethod.GET)
	    @ResponseBody
	    public String getDistricts(ModelAndView model,HttpServletRequest request) {
		 String selectedRegion=request.getParameter("selectedRegion");
			String selectedState=request.getParameter("selectedState");		
			List<Regions> listDistricts = surveyDAO.getDistricts(selectedRegion,selectedState);
			  	   Gson gsonBuilder = new GsonBuilder().create();
	        	   String districtsJson = gsonBuilder.toJson(listDistricts);
		              return districtsJson.toString();
	    }
	 
	 @RequestMapping(value="getCities", method = RequestMethod.GET)
	    @ResponseBody
	    public String getCities(ModelAndView model,HttpServletRequest request) {
		 String selectedRegion=request.getParameter("selectedRegion");
			String selectedState=request.getParameter("selectedState");	
			String selectedDistrict=request.getParameter("selectedDistrict");	
			List<Regions> listCities = surveyDAO.getCities(selectedRegion,selectedState,selectedDistrict);
			  	   Gson gsonBuilder = new GsonBuilder().create();
	        	   String totalJson = gsonBuilder.toJson(listCities);
		              return totalJson.toString();
	    }
    
    
}

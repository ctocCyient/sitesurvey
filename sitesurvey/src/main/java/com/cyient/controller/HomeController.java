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
	

	@RequestMapping(value = "/saveTechnician", method = RequestMethod.POST)
	public ModelAndView saveTechnician(@ModelAttribute final Technician technician,RedirectAttributes redirectAttributes) throws MessagingException {
		String status="Technician Added Successfully";

		final JSONArray json=new JSONArray();
			String managerId=null;
			User user=new User();
			user.setUsername(technician.getTechnicianId());
			user.setName(technician.getTechnicianName());
			user.setEmailId(technician.getEmailId());
			user.setMobileNumber(technician.getMobile());
			user.setPassword(technician.getPassword());
			user.setRegion(technician.getRegion());
			user.setCreatedDate(technician.getCreatedDate());
			user.setRole("FieldTechnician");
    	   surveyDAO.addTechnician(technician);
    	   surveyDAO.addTechnicianIntoUsers(user);
    	   System.out.println("Manager+++++++++++++++"+technician.getManager());
		   managerId=surveyDAO.getManagerId(technician.getManager());
		   final String managerName=technician.getManager();
		   final String managerEmailId=managerId.substring(1, managerId.length()-1);
		   System.out.println("mail::::"+mailSender);
        	List<User> ManagerDetails=surveyDAO.getManagerDetails(technician.getManager());
		   final List<String> managerDet=new ArrayList<String>();
			for(User det:ManagerDetails)
			{
				managerDet.add(det.getName());
				managerDet.add(det.getUsername());
				managerDet.add(det.getPassword());
			}
		      mailSender.send(new MimeMessagePreparator() {
		    	  public void prepare(MimeMessage mimeMessage) throws MessagingException {		    		
		    	    MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
		    	    message.setFrom("Neeraja.Chaparala@cyient.com");
		    	    message.setTo(managerEmailId);
		    	    message.setSubject("Acceptance of Feild Technician Creation");	    	 
		    	  // message.setText("Dear <b>" + managerName +"</b> ,<br><br> Ticket with Id <b>" +selectedTicketNum+" </b> is assigned. Tikcet Details are:<br> Severity: <b>"+severity+ "</b> <br>Ticket Description: <b>" + ticketDesc+"</b><br>Customer ID <b>"+customerId+"</b> . <br> Please <a href='http://172.16.53.79:8080/RFIDAssetTracking/'>login</a> for other details", true);
		    	    message.setText("Dear <b>" + managerDet.get(0) +"</b> ,<br><br> A new Technician created under your region with details:<br><b>Tehnician Id: </b>"+technician.getTechnicianId()+"<br><b>Technician Name: </b>"+technician.getTechnicianName()+"<br><b>Region: </b> "+technician.getRegion()+"<br><br>Please <a href='http://ctoceu.cyient.com:3290/RFIDAssetTracking/'>login</a> for other details with credetials:<br> <b>Username</b>: "+managerDet.get(1)+"<br><b>Password</b>:"+managerDet.get(2)+"", true);
		    	  }
		    	});
		      
		      /*Sending Mail for Technician with his login Details*/ 
		      
		      mailSender.send(new MimeMessagePreparator() {
		    	  public void prepare(MimeMessage mimeMessage) throws MessagingException {		    		
		    	    MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
		    	    message.setFrom("Neeraja.Chaparala@cyient.com");
		    	    message.setTo(technician.getEmailId());
		    	    message.setSubject("Login Credentials");	    	 
		    	  // message.setText("Dear <b>" + managerName +"</b> ,<br><br> Ticket with Id <b>" +selectedTicketNum+" </b> is assigned. Tikcet Details are:<br> Severity: <b>"+severity+ "</b> <br>Ticket Description: <b>" + ticketDesc+"</b><br>Customer ID <b>"+customerId+"</b> . <br> Please <a href='http://172.16.53.79:8080/RFIDAssetTracking/'>login</a> for other details", true);
		    	    message.setText("Dear <b>" + technician.getTechnicianName() +"</b> ,<br>You were registered as a Technicinan. <br>Please <a href='http://ctoceu.cyient.com:3290/RFIDAssetTracking/'>login</a> for other details with credetials:<br> <b>Username</b>: "+technician.getTechnicianName()+"<br><b>Password</b>:"+technician.getPassword()+"", true);
		    	  }
		    	});
		      
		      redirectAttributes.addFlashAttribute("status", status);
			return new ModelAndView("redirect:/newTechnician");
	}
	
	 @RequestMapping(value = "/saveCreatedTicket", method = RequestMethod.POST)
		public ModelAndView saveTicket(@ModelAttribute Ticketing ticket,RedirectAttributes redirectAttributes) {
		
		 	surveyDAO.addTicket(ticket);
			String status="Ticket Created Successfully";
			redirectAttributes.addFlashAttribute("status", status);
			return new ModelAndView("redirect:/newTicket");
		}
	
	
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
	
	@RequestMapping(value = "/newUser", method = RequestMethod.GET)
	public ModelAndView newUser(ModelAndView model) {
		User user = new User();
		model.addObject("User", user);
		model.setViewName("userReg");
		return model;
	}
    
	@RequestMapping(value = "/newTechnician", method = RequestMethod.GET)
	public ModelAndView newTechnician(ModelAndView model) {
		Technician technician = new Technician();
		model.addObject("Technician", technician);
		model.setViewName("technicianReg");
		return model;
	}
	
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
	


	 @RequestMapping(value="/getLastTicketId", method=RequestMethod.GET)
	 @ResponseBody
	 public String getLastTicketId(HttpServletRequest request){
		
		 List<Ticketing> ticketList=surveyDAO.getTicketId();
		 Gson gsonBuilder=new GsonBuilder().create();
		 String executiveJson=gsonBuilder.toJson(ticketList);
		 return executiveJson.toString();
		 
	 }

	 
	   @ModelAttribute("regionsList")	
	   public Map<String, String> getRegions() {
	      Map<String, String> regionsMap = new HashMap<String, String>();
	      List<Regions> regions = surveyDAO.getRegions();
	      int i=0;
	      for(i=0;i<regions.size();i++){
	    	  System.out.println(regions.get(i));
	    	 }
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
    	//  statesMap.put(region.getState(),region.getState());
		    	  listStates.add(region.getState());

		      }
		      
		      List<Object> listWithoutDuplicates = listStates.stream().distinct().collect(Collectors.toList());
		      Gson gsonBuilder = new GsonBuilder().create();
	          String statesJson = gsonBuilder.toJson(listWithoutDuplicates);
	          System.out.println("StatesJSON"+statesJson);
	          return statesJson;
    	  // return statesMap;

	    }
	 
	 @RequestMapping(value="getDistricts", method = RequestMethod.GET)
	    @ResponseBody

	    public  String getDistricts(ModelAndView model,HttpServletRequest request) {
		 String selectedRegion=request.getParameter("selectedRegion");

			String selectedState=request.getParameter("selectedState");	
			List<Regions> districts = surveyDAO.getDistricts(selectedRegion,selectedState);
			List<String> listDistricts = new ArrayList<String>();
			for(Regions region: districts)
			{
				listDistricts.add(region.getDistrict());
			}
			List<Object> listWithoutDuplicates = listDistricts.stream().distinct().collect(Collectors.toList());
			Gson gsonBuilder = new GsonBuilder().create();
		    String districtsJson = gsonBuilder.toJson(listWithoutDuplicates);
			return districtsJson;
			/*List<Regions> regions = surveyDAO.getDistricts(selectedRegion,selectedState);
			 Map<String, String> districtsMap = new HashMap<String, String>();
			 for(Regions region : regions)
		      {
				 districtsMap.put(region.getDistrict(),region.getDistrict());
		      }
//			  	   Gson gsonBuilder = new GsonBuilder().create();
//	        	   String districtsJson = gsonBuilder.toJson(listDistricts);
		              //return districtsJson.toString();
			 return districtsMap;*/

	    }
	 
	    @RequestMapping(value="getCities", method = RequestMethod.GET)
	    @ResponseBody

	    public  String getCities(ModelAndView model,HttpServletRequest request) {

		 String selectedRegion=request.getParameter("selectedRegion");
			String selectedState=request.getParameter("selectedState");	
			String selectedDistrict=request.getParameter("selectedDistrict");	
			List<Regions> cities = surveyDAO.getCities(selectedRegion,selectedState,selectedDistrict);
			List<String> listCities=new ArrayList<String>();
			for(Regions region:cities)
			{
				listCities.add(region.getCity());
			}
			List<Object> listWithoutDuplicates = listCities.stream().distinct().collect(Collectors.toList());
			Gson gsonBuilder = new GsonBuilder().create();
	        String totalJson = gsonBuilder.toJson(listWithoutDuplicates);
		    return totalJson.toString();
	   

			/*List<Regions> regions = surveyDAO.getCities(selectedRegion,selectedState,selectedDistrict);
			 Map<String, String> citiesMap = new HashMap<String, String>();
			 for(Regions region : regions)
		      {
				 citiesMap.put(region.getCity(),region.getCity());
		      }
			
//			  	   Gson gsonBuilder = new GsonBuilder().create();
//	        	   String totalJson = gsonBuilder.toJson(listCities);
		              return citiesMap;*/


	    }
	    
		
	    
	    @RequestMapping("ticketsCount")
	    @ResponseBody
	    public String  ticketsCountData(ModelAndView model) {
			List<Ticketing> listOpen = surveyDAO.openTicketsData();		              
		    List<TechnicianTicketInfo> listAssigned = surveyDAO.assignedTicketsData();
		      List<TechnicianTicketInfo> listHistory = surveyDAO.historyTicketsData();
		      List<Ticketing> listTotal =surveyDAO.getAllTicketsData();
		     
			   JSONObject countData=new JSONObject();
			   countData.put("OpenTickets",listOpen.size());
			   countData.put("AssignedTickets",listAssigned.size());
			   countData.put("HistoryTickets",listHistory.size());
			   countData.put("TotalTickets",listTotal.size());
			   System.out.println(countData);			   
		          return countData.toString();
	    }
	 
	    @RequestMapping("getOpenTickets")
	    @ResponseBody
	    public String  getOpenTicketsData(ModelAndView model) {
			List<Ticketing> listOpen = surveyDAO.openTicketsData();			
			Gson gsonBuilder = new GsonBuilder().create();
			String openJson = gsonBuilder.toJson(listOpen);
    	   	return openJson.toString();
	    }
		
		@RequestMapping("getAssignedTickets")
	    @ResponseBody
	    public String  getAssignedTicketsData(ModelAndView model) {
			List<TechnicianTicketInfo> listAssigned = surveyDAO.assignedTicketsData();
			Gson gsonBuilder = new GsonBuilder().create();
			String closedJson = gsonBuilder.toJson(listAssigned);
    	   	return closedJson.toString();
	    }
		
		@RequestMapping("getHistoryTickets")
	    @ResponseBody
	    public String  getHistoryTicketsData(ModelAndView model) {
			List<TechnicianTicketInfo> listHistory = surveyDAO.historyTicketsData();
	  	    Gson gsonBuilder = new GsonBuilder().create();
    	    String historyJson = gsonBuilder.toJson(listHistory);
              return historyJson.toString();
		}
		
	    @RequestMapping(value="getSiteId", method = RequestMethod.GET)
	    @ResponseBody

	    public  String getSiteId(ModelAndView model,HttpServletRequest request) {

		 String selectedRegion=request.getParameter("selectedRegion");
			String selectedState=request.getParameter("selectedState");	
			String selectedDistrict=request.getParameter("selectedDistrict");	
			String selectedCity=request.getParameter("selectedCity");	
			List<Site> siteIds = surveyDAO.getSiteIdsForRegion(selectedRegion,selectedState,selectedDistrict,selectedCity);
			List<String> listSiteIds=new ArrayList<String>();
			for(Site site:siteIds)
			{
				listSiteIds.add(site.getSiteid());
			}
			List<Object> listWithoutDuplicates = listSiteIds.stream().distinct().collect(Collectors.toList());
			Gson gsonBuilder = new GsonBuilder().create();
	        String totalJson = gsonBuilder.toJson(listWithoutDuplicates);
		    return totalJson;
	   

			/*List<Regions> regions = surveyDAO.getCities(selectedRegion,selectedState,selectedDistrict);
			 Map<String, String> citiesMap = new HashMap<String, String>();
			 for(Regions region : regions)
		      {
				 citiesMap.put(region.getCity(),region.getCity());
		      }
			
//			  	   Gson gsonBuilder = new GsonBuilder().create();
//	        	   String totalJson = gsonBuilder.toJson(listCities);
		              return citiesMap;*/

	    }
	    
	 @RequestMapping(value="/getLastSiteId", method=RequestMethod.GET)
	  @ResponseBody
	  public String getLastSiteId(HttpServletRequest request){
	  
	   List<Site> siteidList=surveyDAO.getSiteId();
	   System.out.println("siteid>>>>>>...."+siteidList);
	   Gson gsonBuilder=new GsonBuilder().create();
	   String executiveJson=gsonBuilder.toJson(siteidList);
	   return executiveJson.toString();
	  
	  }

		@RequestMapping("getTotalTickets")
		@ResponseBody
		public String  getTotalTicketsData(ModelAndView model) {
			List<Ticketing> listTotal = surveyDAO.getAllTicketsData();
		     Gson gsonBuilder = new GsonBuilder().create();
			 String totalJson = gsonBuilder.toJson(listTotal);
		     return totalJson.toString();
		}
		
		@RequestMapping(value = "/adminOpenTickets")
		public ModelAndView adminOpenTickets(ModelAndView model) throws IOException {
			model.setViewName("adminOpenTickets");
			return model;
		}
		
		
		 @RequestMapping("getAdminTicketsCount")
		@ResponseBody
		public String  getAdminTicketsCount(ModelAndView model) {
			List<Ticketing> listOpen = surveyDAO.openTicketsData();		              
		    List<TechnicianTicketInfo> listAssigned = surveyDAO.assignedTicketsData();
		      List<TechnicianTicketInfo> listHistory = surveyDAO.historyTicketsData();
		      List<Ticketing> listTotal =surveyDAO.getAllTicketsData();
		     
			   JSONObject countData=new JSONObject();
			   countData.put("OpenTickets",listOpen.size());
			   countData.put("AssignedTickets",listAssigned.size());
			   countData.put("HistoryTickets",listHistory.size());
			   countData.put("TotalTickets",listTotal.size());
			   System.out.println(countData);			   
		          return countData.toString();
		}
		 
	    @RequestMapping(value= "getManager", method = RequestMethod.GET)
		@ResponseBody
		public String getManager(HttpServletRequest request) {
		 String region=request.getParameter("selectedRegion");
			List<User> managers = surveyDAO.getManager(region);
			List<String> listManagers=new ArrayList<String>();
			for(User user: managers)
			{
				listManagers.add(user.getUsername());
			}
			Gson gsonBuilder = new GsonBuilder().create();
			String managerJSON = gsonBuilder.toJson(listManagers);
	 	   	return managerJSON;
		}


	    @RequestMapping(value = "/getUserName", method = RequestMethod.GET)
		@ResponseBody
		public String getUserName(HttpServletRequest request) {		
			String username=request.getParameter("username");
	    	String role=request.getParameter("role");
	    	String user=surveyDAO.getUserName(role,username);
			return user;
		}
}

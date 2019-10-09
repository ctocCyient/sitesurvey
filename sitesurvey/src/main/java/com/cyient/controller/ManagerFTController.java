
package com.cyient.controller;


import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import org.jboss.logging.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.cyient.dao.SurveyDAO;
import com.cyient.model.Technician;
import com.cyient.model.TechnicianTicketInfo;
import com.cyient.model.Ticketing;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
public class ManagerFTController {
	private static final Logger logger = Logger
			.getLogger(ManagerFTController.class);

	public ManagerFTController() {
		System.out.println("ManagerFTController()");
		 
	}
	
	   Gson gsonBuilder = new GsonBuilder().create();

	@Autowired
	private SurveyDAO surveyDAO;
	
	
	 @RequestMapping(value = "/managerOpenTickets")
		public ModelAndView managerOpenTickets(ModelAndView model) throws IOException {
		 logger.info("Manager Dashboard Open Tickets");
			 try{
				model.setViewName("managerOpenTickets");
			 }
			 catch(Exception e){
				 logger.error("In managerOpenTickets: "+e);
			 }
			return model;
		}
	 
	 @RequestMapping(value = "/managerAssignedTickets")
		public ModelAndView managerAssignedTickets(ModelAndView model) throws IOException {
		 logger.info("Manager Dashboard Assigned Tickets");
		 try{
			model.setViewName("managerAssignedTickets");
		 }
		 catch(Exception e){
			 logger.error("In managerAssignedTickets: "+e);
		 }
			return model;
		}
	 
	 @RequestMapping(value = "/managerClosedTickets")
		public ModelAndView managerClosedTickets(ModelAndView model) throws IOException {
		 logger.info("Manager Dashboard Closed Tickets");
		 try{
			model.setViewName("managerClosedTickets");
		 }
		 catch(Exception e){
			 logger.error("In managerClosedTickets: "+e);
		 }
			return model;
		}
		
		@RequestMapping(value = "/managerNotAcceptedTickets")
		public ModelAndView managerNotAcceptedTickets(ModelAndView model) {
			 logger.info("Manager Dashboard Not Accepted Tickets");
			 try{
			model.setViewName("managerNotAcceptedTickets");
			 }
			 catch(Exception e){
				 logger.error("In managerNotAcceptedTickets: "+e);
			 }
			return model;
		}
		
		@RequestMapping(value = "/techniciansList")
		public ModelAndView techniciansList(ModelAndView model) throws IOException {
			 logger.info("Manager Technicians List");
			 try{
				 model.setViewName("techniciansList");
			 }
			 catch(Exception e){
				 logger.error("In techniciansList : "+e);
			 }
			return model;
		}
		
		 @SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="getManagerTicketsCount", method = RequestMethod.GET)
			@ResponseBody
			public String  managerTicketsCount(ModelAndView model,HttpServletRequest request) {
			 String username=request.getParameter("username");
			 String region=request.getParameter("region");
				String city=request.getParameter("city");
				
				JSONObject countData=new JSONObject();
				 logger.info("Manager Tickets Count: username::"+username+" region::"+region+" city::"+city);
				//List<TechnicianTicketInfo> listOpen = surveyDAO.managerOpenTickets(username);		    
				 try{
					List<Ticketing> listOpen =  surveyDAO.managerOpenTickets(username,region,city);   
					Set ticketSet = new HashSet<Object>();
					 listOpen.removeIf(p -> !ticketSet.add(p.getTicketNum()));
					 List<TechnicianTicketInfo> listAssigned = surveyDAO.managerAssignedTickets(username);
				      Set ticketSet1 = new HashSet<Object>();
				      listAssigned.removeIf(p -> !ticketSet1.add(p.getTicketNum()));
				      List<TechnicianTicketInfo> listClosed = surveyDAO.managerClosedTickets(username);
				      Set ticketSet2 = new HashSet<Object>();
				      listClosed.removeIf(p -> !ticketSet2.add(p.getTicketNum()));
				      List<TechnicianTicketInfo> listNotAccepted = surveyDAO.managerNotAcceptedTickets(username);
				      Set ticketSet3 = new HashSet<Object>();
						listNotAccepted.removeIf(p -> !ticketSet3.add(p.getTicketNum()));
				 
					   countData.put("OpenTickets",listOpen.size());
					   countData.put("AssignedTickets",listAssigned.size());
					   countData.put("ClosedTickets",listClosed.size());
					   countData.put("NotAcceptedTickets",listNotAccepted.size());
					   
					   logger.info("Manager Count Data::"+countData);
				
				 }
				 catch(Exception e){
					 logger.error("Manager TicketsData: "+e);
				 }   
			    return countData.toString();
				
			}
		 
		 @SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="getManagerOpenTickets", method = RequestMethod.GET)
		    @ResponseBody
		    public String getManagerTotalTickets(ModelAndView model,HttpServletRequest request) {
				String username=request.getParameter("username");
				String region=request.getParameter("region");
				String city=request.getParameter("city");
				String openJson = null;
				logger.info("Manager open Tickets: username::"+username+" region::"+region+" city::"+city);

				try{
			 	List<Ticketing> listOpen = surveyDAO.managerOpenTickets(username,region,city);
				Set ticketSet = new HashSet<Object>();
			 	listOpen.removeIf(p -> !ticketSet.add(p.getTicketNum()));				 
	        	 openJson = gsonBuilder.toJson(listOpen);
	        	 logger.info("Manager open Tickets Json::"+openJson);
				}
				catch(Exception e){
					logger.error("In getManagerOpenTickets: "+e);
				}
			    return openJson.toString();
		    }
		    
		    
		    @SuppressWarnings({ "unchecked", "rawtypes" })
			@RequestMapping(value="getManagerAssignedTickets", method = RequestMethod.GET)
			    @ResponseBody
			    public String getManagerAssignedTickets(ModelAndView model,HttpServletRequest request) {
					String username=request.getParameter("username");
					 String assignedJson=null;
					logger.info("Manager Assigned Tickets: username::"+username);
					
					try{
						List<TechnicianTicketInfo> listAssigned = surveyDAO.managerAssignedTickets(username);
						Set ticketSet = new HashSet<Object>();
						listAssigned.removeIf(p -> !ticketSet.add(p.getTicketNum()));
		
		        	    assignedJson = gsonBuilder.toJson(listAssigned);
		        	    logger.info("Manager Assigned Tickets Json::"+assignedJson);			        	    
					}
					catch(Exception e){
						logger.error("In getManagerAssignedTickets: "+e);
					}
				
				              return assignedJson.toString();
			    }
			
			@SuppressWarnings({ "unchecked", "rawtypes" })
			@RequestMapping(value="getManagerNotAcceptedTickets", method = RequestMethod.GET)
		    @ResponseBody
		    public String getManagerNotAcceptedTickets(ModelAndView model,HttpServletRequest request) {
				String username=request.getParameter("username");
				logger.info("Manager Not Accepted Tickets: username::"+username);
				String notAcceptedJson=null;

				try{
					List<TechnicianTicketInfo> listNotAccepted = surveyDAO.managerNotAcceptedTickets(username);
					Set ticketSet = new HashSet<Object>();
					listNotAccepted.removeIf(p -> !ticketSet.add(p.getTicketNum()));
					notAcceptedJson = gsonBuilder.toJson(listNotAccepted);
					logger.info("Manager Not Accepted Tickets Json::"+notAcceptedJson);
				}
				catch(Exception e){
					logger.error("In getManagerAssignedTickets : "+e);
				}
			              return notAcceptedJson.toString();
		    }
			
			@SuppressWarnings({ "unchecked", "rawtypes" })
			@RequestMapping(value="getManagerClosedTickets", method = RequestMethod.GET)
		    @ResponseBody
		    public String getManagerClosedTickets(ModelAndView model,HttpServletRequest request) {
				String username=request.getParameter("username");
				logger.info("Manager Closed Tickets: username::"+username);
				 String closedJson = null;
				 try{
						List<TechnicianTicketInfo> listClosed = surveyDAO.managerClosedTickets(username);
						Set ticketSet = new HashSet<Object>();
						listClosed.removeIf(p -> !ticketSet.add(p.getTicketNum()));
				  	 
		        	    closedJson = gsonBuilder.toJson(listClosed);
		        	    logger.info("Manager Closed Tickets Json::"+closedJson);
					}
					 catch(Exception e){
						 logger.error("In getManagerClosedTickets : "+e);
					 }
			              return closedJson.toString();
		    }
	
	    
	    @RequestMapping(value="getManagerTechnicians", method = RequestMethod.GET)
	    @ResponseBody
	    public String getManagerTechnicians(ModelAndView model,HttpServletRequest request) {
	    	String username=request.getParameter("username");
	    	 String techJson =null;	    	 
	    	logger.info("Manager Technicians: username::"+username);
	    	try{
			List<Technician> listTechnicians = surveyDAO.getManagerTechnicians(username);
		        	  
	        	   techJson = gsonBuilder.toJson(listTechnicians);
	        	   logger.info("Manager Technicians Json::"+techJson);
	    	}
	    	catch(Exception e){
	    		logger.error("In getManagerTechnicians : "+e);
	    	}
		              return techJson.toString();
	    }
	    
	@RequestMapping(value = "/technicianAssignedTickets")
	public ModelAndView technicianAssignedTickets(ModelAndView model) throws IOException {
		 logger.info("Technician Dashboard Assigned Tickets");
		try{
			model.setViewName("technicianAssignedTickets");
		}
		catch(Exception e){
			logger.error("In technicianAssignedTickets : "+e);
		}
		return model;
	}
	
	@RequestMapping(value = "/technicianAcceptedTickets")
	public ModelAndView technicianAcceptedTickets(ModelAndView model) throws IOException {
		 logger.info("Technician Dashboard Accepted Tickets");
			try{
				model.setViewName("technicianAcceptedTickets");
			}
			catch(Exception e){
				logger.error("In technicianAcceptedTickets : "+e);
			}
		return model;
	}

	@RequestMapping(value = "/technicianNotAcceptedTickets")
	public ModelAndView technicianNotAcceptedTickets(ModelAndView model) throws IOException {
		 logger.info("Technician Dashboard Not Accepted Tickets");
			try{
				model.setViewName("techinicanNotAcceptedTickets");
			}
			catch(Exception e){
				logger.error("In technicianNotAcceptedTickets : "+e);
			}
		return model;
	}
	
	@RequestMapping(value = "/technicianClosedTickets")
	public ModelAndView technicianClosedTickets(ModelAndView model) throws IOException {
		 logger.info("Technician Dashboard Closed Tickets");
			try{
				model.setViewName("technicianClosedTickets");
			}
			catch(Exception e){
				logger.error("In technicianClosedTickets : "+e);
			}
		return model;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="getTechnicianAssignedTickets", method = RequestMethod.GET)
    @ResponseBody
    public String  getTechnicianAssignedTicketsData(HttpServletRequest request) {
		String username=request.getParameter("username");
		 String techOpenJson=null;
		logger.info("Technician Assigned Tickets: username::"+username);
			try{
				List<TechnicianTicketInfo> listTechOpen = surveyDAO.techAssignedTicketsData(username);		
				Set ticketSet = new HashSet<Object>();
				listTechOpen.removeIf(p -> !ticketSet.add(p.getTicketNum()));
        	
        	    techOpenJson = gsonBuilder.toJson(listTechOpen);
        	    logger.info("Technician Assigned Tickets Json:: "+techOpenJson);
			}
			catch(Exception e){
				logger.error("In getTechnicianAssignedTickets : "+e);
			}
        	  
	              return techOpenJson;
    }
	

	@SuppressWarnings( { "rawtypes", "unchecked" } )
	@RequestMapping(value="getTechnicianAcceptedTickets", method = RequestMethod.GET)
    @ResponseBody
    public String  getTechnicianAcceptedTickets(HttpServletRequest request) {
		String username=request.getParameter("username");
		logger.info("Technician Accepted Tickets: username::"+username);
		
		
		List<TechnicianTicketInfo> listTechAccept = surveyDAO.techAcceptedTicketsData(username);	
		List<TechnicianTicketInfo> listTechAccept2=surveyDAO.techAcceptedTicketsData(username);
		
		Set ticketSet = new HashSet<Object>();
		listTechAccept2.removeIf(p -> !ticketSet.add(p.getTicketNum()));
		String techAcceptJson = gsonBuilder.toJson(listTechAccept2);
		
		
		Map<Object, List<TechnicianTicketInfo>> studlistGrouped =
				listTechAccept.stream().collect(Collectors.groupingBy(w -> w.getTicketNum()));
		
			logger.info("Technician Accepted Tickets Hashmap "+studlistGrouped);
		
			JSONArray JSONArrFinal=new JSONArray();
		 JSONArray jsonArr=new JSONArray();
		
			
		 for (Map.Entry<Object, List<TechnicianTicketInfo>> entry : studlistGrouped.entrySet())  
		 {
			 JSONObject jsonObjFinal=new JSONObject();
			
			 jsonObjFinal.accumulate("TicketID",entry.getKey());
			List<TechnicianTicketInfo> listFinal=studlistGrouped.get(entry.getKey());
			
			for(TechnicianTicketInfo list1:listFinal)
			{			
				
				JSONObject jsonSites=new JSONObject(); 
				jsonSites.accumulate("SiteName", list1.getSiteid());
				jsonSites.accumulate("SiteNames", list1.getSiteids());
				jsonSites.accumulate("Status", list1.getSurveyStatus());
				jsonSites.accumulate("TicketDesc", list1.getTicketDescription());
				
				jsonObjFinal.accumulate("SITES", jsonSites);
				jsonArr.put(jsonObjFinal);
			}
		 }
		 logger.info("Technician Accepted Tickets jsonArr: "+jsonArr);
		 JSONArrFinal.put(jsonArr);
		 JSONArrFinal.put(techAcceptJson);
		 logger.info("Technician Accepted Tickets JSONArrFinal: "+JSONArrFinal);
		return JSONArrFinal.toString();
    }
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="getTechncianClosedTickets", method = RequestMethod.GET)
    @ResponseBody
    public String  getTechncianClosedTicketsData(HttpServletRequest request) {
		String username=request.getParameter("username");
		logger.info("Technician Closed Tickets: username::"+username);
		String techClosedJson=null;

		try{
			List<TechnicianTicketInfo> listTechClosed = surveyDAO.techClosedTicketsData(username);	
			Set ticketSet1 = new HashSet<Object>();
			listTechClosed.removeIf(p -> !ticketSet1.add(p.getTicketNum()));
	        	
			techClosedJson = gsonBuilder.toJson(listTechClosed);
	        	   logger.info("Technician Closed Tickets Json:: "+techClosedJson);
		}
		catch(Exception e){
			logger.error("In getTechnicianAssignedTickets : "+e);
		}
	              return techClosedJson;
    }
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="getTechncianNotAcceptedTickets", method = RequestMethod.GET)
    @ResponseBody
    public String getTechncianNotAcceptedTickets(ModelAndView model,HttpServletRequest request) {
		String username=request.getParameter("username");
		logger.info("Technician Not Accepted Tickets: username::"+username);
		String notAcceptedJson=null;
		try{
			List<TechnicianTicketInfo> listNotAccepted = surveyDAO.techNotAcceptedTickets(username);
			Set ticketSet = new HashSet<Object>();
			listNotAccepted.removeIf(p -> !ticketSet.add(p.getTicketNum()));
			notAcceptedJson = gsonBuilder.toJson(listNotAccepted);
			logger.info("Technician Not Accepted Tickets Json:: "+notAcceptedJson);
		}
		catch(Exception e){
			logger.error("In getTechncianNotAcceptedTickets : "+e);
		}
	              return notAcceptedJson;
    }
	
	
	
	
	
	 @SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="getTechTicketsCount", method = RequestMethod.GET)
		@ResponseBody
		public String  techTicketsCount(ModelAndView model,HttpServletRequest request) {
		 String username=request.getParameter("username");
		 logger.info("Technician Tickets Count: username::"+username);
		 JSONObject countData=new JSONObject();
		 try{
			List<TechnicianTicketInfo> listAssigned = surveyDAO.techAssignedTicketsData(username);		   
			Set ticketSet = new HashSet<Object>();
			listAssigned.removeIf(p -> !ticketSet.add(p.getTicketNum()));
			List<TechnicianTicketInfo> listAccepted = surveyDAO.techAcceptedTicketsData(username);
			Set ticketSet1 = new HashSet<Object>();
			listAccepted.removeIf(p -> !ticketSet1.add(p.getTicketNum()));
		      List<TechnicianTicketInfo> listClosed = surveyDAO.techClosedTicketsData(username);
		      Set ticketSet2 = new HashSet<Object>();
		      listClosed.removeIf(p -> !ticketSet2.add(p.getTicketNum()));
		      List<TechnicianTicketInfo> listNotAccepted = surveyDAO.techNotAcceptedTickets(username);
		      Set ticketSet3 = new HashSet<Object>();
		      listNotAccepted.removeIf(p -> !ticketSet3.add(p.getTicketNum()));

		     
			  
			   countData.put("AssignedTickets",listAssigned.size());
			   countData.put("AcceptedTickets",listAccepted.size());
			   countData.put("ClosedTickets",listClosed.size());
			   countData.put("NotAcceptedTickets",listNotAccepted.size());
			   logger.info("Technician Tickets Count:: "+countData);
			 }
			 catch(Exception e){
				 logger.error("In getTechTicketsCount : "+e);
			 }
			  			   
		          return countData.toString();
		}
	 
	 @RequestMapping(value="saveTechStatus", method = RequestMethod.GET)
	    @ResponseBody
	    public String  saveTechStatus(ModelAndView model,HttpServletRequest request) {
			 String ticketId = request.getParameter("ticketId");
			 String techStatus = request.getParameter("techStatus");
			 String exeId=request.getParameter("username");
			 String commentsData=request.getParameter("commentsData");
			 String remarksData=request.getParameter("remarksData");
			 String status=null;
			 logger.info("Save technician status: ticketId::"+ticketId+" techStatus"+techStatus+" exeId"+exeId+" commentsData"+commentsData+" remarksData"+remarksData);
			try{
				 status = surveyDAO.saveTechStatus(ticketId,techStatus,exeId,commentsData,remarksData);
			}
			catch(Exception e){
				logger.error("In saveTechStatus: "+e);
			}
			  	  return status;
	    }
}

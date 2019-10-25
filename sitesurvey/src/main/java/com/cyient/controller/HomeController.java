package com.cyient.controller;


import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.jboss.logging.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cyient.dao.SurveyDAO;
import com.cyient.model.Battery_Bank_Master;
import com.cyient.model.Cabinet_Master;
import com.cyient.model.Regions;
import com.cyient.model.Site;
import com.cyient.model.Site_Access;
import com.cyient.model.Site_Generator;
import com.cyient.model.Site_SMPS;
import com.cyient.model.Site_Safety;
import com.cyient.model.Site_Battery_Bank;
import com.cyient.model.Site_Cabinet;
import com.cyient.model.Technician;
import com.cyient.model.TechnicianTicketInfo;
import com.cyient.model.Ticketing;
import com.cyient.model.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
public class HomeController {
	private static final Logger homeLogger = Logger
			.getLogger("homeLogger");
	
	//static final Logger homeLogger = Logger.getLogger("reportsLogger");

	public HomeController() {
		System.out.println("HomeController()");
		 
	}
	
	@Autowired
	private SurveyDAO surveyDAO;
	
	
	Gson gsonBuilder = new GsonBuilder().create();
	
	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping(value = "/openTickets")
	public ModelAndView openTickets(ModelAndView model) throws IOException {
		homeLogger.info("In open tickets");
		try{
		model.setViewName("openTickets");
		}
		catch(Exception e){
			homeLogger.error("In Open Tickets"+e);
		}
		return model;
	}

	@RequestMapping(value = "/assignedTickets")
	public ModelAndView assignedTickets(ModelAndView model) throws IOException {
		homeLogger.info("In Assigned tickets");
		try{
		model.setViewName("assignedTickets");
		}catch(Exception e){
			homeLogger.error("In Assigned Tickets"+e);
		}
		return model;
	}
	
	@RequestMapping(value = "/historyTickets")
	public ModelAndView historyTickets(ModelAndView model) throws IOException {
		homeLogger.info("In History tickets");
		try{
		model.setViewName("historyTickets");
		}catch(Exception e){
			homeLogger.error("In History Tickets"+e);
		}return model;
	}
		
	@RequestMapping(value = "/totalTickets")
	public ModelAndView totalTickets(ModelAndView model) throws IOException {
		homeLogger.info("In open tickets");
		try{
		model.setViewName("totalTickets");
		}catch(Exception e){
			homeLogger.error("In Total ticket"+e);
		}
		return model;
	}
	
	@RequestMapping(value = "/newTicket")
	public ModelAndView newTicket(ModelAndView model) throws IOException {
		homeLogger.info("In new ticket");
		Ticketing ticketing=new Ticketing();
		model.addObject("Ticketing", ticketing);
		try{
		model.setViewName("createTicket");
		}
		catch(Exception e){
			homeLogger.info("In New Ticket"+e);
		}
		return model;
	}

	@RequestMapping(value="/newGenerator")
	public ModelAndView newGenerator(ModelAndView model) throws IOException{
		homeLogger.info("In New Generator ");
		Site_Generator generator=new Site_Generator();
		model.addObject("Site_Generator",generator);
		try{
		model.setViewName("addGenerator");
		}
		catch(Exception e){
			homeLogger.error("In New Generator"+e);
		}
		return model;
	}
	
	
	@RequestMapping(value="/newSMPS")
	public ModelAndView newSMPS(ModelAndView model) throws IOException{
		homeLogger.info("In New Smps ");
		Site_SMPS smps=new Site_SMPS();
		model.addObject("Site_SMPS",smps);
		try{
		model.setViewName("addSMPS");
		}
		catch(Exception e){
			homeLogger.error("In New Smps"+e);
		}
		return model;
	}
	
	@RequestMapping(value="/newBB")
	public ModelAndView newBB(ModelAndView model) throws IOException{
		homeLogger.info("In NewBB ");
		Site_Battery_Bank BB=new Site_Battery_Bank();
		model.addObject("Site_Battery_Bank",BB);
		try{
		model.setViewName("addBB");
		}
		catch(Exception e){
			homeLogger.error("In NewBB "+e);
		}
		return model;
	}
	
	@RequestMapping(value="/newCabinet")
	public ModelAndView newCabinet(ModelAndView model) throws IOException{
		
		homeLogger.info("In New Cabinet ");
		Site_Cabinet BB=new Site_Cabinet();
		model.addObject("Site_Cabinet",BB);
		try{
		model.setViewName("addCabinet");
		}catch(Exception e){
			homeLogger.error("In New Cabinet"+e);
		}
		return model;
	}
	
	@RequestMapping(value = "/saveTechnician", method = RequestMethod.POST)
	public ModelAndView saveTechnician(@ModelAttribute final Technician technician,RedirectAttributes redirectAttributes) throws MessagingException {
		
		homeLogger.info("In Save Technician ");
		
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
			try{
    	   surveyDAO.addTechnician(technician);
			}
			catch(Exception e){
				homeLogger.error("While Adding Technician"+e);
			}
			try{
    	   surveyDAO.addTechnicianIntoUsers(user);
			}
			catch(Exception e){
				homeLogger.error("While Adding technician into user"+e );
			}
    	   System.out.println("Manager+++++++++++++++"+technician.getManager());
    	   try{
		   managerId=surveyDAO.getManagerId(technician.getManager());
    	   }
    	   catch(Exception e){
    		   homeLogger.error("While fetching Manager "+e);
    	   }
		   final String managerName=technician.getManager();
		   final String managerEmailId=managerId.substring(1, managerId.length()-1);
		   System.out.println("mail::::"+mailSender);
		   try{
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
		   }
		   catch(Exception e){
			   homeLogger.error("While fetching Manager Details"+e);
		   }
		      redirectAttributes.addFlashAttribute("status", status);
			return new ModelAndView("redirect:/newTechnician");
	}
	
	 @RequestMapping(value = "/saveCreatedTicket", method = RequestMethod.POST)
		public ModelAndView saveTicket(@ModelAttribute Ticketing ticket,RedirectAttributes redirectAttributes) {
		
		 homeLogger.info("In Save Created ticket ");

		  List<String> siteList = Arrays.asList(ticket.getSiteid().split(","));
		
		 for(int i=0;i<siteList.size();i++){
			 Ticketing ticketing=new Ticketing();
			 ticketing.setTicketNum(ticket.getTicketNum());
			 ticketing.setRegion(ticket.getRegion());
			 ticketing.setState(ticket.getState());
			 ticketing.setDistrict(ticket.getDistrict());
			 ticketing.setCity(ticket.getCity());
			 ticketing.setSiteid(siteList.get(i));
			 ticketing.setOpenDate(ticket.getOpenDate());
			 ticketing.setOpenTime(ticket.getOpenTime());
			 ticketing.setSiteids(ticket.getSiteid());
			 ticketing.setTicketStatus("Open");	
			 ticketing.setSurveyStatus("Open");
			 ticketing.setTicketDescription(ticket.getTicketDescription());
			 try{
			 surveyDAO.addTicket(ticketing);
		 }catch(Exception e){
			 homeLogger.error("While Adding Ticket"+e);
		 }
			 }
		 
		 	
			String status="Ticket Created Successfully";
			redirectAttributes.addFlashAttribute("status", status);
			return new ModelAndView("redirect:/newTicket");
		}
	                                                                                                                                                                                                                                                                                   
   @RequestMapping(value="getUnassignedTechnicians", method = RequestMethod.GET)
    @ResponseBody
    public String  getTechniciansData(ModelAndView model,HttpServletRequest request) {
	   homeLogger.info("In Get Unassigned Techinicians ");
    	 String region=request.getParameter("region");
    	 String city=request.getParameter("city");
    	 String username=request.getParameter("username");
    	 String techniciansJson="";
    	 System.out.println("city :::"+city);
    	 try{
		List<Technician> listTechnicians = surveyDAO.getUnassignedTechniciansData(username,region,city);
		System.out.println(listTechnicians);
		    techniciansJson = gsonBuilder.toJson(listTechnicians);
    	 }catch(Exception e){
    		 homeLogger.error("While fetching get unassigned ticket"+e);
    	 }
		
          return techniciansJson.toString();
    }
    

    @RequestMapping(value="/assignTechnician", method = RequestMethod.GET)
    @ResponseBody
	public String assignTechnician(HttpServletRequest request) throws MessagingException {	
    	
    	 homeLogger.info("In Assign technician ");
    	
    	 String selectedTechnicianId=request.getParameter("technicianId");
    	 
    	 final Technician technicianData = surveyDAO.getTechniciansData(selectedTechnicianId);
    	 
    	 System.out.println("technicians: "+technicianData);
    	
    	 String selectedTicketNum=request.getParameter("ticketId");
    	 
    	 try{
    	 List<Ticketing> ticketData = surveyDAO.getTicketsData(selectedTicketNum);
    	 
//    	 System.out.println("Ticket1"+ticketData.get(0).getId());
//    	 System.out.println("Ticket2"+ticketData.get(1).getId());
//    	 System.out.println("Ticket3"+ticketData.get(2).getId());
    	 
    	
    	 
    	 String ticketId = null;
    	 String status=null;
    	 String statusUpdate=null,statusUpdate1=null;
    
		for(Ticketing ticket : ticketData)
	      {
			TechnicianTicketInfo technicianTicket=new TechnicianTicketInfo();
	    	 
	    	 technicianTicket.setTechnicianId(technicianData.getTechnicianId());
	    	 technicianTicket.setTechnicianName(technicianData.getTechnicianName());
	    	 technicianTicket.setRegion(technicianData.getRegion());
	    	 technicianTicket.setState(technicianData.getState());
	    	 technicianTicket.setDistrict(technicianData.getDistrict());
	    	 technicianTicket.setManager(technicianData.getManager());
	    	 technicianTicket.setCity(technicianData.getCity());
	    	 technicianTicket.setTicketStatus("Assigned");
	    	 technicianTicket.setSurveyStatus("Open");
	    	
	    	 
    	 
    		 ticketId=ticket.getTicketNum();
        	 technicianTicket.setTicketNum(ticket.getTicketNum());
        	 technicianTicket.setSiteid(ticket.getSiteid());  
        	 technicianTicket.setSiteids(ticket.getSiteids());  
        	 technicianTicket.setOpenDate(ticket.getOpenDate());
        	 technicianTicket.setOpenTime(ticket.getOpenTime());  
        	 technicianTicket.setTicketDescription(ticket.getTicketDescription());    
        	 	try{
        	  status= surveyDAO.assignTechnician(technicianTicket);
        	  
        	 	}catch(Exception e){
        	 		homeLogger.error("while fetching the status of the technician ticket "+e);
        	 	}
        	 	try{
        	  statusUpdate =surveyDAO.updateTicketingStatus(ticketId,ticket.getSiteid());
        	  statusUpdate1 =surveyDAO.updateSurveyStatus(ticket.getSiteid(),"Assigned");
        	 
      	 	}catch(Exception e){
      	 		homeLogger.error("While fetching the statusupdate of the ticket"+e);
      	 	}
        	 	}
		
    	// if (technicianTicket.getSiteid() != null) { 			
			if(status.equalsIgnoreCase("Assigned")&&statusUpdate.equalsIgnoreCase("Assigned"))
			{
				mailSender.send(new MimeMessagePreparator() {
			      	  public void prepare(MimeMessage mimeMessage) throws MessagingException {
			      	    MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
			      	    message.setTo("lakshmimadhuri.pulavarthy@cyient.com");
			      	    message.setSubject("Ticket Information");	    	 
			      	    message.setText("Dear <b>" + technicianData.getTechnicianName() +"</b> ,<br><br> Site with Id is assigned for Survey . <br><br> Please <a href='http://ctoceu.cyient.com:3290/RFIDAssetTracking/'>login</a> for other details", true);
			      	    
			      	  }
			      	});
//			}
			}
    	 }
    	 catch(Exception e){
    		 homeLogger.error("While fetching tickets data "+e);
    	 }
    	return "Assigned";		
	}
      

	
	@RequestMapping(value = "/newUser", method = RequestMethod.GET)
	public ModelAndView newUser(ModelAndView model) {
		 homeLogger.info("In New User ");
		User user = new User();
		model.addObject("User", user);
		try{
		model.setViewName("userReg");
		}
		catch(Exception e){
			homeLogger.error("In User Reg"+e);
		}return model;
	}
    
	@RequestMapping(value = "/newTechnician", method = RequestMethod.GET)
	public ModelAndView newTechnician(ModelAndView model) {
		 homeLogger.info("In New Technician ");
		Technician technician = new Technician();
		model.addObject("Technician", technician);
		try{
		model.setViewName("technicianReg");
		}catch(Exception e){
			homeLogger.error("In New Technician"+e);
		}
		return model;
	}
	
	@RequestMapping(value = "/newSite", method = RequestMethod.GET)
	public ModelAndView newSite(ModelAndView model) {
		 homeLogger.info("In New Site ");
		Site site = new Site();
		model.addObject("Site", site);
		try{
		model.setViewName("addSite");
		}catch(Exception e){
			homeLogger.error("In new Site"+e);
		}
		return model;
		
		// return new ModelAndView("addSite", "command", new Site());
	}
	
	@RequestMapping(value = "/ValidateLatLong", method = RequestMethod.GET)
	@ResponseBody
	public String ValidateLatLong(ModelAndView model,HttpServletRequest request){
		
		 homeLogger.info("In Validate LatLong ");
		try{
		if(surveyDAO.ValidateLatLong(request.getParameter("latitude"), request.getParameter("longitude")).size()>0)
		{
			return "Existing";
		}
		else
		{
			return "New";
		}
		}
		catch(Exception e){
			homeLogger.error("In Validate Lat Long"+e);
		}
		
		return null;
	}
	
	@RequestMapping(value = "/saveSite", method = RequestMethod.POST)
	public ModelAndView saveSiter(@ModelAttribute Site site,RedirectAttributes redirectAttributes) {
	
		 homeLogger.info("In Save Site ");
		String status="Site Added Successfully";
		if (site.getSiteid() !=null) { 
			try{
			surveyDAO.addSite(site);
			}catch(Exception e){
				homeLogger.error("While adding site"+e);
			}
		} 
		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newSite");
	}
	

	@RequestMapping(value="/saveGenerator" , method=RequestMethod.POST)
	public ModelAndView saveGenerator(@Valid @ModelAttribute("Site_Generator") Site_Generator generator , BindingResult br , ModelAndView model, @RequestParam("file") MultipartFile[] multipart,
			@RequestParam("submit") String submit, RedirectAttributes redirectAttributes,HttpServletRequest request) throws IOException{
		
		 homeLogger.info("In Save Generator ");
		
		/*if(br.hasErrors())
		{
			System.out.println("errorss-----------"+br.getAllErrors());

			model.setViewName("addGenerator");
			return model;
		}
		else
		{
			try
			{
				generator.setGdphoto(multipart[0].getBytes());
				generator.setDg_photo_name(multipart[0].getOriginalFilename());
				generator.setFuellevel_photo(multipart[1].getBytes());
				generator.setFuel_level_name(multipart[1].getOriginalFilename());
				generator.setDg_inproper_1(multipart[2].getBytes());
				generator.setDg_inproper_1_name(multipart[2].getOriginalFilename());
				generator.setDg_inproper_2(multipart[3].getBytes());
				generator.setDg_inproper_2_name(multipart[3].getOriginalFilename());
				generator.setTag_photo(multipart[4].getBytes());
				generator.setTag_photo_name(multipart[4].getOriginalFilename());
			}
			catch(Exception e)
			{
				System.out.println(e.toString());
			}
		}*/
		
		for(int i=0;i<multipart.length;i++){
			
			if(multipart[i].isEmpty()){
				
				try{
				//Object s="setSite_photo"+i;
				List<Site_Generator> generatorList=surveyDAO.getGeneratorDetails(generator.getSiteid().getSiteid());
				if(i==0){
					System.out.println("in i=1");
					generator.setGdphoto(generatorList.get(0).getGdphoto());
					generator.setDg_photo_name(generatorList.get(0).getDg_photo_name());
					}
				else if(i==1){
					System.out.println("in i=2");
					generator.setFuellevel_photo(generatorList.get(0).getFuellevel_photo());
					generator.setFuel_level_name(generatorList.get(0).getFuel_level_name());
				}
				else if(i==2){
					System.out.println("in i=3");
					generator.setDg_inproper_1(generatorList.get(0).getDg_inproper_1());
					generator.setDg_inproper_1_name(generatorList.get(0).getDg_inproper_1_name());
				}else if(i==3){
					System.out.println("in i=4");
					generator.setDg_inproper_2(generatorList.get(0).getDg_inproper_2());
					generator.setDg_inproper_2_name(generatorList.get(0).getDg_inproper_2_name());
				}
				else if(i==4){
					System.out.println("in i=5");
					generator.setTag_photo(generatorList.get(0).getTag_photo());
					generator.setTag_photo_name(generatorList.get(0).getTag_photo_name());
				}
			}catch(Exception e){
				homeLogger.error("While fetching Genarator list"+e);
			}
			}
			else{
				if(i==0){
					generator.setGdphoto(multipart[0].getBytes());
					generator.setDg_photo_name(multipart[0].getOriginalFilename());
					
				}
				else if(i==1){
					generator.setFuellevel_photo(multipart[1].getBytes());
					generator.setFuel_level_name(multipart[1].getOriginalFilename());
					
				}
				else if(i==2){
					generator.setDg_inproper_1(multipart[2].getBytes());
					generator.setDg_inproper_1_name(multipart[2].getOriginalFilename());
					
				}else if(i==3){
					generator.setDg_inproper_2(multipart[3].getBytes());
					generator.setDg_inproper_2_name(multipart[3].getOriginalFilename());
				}
				else if(i==4){
					generator.setTag_photo(multipart[4].getBytes());
					generator.setTag_photo_name(multipart[4].getOriginalFilename());
				}
			}
		}
		
		String status="Generator Added Successfully";
		try{
		surveyDAO.addGenerator(generator);
		}catch(Exception e){
			homeLogger.error("While adding genarator"+e );
		}
		redirectAttributes.addFlashAttribute("status",status);
		
		if(submit.equals("Next"))
		{

			/*model.addObject("siteId", siteId);
			model.setViewName("redirect:/newSMPS");*/
			return new ModelAndView("redirect:/newSMPS");
			
		}
		else if(submit.equals("Save for Later") || submit.equals("Add"))
		{
			return new ModelAndView("redirect:/home");
			
		}
		return model;

	}

	@RequestMapping(value="/saveSMPS" , method=RequestMethod.POST)
	public ModelAndView saveSMPS(@ModelAttribute("Site_SMPS") Site_SMPS smps, @RequestParam("file") MultipartFile[] multipart ,@RequestParam("submit") String submit,RedirectAttributes redirectAttributes,ModelAndView model){

		 homeLogger.info("In Save SMPS ");
		int id=smps.getId();
		try {
			
			for(int i=0;i<multipart.length;i++){
				
				if(multipart[i].isEmpty()){
					
					//Object s="setSite_photo"+i;
					try{
					List<Site_SMPS> smpsList=surveyDAO.getSMPSDetails(smps.getSiteid().getSiteid());
					if(i==0){
						System.out.println("in i=1");
						smps.setObservation_1(smpsList.get(0).getObservation_1());
						smps.setObservation_1_Name(smpsList.get(0).getObservation_1_Name());
						}
					else if(i==1){
						System.out.println("in i=2");
						smps.setObservation_2(smpsList.get(0).getObservation_2());
						smps.setObservation_2_Name(smpsList.get(0).getObservation_2_Name());
					}
				}catch(Exception e){
					homeLogger.error("While Fetching SMPS Details"+e);
				}
				}
				else{
					if(i==0){
						smps.setObservation_1(multipart[0].getBytes());
						smps.setObservation_1_Name(multipart[0].getOriginalFilename());
						
					}
					else if(i==1){
						smps.setObservation_2(multipart[1].getBytes());
						smps.setObservation_2_Name(multipart[1].getOriginalFilename());
						
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		try{
		surveyDAO.addSMPS(smps);
		}catch(Exception e){
			homeLogger.error("While adding smps "+e);
		}
		String status="SMPS Added Successfully";
		redirectAttributes.addFlashAttribute("status",status);

		if(submit.equals("Save for Later"))
		{
			return new ModelAndView("redirect:/home");
		}
		else if(submit.equals("Next"))
		{
			return new ModelAndView("redirect:/newBB");
		}

	
		return model;
	}
	
	@RequestMapping(value="/getSMPSDetails", method=RequestMethod.GET)
	@ResponseBody
	public String getSMPSDetails(HttpServletRequest request)
	{
		String siteId=request.getParameter("siteId");
		String ticketId=request.getParameter("ticketId");
		List<Site_SMPS> siteSMPSList=surveyDAO.getSMPSDetails(siteId);
	
		String siteSMPSJson=gsonBuilder.toJson(siteSMPSList);
		return siteSMPSJson.toString();
	}
	
	@RequestMapping(value="/getGeneratorDetails", method=RequestMethod.GET)
	@ResponseBody
	public String getGeneratorDetails(HttpServletRequest request)
	{
		String siteId=request.getParameter("siteId");
		List<Site_Generator> siteGeneratorList=surveyDAO.getGeneratorDetails(siteId);
		
		String siteGeneratorJson=gsonBuilder.toJson(siteGeneratorList);
		return siteGeneratorJson.toString();

	}

	@RequestMapping(value = "/saveBB", method = RequestMethod.POST)
	public ModelAndView saveBB(@ModelAttribute Site_Battery_Bank BB,@RequestParam("photos") MultipartFile[] tag_photo,@RequestParam("submit") String submit,RedirectAttributes redirectAttributes) throws IOException {
		 homeLogger.info("In Save BB ");
		
		System.out.println("save bb calling" + tag_photo.length);
		String status = "Battery Bank Added Successfully";
		Site_Battery_Bank obj = new Site_Battery_Bank();

	
if(BB.getId()!=0){
	try{
	obj= surveyDAO.getBB(BB.getSiteid().getSiteid()).get(0);
	}catch(Exception e){
		homeLogger.error("While fetching BB details"+e );
	}
}

		// saggrigation of files
		if(tag_photo[0].isEmpty())
		{
			BB.setTag_photo(obj.getTag_photo());
			BB.setTag_photo_Name(obj.getTag_photo_Name());
		}
		else
		{
			BB.setTag_photo(tag_photo[0].getBytes());
			BB.setTag_photo_Name(tag_photo[0].getOriginalFilename());
			
		}
		
		if(tag_photo[1].isEmpty())
		{
			BB.setTag_photo1(obj.getTag_photo1());
			BB.setTag_photo1_Name(obj.getTag_photo1_Name());	
		}
		else
		{
			BB.setTag_photo1(tag_photo[1].getBytes());
			BB.setTag_photo1_Name(tag_photo[1].getOriginalFilename());
			
		}
		
		if(tag_photo[2].isEmpty())
		{
			BB.setTag_photo_2(obj.getTag_photo_2());
			BB.setTag_photo2_Name(obj.getTag_photo2_Name());
		}
		else
		{
			BB.setTag_photo_2(tag_photo[2].getBytes());
			BB.setTag_photo2_Name(tag_photo[2].getOriginalFilename());			
		}
		System.out.println("BB id"+BB.getId());
		try{
		surveyDAO.addBB(BB);
		}catch(Exception e){
			homeLogger.error("While adding BB"+e);
		}
		redirectAttributes.addFlashAttribute("status", status);
		if (submit.equals("Save for Later")) {
			return new ModelAndView("redirect:/home");
		} else if (submit.equals("Next")) {
			return new ModelAndView("redirect:/newCabinet");
		} else {
			return new ModelAndView("redirect:/");
		}

	}


	@RequestMapping(value = "/saveCabinet", method = RequestMethod.POST)
	public ModelAndView saveCabinet(@ModelAttribute Site_Cabinet BB, @RequestParam("updatetype") String updatetype,
			@RequestParam("submit") String submit, RedirectAttributes redirectAttributes,
			@RequestParam(name = "tag_photo") MultipartFile[] tag_photo) throws IOException {
		 homeLogger.info("In Save Cabinet ");
		
		String status = "Cabinet Added Successfully";
		Site_Cabinet obj = new Site_Cabinet();
		/*System.out.println(updatetype);
		System.out.println(updatetype.split(";")[0]);
		System.out.println(updatetype.split(";")[1]);
		System.out.println(updatetype.split(";")[2]);
		System.out.println(updatetype.split(";")[3]);
		System.out.println(updatetype.split(";")[0]=="New");*/
		if(updatetype.split(";")[0].contains("New"))
		{
			
		}
		else
		{
			try{
			obj= surveyDAO.getCabinet(BB.getSiteid().getSiteid()).get(0);
			}catch(Exception e){
				homeLogger.error("While fetching Cabinet Details"+e);
			}
		}

		if(updatetype.split(";")[2].contains("Yes"))
		{
		BB.setPhoto_1(tag_photo[0].getBytes());
		BB.setPhoto_1_Name(tag_photo[0].getOriginalFilename());
		}
		else
		{
			BB.setPhoto_1(obj.getPhoto_1());
			BB.setPhoto_1_Name(obj.getPhoto_1_Name());
		}
		
		if(updatetype.split(";")[3].contains("Yes"))
		{
			BB.setPhoto_2(tag_photo[tag_photo.length-1].getBytes());
			BB.setPhoto_2_Name(tag_photo[tag_photo.length-1].getOriginalFilename());
		}
		else
		{
			BB.setPhoto_2(obj.getPhoto_2());
			BB.setPhoto_2_Name(obj.getPhoto_2_Name());
		}
		
		try{
		surveyDAO.addCabinet(updatetype,BB);
		}catch(Exception e){
			homeLogger.error("While adding Cabinet"+e);
		}
		redirectAttributes.addFlashAttribute("status", status);

		if (submit.equals("Save for Later")) {
			return new ModelAndView("redirect:/home");
		} else if (submit.equals("Next")) {
			return new ModelAndView("redirect:/fetchtowerinstallation");
		} else {
			return new ModelAndView("redirect:/");
		}
	}

	@RequestMapping(value = "/getBBData", method = RequestMethod.GET)
	@ResponseBody
	public String getBB(HttpServletRequest request) {
		
		 homeLogger.info("In Get BB Data");
		 String siteSMPSJson ="";
		try{
		List<Site_Battery_Bank> obj = surveyDAO.getBB(request.getParameter("siteid"));
		 siteSMPSJson = gsonBuilder.toJson(obj);
		}
		catch(Exception e){
			homeLogger.error("While fetching the Batery Bank Details"+e);
		}
		return siteSMPSJson.toString();

	}

	@RequestMapping(value = "/getCabinetData", method = RequestMethod.GET)
	@ResponseBody
	public String getCabinetData(HttpServletRequest request) {
		
		 homeLogger.info("In Get Cabinet Data");
		 String siteSMPSJson="";
		 try{
		 List<Site_Cabinet> obj = surveyDAO.getCabinet(request.getParameter("siteid"));
		 siteSMPSJson = gsonBuilder.toJson(obj);
		 }catch(Exception e){
			 homeLogger.error("While fetching the cabinet details"+e);
		 }
		 return siteSMPSJson.toString();

	}
	
	
	
	 @RequestMapping(value="/getLastTicketId", method=RequestMethod.GET)
	 @ResponseBody
	 public String getLastTicketId(HttpServletRequest request){
		
		 homeLogger.info("In Get Last Ticket Id");
		 String executiveJson="";
		 try{
		 List<Ticketing> ticketList=surveyDAO.getTicketId();
		  executiveJson=gsonBuilder.toJson(ticketList);
		 }
		 catch(Exception e){
			 homeLogger.error("While fetching the ticket list"+e);
		 }
		  return executiveJson.toString();
		 
	 }

	 
	   @ModelAttribute("regionsList")	
	   public Map<String, String> getRegions() {
		   
		   homeLogger.info("In Get Region list");
		   
	      Map<String, String> regionsMap = new HashMap<String, String>();
	      try{
	      List<Regions> regions = surveyDAO.getRegions();
	  
//	      for(int i=0;i<regions.size();i++){
//	    	 // System.out.println(regions.get(i));
//	    	 }
	      for(Regions region : regions)
	      {
	    	  regionsMap.put(region.getRegion(), region.getRegion());
	      }
	     // System.out.println("RegionsData "+regionsMap);
	      }catch(Exception e){
	    	  homeLogger.error("While fetching the region list"+e);
	      }
	      return regionsMap;
	   }
	   
	   @ModelAttribute("BBManufacturer")	
	   public Map<String, String> getBBManufacturer() {
		   
		   homeLogger.info("In BBManufacturer");
		   
	      Map<String, String> BBMap = new HashMap<String, String>();
	      try{
	      List<Battery_Bank_Master> regions = surveyDAO.getBBManufacturer();
	      int i=0;
	      for(i=0;i<regions.size();i++){
	    	  System.out.println(regions.get(i));
	    	 }
	      for(Battery_Bank_Master region : regions)
	      {
	    	  BBMap.put(region.getManufacturer(), region.getManufacturer());
	      }
	      System.out.println("RegionsData "+BBMap);
	      }catch(Exception e){
	    	  homeLogger.error("While fetching the BBManufacturer Details"+e);
	      }
	      return BBMap;
	   }
	  
	   
	   @ModelAttribute("BBType")	
	   public Map<String, String> getBBType() {
		   homeLogger.info("In BB Type");
	      Map<String, String> BBMap = new HashMap<String, String>();
	      try{
	      List<Battery_Bank_Master> regions = surveyDAO.getBBManufacturer();
	      int i=0;
	      for(i=0;i<regions.size();i++){
	    	  System.out.println(regions.get(i));
	    	 }
	      for(Battery_Bank_Master region : regions)
	      {
	    	  BBMap.put(region.getType(), region.getType());
	      }
	      System.out.println("RegionsData "+BBMap);
	      }catch(Exception e){
	    	  homeLogger.error("While fetching the Bank Master details"+e);
	      }
	      return BBMap;
	   }
	   
	   
	   @ModelAttribute("CabinetManufacturer")	
	   public Map<String, String> getCabinetManufacturer() {
		   
		   homeLogger.info("In Cabiner Manufacturer");
	      Map<String, String> BBMap = new HashMap<String, String>();
	      try{
	      List<Cabinet_Master> regions = surveyDAO.getCabinetManufacturer();
	      int i=0;
	      for(i=0;i<regions.size();i++){
	    	  System.out.println(regions.get(i));
	    	 }
	      for(Cabinet_Master region : regions)
	      {
	    	  BBMap.put(region.getCabinetManufacturer(), region.getCabinetManufacturer());
	      }
	      System.out.println("RegionsData "+BBMap);
	      }catch(Exception e){
	    	  homeLogger.error("While fetching the cabinet manufacturer details"+e);
	      }
	      return BBMap;
	   }
	  
	   
	   @ModelAttribute("CabinetType")	
	   public Map<String, String> getCabinetType() {
		   homeLogger.info("In Cabinet Type");
	      Map<String, String> BBMap = new HashMap<String, String>();
	      try{
	      List<Cabinet_Master> regions = surveyDAO.getCabinetManufacturer();
	      int i=0;
	      for(i=0;i<regions.size();i++){
	    	  System.out.println(regions.get(i));
	    	 }
	      for(Cabinet_Master region : regions)
	      {
	    	  BBMap.put(region.getType(), region.getType());
	      }
	      System.out.println("RegionsData "+BBMap);
	      }catch(Exception e){
	    	  homeLogger.error("While fetching the cabinet manufacturer details "+e);
	      }
	      return BBMap;
	   }
	   

	 @RequestMapping(value="getStates", method = RequestMethod.GET)
	    @ResponseBody

	    public String getStates(ModelAndView model,HttpServletRequest request) {
		   homeLogger.info("In Get States");
		String selectedRegion=request.getParameter("selectedRegion");		
		String statesJson="";
			//List<Regions> listStates = surveyDAO.getStates(selectedRegion);
		try{
			 List<Regions> regions = surveyDAO.getStates(selectedRegion);
			 List<String> listStates = new ArrayList<String>();
		      for(Regions region : regions)
		      {
    	//  statesMap.put(region.getState(),region.getState());
		    	  listStates.add(region.getState());

		      }
		      
		      List<Object> listWithoutDuplicates = listStates.stream().distinct().collect(Collectors.toList());
		    
	           statesJson = gsonBuilder.toJson(listWithoutDuplicates);
	          //System.out.println("StatesJSON"+statesJson);
		}catch(Exception e){
			homeLogger.error("While fetching the states"+e);
		}
	          return statesJson;
    	  // return statesMap;

	    }
	 
	 @RequestMapping(value="getDistricts", method = RequestMethod.GET)
	    @ResponseBody

	    public  String getDistricts(ModelAndView model,HttpServletRequest request) {
		 
		 homeLogger.info("In Get Districts");
		 String selectedRegion=request.getParameter("selectedRegion");

			String selectedState=request.getParameter("selectedState");	
			String districtsJson="";
			try {
			List<Regions> districts = surveyDAO.getDistricts(selectedRegion,selectedState);
			List<String> listDistricts = new ArrayList<String>();
			for(Regions region: districts)
			{
				listDistricts.add(region.getDistrict());
			}
			List<Object> listWithoutDuplicates = listDistricts.stream().distinct().collect(Collectors.toList());
			
		    districtsJson = gsonBuilder.toJson(listWithoutDuplicates);
			}catch(Exception e){
				homeLogger.error("While fetching the the districts list"+e);
			}
			return districtsJson;
		    }
	 
	    @RequestMapping(value="getCities", method = RequestMethod.GET)
	    @ResponseBody

	    public  String getCities(ModelAndView model,HttpServletRequest request) {
	    	
	    	 homeLogger.info("In Get Cities");
		 String selectedRegion=request.getParameter("selectedRegion");
			String selectedState=request.getParameter("selectedState");	
			String selectedDistrict=request.getParameter("selectedDistrict");	
			String totalJson="";
			try{
			List<Regions> cities = surveyDAO.getCities(selectedRegion,selectedState,selectedDistrict);
			List<String> listCities=new ArrayList<String>();
			for(Regions region:cities)
			{
				listCities.add(region.getCity());
			}
			List<Object> listWithoutDuplicates = listCities.stream().distinct().collect(Collectors.toList());
			
	         totalJson = gsonBuilder.toJson(listWithoutDuplicates);
			}
			catch(Exception e){
				homeLogger.error("While fetching the cities"+e);
			}
	        return totalJson.toString();
	   

			/*List<Regions> regions = surveyDAO.getCities(selectedRegion,selectedState,selectedDistrict);
			 Map<String, String> citiesMap = new HashMap<String, String>();
			 for(Regions region : regions)
		      {
				 citiesMap.put(region.getCity(),region.getCity());
		      }
			
//			  	  
//	        	   String totalJson = gsonBuilder.toJson(listCities);
		              return citiesMap;*/


	    }
	    	
	    
	    @SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping("ticketsCount")
	    @ResponseBody
	    public String  ticketsCountData(ModelAndView model) {
	    	homeLogger.info("In Tickets Count");
	    	 JSONObject countData=new JSONObject();
	    	 List<Ticketing> listOpen=null;
	    	 List<TechnicianTicketInfo> listAssigned =null;
	    	 List<Ticketing> listTotal=null;
	    	try{
			listOpen = surveyDAO.openTicketsData();		
		    Set ticketSet = new HashSet<Object>();
			 listOpen.removeIf(p -> !ticketSet.add(p.getTicketNum()));
	    	}catch(Exception e){
	    		homeLogger.error("While fetching the tickets data"+e);
	    	}
	    	try{
		    listAssigned = surveyDAO.assignedTicketsData();
	    	}catch(Exception e){
	    		homeLogger.error("While fetching list assigned data"+e);
	    	}
		    Set ticketSet1 = new HashSet<Object>();
			listAssigned.removeIf(p -> !ticketSet1.add(p.getTicketNum()));
		      List<TechnicianTicketInfo> listHistory = surveyDAO.historyTicketsData();
		      Set ticketSet2 = new HashSet<Object>();
		      listHistory.removeIf(p -> !ticketSet2.add(p.getTicketNum()));
		      try{
		      listTotal =surveyDAO.getAllTicketsData();
		      }catch(Exception e){
		    	  homeLogger.error("While fetching the total tickets list"+e);
		      }
		      Set ticketSet3 = new HashSet<Object>();
		      listTotal.removeIf(p -> !ticketSet3.add(p.getTicketNum()));
		     
			   
			   countData.put("OpenTickets",listOpen.size());
			   countData.put("AssignedTickets",listAssigned.size());
			   countData.put("HistoryTickets",listHistory.size());
			   countData.put("TotalTickets",listTotal.size());
			   System.out.println(countData);			   
		          return countData.toString();
	    }
	 
	    @SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping("getOpenTickets")
	    @ResponseBody
	    public String  getOpenTicketsData(ModelAndView model) {
	    	homeLogger.info("In getOpenTickets ");
	    	List<Ticketing> listOpen=null;
	    	try{
	    	listOpen = surveyDAO.openTicketsData();	
	    	}catch(Exception e){
	    		homeLogger.error("While fetching the openTickets Data"+e);
	    	}
		    Set openSet = new HashSet<Object>();

	        // directly removing the elements from list if already existed in set
		    listOpen.removeIf(p -> !openSet.add(p.getTicketNum()));

	     //   listOpen.forEach(dept->System.out.println(dept.getId() +" : "+dept.getSiteid()+"::"+dept.getSiteids()));
				
		
			String openJson = gsonBuilder.toJson(listOpen);
    	   	return openJson.toString();
	    }
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping("getAssignedTickets")
	    @ResponseBody
	    public String  getAssignedTicketsData(ModelAndView model) {
			homeLogger.info("In getAssignedTickets ");
			List<TechnicianTicketInfo> listAssigned =null;
			try{
			listAssigned = surveyDAO.assignedTicketsData();
			}catch(Exception e){
				homeLogger.error("While fetching the assignedTickets data"+e);
			}
			Set ticketSet = new HashSet<Object>();
			listAssigned.removeIf(p -> !ticketSet.add(p.getTicketNum()));
			
			String closedJson = gsonBuilder.toJson(listAssigned);
    	   	return closedJson.toString();
	    }
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping("getHistoryTickets")
	    @ResponseBody
	    public String  getHistoryTicketsData(ModelAndView model) {
			homeLogger.info("In getHistoryTickets ");
			List<TechnicianTicketInfo> listHistory=null;
			try{
			 listHistory = surveyDAO.historyTicketsData();
			}catch(Exception e){
				homeLogger.error("While fetching the historyTickets data"+e);
			}
			 Set ticketSet = new HashSet<Object>();
			listHistory.removeIf(p -> !ticketSet.add(p.getTicketNum()));
	  	   
    	    String historyJson = gsonBuilder.toJson(listHistory);
              return historyJson.toString();
		}
		
	    @RequestMapping(value="getSiteId", method = RequestMethod.GET)
	    @ResponseBody

	    public  String getSiteId(ModelAndView model,HttpServletRequest request) {
	    	homeLogger.info("In getSiteId ");
		 String selectedRegion=request.getParameter("selectedRegion");
			String selectedState=request.getParameter("selectedState");	
			String selectedDistrict=request.getParameter("selectedDistrict");	
			String selectedCity=request.getParameter("selectedCity");	
			List<Site> siteIds=null;

			List<Ticketing> TicketingSiteIds=null;
			
			try{
				siteIds = surveyDAO.getSiteIdsForRegion(selectedRegion,selectedState,selectedDistrict,selectedCity);
				TicketingSiteIds =  surveyDAO.getTicketingSiteIds();			
			}catch(Exception e){
				homeLogger.error("While fetching the siteIds for region"+e);
			}
			List<String> listSiteIds=new ArrayList<String>();
			for(Site site:siteIds)
			{
				listSiteIds.add(site.getSiteid());
			}
			List<String> TicketingListSiteIds =  new ArrayList<String>();
			for(Ticketing ticket:TicketingSiteIds)
			{
				TicketingListSiteIds.add(ticket.getSiteids());
			}
			List<Object> listWithoutDuplicates = listSiteIds.stream().distinct().collect(Collectors.toList());
		

			List<String> totalSiteIds =  new ArrayList<String>();
						
			List<String> List=new ArrayList<String>();
			
			for(int i=0;i<TicketingListSiteIds.size();i++){
				
				List.addAll(Arrays.asList(TicketingListSiteIds.get(i).split("\\s*,\\s*")));
			}
			
			for(int i=0;i<listWithoutDuplicates.size();i++){
				
				if(List.contains(listWithoutDuplicates.get(i)))
				{
					System.out.println(listWithoutDuplicates.get(i));
				}
				else
				{
					totalSiteIds.add((String) listWithoutDuplicates.get(i));
				}
			}
			
			
			
	        String totalJson = gsonBuilder.toJson(totalSiteIds);
		    return totalJson;
		    
			/*List<Regions> regions = surveyDAO.getCities(selectedRegion,selectedState,selectedDistrict);
			 Map<String, String> citiesMap = new HashMap<String, String>();
			 for(Regions region : regions)
		      {
				 citiesMap.put(region.getCity(),region.getCity());
		      }
			
//			  	  
//	        	   String totalJson = gsonBuilder.toJson(listCities);
		              return citiesMap;*/

	    }
	    
	 @RequestMapping(value="/getLastSiteId", method=RequestMethod.GET)
	  @ResponseBody
	  public String getLastSiteId(HttpServletRequest request){
			homeLogger.info("In GetLastSiteId ");
			List<Site> siteidList=null;
			try{
	    siteidList=surveyDAO.getSiteId();
			}catch(Exception e){
				homeLogger.error("While fetching the siteList"+e);
			}
	    System.out.println("siteid>>>>>>...."+siteidList);
	  
	   String executiveJson=gsonBuilder.toJson(siteidList);
	   return executiveJson.toString();
	  
	  }

		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping("getTotalTickets")
		@ResponseBody
		public String  getTotalTicketsData(ModelAndView model) {
			homeLogger.info("In getTotalTickets ");
			String totalJson =null;
			List<Ticketing> listTotal=null;
			try{
			 listTotal = surveyDAO.getAllTicketsData();
			}catch(Exception e){
				homeLogger.error("While fetching the total ticket list"+e);
			}
			 Set ticketSet = new HashSet<Object>();
		      listTotal.removeIf(p -> !ticketSet.add(p.getTicketNum()));
		    
			  totalJson = gsonBuilder.toJson(listTotal);
			
			 return totalJson.toString();
		}
		
		@RequestMapping(value = "/adminOpenTickets")
		public ModelAndView adminOpenTickets(ModelAndView model) throws IOException {
			homeLogger.info("In adminOpenTickets ");
			try{
			model.setViewName("adminOpenTickets");
			}catch(Exception e){
				homeLogger.error("In Viewing the adminOpenTickets"+e);
			}
			return model;
		}
		
		
		 @RequestMapping("getAdminTicketsCount")
		@ResponseBody
		public String  getAdminTicketsCount(ModelAndView model) {
			 homeLogger.info("In GetManager ");
			 JSONObject countData=new JSONObject();
			 List<Ticketing> listOpen=null;
			 List<TechnicianTicketInfo> listAssigned=null;
			  List<TechnicianTicketInfo> listHistory=null;
			 List<Ticketing> listTotal=null;
			 try{
			 listOpen = surveyDAO.openTicketsData();		              
			 }catch(Exception e){
				 homeLogger.error("While fetching Opentickets"+e);
			 }
			 try{
			  listAssigned = surveyDAO.assignedTicketsData();
			 }catch(Exception e){
				 homeLogger.error("While fetchimg assigned tickets data"+e);
			 }
			 try{
			  listHistory = surveyDAO.historyTicketsData();
			 }catch(Exception e){
				 homeLogger.error("While fetching the history tickets"+e);
			 }
			 try{
			   listTotal =surveyDAO.getAllTicketsData();
			 }catch(Exception e){
				 homeLogger.error("While fetching the total tickets data"+e);
			 }
			  
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
	    	
	    	homeLogger.info("In GetManager ");
	    	
	    	String region=request.getParameter("selectedRegion");
	    	homeLogger.info("Region"+region);
	    	String managerJSON=null;
	    	try{
	    	List<User> managers = surveyDAO.getManager(region);
			List<String> listManagers=new ArrayList<String>();
			for(User user: managers)
			{
				listManagers.add(user.getUsername());
			}
		
			 managerJSON = gsonBuilder.toJson(listManagers);
	    	}catch(Exception e){
	    		homeLogger.error("While fetching list of managers"+e);
	    	}
			return managerJSON;
		}


	    @RequestMapping(value = "/getUserName", method = RequestMethod.GET)
		@ResponseBody
		public String getUserName(HttpServletRequest request) {	
	    	
	    	homeLogger.info("In Get UserName ");
	    	String user=null;
			String username=request.getParameter("username");
	    	String role=request.getParameter("role");
	    	try{
	    	user=surveyDAO.getUserName(role,username);
	    	homeLogger.info("userName"+user);
	    	}catch(Exception e){
	    		homeLogger.error("While Getting UserName"+e);
	    	}
	    	return user;
		}
	   
}
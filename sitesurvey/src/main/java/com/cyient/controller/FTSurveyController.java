
package com.cyient.controller;


import java.awt.PageAttributes.MediaType;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cyient.dao.SurveyDAO;
import com.cyient.model.Regions;
import com.cyient.model.Site;
import com.cyient.model.Site_Access;
import com.cyient.model.Site_Area;
import com.cyient.model.Site_SMPS;
import com.cyient.model.Site_Wiring;
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
	
	 Gson gsonBuilder = new GsonBuilder().create();
	 
	 
	 @RequestMapping(value="getSiteDetails", method = RequestMethod.GET)
	    @ResponseBody
	    public String  getSiteDetails(HttpServletRequest request) {
			String siteId=request.getParameter("siteId");
			String ticketId=request.getParameter("ticketId");
			System.out.println("SITE"+siteId);
			String siteStatus=surveyDAO.updateSiteStatus(siteId,ticketId);
			List<Site> siteDetails = surveyDAO.getSiteDetails(siteId);				
	        String siteDetailsJson = gsonBuilder.toJson(siteDetails);
		    return siteDetailsJson.toString();
	    }
		
	 @RequestMapping(value = "/siteDetails")
		public ModelAndView siteDetails(ModelAndView model) throws IOException {
		 Site site=new Site();
		 model.addObject("SiteDetails", site);
			model.setViewName("siteDetails");
			return model;
	}
	 
		
		@RequestMapping(value="/saveSiteDetails" , method=RequestMethod.POST)
	public String saveSiteDetails(@ModelAttribute("Site") Site site,RedirectAttributes redirectAttributes, ModelAndView model,@RequestParam("clickBtn") String clickBtn)throws IOException{
	
		String status="Saved";
		String state=site.getState();
		String siteId=site.getSiteid();
		String lati=site.getLatitude();
		String longi=site.getLongitude();
		surveyDAO.updateSiteDetails(state,siteId,lati,longi);
		redirectAttributes.addFlashAttribute("status",status);
		redirectAttributes.addFlashAttribute("btnClick",clickBtn);
//		if(clickBtn.equals("Save")){
//			return "redirect:/home";
//		}
//		else{
//			return "redirect:/surveyTeamPPE";
//		}
		return "redirect:/siteDetails";
	}
	
		 @RequestMapping(value = "/surveyTeamPPE")
			public ModelAndView surveyTeamPPE(ModelAndView model) throws IOException {
			 Survey_Team_PPE surveyTeamPPE=new Survey_Team_PPE();
			 model.addObject("SurveyTeamPPE", surveyTeamPPE);
				model.setViewName("surveyTeamPPE");
				return model;
		}
		 
	 @ModelAttribute("statesList")
	   public Map<String, String> getCountryList() {
	      Map<String, String> statesList = new HashMap<String, String>();
	      statesList.put("Andhra Pradesh", "Andhra Pradesh");
	      statesList.put("Arunachal Pradesh", "Arunachal Pradesh");
	      statesList.put("Assam", "Assam");
	      statesList.put("Bihar", "Bihar");
	      statesList.put("Chhattisgarh", "Chhattisgarh");
	      statesList.put("Goa", "Goa");
	      statesList.put("Gujarat", "Gujarat");
	      statesList.put("Haryana", "Haryana");
	      statesList.put("Himachal Pradesh", "Himachal Pradesh");
	      statesList.put("Jammu and Kashmir", "Jammu and Kashmir");
	      statesList.put("Jharkhand", "Jharkhand");
	      statesList.put("Karnataka", "Karnataka");
	      statesList.put("Kerala", "Kerala");
	      statesList.put("Madya Pradesh", "Madya Pradesh");
	      statesList.put("Maharashtra", "Maharashtra");
	      statesList.put("Manipur", "Manipur");
	      statesList.put("Meghalaya", "Meghalaya");
	      statesList.put("Mizoram", "Mizoram");
	      statesList.put("Nagaland", "Nagaland");
	      statesList.put("Orissa", "Orissa");
	      statesList.put("Rajasthan", "Rajasthan");
	      statesList.put("Sikkim", "Sikkim");
	      statesList.put("Tamil Nadu", "Tamil Nadu");
	      statesList.put("Telangana", "Telangana");
	      statesList.put("Tripura", "Tripura");
	      statesList.put("Uttaranchal", "Uttaranchal");
	      statesList.put("Uttar Pradesh", "Uttar Pradesh");
	      statesList.put("West Bengal", "West Bengal");
	      return statesList;
	   }
	 
	 
	 @RequestMapping(value="getSurveyTeamPPEDetails", method = RequestMethod.GET)
	    @ResponseBody
	    public String  getSurveyTeamPPEDetails(HttpServletRequest request) {
			String selectedSiteId=request.getParameter("selectedSiteId");
			System.out.println("SITE"+selectedSiteId);
			List<Survey_Team_PPE> siteDetails = surveyDAO.getSurveyTeamDetails(selectedSiteId);	
	        String siteDetailsJson = gsonBuilder.toJson(siteDetails);
		    return siteDetailsJson.toString();
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
	 
		@RequestMapping(value="/saveSurveyPPE" , method=RequestMethod.POST)
		public String saveSurveyPPE(@ModelAttribute("Survey_Team_PPE") Survey_Team_PPE surveyTeamPPPE,RedirectAttributes redirectAttributes, @RequestParam("file") MultipartFile[] multipart,ModelAndView model,@RequestParam("clickBtn") String clickBtn)throws IOException{
		
			
			String status="Saved";
			try
			  {
				surveyTeamPPPE.setPhotoSurveyTeam(multipart[0].getBytes());
				surveyTeamPPPE.setPhotoSurveyTeamName(multipart[0].getOriginalFilename());
				surveyTeamPPPE.setPhotoTechnicianTeam(multipart[1].getBytes());
				surveyTeamPPPE.setPhotoTechnicianTeamName(multipart[1].getOriginalFilename());
				surveyTeamPPPE.setPhotoRiggerTeam(multipart[2].getBytes());
				surveyTeamPPPE.setPhotoRiggerTeamName(multipart[2].getOriginalFilename());
			  }
			  catch(Exception e)
			  {
			   System.out.println(e.toString());
			  }
			surveyDAO.addSiteSurveyPPE(surveyTeamPPPE);
			redirectAttributes.addFlashAttribute("PPEStatus",status);
			redirectAttributes.addFlashAttribute("btnClick",clickBtn);
			
				return "redirect:/surveyTeamPPE";
			
		}
		
	 @RequestMapping(value = "/siteAccess", method = RequestMethod.GET)
		public ModelAndView newAccess(ModelAndView model) {
			Site_Access siteaccess = new Site_Access();
			model.addObject("Site_Access", siteaccess);
			model.setViewName("accessDetails");
			return model;
		}
	 

	 /*@RequestMapping(value = "/accessDetails")
		public ModelAndView accessDetails(ModelAndView model) throws IOException {
			model.setViewName("accessDetails");
			return model;
	}*/
	 @RequestMapping(value = "/siteArea", method = RequestMethod.GET)
		public ModelAndView Area(ModelAndView model) {
			Site_Area sitearea = new Site_Area();
			model.addObject("Site_Area", sitearea);
			model.setViewName("siteAreaDetails");
			return model;
		}
	 
	 @RequestMapping(value = "/siteWiring", method = RequestMethod.GET)
		public ModelAndView Wiring(ModelAndView model) {
			Site_Wiring sitewiring = new Site_Wiring();
			model.addObject("Site_Wiring", sitewiring);
			model.setViewName("powerWiring");
			return model;
		}
	 /*@RequestMapping(value = "/siteAreaDetails")
		public ModelAndView siteAreaDetails(ModelAndView model) throws IOException {
			model.setViewName("siteAreaDetails");
			return model;
	}*/
		@RequestMapping(value="/saveAccess" , method=RequestMethod.POST)
		public String saveAccess(@ModelAttribute("Site_Access") Site_Access siteacc,RedirectAttributes redirectAttributes,@RequestParam("file") MultipartFile[] multipart, ModelAndView model,@RequestParam("clickBtn") String clickBtn)throws IOException{
	
		
		/*if(br.hasErrors())  
	         {  
			 
			 System.out.println("errorssss--------------"+br.getAllErrors());
			  //redirectAttributes.addFlashAttribute("errMsg","Should Enter All Feilds");
			
			 return "accessDetails";
	        }  */
				try
				  {
					siteacc.setPhoto_way(multipart[0].getBytes());
					siteacc.setPhoto_way_name(multipart[0].getOriginalFilename());
					siteacc.setPhoto_way2(multipart[1].getBytes());
					siteacc.setPhoto_way_name2(multipart[1].getOriginalFilename());
				  }
				  catch(Exception e)
				  {
				   System.out.println(e.toString());
				  }
		    if(siteacc.getId()==0){
		    	surveyDAO.addSiteAccess(siteacc);
		    }
		    else {
		    	surveyDAO.updateSiteAccess(siteacc);
		    }
			String status="Site Access Details Added Successfully";
			
			
			redirectAttributes.addFlashAttribute("status",status);
			if(clickBtn.equals("Save")){
			return "redirect:/siteAccess";
			}
			else{
				return "redirect:/siteArea";
			}
		}
		
		@RequestMapping(value="/saveArea" , method=RequestMethod.POST)
		public ModelAndView saveSiteArea(@ModelAttribute("Site_Area") Site_Area sitearea,RedirectAttributes redirectAttributes,@RequestParam("file") MultipartFile[] multipart, ModelAndView model,@RequestParam("clickBtn")String clickBtn)throws IOException{
		//System.out.println("PHOTOOOTOO"+multipart);
		//System.out.println("CLICKKKK"+clickBtn);
			 
		System.out.println("sdgsdg"+sitearea.getId());
		System.out.println("sdgsdg"+sitearea.getSiteCondition());
		
				try
				  {
					sitearea.setPhoto_inproper(multipart[0].getBytes());
					sitearea.setPhoto_inproper_name(multipart[0].getOriginalFilename());
					
				  }
				  catch(Exception e)
				  {
				   System.out.println(e.toString());
				  }
				  

			String status="Site Area Details Added Successfully";
			surveyDAO.addSiteArea(sitearea);
			redirectAttributes.addFlashAttribute("status",status);
			if(clickBtn.equals("Save")){
		return new ModelAndView("redirect:/siteArea");
			}
			else{
				return new ModelAndView("redirect:/siteWiring");
			}
		}
		
		@RequestMapping(value="/saveWiring" , method=RequestMethod.POST)
		public String saveWiring(@ModelAttribute("Site_Wiring") Site_Wiring sitewiring,RedirectAttributes redirectAttributes,@RequestParam("file") MultipartFile[] multipart, ModelAndView model,@RequestParam("clickBtn") String clickBtn,HttpServletRequest request)throws IOException{
		System.out.println("PHOTOOOTOO"+multipart);
		System.out.println("CLICKKKK"+clickBtn);
		String siteId=sitewiring.getSiteid().getSiteid();
		/*if(br.hasErrors())  
	         {  
			 
			 System.out.println("errorssss--------------"+br.getAllErrors());
			  //redirectAttributes.addFlashAttribute("errMsg","Should Enter All Feilds");
			
			 return "accessDetails";
	        }  */
				try
				  {
					sitewiring.setSite_photo1(multipart[0].getBytes());
					sitewiring.setSitePhotoName1(multipart[0].getOriginalFilename());
					sitewiring.setSite_photo2(multipart[1].getBytes());
					sitewiring.setSitePhotoName2(multipart[1].getOriginalFilename());
				  }
				  catch(Exception e)
				  {
				   System.out.println(e.toString());
				  }
				  

			String status="Site Power Wiring  Details Added Successfully";
			surveyDAO.addSitePowering(sitewiring);
			redirectAttributes.addFlashAttribute("status",status);
			if(clickBtn.equals("Save")){
			return "redirect:/siteWiring";
			}
			else{
				
				return "redirect:/newGenerator?siteId="+siteId;
			}
		}
}


package com.cyient.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cyient.dao.SurveyDAO;
import com.cyient.model.Site;
import com.cyient.model.Site_Access;
import com.cyient.model.Site_Area;
import com.cyient.model.Site_Wiring;
import com.cyient.model.Survey_Team_PPE;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
public class FTSurveyController {
	//private static final Logger ftManLogger = Logger.getLogger(ManagerFTController.class);
	
	static final Logger ftManLogger = Logger.getLogger("FTManagerLogger");
	

	public FTSurveyController() {
		System.out.println("FTSurveyController()");
	}

	@Autowired
	private SurveyDAO surveyDAO;

	Gson gsonBuilder = new GsonBuilder().create();

	@RequestMapping(value = "getSiteDetails", method = RequestMethod.GET)
	@ResponseBody
	public String getSiteDetails(HttpServletRequest request) {
		String siteId = request.getParameter("siteId");
		String ticketId = request.getParameter("ticketId");
		ftManLogger.info("In getSiteDetails Site::" + siteId+" ticketId::"+ticketId);
		String siteDetailsJson=null;
		try{
			String siteStatus = surveyDAO.updateSiteStatus(siteId, ticketId);	
			List<Site> siteDetails = surveyDAO.getSiteDetails(siteId);
			siteDetailsJson = gsonBuilder.toJson(siteDetails);
			ftManLogger.info("SiteDetails: Site Update Status::"+siteStatus+" site Details Json::"+siteDetailsJson);
		}
		catch(Exception e){
			ftManLogger.error("In getSiteDetails: "+e);
		}
		
		return siteDetailsJson;
	}

	@RequestMapping(value = "/siteDetails")
	public ModelAndView siteDetails(ModelAndView model) throws IOException {
		ftManLogger.info("In Technician Site Details");
		try{
			Site site = new Site();
			model.addObject("SiteDetails", site);
			model.setViewName("siteDetails");
		}
		catch(Exception e){
			ftManLogger.error("In siteDetails: "+e);
		}
		return model;
	}

	@RequestMapping(value = "/saveSiteDetails", method = RequestMethod.POST)
	public String saveSiteDetails(@ModelAttribute("Site") Site site, RedirectAttributes redirectAttributes,
			ModelAndView model, @RequestParam("clickBtn") String clickBtn) throws IOException {

		String status = "Saved";
		ftManLogger.info("Site Details: State::"+site.getState()+" SiteId"+site.getSiteid()+" Latitude"+site.getLatitude()+" Longitude"+site.getLongitude());
		try{
			surveyDAO.updateSiteDetails(site.getState(), site.getSiteid(), site.getLatitude(), site.getLongitude());
		}
		catch(Exception e){
			ftManLogger.error("In saveSiteDetails: "+e);
		}
		redirectAttributes.addFlashAttribute("status", status);
		redirectAttributes.addFlashAttribute("btnClick", clickBtn);
		// if(clickBtn.equals("Save")){
		// return "redirect:/home";
		// }
		// else{
		// return "redirect:/surveyTeamPPE";
		// }
		return "redirect:/siteDetails";
	}

	@RequestMapping(value = "/surveyTeamPPE")
	public ModelAndView surveyTeamPPE(ModelAndView model) throws IOException {
		ftManLogger.info("In Technician Site Survey PPE");
		try{
			Survey_Team_PPE surveyTeamPPE = new Survey_Team_PPE();
			model.addObject("SurveyTeamPPE", surveyTeamPPE);
			model.setViewName("surveyTeamPPE");
		}
		catch(Exception e){
			ftManLogger.error("In surveyTeamPPE: "+e);
		}
		return model;
	}

	@ModelAttribute("statesList")
	public Map<String, String> getStatesList() {
		
		Map<String, String> statesList = new HashMap<String, String>();
		try{
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
		}
		catch(Exception e){
			ftManLogger.error("In getStatesList: "+e);
		}
		return statesList;
	}

	@RequestMapping(value = "getSurveyTeamPPEDetails", method = RequestMethod.GET)
	@ResponseBody
	public String getSurveyTeamPPEDetails(HttpServletRequest request) {
		String selectedSiteId = request.getParameter("selectedSiteId");
		ftManLogger.info("In getSurveyTeamPPEDetails SiteId:" + selectedSiteId);
		String siteDetailsJson=null;
		try{
			List<Survey_Team_PPE> siteDetails = surveyDAO.getSurveyTeamDetails(selectedSiteId);
			siteDetailsJson = gsonBuilder.toJson(siteDetails);
		}
		catch(Exception e){
			ftManLogger.error("In getSurveyTeamPPEDetails: "+e);
		}
		return siteDetailsJson;
	}

	@ModelAttribute("PPEList")
	public List<String> getPPEList() {
		List<String> PPEList = new ArrayList<String>();
		try{
			PPEList.add("High visibility vest");
			PPEList.add("Safety shoes");
			PPEList.add("Hard hat");
		}
		catch(Exception e){
			ftManLogger.error("In getPPEList: "+e);
		}
		return PPEList;
	}

	@ModelAttribute("riggerPPEList")
	public List<String> getRiggerPPEList() {
		List<String> riggerPPEList = new ArrayList<String>();
		try{
			riggerPPEList.add("High visibility vest");
			riggerPPEList.add("Safety shoes");
			riggerPPEList.add("Hard hat");
			riggerPPEList.add("Use of rigging equipment");
		}
		catch(Exception e){
			ftManLogger.error("In getRiggerPPEList: "+e);
		}
		return riggerPPEList;
	}

	@RequestMapping(value = "/saveSurveyPPE", method = RequestMethod.POST)
	public String saveSurveyPPE(@ModelAttribute("Survey_Team_PPE") Survey_Team_PPE surveyTeamPPE,
			RedirectAttributes redirectAttributes, @RequestParam("file") MultipartFile[] multipart, ModelAndView model,
			@RequestParam("clickBtn") String clickBtn) throws IOException {

		String status = "Saved";
		try {
			// surveyTeamPPPE.setPhotoSurveyTeam(multipart[0].getBytes());
			// surveyTeamPPPE.setPhotoSurveyTeamName(multipart[0].getOriginalFilename());
			// surveyTeamPPPE.setPhotoTechnicianTeam(multipart[1].getBytes());
			// surveyTeamPPPE.setPhotoTechnicianTeamName(multipart[1].getOriginalFilename());
			// surveyTeamPPPE.setPhotoRiggerTeam(multipart[2].getBytes());
			// surveyTeamPPPE.setPhotoRiggerTeamName(multipart[2].getOriginalFilename());

			ftManLogger.info("In saveSurveyPPE Files length:: " + multipart.length);
			for (int i = 0; i < multipart.length; i++) {

				if (multipart[i].isEmpty()) {

					// Object s="setSite_photo"+i;
					List<Survey_Team_PPE> surveyPPEList = surveyDAO.getSurveyTeamDetails(surveyTeamPPE.getSiteid().getSiteid());
					if (i == 0) {
						surveyTeamPPE.setPhotoSurveyTeam(surveyPPEList.get(0).getPhotoSurveyTeam());
						surveyTeamPPE.setPhotoSurveyTeamName(surveyPPEList.get(0).getPhotoSurveyTeamName());
					} else if (i == 1) {
						surveyTeamPPE.setPhotoTechnicianTeam(surveyPPEList.get(0).getPhotoTechnicianTeam());
						surveyTeamPPE.setPhotoTechnicianTeamName(surveyPPEList.get(0).getPhotoTechnicianTeamName());
					} else if (i == 2) {						
						surveyTeamPPE.setPhotoRiggerTeam(surveyPPEList.get(0).getPhotoRiggerTeam());
						surveyTeamPPE.setPhotoRiggerTeamName(surveyPPEList.get(0).getPhotoRiggerTeamName());
					}
				} else {
					if (i == 0) {
						surveyTeamPPE.setPhotoSurveyTeam(multipart[0].getBytes());
						surveyTeamPPE.setPhotoSurveyTeamName(multipart[0].getOriginalFilename());
					} else if (i == 1) {
						surveyTeamPPE.setPhotoTechnicianTeam(multipart[1].getBytes());
						surveyTeamPPE.setPhotoTechnicianTeamName(multipart[1].getOriginalFilename());
					} else if (i == 2) {
						surveyTeamPPE.setPhotoRiggerTeam(multipart[2].getBytes());
						surveyTeamPPE.setPhotoRiggerTeamName(multipart[2].getOriginalFilename());
					}
				}
			}
			surveyDAO.addSiteSurveyPPE(surveyTeamPPE);
		} 
		catch (Exception e) {
			ftManLogger.error("In saveSurveyPPE: "+e);
		}
		
		// redirectAttributes.addFlashAttribute("PPEStatus",status);
		// redirectAttributes.addFlashAttribute("btnClick",clickBtn);
		if (clickBtn.equals("Save for Later")) {
			return "redirect:/home";
		} else {
			return "redirect:/siteAccess";
		}

	}

	@RequestMapping(value = "/siteAccess", method = RequestMethod.GET)
	public ModelAndView newAccess(ModelAndView model) {
		ftManLogger.info("Technician Site Access");
		try{
			Site_Access siteaccess = new Site_Access();
			model.addObject("Site_Access", siteaccess);
			model.setViewName("accessDetails");
		}
		catch(Exception e){
			ftManLogger.error("In siteAccess:"+e);
		}
		return model;
	}

	@RequestMapping(value = "/siteArea", method = RequestMethod.GET)
	public ModelAndView Area(ModelAndView model) {
		ftManLogger.info("Technician Site Area");
		try{
			Site_Area sitearea = new Site_Area();
			model.addObject("Site_Area", sitearea);
			model.setViewName("siteAreaDetails");
		}
		catch(Exception e){
			ftManLogger.error("In siteArea: "+e);
		}
		return model;
	}

	@RequestMapping(value = "/siteWiring", method = RequestMethod.GET)
	public ModelAndView Wiring(ModelAndView model) {
		ftManLogger.info("Technician Power Wiring");
		try{
			Site_Wiring sitewiring = new Site_Wiring();
			model.addObject("Site_Wiring", sitewiring);
			model.setViewName("powerWiring");
		}
		catch(Exception e){
			ftManLogger.error("In siteWiring:"+e);
		}
		return model;
	}


	@RequestMapping(value = "/getSiteAccessDetails", method = RequestMethod.GET)
	@ResponseBody
	public String getSiteAccessDetails(HttpServletRequest request) {
		String siteId = request.getParameter("siteId");
		ftManLogger.info("In SiteAccess Site::"+siteId);
		String siteAccessJson=null;
		try{
			List<Site_Access> siteAccessList = surveyDAO.getSiteAccDetails(siteId);		
			siteAccessJson = gsonBuilder.toJson(siteAccessList);
		}
		catch(Exception e){
			ftManLogger.error("In getSiteAccessDetails: "+e);
		}
		return siteAccessJson;
	}

	@RequestMapping(value = "/getSiteAreaDetails", method = RequestMethod.GET)
	@ResponseBody
	public String getSiteArrDetails(HttpServletRequest request) {
		String siteId = request.getParameter("siteId");
		ftManLogger.info("In SiteArea Site::"+siteId);
		String siteAreaJson=null;
		try{
			List<Site_Area> siteAccessList = surveyDAO.getSiteArDetails(siteId);		
			siteAreaJson = gsonBuilder.toJson(siteAccessList);
		}
		catch(Exception e){
			ftManLogger.error("In getSiteAreaDetails: "+e);
		}
		return siteAreaJson;
	}

	@RequestMapping(value = "/getSiteWiringDetails", method = RequestMethod.GET)
	@ResponseBody
	public String getSiteWiringDetails(HttpServletRequest request) {
		String siteId = request.getParameter("siteId");
		ftManLogger.info("In SiteWiring Site::"+siteId);
		String siteAreaJson=null;
		try{
			List<Site_Wiring> siteAccessList = surveyDAO.getPowerWiringDetails(siteId);		
			siteAreaJson = gsonBuilder.toJson(siteAccessList);
		}
		catch(Exception e){
			ftManLogger.error("In getSiteWiringDetails: "+e);
		}
		return siteAreaJson;
	}

	@RequestMapping(value = "/saveAccess", method = RequestMethod.POST)
	public String saveAccess(@ModelAttribute("Site_Access") Site_Access siteacc, RedirectAttributes redirectAttributes,
			@RequestParam("file") MultipartFile[] multipart, HttpServletRequest request, ModelAndView model,
			@RequestParam("clickBtn") String clickBtn) throws IOException {

		try {
			for (int i = 0; i < multipart.length; i++) {
				if (multipart[i].isEmpty()) {
					List<Site_Access> siteAcc = surveyDAO.getSiteAccDetails(siteacc.getSiteid().getSiteid());
					if (i == 0) {
						
						siteacc.setPhoto_way(siteAcc.get(0).getPhoto_way());
						siteacc.setPhoto_way_name(siteAcc.get(0).getPhoto_way_name());
					} else if (i == 1) {
						
						siteacc.setPhoto_way2(siteAcc.get(0).getPhoto_way2());
						siteacc.setPhoto_way_name2(siteAcc.get(0).getPhoto_way_name2());
					}
				} 
				else {
					if (i == 0) {
						siteacc.setPhoto_way(multipart[0].getBytes());
						siteacc.setPhoto_way_name(multipart[0].getOriginalFilename());

					} else if (i == 1) {
						siteacc.setPhoto_way2(multipart[1].getBytes());
						siteacc.setPhoto_way_name2(multipart[1].getOriginalFilename());

					}
				}
			}
			surveyDAO.addSiteAccess(siteacc);
		} catch (Exception e) {
			ftManLogger.error("In saveAccess: "+e);
		}

		String status = "Site Access Details Added Successfully";		
		redirectAttributes.addFlashAttribute("status", status);
		if (clickBtn.equals("Save for Later")) {
			return "redirect:/home";
		} else {
			return "redirect:/siteArea";
		}
	}

	@RequestMapping(value = "/saveArea", method = RequestMethod.POST)
	public ModelAndView saveSiteArea(@ModelAttribute("Site_Area") Site_Area sitearea,
			RedirectAttributes redirectAttributes, @RequestParam("file") MultipartFile[] multipart,
			HttpServletRequest request, ModelAndView model, @RequestParam("clickBtn") String clickBtn)
			throws IOException {
	
		try {
			for (int i = 0; i < multipart.length; i++) {
				if (multipart[i].isEmpty()) {
					List<Site_Area> siteArea = surveyDAO.getSiteArDetails(sitearea.getSiteid().getSiteid());
					if (i == 0) {					
						sitearea.setPhoto_inproper(siteArea.get(0).getPhoto_inproper());
						sitearea.setPhoto_inproper_name(siteArea.get(0).getPhoto_inproper_name());
					}

				} else {
					if (i == 0) {
						sitearea.setPhoto_inproper(multipart[0].getBytes());
						sitearea.setPhoto_inproper_name(multipart[0].getOriginalFilename());

					}

				}
				
			}
			surveyDAO.addSiteArea(sitearea);
		}		
		catch (Exception e) {
			ftManLogger.error("In saveArea: "+e);
		}

		String status = "Site Area Details Added Successfully";		
		redirectAttributes.addFlashAttribute("status", status);
		if (clickBtn.equals("Save for Later")) {
			return new ModelAndView("redirect:/home");
		} else {
			return new ModelAndView("redirect:/siteWiring");
		}
	}

	@RequestMapping(value = "/saveWiring", method = RequestMethod.POST)
	public String saveWiring(@ModelAttribute("Site_Wiring") Site_Wiring sitewiring,
			RedirectAttributes redirectAttributes, @RequestParam("file") MultipartFile[] multipart, ModelAndView model,
			@RequestParam("clickBtn") String clickBtn, HttpServletRequest request) throws IOException {
		
		try {
			for (int i = 0; i < multipart.length; i++) {
				if (multipart[i].isEmpty()) {
					List<Site_Wiring> siteWiring = surveyDAO.getPowerWiringDetails(sitewiring.getSiteid().getSiteid());
					if (i == 0) {						
						sitewiring.setSite_photo1(siteWiring.get(0).getSite_photo1());
						sitewiring.setSitePhotoName1(siteWiring.get(0).getSitePhotoName1());
					} 
					else if (i == 1) {						
						sitewiring.setSite_photo2(siteWiring.get(0).getSite_photo2());
						sitewiring.setSitePhotoName2(siteWiring.get(0).getSitePhotoName2());
					}
				} 
				else {
					if (i == 0) {
						sitewiring.setSite_photo1(multipart[0].getBytes());
						sitewiring.setSitePhotoName1(multipart[0].getOriginalFilename());

					} 
					else if (i == 1) {
						sitewiring.setSite_photo2(multipart[1].getBytes());
						sitewiring.setSitePhotoName2(multipart[1].getOriginalFilename());

					}
				}
				
			}
			surveyDAO.addSitePowering(sitewiring);
		}		
		catch (Exception e) {
			ftManLogger.error("In saveWiring: "+e);
		}

		String status = "Site Power Wiring  Details Added Successfully";		
		redirectAttributes.addFlashAttribute("status", status);
		if (clickBtn.equals("Save for Later")) {
			return "redirect:/home";
		} else {

			return "redirect:/newGenerator";
		}
	}

	@RequestMapping(value = "/updateTicketStatus", method = RequestMethod.GET)
	@ResponseBody
	public String updateTicketStatus(HttpServletRequest request) {
		String ticketId = request.getParameter("ticketId");
		ftManLogger.info("In updateTicketStatus ticketId::"+ticketId);
		String status=null;
		try{
		    status = surveyDAO.updateClosedStatus(ticketId);
		}
		catch(Exception e){
			ftManLogger.error("In updateTicketStatus: "+e);
		}
		return status;
	}
}

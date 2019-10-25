
package com.cyient.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.jboss.logging.Logger;
import org.json.JSONObject;
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
import com.cyient.model.Site_Additional_Notes;
import com.cyient.model.Site_Area;
import com.cyient.model.Site_Battery_Bank;
import com.cyient.model.Site_Cabinet;
import com.cyient.model.Site_Generator;
import com.cyient.model.Site_SMPS;
import com.cyient.model.Site_Safety;
import com.cyient.model.Site_Security;
import com.cyient.model.Site_Wiring;
import com.cyient.model.Survey_Team_PPE;
import com.cyient.model.Technician;
import com.cyient.model.TechnicianTicketInfo;
import com.cyient.model.Ticketing;
import com.cyient.model.Tower_Installation;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

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

	@SuppressWarnings("unused")
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

	
	@SuppressWarnings("unused")
	@RequestMapping(value = "/updateTicketStatus", method = RequestMethod.GET)
	@ResponseBody
	public String updateTicketStatus(HttpServletRequest request) {
		String ticketId = request.getParameter("ticketId");
		ftManLogger.info("In updateTicketStatus ticketId::"+ticketId);
		String status=null,statusUpdate=null,pdfFileName=null;
		try{
		    status = surveyDAO.updateClosedStatus(ticketId);
		   
		    
		    List<Ticketing> ticketData=surveyDAO.getTicketsData(ticketId);
		    List<String> sitesArr = new ArrayList<String>();
		    for(Ticketing ticket:ticketData){
				sitesArr.add(ticket.getSiteid());
		    }
		   
		    for(int i=0;i<sitesArr.size();i++){
		    	 System.out.println("ksndkn "+sitesArr.get(i).toString());
		    	 pdfFileName=createPDF(sitesArr.get(i).toString());
		    	 

		    		
		    	    
				 statusUpdate=surveyDAO.updateSurveyStatus(sitesArr.get(i).toString(), "Closed");
		    }
		    
		}
		catch(Exception e){
			ftManLogger.error("In updateTicketStatus: "+e);
		}
		return status;
	}
	
	
	@RequestMapping("/surveyReports")
	public ModelAndView surveyReports(ModelAndView model) throws IOException {
		model.setViewName("surveyReports");
		return model;
	}
	
	
	@RequestMapping("/createPDF")	
	public String createPDF(String siteId) {
	
		
		// Creating the directory to store file
		String rootPath = System.getProperty("catalina.home");
		File dir = new File(rootPath + File.separator + "tmpFiles");
		if (!dir.exists())
			dir.mkdirs();

//		// Create the file on server
//		File serverFile = new File(dir.getAbsolutePath()
//				+ File.separator + siteId+".pdf");
//	
//		System.out.println("serverFile: "+serverFile);
//		logger.info("Server File Location="
//				+ serverFile.getAbsolutePath())
	//	String FILE_NAME="D:/"+siteId+".pdf";
    Document document = new Document();
    String FILE_NAME=dir.getAbsolutePath()+ File.separator + siteId+".pdf";
	try {
    	//String FILE_NAME = request.getServletContext().getRealPath("/resources/documents"+siteId+".pdf");
    	//String FILE_NAME = "\\resources\\documents\\"+siteId+".pdf";
    	
        PdfWriter.getInstance(document, new FileOutputStream(new File(FILE_NAME)));
        document.open();
        Paragraph p = new Paragraph();
        p.add("Survey Report for Site "+siteId);
        p.setAlignment(Element.ALIGN_CENTER);
        document.add(p);
        Paragraph p2 = new Paragraph(),p3=new Paragraph(),p4=new Paragraph(),p5=new Paragraph(),p6=new Paragraph(),p7=new Paragraph(),p8=new Paragraph(),p9=new Paragraph(),
        		p10=new Paragraph(),p11=new Paragraph(),p12=new Paragraph(),p13=new Paragraph(),p14=new Paragraph();
        Font f = new Font();
        f.setStyle(Font.BOLD);
        f.setSize(8);
        p2.add("Site Details"); 
        document.add(p2);
        document.add(Chunk.NEWLINE );
        List<Site> detailsList= surveyDAO.getSiteDetails(siteId);
        float[] colsWidth = {1f, 1f}; // Code 1
        PdfPTable table1 = new PdfPTable(colsWidth);
        table1.setWidthPercentage(100); // Code 2
        Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);
        table1.setHorizontalAlignment(Element.ALIGN_LEFT);//Code 3
        Phrase region = new Phrase("Region", boldFont );
        Phrase lati = new Phrase("Latitude", boldFont );
        Phrase longi = new Phrase("Longitude", boldFont );
       
        table1.addCell(region);
        table1.addCell(detailsList.get(0).getRegion());
        table1.addCell(lati);
        table1.addCell(detailsList.get(0).getLatitude());
        table1.addCell(longi);
        table1.addCell(detailsList.get(0).getLongitude());
        document.add(table1);
        
        
        //Site Survey Team PPE
        p3.add("Survey Team PPE"); 
        document.add(p3);

        List<Survey_Team_PPE> surveyPPElist= surveyDAO.getSurveyTeamDetails(siteId);
        byte[] surveyPPEPhoto1=surveyPPElist.get(0).getPhotoSurveyTeam();
        byte[] surveyPPEPhoto2=surveyPPElist.get(0).getPhotoTechnicianTeam();
        byte[] surveyPPEPhoto3=surveyPPElist.get(0).getPhotoRiggerTeam();
        document.add(Image.getInstance(surveyPPEPhoto1));
        document.add(Image.getInstance(surveyPPEPhoto2));
        document.add(Image.getInstance(surveyPPEPhoto3));
        
        //Site Access
        p4.add("Site Access"); 
        document.add(p4);

        List<Site_Access> accesslist= surveyDAO.getSiteAccDetails(siteId);
        byte[] accessPhoto1=accesslist.get(0).getPhoto_way();
        byte[] accessPhoto2=accesslist.get(0).getPhoto_way2();
        document.add(Image.getInstance(accessPhoto1));
        document.add(Image.getInstance(accessPhoto2));
      
        //Site Area
        p5.add("Site Area"); 
        document.add(p5);
  
        List<Site_Area> areaList= surveyDAO.getSiteArDetails(siteId);
        byte[] areaPhoto1=areaList.get(0).getPhoto_inproper();
        document.add(Image.getInstance(areaPhoto1));
        
        //Power Wiring
        p6.add("Power Wiring"); 
        document.add(p6);
 
        List<Site_Wiring> wiringlist= surveyDAO.getPowerWiringDetails(siteId);
        byte[] wiringPhoto1=wiringlist.get(0).getSite_photo1();
        byte[] wiringPhoto2=wiringlist.get(0).getSite_photo2();
        document.add(Image.getInstance(wiringPhoto1));
        document.add(Image.getInstance(wiringPhoto2));
        
        //Generator
        p7.add("Site Generator"); 
        document.add(p7);
      
        List<Site_Generator> generatorlist= surveyDAO.getGeneratorDetails(siteId);
        byte[] generatorPhoto1=generatorlist.get(0).getGdphoto();
        byte[] generatorPhoto2=generatorlist.get(0).getFuellevel_photo();
        byte[] generatorPhoto3=generatorlist.get(0).getDg_inproper_1();
        byte[] generatorPhoto4=generatorlist.get(0).getDg_inproper_2();
        byte[] generatorPhoto5=generatorlist.get(0).getTag_photo();
        document.add(Image.getInstance(generatorPhoto1));
        document.add(Image.getInstance(generatorPhoto2));
        document.add(Image.getInstance(generatorPhoto3));
        document.add(Image.getInstance(generatorPhoto4));
        document.add(Image.getInstance(generatorPhoto5));
        
        //SMPS
        p8.add("Site SMPS"); 
        document.add(p8);
    
        List<Site_SMPS> smpslist= surveyDAO.getSMPSDetails(siteId);
        byte[] smpsPhoto1=smpslist.get(0).getObservation_1();
        byte[] smpsPhoto2=smpslist.get(0).getObservation_2();
        document.add(Image.getInstance(smpsPhoto1));
        document.add(Image.getInstance(smpsPhoto2));
        
        //Battery bank
        p9.add("Battery Bank"); 
        document.add(p9);

        List<Site_Battery_Bank> bblist= surveyDAO.getBB(siteId);
        byte[] bbPhoto1=bblist.get(0).getTag_photo();
        byte[] bbPhoto2=bblist.get(0).getTag_photo1();
        byte[] bbPhoto3=bblist.get(0).getTag_photo_2();
        document.add(Image.getInstance(bbPhoto1));
        document.add(Image.getInstance(bbPhoto2));
        document.add(Image.getInstance(bbPhoto3));
        
        //Cabinet
        p10.add("Site Cabinet"); 
        document.add(p10);
    
        List<Site_Cabinet> cabinetlist= surveyDAO.getCabinet(siteId);
        byte[] cabinetPhoto1=cabinetlist.get(0).getPhoto_1();
        byte[] cabinetPhoto2=cabinetlist.get(0).getPhoto_2();
        document.add(Image.getInstance(cabinetPhoto1));
        document.add(Image.getInstance(cabinetPhoto2));
        
        //Tower Installation
        p11.add("Tower Installation"); 
        document.add(p11);
    
        List<Tower_Installation> towerInstlist= surveyDAO.fetchTowerDetails(siteId);
        byte[] towerInstPhoto1=towerInstlist.get(0).getTower_photo1();
        byte[] towerInstPhoto2=towerInstlist.get(0).getTower_photo2();
        byte[] towerInstPhoto3=towerInstlist.get(0).getTower_photo3();
        byte[] towerInstPhoto4=towerInstlist.get(0).getTower_photo4();
        document.add(Image.getInstance(towerInstPhoto1));
        document.add(Image.getInstance(towerInstPhoto2));
        document.add(Image.getInstance(towerInstPhoto3));
        document.add(Image.getInstance(towerInstPhoto4));
        
        //Security
        p12.add("Site Security"); 
        document.add(p12);
        
        List<Site_Security> securitylist= surveyDAO.getSecurityDetails(siteId);
        byte[] securityPhoto1=securitylist.get(0).getSecurity_photo1();
        byte[] securityPhoto2=securitylist.get(0).getSecurity_photo2();
        document.add(Image.getInstance(securityPhoto1));
        document.add(Image.getInstance(securityPhoto2));
      
        //Safety
        p13.add("Site Safety"); 
        document.add(p13);
      
        List<Site_Safety> safetylist= surveyDAO.getSafetyDetails(siteId);
        byte[] safetyPhoto1=safetylist.get(0).getSafety_photo1();
        byte[] safetyPhoto2=safetylist.get(0).getSafety_photo2();
        byte[] safetyPhoto3=safetylist.get(0).getSafety_photo3();
        byte[] safetyPhoto4=safetylist.get(0).getSafety_photo4();
        byte[] safetyPhoto5=safetylist.get(0).getSafety_photo5();
        byte[] safetyPhoto6=safetylist.get(0).getSafety_photo6();
        byte[] safetyPhoto7=safetylist.get(0).getSafety_photo7();
        document.add(Image.getInstance(safetyPhoto1));
        document.add(Image.getInstance(safetyPhoto2));
        document.add(Image.getInstance(safetyPhoto3));
        document.add(Image.getInstance(safetyPhoto4));
        document.add(Image.getInstance(safetyPhoto5));
        document.add(Image.getInstance(safetyPhoto6));
        document.add(Image.getInstance(safetyPhoto7));
        
        //Additional Notes
        p14.add("Site Additional Notes"); 
        document.add(p14);
     
        List<Site_Additional_Notes> additionallist= surveyDAO.getSiteAddDetails(siteId);
        byte[] additionalPhoto1=additionallist.get(0).getSite_photo1();
        byte[] additionalPhoto2=additionallist.get(0).getSite_photo2();
        document.add(Image.getInstance(additionalPhoto1));
        document.add(Image.getInstance(additionalPhoto2));
        
        
        document.close();
        
        
       // byte[] bFile = readBytesFromFile(FILE_NAME);

	    
	    String status1=surveyDAO.updateSurveyDocument(siteId,FILE_NAME);
        
        System.out.println("Done");
	    } catch (Exception e) {
	        System.out.println("EXception "+e);
	    }
    return FILE_NAME;
	}
	
	
	 @RequestMapping(value = "/downloadFile", method = RequestMethod.GET)
		public ModelAndView downloadFileRedirect(ModelAndView model) {
			model.setViewName("downloadFile");
			return model;
		}
	
	
	
    
    
	@SuppressWarnings("unused")
	private static byte[] readBytesFromFile(String filePath) {

        FileInputStream fileInputStream = null;
        byte[] bytesArray = null;

        try {

            File file = new File(filePath);
            bytesArray = new byte[(int) file.length()];

            //read file into bytes[]
            fileInputStream = new FileInputStream(file);
            fileInputStream.read(bytesArray);

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (fileInputStream != null) {
                try {
                    fileInputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }

        return bytesArray;

    }
	
	 @RequestMapping(value="getAssignedSurveySites", method = RequestMethod.GET)
	    @ResponseBody
	    public String getAssignedSurveySites(ModelAndView model,HttpServletRequest request) {
	    	
	    	 String assignedJson =null;	    	 
	    
	    	try{
			List<Site> listAssigned = surveyDAO.getAssignedSurveySites();
		        	  
			assignedJson = gsonBuilder.toJson(listAssigned);
	        	   ftManLogger.info("Survey Assigned Json:: "+assignedJson);
	    	}
	    	catch(Exception e){
	    		ftManLogger.error("In getAssignedSurveySites : "+e);
	    	}
		              return assignedJson.toString();
	    }
	    
	 @RequestMapping(value="getUnAssignedSurveySites", method = RequestMethod.GET)
	    @ResponseBody
	    public String getUnAssignedSurveySites(ModelAndView model,HttpServletRequest request) {
	    	
	    	 String unassignedJson =null;	    	 
	    	try{
			List<Site> listUnassigned = surveyDAO.getUnAssignedSurveySites();
		        	  
			unassignedJson = gsonBuilder.toJson(listUnassigned);
	        	   ftManLogger.info("Survey Assigned Json:: "+unassignedJson);
	    	}
	    	catch(Exception e){
	    		ftManLogger.error("In getUnAssignedSurveySites : "+e);
	    	}
		              return unassignedJson.toString();
	    }
	    
	 @RequestMapping(value="getClosedSurveySites", method = RequestMethod.GET)
	    @ResponseBody
	    public String getClosedSurveySites(ModelAndView model,HttpServletRequest request) {
	    	
	    	String closedJson =null;	    	 
	    	try{
				List<Site> listClosed = surveyDAO.getClosedSurveySites();
			        	  
				closedJson = gsonBuilder.toJson(listClosed);
	        	   ftManLogger.info("Survey Closed Json:: "+closedJson);
	    	}
	    	catch(Exception e){
	    		ftManLogger.error("In getClosedSurveySites : "+e);
	    	}
		    return closedJson.toString();
	    }
	 
		@RequestMapping("surveySitesCount")
	    @ResponseBody
	    public String surveySitesCount(ModelAndView model) {
		 ftManLogger.info("In Survey Sites Count");
	    	 JSONObject countData=new JSONObject();
	    	 List<Site> listAssigned =null;
	    	 List<Site> listUnAssgined=null;	    	
	    	 List<Site> listClosed=null;
	    	try{
	    		listAssigned = surveyDAO.getAssignedSurveySites();		
		   
	    	}catch(Exception e){
	    		ftManLogger.error("While fetching the assigned survey sites "+e);
	    	}
	    	try{
	    		listUnAssgined = surveyDAO.getUnAssignedSurveySites();
	    	}catch(Exception e){
	    		ftManLogger.error("While fetching list unassigned Survey sites "+e);
	    	}
	    	try{
	    		listClosed = surveyDAO.getClosedSurveySites();
	    	}catch(Exception e){
	    		ftManLogger.error("While fetching list closed surveuy sites "+e);
	    	}
		    
			   countData.put("AssignedSurvey",listAssigned.size());
			   countData.put("UnAssignedSurvey",listUnAssgined.size());
			   countData.put("ClosedSurvey",listClosed.size());
			   System.out.println(countData);			   
		          return countData.toString();
	    }
		
		 @RequestMapping(value="getFilename", method = RequestMethod.GET)
		    @ResponseBody
		    public String getFilename(HttpServletRequest request) {
//		// Creating the directory to store file
//				String rootPath = System.getProperty("catalina.home");
//				File dir = new File(rootPath + File.separator + "tmpFiles");
//				if (!dir.exists())
//					dir.mkdirs();
//
//				System.out.println("dir "+dir.getAbsolutePath()+ File.separator + "IND005");
//				// Create the file on server
////				File serverFile = new File(dir.getAbsolutePath()
////						+ File.separator + "IND005");
//			
////				System.out.println("serverFile: "+serverFile);
//				return rootPath;
			 
			 
			 
			 
			 
			 
			 
			 
//			 ClassLoader classLoader = getClass().getClassLoader();
//			    //System.out.println("FILE llh;s "+classLoader.getResource("file/test.xml").getFile());
//			 System.out.println("\\resources\\documents\\IND005.pdf");
//			 System.out.println("zxzb"+classLoader.getResource(".").getFile() + "/IND005.pdf");
			 
			 
			  String dataDirectory = request.getServletContext().getRealPath("/resources/documents");
		       System.out.println("dataDirectory "+dataDirectory);
			   
			   
				return "sdhsdg";
		 }
}

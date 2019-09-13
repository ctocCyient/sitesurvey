package com.cyient.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
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

import com.cyient.model.Site_Generator;
import com.cyient.model.Site_SMPS;
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
	private static final Logger logger = Logger.getLogger(HomeController.class);

	public HomeController() {
		System.out.println("HomeController()");

	}

	@Autowired
	private SurveyDAO surveyDAO;

	Gson gson = new Gson();

	@Autowired
	private JavaMailSender mailSender;

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
		Ticketing ticketing = new Ticketing();
		model.addObject("Ticketing", ticketing);
		model.setViewName("createTicket");
		return model;
	}

	@RequestMapping(value = "/newGenerator")
	public ModelAndView newGenerator(ModelAndView model) throws IOException {
		Site_Generator generator = new Site_Generator();
		model.addObject("Site_Generator", generator);
		model.setViewName("addGenerator");
		return model;
	}

	@RequestMapping(value = "/newSMPS")
	public ModelAndView newSMPS(ModelAndView model) throws IOException {
		Site_SMPS smps = new Site_SMPS();
		model.addObject("Site_SMPS", smps);
		model.setViewName("addSMPS");
		return model;
	}

	@RequestMapping(value = "/newBB")
	public ModelAndView newBB(ModelAndView model) throws IOException {
		Site_Battery_Bank BB = new Site_Battery_Bank();
		model.addObject("Site_Battery_Bank", BB);
		model.setViewName("addBB");
		return model;
	}

	@RequestMapping(value = "/newCabinet")
	public ModelAndView newCabinet(ModelAndView model) throws IOException {
		Site_Cabinet BB = new Site_Cabinet();
		model.addObject("Site_Cabinet", BB);
		model.setViewName("addCabinet");
		return model;
	}

	@RequestMapping(value = "/saveTechnician", method = RequestMethod.POST)
	public ModelAndView saveTechnician(@ModelAttribute final Technician technician,
			RedirectAttributes redirectAttributes) throws MessagingException {
		String status = "Technician Added Successfully";

		final JSONArray json = new JSONArray();
		String managerId = null;
		User user = new User();
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
		System.out.println("Manager+++++++++++++++" + technician.getManager());
		managerId = surveyDAO.getManagerId(technician.getManager());
		final String managerName = technician.getManager();
		final String managerEmailId = managerId.substring(1, managerId.length() - 1);
		System.out.println("mail::::" + mailSender);
		List<User> ManagerDetails = surveyDAO.getManagerDetails(technician.getManager());
		final List<String> managerDet = new ArrayList<String>();
		for (User det : ManagerDetails) {
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
				// message.setText("Dear <b>" + managerName +"</b> ,<br><br>
				// Ticket with Id <b>" +selectedTicketNum+" </b> is assigned.
				// Tikcet Details are:<br> Severity: <b>"+severity+ "</b>
				// <br>Ticket Description: <b>" + ticketDesc+"</b><br>Customer
				// ID <b>"+customerId+"</b> . <br> Please <a
				// href='http://172.16.53.79:8080/RFIDAssetTracking/'>login</a>
				// for other details", true);
				message.setText("Dear <b>" + managerDet.get(0)
						+ "</b> ,<br><br> A new Technician created under your region with details:<br><b>Tehnician Id: </b>"
						+ technician.getTechnicianId() + "<br><b>Technician Name: </b>" + technician.getTechnicianName()
						+ "<br><b>Region: </b> " + technician.getRegion()
						+ "<br><br>Please <a href='http://ctoceu.cyient.com:3290/RFIDAssetTracking/'>login</a> for other details with credetials:<br> <b>Username</b>: "
						+ managerDet.get(1) + "<br><b>Password</b>:" + managerDet.get(2) + "", true);
			}
		});

		/* Sending Mail for Technician with his login Details */

		mailSender.send(new MimeMessagePreparator() {
			public void prepare(MimeMessage mimeMessage) throws MessagingException {
				MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				message.setFrom("Neeraja.Chaparala@cyient.com");
				message.setTo(technician.getEmailId());
				message.setSubject("Login Credentials");
				// message.setText("Dear <b>" + managerName +"</b> ,<br><br>
				// Ticket with Id <b>" +selectedTicketNum+" </b> is assigned.
				// Tikcet Details are:<br> Severity: <b>"+severity+ "</b>
				// <br>Ticket Description: <b>" + ticketDesc+"</b><br>Customer
				// ID <b>"+customerId+"</b> . <br> Please <a
				// href='http://172.16.53.79:8080/RFIDAssetTracking/'>login</a>
				// for other details", true);
				message.setText("Dear <b>" + technician.getTechnicianName()
						+ "</b> ,<br>You were registered as a Technicinan. <br>Please <a href='http://ctoceu.cyient.com:3290/RFIDAssetTracking/'>login</a> for other details with credetials:<br> <b>Username</b>: "
						+ technician.getTechnicianName() + "<br><b>Password</b>:" + technician.getPassword() + "",
						true);
			}
		});

		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newTechnician");
	}

	@RequestMapping(value = "/saveCreatedTicket", method = RequestMethod.POST)
	public ModelAndView saveTicket(@ModelAttribute Ticketing ticket, RedirectAttributes redirectAttributes) {

		List<String> siteList = Arrays.asList(ticket.getSiteid().split(","));

		for (int i = 0; i < siteList.size(); i++) {
			Ticketing ticketing = new Ticketing();
			ticketing.setTicketNum(ticket.getTicketNum());
			ticketing.setRegion(ticket.getRegion());
			ticketing.setState(ticket.getState());
			ticketing.setDistrict(ticket.getDistrict());
			ticketing.setCity(ticket.getCity());
			ticketing.setSiteid(siteList.get(i));
			ticketing.setOpenDate(ticket.getOpenDate());
			ticketing.setOpenTime(ticket.getOpenTime());
			ticketing.setSiteids(ticket.getSiteid());
			ticketing.setStatus("Open");
			ticketing.setTicketDescription(ticket.getTicketDescription());
			surveyDAO.addTicket(ticketing);
		}

		String status = "Ticket Created Successfully";
		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newTicket");
	}

	@RequestMapping(value = "getUnassignedTechnicians", method = RequestMethod.GET)
	@ResponseBody
	public String getTechniciansData(ModelAndView model, HttpServletRequest request) {
		String region = request.getParameter("region");
		String city = request.getParameter("city");
		System.out.println("city :::" + city);
		List<Technician> listTechnicians = surveyDAO.getUnassignedTechniciansData(region, city);
		System.out.println(listTechnicians);
		Gson gsonBuilder = new GsonBuilder().create();
		String techniciansJson = gsonBuilder.toJson(listTechnicians);
		return techniciansJson.toString();
	}

	@RequestMapping(value = "/assignTechnician", method = RequestMethod.GET)
	@ResponseBody
	public String assignTechnician(HttpServletRequest request) throws MessagingException {

		String selectedTechnicianId = request.getParameter("technicianId");

		final Technician technicianData = surveyDAO.getTechniciansData(selectedTechnicianId);

		System.out.println("technicians: " + technicianData);

		String selectedTicketNum = request.getParameter("ticketId");

		List<Ticketing> ticketData = surveyDAO.getTicketsData(selectedTicketNum);

		// System.out.println("Ticket1"+ticketData.get(0).getId());
		// System.out.println("Ticket2"+ticketData.get(1).getId());
		// System.out.println("Ticket3"+ticketData.get(2).getId());

		String ticketId = null;
		String status = null;
		String statusUpdate = null;

		for (Ticketing ticket : ticketData) {
			TechnicianTicketInfo technicianTicket = new TechnicianTicketInfo();

			technicianTicket.setTechnicianId(technicianData.getTechnicianId());
			technicianTicket.setTechnicianName(technicianData.getTechnicianName());
			technicianTicket.setRegion(technicianData.getRegion());
			technicianTicket.setState(technicianData.getState());
			technicianTicket.setDistrict(technicianData.getDistrict());
			technicianTicket.setManager(technicianData.getManager());
			technicianTicket.setCity(technicianData.getCity());
			technicianTicket.setStatus("Assigned");

			ticketId = ticket.getTicketNum();
			technicianTicket.setTicketNum(ticket.getTicketNum());
			technicianTicket.setSiteid(ticket.getSiteid());
			technicianTicket.setSiteids(ticket.getSiteids());
			technicianTicket.setOpenDate(ticket.getOpenDate());
			technicianTicket.setOpenTime(ticket.getOpenTime());
			technicianTicket.setTicketDescription(ticket.getTicketDescription());

			status = surveyDAO.assignTechnician(technicianTicket);
			statusUpdate = surveyDAO.updateTicketingStatus(ticketId, ticket.getSiteid());
		}
		// if (technicianTicket.getSiteid() != null) {
		if (status.equalsIgnoreCase("Assigned") && statusUpdate.equalsIgnoreCase("Assigned")) {
			mailSender.send(new MimeMessagePreparator() {
				public void prepare(MimeMessage mimeMessage) throws MessagingException {
					MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "UTF-8");
					message.setTo("lakshmimadhuri.pulavarthy@cyient.com");
					message.setSubject("Ticket Information");
					message.setText(
							"Dear <b>" + technicianData.getTechnicianName()
									+ "</b> ,<br><br> Site with Id is assigned for Survey . <br><br> Please <a href='http://ctoceu.cyient.com:3290/RFIDAssetTracking/'>login</a> for other details",
							true);

				}
			});
			// }
		}

		return "Assigned";
	}

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
	public ModelAndView saveSiter(@ModelAttribute Site site, RedirectAttributes redirectAttributes) {
		String status = "Site Added Successfully";
		if (site.getSiteid() != null) {
			surveyDAO.addSite(site);
		}
		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newSite");
	}

	@RequestMapping(value = "/saveGenerator", method = RequestMethod.POST)
	public ModelAndView saveGenerator(@Valid @ModelAttribute("Site_Generator") Site_Generator generator,
			BindingResult br, ModelAndView model, @RequestParam("file") MultipartFile[] multipart,
			@RequestParam("submit") String submit, RedirectAttributes redirectAttributes) throws IOException {

		/*
		 * for(int i=0;i<multipart.length;i++){ if (multipart[i] != null &&
		 * multipart[i].getContentType()!= null &&
		 * !multipart[i].getContentType().toLowerCase().startsWith("image")){
		 * //throw new MultipartException("not img");
		 * redirectAttributes.addFlashAttribute("errMsg","Please Upload Image");
		 * return "addGenerator"; } }
		 */
		System.out.println("Generator++++++++++");
		System.out.println("Multipart----------" + multipart);
		if (br.hasErrors()) {
			System.out.println("errorss-----------" + br.getAllErrors());
			// redirectAttributes.addFlashAttribute("errMsg", " errorr");
			// return new ModelAndView("redirect:/newGenerator");
			model.setViewName("addGenerator");
			return model;
		} else {
			try {
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
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}
		String status = "Generator Added Successfully";
		surveyDAO.addGenerator(generator);
		redirectAttributes.addFlashAttribute("status", status);

		if (submit.equals("Save & Continue")) {
			return new ModelAndView("redirect:/newSMPS");

		} else if (submit.equals("Save") || submit.equals("Add")) {
			return new ModelAndView("redirect:/newGenerator");

		}
		return model;

	}
	/*
	 * @RequestMapping(value = "/towerinstallation", method =
	 * RequestMethod.POST) public ModelAndView
	 * savetowerInstallation(@ModelAttribute("Tower_Installation")
	 * Tower_Installation towerinstallation,@RequestParam("file")
	 * MultipartFile[] multipart ,ModelAndView model) {
	 * 
	 * System.out.println(" tower file name>>>>"+towerinstallation.getSiteid().
	 * getSiteid()); // System.out.println("json>>>>>>>>"+jsonarr); String
	 * message = ""; for (int i = 0; i < multipart.length; i++) { MultipartFile
	 * file = multipart[i]; //String name = names[i]; try { byte[] bytes =
	 * file.getBytes(); System.out.println("bytes>>>>>"+bytes);
	 * System.out.println(" file name"+file.getOriginalFilename());
	 * }catch(Exception e){
	 * 
	 * } }
	 * 
	 * return model; }
	 */

	/*
	 * @RequestMapping(value="/saveGenerator" , method=RequestMethod.POST)
	 * public ModelAndView saveGenerator(HttpServletRequest request,
	 * final @RequestParam CommonsMultipartFile[] gdphoto ,@ModelAttribute
	 * Site_Generator generator, RedirectAttributes redirectAttributes){
	 * 
	 * System.out.println("Generator  ++++++++++++++++++++++++"); // Determine
	 * If There Is An File Upload. If Yes, Attach It To The Client Email if
	 * ((gdphoto != null) && (gdphoto.length > 0) && (!gdphoto.equals(""))) {
	 * for (CommonsMultipartFile aFile : gdphoto) { if(aFile.isEmpty()) {
	 * continue; } else { System.out.println("Attachment Name?= " +
	 * aFile.getOriginalFilename() + "\n"); if
	 * (!aFile.getOriginalFilename().equals("")) {
	 * System.out.println(generator.getAssettagnumber());
	 * System.out.println(generator.getCapacity());
	 * generator.setGdphoto(aFile.getBytes());
	 * 
	 * List<Site_Generator> siteGenerator= new ArrayList(); siteGenerator.se
	 * fileUploadObj.setFileDescription(fileDescription);
	 * fileUploadObj.setData(aFile.getBytes());
	 * 
	 * // Calling The Db Method To Save The Uploaded File In The Db
	 * FileUploadInDb.fileSaveInDb(fileUploadObj); } }
	 * 
	 * } } else { // Do Nothing }
	 * 
	 * 
	 * String status="Generator Added Successfully";
	 * surveyDAO.addGenerator(generator);
	 * redirectAttributes.addFlashAttribute("status",status); return new
	 * ModelAndView("redirect:/newGenerator"); }
	 */

	@RequestMapping(value = "/saveSMPS", method = RequestMethod.POST)
	public ModelAndView saveSMPS(@ModelAttribute Site_SMPS smps, @RequestParam("file") MultipartFile[] multipart,
			@RequestParam("submit") String submit, RedirectAttributes redirectAttributes, ModelAndView model) {

		try {
			smps.setObservation_1(multipart[0].getBytes());
			smps.setObservation_1_Name(multipart[0].getOriginalFilename());
			smps.setObservation_2(multipart[1].getBytes());
			smps.setObservation_2_Name(multipart[1].getOriginalFilename());
		} catch (IOException e) {
			e.printStackTrace();
		}

		String status = "SMPS Added Successfully";
		surveyDAO.addSMPS(smps);
		redirectAttributes.addFlashAttribute("status", status);

		if (submit.equals("Save")) {
			return new ModelAndView("redirect:/newSMPS");
		} else if (submit.equals("Save & Continue")) {
			return new ModelAndView("redirect:/newBB");
		}

		return model;
	}

	@RequestMapping(value = "/saveBB", method = RequestMethod.POST)
	public ModelAndView saveBB(@ModelAttribute Site_Battery_Bank BB,@RequestParam("updatetype") String updatetype,@RequestParam("submit") String submit,RedirectAttributes redirectAttributes,@RequestParam(name = "photos") MultipartFile[] tag_photo) throws IOException {
		System.out.println("save bb calling" + tag_photo);
		String status = "Battery Bank Added Successfully";
		Site_Battery_Bank obj = new Site_Battery_Bank();

		//update type condition check
		if(updatetype.split(";")[0].contains("New"))
		{
			
		}
		else
		{
			obj= surveyDAO.getBB(BB.getSiteid().getSiteid()).get(0);
		}
		
		// saggrigation of files
		if(updatetype.split(";")[2].contains("false"))
		{
		BB.setTag_photo(tag_photo[0].getBytes());
		BB.setTag_photo_Name(tag_photo[0].getOriginalFilename());
		}
		else
		{
			BB.setTag_photo(obj.getTag_photo());
			BB.setTag_photo_Name(obj.getTag_photo_Name());
		}
		
		if(updatetype.split(";")[3].contains("false"))
		{
			BB.setTag_photo1(tag_photo[1].getBytes());
			BB.setTag_photo1_Name(tag_photo[1].getOriginalFilename());
		}
		else
		{
			BB.setTag_photo1(obj.getTag_photo1());
			BB.setTag_photo1_Name(obj.getTag_photo1_Name());
		}
		
		if(updatetype.split(";")[4].contains("false"))
		{
			BB.setTag_photo_2(tag_photo[2].getBytes());
			BB.setTag_photo2_Name(tag_photo[2].getOriginalFilename());
		}
		else
		{
			BB.setTag_photo_2(obj.getTag_photo_2());
			BB.setTag_photo2_Name(obj.getTag_photo2_Name());
		}
		surveyDAO.addBB(updatetype, BB);
		redirectAttributes.addFlashAttribute("status", status);
		if (submit.equals("Save")) {
			return new ModelAndView("redirect:/newBB");
		} else if (submit.equals("Save & Continue")) {
			return new ModelAndView("redirect:/newCabinet");
		} else {
			return new ModelAndView("redirect:/");
		}

	}


	@RequestMapping(value = "/saveCabinet", method = RequestMethod.POST)
	public ModelAndView saveCabinet(@ModelAttribute Site_Cabinet BB, @RequestParam("updatetype") String updatetype,
			@RequestParam("submit") String submit, RedirectAttributes redirectAttributes,
			@RequestParam(name = "tag_photo") MultipartFile[] tag_photo) throws IOException {
		String status = "Battery Bank Added Successfully";
		Site_Cabinet obj = new Site_Cabinet();
		System.out.println(updatetype);
		System.out.println(updatetype.split(";")[0]);
		System.out.println(updatetype.split(";")[1]);
		System.out.println(updatetype.split(";")[2]);
		System.out.println(updatetype.split(";")[3]);
System.out.println(updatetype.split(";")[0]=="New");
		if(updatetype.split(";")[0].contains("New"))
		{
			
		}
		else
		{
			obj= surveyDAO.getCabinet(BB.getSiteid().getSiteid()).get(0);
		}

		if(updatetype.split(";")[2].contains("false"))
		{
		BB.setPhoto_1(tag_photo[0].getBytes());
		BB.setPhoto_1_Name(tag_photo[0].getOriginalFilename());
		}
		else
		{
			BB.setPhoto_1(obj.getPhoto_1());
			BB.setPhoto_1_Name(obj.getPhoto_1_Name());
		}
		
		if(updatetype.split(";")[3].contains("false"))
		{
			BB.setPhoto_2(tag_photo[1].getBytes());
			BB.setPhoto_2_Name(tag_photo[1].getOriginalFilename());
		}
		else
		{
			BB.setPhoto_2(obj.getPhoto_2());
			BB.setPhoto_2_Name(obj.getPhoto_2_Name());
		}
		
		surveyDAO.addCabinet(updatetype,BB);
		redirectAttributes.addFlashAttribute("status", status);

		if (submit.equals("Save")) {
			return new ModelAndView("redirect:/newCabinet");
		} else if (submit.equals("Save & Continue")) {
			return new ModelAndView("redirect:/newCabinet");
		} else {
			return new ModelAndView("redirect:/");
		}
	}

	@RequestMapping(value = "/getBBData", method = RequestMethod.GET)
	@ResponseBody
	public String getBB(HttpServletRequest request) {
		List<Site_Battery_Bank> obj = surveyDAO.getBB(request.getParameter("siteid"));
		String siteSMPSJson = gson.toJson(obj);
		return siteSMPSJson.toString();

	}

	@RequestMapping(value = "/getCabinetData", method = RequestMethod.GET)
	@ResponseBody
	public String getCabinetData(HttpServletRequest request) {
		List<Site_Cabinet> obj = surveyDAO.getCabinet(request.getParameter("siteid"));
		String siteSMPSJson = gson.toJson(obj);
		return siteSMPSJson.toString();

	}

	@RequestMapping(value = "/getLastTicketId", method = RequestMethod.GET)
	@ResponseBody
	public String getLastTicketId(HttpServletRequest request) {

		List<Ticketing> ticketList = surveyDAO.getTicketId();
		Gson gsonBuilder = new GsonBuilder().create();
		String executiveJson = gsonBuilder.toJson(ticketList);
		return executiveJson.toString();

	}

	@ModelAttribute("regionsList")
	public Map<String, String> getRegions() {
		Map<String, String> regionsMap = new HashMap<String, String>();
		List<Regions> regions = surveyDAO.getRegions();

		// for(int i=0;i<regions.size();i++){
		// // System.out.println(regions.get(i));
		// }
		for (Regions region : regions) {
			regionsMap.put(region.getRegion(), region.getRegion());
		}
		// System.out.println("RegionsData "+regionsMap);
		return regionsMap;
	}

	@ModelAttribute("BBManufacturer")
	public Map<String, String> getBBManufacturer() {
		Map<String, String> BBMap = new HashMap<String, String>();
		List<Battery_Bank_Master> regions = surveyDAO.getBBManufacturer();
		int i = 0;
		for (i = 0; i < regions.size(); i++) {
			System.out.println(regions.get(i));
		}
		for (Battery_Bank_Master region : regions) {
			BBMap.put(region.getManufacturer(), region.getManufacturer());
		}
		System.out.println("RegionsData " + BBMap);
		return BBMap;
	}

	@ModelAttribute("BBType")
	public Map<String, String> getBBType() {
		Map<String, String> BBMap = new HashMap<String, String>();
		List<Battery_Bank_Master> regions = surveyDAO.getBBManufacturer();
		int i = 0;
		for (i = 0; i < regions.size(); i++) {
			System.out.println(regions.get(i));
		}
		for (Battery_Bank_Master region : regions) {
			BBMap.put(region.getType(), region.getType());
		}
		System.out.println("RegionsData " + BBMap);
		return BBMap;
	}

	@ModelAttribute("CabinetManufacturer")
	public Map<String, String> getCabinetManufacturer() {
		Map<String, String> BBMap = new HashMap<String, String>();
		List<Cabinet_Master> regions = surveyDAO.getCabinetManufacturer();
		int i = 0;
		for (i = 0; i < regions.size(); i++) {
			System.out.println(regions.get(i));
		}
		for (Cabinet_Master region : regions) {
			BBMap.put(region.getCabinetManufacturer(), region.getCabinetManufacturer());
		}
		System.out.println("RegionsData " + BBMap);
		return BBMap;
	}

	@ModelAttribute("CabinetType")
	public Map<String, String> getCabinetType() {
		Map<String, String> BBMap = new HashMap<String, String>();
		List<Cabinet_Master> regions = surveyDAO.getCabinetManufacturer();
		int i = 0;
		for (i = 0; i < regions.size(); i++) {
			System.out.println(regions.get(i));
		}
		for (Cabinet_Master region : regions) {
			BBMap.put(region.getType(), region.getType());
		}
		System.out.println("RegionsData " + BBMap);
		return BBMap;
	}

	@RequestMapping(value = "getStates", method = RequestMethod.GET)
	@ResponseBody

	public String getStates(ModelAndView model, HttpServletRequest request) {
		String selectedRegion = request.getParameter("selectedRegion");
		// List<Regions> listStates = surveyDAO.getStates(selectedRegion);
		List<Regions> regions = surveyDAO.getStates(selectedRegion);
		List<String> listStates = new ArrayList<String>();
		for (Regions region : regions) {
			// statesMap.put(region.getState(),region.getState());
			listStates.add(region.getState());

		}

		List<Object> listWithoutDuplicates = listStates.stream().distinct().collect(Collectors.toList());
		Gson gsonBuilder = new GsonBuilder().create();
		String statesJson = gsonBuilder.toJson(listWithoutDuplicates);
		// System.out.println("StatesJSON"+statesJson);
		return statesJson;
		// return statesMap;

	}

	@RequestMapping(value = "getDistricts", method = RequestMethod.GET)
	@ResponseBody

	public String getDistricts(ModelAndView model, HttpServletRequest request) {
		String selectedRegion = request.getParameter("selectedRegion");

		String selectedState = request.getParameter("selectedState");
		List<Regions> districts = surveyDAO.getDistricts(selectedRegion, selectedState);
		List<String> listDistricts = new ArrayList<String>();
		for (Regions region : districts) {
			listDistricts.add(region.getDistrict());
		}
		List<Object> listWithoutDuplicates = listDistricts.stream().distinct().collect(Collectors.toList());
		Gson gsonBuilder = new GsonBuilder().create();
		String districtsJson = gsonBuilder.toJson(listWithoutDuplicates);
		return districtsJson;
	}

	@RequestMapping(value = "getCities", method = RequestMethod.GET)
	@ResponseBody

	public String getCities(ModelAndView model, HttpServletRequest request) {

		String selectedRegion = request.getParameter("selectedRegion");
		String selectedState = request.getParameter("selectedState");
		String selectedDistrict = request.getParameter("selectedDistrict");
		List<Regions> cities = surveyDAO.getCities(selectedRegion, selectedState, selectedDistrict);
		List<String> listCities = new ArrayList<String>();
		for (Regions region : cities) {
			listCities.add(region.getCity());
		}
		List<Object> listWithoutDuplicates = listCities.stream().distinct().collect(Collectors.toList());
		Gson gsonBuilder = new GsonBuilder().create();
		String totalJson = gsonBuilder.toJson(listWithoutDuplicates);
		return totalJson.toString();

		/*
		 * List<Regions> regions =
		 * surveyDAO.getCities(selectedRegion,selectedState,selectedDistrict);
		 * Map<String, String> citiesMap = new HashMap<String, String>();
		 * for(Regions region : regions) {
		 * citiesMap.put(region.getCity(),region.getCity()); }
		 * 
		 * // Gson gsonBuilder = new GsonBuilder().create(); // String totalJson
		 * = gsonBuilder.toJson(listCities); return citiesMap;
		 */

	}

	@SuppressWarnings("unchecked")
	@RequestMapping("ticketsCount")
	@ResponseBody
	public String ticketsCountData(ModelAndView model) {
		List<Ticketing> listOpen = surveyDAO.openTicketsData();
		Set ticketSet = new HashSet<Object>();
		listOpen.removeIf(p -> !ticketSet.add(p.getTicketNum()));
		List<TechnicianTicketInfo> listAssigned = surveyDAO.assignedTicketsData();
		Set ticketSet1 = new HashSet<Object>();
		listAssigned.removeIf(p -> !ticketSet1.add(p.getTicketNum()));
		List<TechnicianTicketInfo> listHistory = surveyDAO.historyTicketsData();
		Set ticketSet2 = new HashSet<Object>();
		listHistory.removeIf(p -> !ticketSet2.add(p.getTicketNum()));
		List<Ticketing> listTotal = surveyDAO.getAllTicketsData();
		Set ticketSet3 = new HashSet<Object>();
		listTotal.removeIf(p -> !ticketSet3.add(p.getTicketNum()));

		JSONObject countData = new JSONObject();
		countData.put("OpenTickets", listOpen.size());
		countData.put("AssignedTickets", listAssigned.size());
		countData.put("HistoryTickets", listHistory.size());
		countData.put("TotalTickets", listTotal.size());
		System.out.println(countData);
		return countData.toString();
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("getOpenTickets")
	@ResponseBody
	public String getOpenTicketsData(ModelAndView model) {
		List<Ticketing> listOpen = surveyDAO.openTicketsData();

		Set openSet = new HashSet<Object>();

		// directly removing the elements from list if already existed in set
		listOpen.removeIf(p -> !openSet.add(p.getTicketNum()));

		// listOpen.forEach(dept->System.out.println(dept.getId() +" :
		// "+dept.getSiteid()+"::"+dept.getSiteids()));

		Gson gsonBuilder = new GsonBuilder().create();
		String openJson = gsonBuilder.toJson(listOpen);
		return openJson.toString();
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("getAssignedTickets")
	@ResponseBody
	public String getAssignedTicketsData(ModelAndView model) {
		List<TechnicianTicketInfo> listAssigned = surveyDAO.assignedTicketsData();
		Set ticketSet = new HashSet<Object>();
		listAssigned.removeIf(p -> !ticketSet.add(p.getTicketNum()));
		Gson gsonBuilder = new GsonBuilder().create();
		String closedJson = gsonBuilder.toJson(listAssigned);
		return closedJson.toString();
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("getHistoryTickets")
	@ResponseBody
	public String getHistoryTicketsData(ModelAndView model) {
		List<TechnicianTicketInfo> listHistory = surveyDAO.historyTicketsData();
		Set ticketSet = new HashSet<Object>();
		listHistory.removeIf(p -> !ticketSet.add(p.getTicketNum()));
		Gson gsonBuilder = new GsonBuilder().create();
		String historyJson = gsonBuilder.toJson(listHistory);
		return historyJson.toString();
	}

	@RequestMapping(value = "getSiteId", method = RequestMethod.GET)
	@ResponseBody

	public String getSiteId(ModelAndView model, HttpServletRequest request) {

		String selectedRegion = request.getParameter("selectedRegion");
		String selectedState = request.getParameter("selectedState");
		String selectedDistrict = request.getParameter("selectedDistrict");
		String selectedCity = request.getParameter("selectedCity");
		List<Site> siteIds = surveyDAO.getSiteIdsForRegion(selectedRegion, selectedState, selectedDistrict,
				selectedCity);
		List<String> listSiteIds = new ArrayList<String>();
		for (Site site : siteIds) {
			listSiteIds.add(site.getSiteid());
		}
		List<Object> listWithoutDuplicates = listSiteIds.stream().distinct().collect(Collectors.toList());
		Gson gsonBuilder = new GsonBuilder().create();
		String totalJson = gsonBuilder.toJson(listWithoutDuplicates);
		return totalJson;

		/*
		 * List<Regions> regions =
		 * surveyDAO.getCities(selectedRegion,selectedState,selectedDistrict);
		 * Map<String, String> citiesMap = new HashMap<String, String>();
		 * for(Regions region : regions) {
		 * citiesMap.put(region.getCity(),region.getCity()); }
		 * 
		 * // Gson gsonBuilder = new GsonBuilder().create(); // String totalJson
		 * = gsonBuilder.toJson(listCities); return citiesMap;
		 */

	}

	@RequestMapping(value = "/getLastSiteId", method = RequestMethod.GET)
	@ResponseBody
	public String getLastSiteId(HttpServletRequest request) {

		List<Site> siteidList = surveyDAO.getSiteId();
		System.out.println("siteid>>>>>>...." + siteidList);
		Gson gsonBuilder = new GsonBuilder().create();
		String executiveJson = gsonBuilder.toJson(siteidList);
		return executiveJson.toString();

	}

	@RequestMapping("getTotalTickets")
	@ResponseBody
	public String getTotalTicketsData(ModelAndView model) {
		List<Ticketing> listTotal = surveyDAO.getAllTicketsData();
		Set ticketSet = new HashSet<Object>();
		listTotal.removeIf(p -> !ticketSet.add(p.getTicketNum()));
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
	public String getAdminTicketsCount(ModelAndView model) {
		List<Ticketing> listOpen = surveyDAO.openTicketsData();
		List<TechnicianTicketInfo> listAssigned = surveyDAO.assignedTicketsData();
		List<TechnicianTicketInfo> listHistory = surveyDAO.historyTicketsData();
		List<Ticketing> listTotal = surveyDAO.getAllTicketsData();

		JSONObject countData = new JSONObject();
		countData.put("OpenTickets", listOpen.size());
		countData.put("AssignedTickets", listAssigned.size());
		countData.put("HistoryTickets", listHistory.size());
		countData.put("TotalTickets", listTotal.size());
		System.out.println(countData);
		return countData.toString();
	}

	@RequestMapping(value = "getManager", method = RequestMethod.GET)
	@ResponseBody
	public String getManager(HttpServletRequest request) {
		String region = request.getParameter("selectedRegion");
		List<User> managers = surveyDAO.getManager(region);
		List<String> listManagers = new ArrayList<String>();
		for (User user : managers) {
			listManagers.add(user.getUsername());
		}
		Gson gsonBuilder = new GsonBuilder().create();
		String managerJSON = gsonBuilder.toJson(listManagers);
		return managerJSON;
	}

	@RequestMapping(value = "/getUserName", method = RequestMethod.GET)
	@ResponseBody
	public String getUserName(HttpServletRequest request) {
		String username = request.getParameter("username");
		String role = request.getParameter("role");
		String user = surveyDAO.getUserName(role, username);
		return user;
	}

}

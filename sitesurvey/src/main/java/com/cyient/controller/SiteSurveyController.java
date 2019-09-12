package com.cyient.controller;


import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.URL;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.jboss.logging.Logger;
import org.json.simple.JSONArray;
import org.omg.CORBA.portable.OutputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
import com.cyient.model.Site_Additional_Notes;
import com.cyient.model.Site_Generator;
import com.cyient.model.Site_Safety;
import com.cyient.model.Site_Security;
import com.cyient.model.Technician;
import com.cyient.model.Tower_Installation;
import com.cyient.model.Track_Users;
import com.cyient.model.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;



@Controller
public class SiteSurveyController {
	private static final Logger logger = Logger
			.getLogger(SiteSurveyController.class);

	
		// TODO Auto-generated method stub

	
	
	public SiteSurveyController() {
		
		System.out.println("SiteSurveyController()");
	}
	@Autowired
	private SurveyDAO surveyDAO;
	
	//ConfigurableApplicationContext con= ConfigurableApplicationContext(SiteSurveyController.class)
	
	private Integer Session_counter = 0;	
	@RequestMapping(value = "/")
	public ModelAndView viewIndex(ModelAndView model) throws IOException {
		User user = new User();
		model.addObject("User", user);
		model.setViewName("index");
		return model;
	}
	
	@RequestMapping(value = "/validateUser", method = RequestMethod.POST)

    public ModelAndView checkUser(@ModelAttribute User user,ModelAndView model, HttpSession session,HttpServletRequest request) throws SocketException {


		System.out.println("Usernaem"+user.getUsername()+"Password"+user.getPassword()+"Role:"+user.getRole());

		List<User> userList = surveyDAO.getAllUsersOnCriteria(user.getUsername(),user.getPassword(),user.getRole());        
           if(userList.size()!=0)

           {
                  return new ModelAndView("redirect:/");
           }
           else
           {      
        	  Session_counter = Session_counter + 1;
        	  session=request.getSession();
        	  session.setAttribute("userName",user.getUsername());
			  session.setAttribute("password",user.getPassword());
        	  session.setAttribute("userRole",user.getRole());
        	  System.out.println(user.getUsername());
        	  System.out.println(user.getName());

        	  Enumeration e = NetworkInterface.getNetworkInterfaces();
        	  while(e.hasMoreElements())
        	  {
        	      NetworkInterface n = (NetworkInterface) e.nextElement();
        	      Enumeration ee = n.getInetAddresses();
        	      while (ee.hasMoreElements())
        	      {
        	          InetAddress i = (InetAddress) ee.nextElement();
        	          System.out.println(i.getHostAddress());
        	      }
        	  } 
        	  
	              model.setViewName("homePage");
	              return model;
           }
    }	
	
	@RequestMapping(value = "/validateUserAjax", method = RequestMethod.GET)
	@ResponseBody
    public String validateUserAjax(HttpServletRequest request) {
		String username=request.getParameter("username");
    	String password=request.getParameter("password");
    	String role=request.getParameter("role");
    	try
    	{
    		List<User> userList = surveyDAO.getAllUsersOnCriteria(username,password,role);	
    		String userName=null,roleType=null;
			for(User user:userList)
    		{
    			userName=user.getUsername();
    			roleType=user.getRole();
    		}
	    	if(userName.equals(username) & roleType.equals(role))
	    	{
	    		
	    		 Gson gsonBuilder = new GsonBuilder().create();
	        	   String userJson = gsonBuilder.toJson(userList);
		              return userJson.toString();	    	
	    	}
	    	else
	    	{
	    		return "failure";
	    	}
    	}
    	catch(Exception e)
    	{
    		return "failure";
    	}
    }	
	
	@RequestMapping(value = "/saveLoginInfo", method = RequestMethod.GET)
	@ResponseBody
	public String TrackUser(ModelAndView model,HttpServletRequest request) {
		String Uname= request.getParameter("UserName");
		String CurrentIP= request.getParameter("CurrentIP");
		String Type= request.getParameter("Type");
		String Time= request.getParameter("Time");
		
		System.out.println("user + ip"+Uname  +CurrentIP);
		Track_Users trackuser= new Track_Users();
		trackuser.setUsername(Uname);
		trackuser.setCurrentip(CurrentIP);
		trackuser.setTime2(Time);
		trackuser.setType(Type);
		String status=surveyDAO.saveTrackuser(trackuser);
		return status;
	}
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView redirectHome(ModelAndView model) {
		model.setViewName("homePage");
		return model;
	}

	@RequestMapping(value = "/saveUser", method = RequestMethod.POST)
	public ModelAndView saveUser(@ModelAttribute User user,RedirectAttributes redirectAttributes) {
		String status="User Added Successfully";
		if (user.getUsername() !=null) { 
			surveyDAO.addUser(user);
		} 
		redirectAttributes.addFlashAttribute("status", status);
		return new ModelAndView("redirect:/newUser");
	}

	/*@RequestMapping(value = "/newTechnician", method = RequestMethod.GET)
	public ModelAndView newTechnician(ModelAndView model) {
		Technician technician = new Technician();
		model.addObject("Technician", technician);
		model.setViewName("technicianReg");
		return model;
	}*/
	
	/*Added for fetching roles in header page */
	 @RequestMapping(value= "getRoles", method = RequestMethod.GET)
		@ResponseBody
		public String getRoles(HttpServletRequest request) {
		 String username=request.getParameter("userName");
			List<User> user = surveyDAO.getRoles(username);
			Gson gsonBuilder = new GsonBuilder().create();
			String regionJSON = gsonBuilder.toJson(user);
	 	   	return regionJSON;
		}
	 
	@RequestMapping(value = "/logout")
	 public String logout(@ModelAttribute User user, HttpSession session,HttpServletRequest request) {
          	  session.removeAttribute("userName");
              return "redirect:/";
	 }
	
	
	@RequestMapping(value = "/fetchSiteInformation", method = RequestMethod.GET)
	@ResponseBody
	public String fetchsiteinformation(ModelAndView model,HttpServletRequest request){
		
		String ticketid=request.getParameter("ticketid");
		String siteid=request.getParameter("siteid");
		
		JSONArray json=new JSONArray();
		json.add(ticketid);
		json.add(siteid);
		
		return json.toJSONString();
	}
	
	
	@RequestMapping(value = "/fetchtowerinstallation", method = RequestMethod.GET)
	public ModelAndView fetchtowerinstallation(ModelAndView model) {
		
		//Tower_Installation ti=
		
		Tower_Installation ti=new Tower_Installation();
		model.addObject("Tower_Installation",ti);
		model.setViewName("towerInstallation");
		return model;
	}
	
	@RequestMapping(params = "btn",value = "/towerinstallation",  method = RequestMethod.POST)
	public ModelAndView savetowerInstallation(@Valid @ModelAttribute("Tower_Installation") Tower_Installation towerinstallation,
			BindingResult bir,
			@RequestParam("file") MultipartFile[] multipart,ModelAndView model,HttpServletRequest request,RedirectAttributes redirectAttributes) {
		
		ModelMap map= new ModelMap();
		
		 String json=(String) request.getParameter("json");
		System.out.println("json>>>>------------------------"+json);
		System.out.println("siteid>>>>"+towerinstallation.getSiteid().getSiteid());
		System.out.println(" tower file name>>>>"+towerinstallation.getSiteid().getSiteid());
		System.out.print("Overall Condition"+towerinstallation.getOverallconditon());
		String action= request.getParameter("btn");
		System.out.println("bts value>>>> "+action);
	//	System.out.println("json>>>>>>>>"+jsonarr);
		String message = "";
		if(bir.hasErrors()){
			System.out.println(" Got error");
			model.setViewName("towerInstallation");
			return model;
		}
		else{
		try {
			System.out.println("image Details>>>>>>>>>>>>>"+multipart[0].getBytes()+" image name"+multipart[0].getOriginalFilename());
			towerinstallation.setTower_photo1(multipart[0].getBytes());
			towerinstallation.setTower_photo1_name(multipart[0].getOriginalFilename());
			towerinstallation.setTower_photo2(multipart[1].getBytes());
			towerinstallation.setTower_photo2_name(multipart[1].getOriginalFilename());
			towerinstallation.setTower_photo3(multipart[2].getBytes());
			towerinstallation.setTower_photo3_name(multipart[2].getOriginalFilename());
			towerinstallation.setTower_photo4(multipart[3].getBytes());
			towerinstallation.setTower_photo4_name(multipart[3].getOriginalFilename());
			//Site s = new Site();
		//	//s.setSiteid("IND001");
			//towerinstallation.setSiteid(s);
			System.out.println("towerphoto1>>"+towerinstallation.getTower_photo1());
			String status=surveyDAO.saveTowerInstallation(towerinstallation);
			
			/*Gson gsonBuilder = new GsonBuilder().create();
            String towerInstallationJson = gsonBuilder.toJson(towerinstallation);
            //System.out.println(towerInstallationJson);
              // return execOpenJson.toString()
					try {    		  
			            URL url = new URL("http://localhost:8080/SiteSurveyRest/sitesurvey/saveTowerInstallation");
			            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			            conn.setRequestProperty("Content-Type", "application/json; utf-8");

			          conn.setRequestMethod("POST");
			           conn.setDoOutput(true);
			            DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
			            wr.writeBytes(towerInstallationJson);
			            wr.flush();
							wr.close();
			            java.io.OutputStream os = conn.getOutputStream();


			    		os.write(towerInstallationJson.toString().getBytes());
			    		os.flush();
			    		os.close();
			            //conn.setRequestProperty("Accept", "application/json");
			            if (conn.getResponseCode() != 200) {
			                throw new RuntimeException("Failed : HTTP Error code : "
			                        + conn.getResponseCode());
			            }     
			            InputStreamReader in = new InputStreamReader(conn.getInputStream());
			            StringBuilder stringBuilder= new StringBuilder();
			            BufferedReader br = new BufferedReader(in);
			            String response = null;
		                while ((response = br.readLine()) != null) {
		                    stringBuilder.append(response + "\n");
		                }
		                System.out.println("status>>>"+stringBuilder);
		                br.close();
			            
			            conn.disconnect();
			            String s1=stringBuilder.toString().trim();
			            System.out.println("s1>>>>"+s1);
			            String s2="Saved";
			            System.out.println(s1.equals(s2));*/
			
						
			            System.out.println(action.equalsIgnoreCase("Save & Continue"));
			            if(status.equalsIgnoreCase("Saved")){
			            	if(action.equalsIgnoreCase("Save")){
			            		redirectAttributes.addFlashAttribute("succMsg","Details Saved Successfully");
			            		model.setViewName("redirect:/fetchtowerinstallation");
			            		return model;
			            		
			            	}else if(action.equalsIgnoreCase("Save & Continue")){
			            		redirectAttributes.addFlashAttribute("succMsg","Details Saved Successfully");
			            		
			            		model.addObject("ticketDetails",json);
			            		
			            		model.setViewName("redirect:/gotositesecurity");
			            		
			            		return model;
			               	}
			            }
			
			        } catch (Exception e) {
			            System.out.println("Exception in NetClientGet:- " + e);
			        }

		return model;
	}
}
	
	@RequestMapping(value = "/gotositesecurity", method = RequestMethod.GET)
	public ModelAndView fetchsitesecurity(ModelAndView model) {
		
		//Tower_Installation ti=
		Site_Security ss=new Site_Security();	
		model.addObject("Site_Security",ss);
		model.setViewName("addSecurity");
		return model;
	}
	
	
	@RequestMapping(params = "btn",value = "/sitesecurity",  method = RequestMethod.POST)
	public ModelAndView savesitesecurity(@Valid @ModelAttribute("Site_Security") Site_Security sitesecurity,
			BindingResult bir,
			@RequestParam("file") MultipartFile[] multipart,ModelAndView model,HttpServletRequest request,RedirectAttributes redirectAttributes) {
		 String json=(String) request.getParameter("json");
		 System.out.println("json site security>>>>>>>>>"+json);
		System.out.println("siteid>>>>"+sitesecurity.getSiteid().getSiteid());
		System.out.println("observations"+sitesecurity.getObservations());
		String action= request.getParameter("btn");
		try{
			System.out.println("image Details>>>>>>>>>>>>>"+multipart[0].getBytes()+" image name"+multipart[0].getOriginalFilename());
			sitesecurity.setSecurity_photo1(multipart[0].getBytes());
			sitesecurity.setSecurity_photo1_name(multipart[0].getOriginalFilename());
			sitesecurity.setTower_photo2(multipart[1].getBytes());
			sitesecurity.setTower_photo2_name(multipart[1].getOriginalFilename());
			
			String status=surveyDAO.storeSitesecurity(sitesecurity);
			
/*			Gson gsonBuilder = new GsonBuilder().create();
            String sitesecurityJson = gsonBuilder.toJson(sitesecurity);
            URL url = new URL("http://localhost:8080/SiteSurveyRest/sitesurvey/saveSiteSecurity");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("Content-Type", "application/json; utf-8");

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
            wr.writeBytes(sitesecurityJson);
            wr.flush();
            wr.close();
            /*java.io.OutputStream os = conn.getOutputStream();


    		os.write(towerInstallationJson.toString().getBytes());
    		os.flush();
    		os.close();
            //conn.setRequestProperty("Accept", "application/json");
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP Error code : "
                        + conn.getResponseCode());
            }     
            InputStreamReader in = new InputStreamReader(conn.getInputStream());
            StringBuilder stringBuilder= new StringBuilder();
            BufferedReader br = new BufferedReader(in);
            String response = null;
            while ((response = br.readLine()) != null) {
                stringBuilder.append(response + "\n");
            }
            System.out.println("status>>>"+stringBuilder);
            br.close();
            
            conn.disconnect();
            String s1=stringBuilder.toString().trim();
            System.out.println("s1>>>>"+s1);
            String s2="Saved";
            System.out.println(s1.equals(s2));*/
            if(status.equalsIgnoreCase("Saved")){
            	if(action.equalsIgnoreCase("Save")){
            		redirectAttributes.addFlashAttribute("succMsg","Details Saved Successfully");
            		model.setViewName("redirect:/gotositesecurity");
            		return model;
            		
            	}else if(action.equalsIgnoreCase("Save & Continue")){
            		redirectAttributes.addFlashAttribute("succMsg","Details Saved Successfully");
            		
            		model.addObject("ticketDetails",json);
            		
            		model.setViewName("redirect:/gotosafety");
            		
            		return model;
               	}
            }
		}catch(Exception e){
			
		}
		
		return model;
	}
	
	
	
	@RequestMapping(value = "/gotosafety", method = RequestMethod.GET)
	public ModelAndView fetchsitesafety(ModelAndView model) {
		
		//Tower_Installation ti=
		System.out.println();
		Site_Safety ss= new Site_Safety();	
		model.addObject("Site_Safety",ss);
		model.setViewName("addsafety");
		return model;
	}
	
	@RequestMapping(params = "btn",value = "/sitesafety",  method = RequestMethod.POST)
	public ModelAndView savesitesafety(@Valid @ModelAttribute("Site_Safety") Site_Safety sitesafety,
			BindingResult bir,
			@RequestParam("file") MultipartFile[] multipart,ModelAndView model,HttpServletRequest request,RedirectAttributes redirectAttributes) {
		 String json=(String) request.getParameter("json");
		 System.out.println("json site safety>>>>>>>>>"+json);
		System.out.println("siteid>>>>"+sitesafety.getSiteid().getSiteid());
		System.out.println("observations"+sitesafety.getObservations());
		String action= request.getParameter("btn");
		try{
			System.out.println("image Details>>>>>>>>>>>>>"+multipart[0].getBytes()+" image name"+multipart[0].getOriginalFilename());
			sitesafety.setSafety_photo1(multipart[0].getBytes());
			sitesafety.setSafety_photo1_name(multipart[0].getOriginalFilename());
			
			sitesafety.setSafety_photo2(multipart[1].getBytes());
			sitesafety.setSafety_photo2_name(multipart[1].getOriginalFilename());
			
			
			sitesafety.setSafety_photo3(multipart[1].getBytes());
			sitesafety.setSafety_photo3_name(multipart[1].getOriginalFilename());
			
			sitesafety.setSafety_photo4(multipart[1].getBytes());
			sitesafety.setSafety_photo4_name(multipart[1].getOriginalFilename());
			
			sitesafety.setSafety_photo5(multipart[1].getBytes());
			sitesafety.setSafety_photo5_name(multipart[1].getOriginalFilename());
			
			sitesafety.setSafety_photo6(multipart[1].getBytes());
			sitesafety.setSafety_photo6_name(multipart[1].getOriginalFilename());
			
			sitesafety.setSafety_photo7(multipart[1].getBytes());
			sitesafety.setSafety_photo7_name(multipart[1].getOriginalFilename());
			
			
			
			String status=surveyDAO.storeSiteSafety(sitesafety);
		
			
			
		/*	Gson gsonBuilder = new GsonBuilder().create();
            String sitesafetyJson = gsonBuilder.toJson(sitesafety);
            URL url = new URL("http://localhost:8080/SiteSurveyRest/sitesurvey/saveSiteSafety");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("Content-Type", "application/json; utf-8");

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
            wr.writeBytes(sitesafetyJson);
            wr.flush();
            wr.close();
            java.io.OutputStream os = conn.getOutputStream();


    		os.write(towerInstallationJson.toString().getBytes());
    		os.flush();
    		os.close();
            //conn.setRequestProperty("Accept", "application/json");
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP Error code : "
                        + conn.getResponseCode());
            }     
            InputStreamReader in = new InputStreamReader(conn.getInputStream());
            StringBuilder stringBuilder= new StringBuilder();
            BufferedReader br = new BufferedReader(in);
            String response = null;
            while ((response = br.readLine()) != null) {
                stringBuilder.append(response + "\n");
            }
            System.out.println("status>>>"+stringBuilder);
            br.close();
            
            conn.disconnect();
            String s1=stringBuilder.toString().trim();
            System.out.println("s1>>>>"+s1);
            String s2="Saved";
            System.out.println(s1.equals(s2));*/
            if(status.equalsIgnoreCase("Saved")){
            	if(action.equalsIgnoreCase("Save")){
            		redirectAttributes.addFlashAttribute("succMsg","Details Saved Successfully");
            		model.setViewName("redirect:/gotosafety");
            		return model;
            		
            	}else if(action.equalsIgnoreCase("Save & Continue")){
            		redirectAttributes.addFlashAttribute("succMsg","Details Saved Successfully");
            		
            		model.addObject("ticketDetails",json);
            		
            		model.setViewName("redirect:/gotoAdditional");
            		
            		return model;
               	}
            }
		}catch(Exception e){
			
		}
		
		return model;
	}
	
	@RequestMapping(value = "/gotoAdditional", method = RequestMethod.GET)
	public ModelAndView fetchsiteAddtional(ModelAndView model) {
		
		//Tower_Installation ti=
		System.out.println();
		Site_Additional_Notes sa= new Site_Additional_Notes();	
		model.addObject("Site_Additional_Notes",sa);
		model.setViewName("addSiteAdditional");
		return model;
	}

	@SuppressWarnings("null")
	@RequestMapping(params = "btn",value = "/additionalNotes",  method = RequestMethod.POST)
	public ModelAndView savesitesafety(@Valid @ModelAttribute("Site_Additional_Notes") Site_Additional_Notes siteaddtional,
			BindingResult bir,
			@RequestParam("file") MultipartFile[] multipart,ModelAndView model,HttpServletRequest request,RedirectAttributes redirectAttributes) {
		 String json=(String) request.getParameter("json");
		 System.out.println("json site safety>>>>>>>>>"+json);
		System.out.println("siteid>>>>"+siteaddtional.getSiteid().getSiteid());
		System.out.println("observations"+siteaddtional.getObservations());
		String action= request.getParameter("btn");
		try{
			System.out.println("image Details>>>>>>>>>>>>>"+multipart[0].getBytes()+" image name"+multipart[0].getOriginalFilename());
			siteaddtional.setSite_photo1(multipart[0].getBytes());
			siteaddtional.setSite_photo1_name(multipart[0].getOriginalFilename());
			
			siteaddtional.setSite_photo2(multipart[1].getBytes());
			siteaddtional.setSite_photo2_name(multipart[1].getOriginalFilename());
			
			String status=surveyDAO.storeSiteAdditional(siteaddtional);
					
			/*Gson gsonBuilder = new GsonBuilder().create();
            String siteAdditionalJson = gsonBuilder.toJson(siteaddtional);
            URL url = new URL("http://localhost:8080/SiteSurveyRest/sitesurvey/saveSiteAddition");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("Content-Type", "application/json; utf-8");

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
            wr.writeBytes(siteAdditionalJson);
            wr.flush();
            wr.close();
            java.io.OutputStream os = conn.getOutputStream();


    		os.write(towerInstallationJson.toString().getBytes());
    		os.flush();
    		os.close();
            //conn.setRequestProperty("Accept", "application/json");
            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP Error code : "
                        + conn.getResponseCode());
            }     
            InputStreamReader in = new InputStreamReader(conn.getInputStream());
            StringBuilder stringBuilder= new StringBuilder();
            BufferedReader br = new BufferedReader(in);
            String response = null;
            while ((response = br.readLine()) != null) {
                stringBuilder.append(response + "\n");
            }
            System.out.println("status>>>"+stringBuilder);
            br.close();
            
            conn.disconnect();
            String s1=stringBuilder.toString().trim();
            System.out.println("s1>>>>"+s1);
            String s2="Saved";
            System.out.println(s1.equals(s2));*/
            if(status.equalsIgnoreCase("Saved")){
            	if(action.equalsIgnoreCase("Save")){
            		redirectAttributes.addFlashAttribute("succMsg","Details Saved Successfully");
            		model.setViewName("redirect:/gotoAdditional");
            		return model;
            		
            	}else if(action.equalsIgnoreCase("Save & Continue")){
            		redirectAttributes.addFlashAttribute("succMsg","Details Saved Successfully");
            		
            		Model m=null;
            		model.addObject("ticketDetails",json);
            		//m.addAttribute("ticketDetails",json);
            		model.setViewName("redirect:/home");
            		
            		return model;
               	}
            }
		}catch(Exception e){
			
		}
		
		return model;
	}

	@RequestMapping(value="/getSafetyDetails", method=RequestMethod.GET)
	@ResponseBody
	public String getSafetyDetails(HttpServletRequest request)
	{
		String siteId=request.getParameter("siteId");
		List<Site_Safety> siteSafetyList=surveyDAO.getSafetyDetails(siteId);
		Gson gson=new GsonBuilder().create();
		String siteSafetyJson=gson.toJson(siteSafetyList);
		return siteSafetyJson.toString();
	}
	
	
	
}

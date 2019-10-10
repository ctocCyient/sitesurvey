package com.cyient.dao;

import java.util.Calendar;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cyient.controller.SiteSurveyController;
import com.cyient.model.Battery_Bank_Master;
import com.cyient.model.Cabinet_Master;
import com.cyient.model.Regions;
import com.cyient.model.Site;
import com.cyient.model.Site_Access;
import com.cyient.model.Site_Additional_Notes;
import com.cyient.model.Site_Area;
import com.cyient.model.Site_Generator;
import com.cyient.model.Site_SMPS;
import com.cyient.model.Site_Wiring;
import com.cyient.model.Survey_Team_PPE;
import com.cyient.model.Site_Safety;
import com.cyient.model.Site_Security;
import com.cyient.model.Site_Battery_Bank;
import com.cyient.model.Site_Cabinet;
import com.cyient.model.Technician;
import com.cyient.model.TechnicianTicketInfo;
import com.cyient.model.Ticketing;
import com.cyient.model.Tower_Installation;
import com.cyient.model.Track_Users;

import com.cyient.model.User;

@Repository
public class SurveyDAOImpl implements SurveyDAO {

	@Autowired
	private SessionFactory sessionFactory;

	private static final Logger impLogger = Logger.getLogger("impLogger");

	public void addUser(User user) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(user);
			impLogger.info(user.getName() + " Added");
		} catch (Exception e) {
			impLogger.info("Function : SurveyDAOImpl-addUser");
			impLogger.error(e);
		}
	}

	public void addTicket(Ticketing ticket) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(ticket);
			impLogger.info("Ticket no" + ticket.getTicketNum() + " Added");

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-addTicket");
			impLogger.error(e);
		}
		// System.out.println("ADDEDDDDSDGF");
	}

	@SuppressWarnings("unchecked")
	public List<User> getAllUsersOnCriteria(String username, String password, String type) {
		Criteria c = sessionFactory.getCurrentSession().createCriteria(User.class);
		try {
			c.add(Restrictions.eq("username", username));
			c.add(Restrictions.eq("password", password));
			c.add(Restrictions.eq("role", type));
			impLogger.info("List Genrated by getAllUsersOnCriteria");
			// System.out.println(c.list());
		} catch (Exception e) {
			impLogger.info("Function : SurveyDAOImpl-getAllUsersOnCriteria");
			impLogger.error(e);
			// TODO: handle exception
		}
		return c.list();

	}

	public void addSiteAccess(Site_Access siteacc) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(siteacc);
			impLogger.info("Site_Access Added : " + siteacc.getSiteid().getSiteid());

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-addSiteAccess");
			impLogger.error(e);
		}

	}

	public void addSiteArea(Site_Area sitearea) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(sitearea);
			impLogger.info("Site_Area Added : " + sitearea.getSiteid().getSiteid());

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-addSiteArea");
			impLogger.error(e);
		}
	}

	public void addSitePowering(Site_Wiring sitewiring) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(sitewiring);
			impLogger.info("Site_Wiring Added : " + sitewiring.getSiteid().getSiteid());
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-addSitePowering");
			impLogger.error(e);
		}
	}

	public void addSite(Site site) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(site);
			impLogger.info("Site Added : " + site.getSiteid());
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-addSite");
			impLogger.error(e);
		}
	}

	public void updateSiteAccess(Site_Access upsiteacc) {
		try {
			sessionFactory.getCurrentSession().update(upsiteacc);
			impLogger.info("updateSiteAccess : " + upsiteacc.getSiteid().getSiteid());

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-updateSiteAccess");
			impLogger.error(e);
		}
	}

	public void addGenerator(Site_Generator generator) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(generator);
			impLogger.info("Site_Generator : " + generator.getSiteid().getSiteid());

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-addGenerator");
			impLogger.error(e);
		}
	}

	public void addSMPS(Site_SMPS smps) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(smps);
			impLogger.info("Site_SMPS : " + smps.getSiteid().getSiteid());

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-addSMPS");
			impLogger.error(e);
		}
	}

	@SuppressWarnings("unchecked")
	public List<Regions> getRegions() {
		// return sessionFactory.getCurrentSession().createQuery("from
		// Regions").list();
		try {
			return sessionFactory.getCurrentSession().createCriteria(Regions.class)
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getRegions");
			impLogger.error(e);
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<Battery_Bank_Master> getBBManufacturer() {
		// return sessionFactory.getCurrentSession().createQuery("from
		// Regions").list();
		List<Battery_Bank_Master> data_list = null;
		try {
			data_list = sessionFactory.getCurrentSession().createCriteria(Battery_Bank_Master.class)
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();
			return data_list;
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getBBManufacturer");
			impLogger.error(e);
		}
		return data_list;

	}

	@SuppressWarnings("unchecked")
	public List<Cabinet_Master> getCabinetManufacturer() {
		// return sessionFactory.getCurrentSession().createQuery("from
		// Regions").list();
		List<Cabinet_Master> data_list = null;
		try {
			data_list = sessionFactory.getCurrentSession().createCriteria(Cabinet_Master.class)
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();
			return data_list;
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getCabinetManufacturer");
			impLogger.error(e);
		}
		return data_list;
	}

	@SuppressWarnings("unchecked")
	public List<Regions> getStates(String region) {
		// return sessionFactory.getCurrentSession().createQuery("select
		// distinct state from Regions where region='"+region+"'").list();
		List<Regions> data_list = null;
		try {
			data_list = sessionFactory.getCurrentSession().createCriteria(Regions.class)
					.add(Restrictions.eq("region", region)).setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();
			return data_list;
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getStates");
			impLogger.error(e);
		}
		return data_list;
	}

	@SuppressWarnings("unchecked")
	public List<Regions> getDistricts(String region, String state) {
		List<Regions> data_list = null;
		// return sessionFactory.getCurrentSession().createQuery("select region
		// from Regions").list();
		try {
			data_list = sessionFactory.getCurrentSession().createCriteria(Regions.class)
					.add(Restrictions.eq("region", region)).add(Restrictions.eq("state", state))
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();
			return data_list;
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getDistricts");
			impLogger.error(e);
		}
		return data_list;
	}

	@SuppressWarnings("unchecked")
	public List<Regions> getCities(String region, String state, String district) {
		List<Regions> data_list = null;
		try {
			return sessionFactory.getCurrentSession().createCriteria(Regions.class)
					.add(Restrictions.eq("region", region)).add(Restrictions.eq("state", state))
					.add(Restrictions.eq("district", district)).setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
					.list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getCities");
			impLogger.error(e);
		}
		return data_list;

	}

	@SuppressWarnings("unchecked")
	public List<Site> getSiteIdsForRegion(String region, String state, String district, String city) {
		List<Site> data_list = null;
		try {
			return sessionFactory.getCurrentSession().createCriteria(Site.class).add(Restrictions.eq("region", region))
					.add(Restrictions.eq("state", state)).add(Restrictions.eq("district", district))
					.add(Restrictions.eq("city", city)).setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getSiteIdsForRegion");
			impLogger.error(e);
		}
		return data_list;

	}

	@SuppressWarnings("unchecked")
	public String getUserName(String role, String username) {
		Criteria c = sessionFactory.getCurrentSession().createCriteria(User.class);
		List<User> userlist = null;
		try {
			c.add(Restrictions.eq("username", username));
			c.add(Restrictions.eq("role", role));
			userlist = c.list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getUserName");
			impLogger.error(e);
		}
		Integer count = userlist.size();
		if (count != 0) {
			return "Exists";
		} else {
			return "New";
		}

	}

	@SuppressWarnings("unchecked")
	public List<Site> getSiteId() {
		List<Site> data_list = null;

		try {
			data_list = sessionFactory.getCurrentSession()
					.createQuery("select siteid from Site where siteid=(select max(siteid) from Site)").list();
			return data_list;
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getSiteId");
			impLogger.error(e);
		}
		return data_list;

	}

	@SuppressWarnings("unchecked")
	public List<User> getManager(String region) {
		List<User> data_list = null;

		try {
			data_list = sessionFactory.getCurrentSession().createCriteria(User.class)
					.add(Restrictions.eq("region", region)).add(Restrictions.eq("role", "Manager"))
					.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getManager");
			impLogger.error(e);

		}
		return data_list;

	}

	@SuppressWarnings("unchecked")
	public String getManagerId(String managerName) {
		List<User> list = null;
		try {
			list = sessionFactory.getCurrentSession()
					.createQuery("select distinct emailId from User where username='" + managerName + "'").list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getManagerId");
			impLogger.error(e);
		}

		return list.toString();
	}

	@SuppressWarnings("unchecked")
	public List<User> getManagerDetails(String managerId) {
		List<User> list = null;
		try {
			return list = sessionFactory.getCurrentSession().createQuery("from User where username='" + managerId + "'")
					.list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getManagerDetails");
			impLogger.error(e);
		}
		return list;

	}

	@SuppressWarnings("unchecked")
	public List<Ticketing> getTicketId() {
		List<Ticketing> data_list = null;
		try {
			data_list = sessionFactory.getCurrentSession()
					.createQuery("select ticketNum from Ticketing where id=(select max(id) from Ticketing)").list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getTicketId");
			impLogger.error(e);
		}
		return data_list;
	}

	public void addTechnician(Technician technician) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(technician);
			impLogger.info(technician.getTechnicianName() + "Technician Added");
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-addTechnician");
			impLogger.error(e);
		}

	}

	public void addTechnicianIntoUsers(User technician) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(technician);
			impLogger.info(technician.getUsername() + "addTechnicianIntoUsers Added");

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-addTechnicianIntoUsers");
			impLogger.error(e);
		}
	}

	@SuppressWarnings("unchecked")
	public List<Ticketing> openTicketsData() {
		List<Ticketing> data_list = null;

		try {
			data_list = sessionFactory.getCurrentSession().createQuery("FROM Ticketing where ticketStatus='Open'")
					.list();
			return data_list;

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-openTicketsData");
			impLogger.error(e);
		}
		return data_list;
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> assignedTicketsData() {
		List<TechnicianTicketInfo> data_list = null;
		try {
			data_list = sessionFactory.getCurrentSession()
					.createQuery(
							"FROM TechnicianTicketInfo where ticketStatus='Assigned' or ticketStatus='Accepted' or ticketStatus='InProgress'")
					.list();
			return data_list;
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-assignedTicketsData");
			impLogger.error(e);
		}
		return data_list;
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> historyTicketsData() {
		List<TechnicianTicketInfo> data_list = null;

		try {
			data_list = sessionFactory.getCurrentSession()
					.createQuery("FROM TechnicianTicketInfo where ticketStatus='Closed'").list();
			return data_list;
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-historyTicketsData");
			impLogger.error(e);
		}
		return data_list;
	}

	@SuppressWarnings("unchecked")
	public List<Ticketing> getAllTicketsData() {
		List<Ticketing> data_list = null;

		try {
			data_list = sessionFactory.getCurrentSession().createQuery("FROM Ticketing").list();
			return data_list;
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getAllTicketsData");
			impLogger.error(e);
		}
		return data_list;
	}

	@SuppressWarnings("unchecked")
	public List<Technician> getUnassignedTechniciansData(String region, String city) {
		List<Technician> data_list = null;

		try {
			data_list = sessionFactory.getCurrentSession()
					.createQuery("FROM Technician where region='" + region + "' and city ='" + city + "'").list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getUnassignedTechniciansData");
			impLogger.error(e);
		}
		return data_list;

		// return sessionFactory.getCurrentSession().createQuery("FROM Executive
		// where region='"+region+"' and city ='"+city+"' and executiveId NOT IN
		// (SELECT executiveId FROM ExecutiveTicketInfo)").list();

	}

	@SuppressWarnings("unchecked")
	public List<Ticketing> managerOpenTickets(String username, String region, String city) {
		List<Ticketing> data_list = null;

		try {
			data_list = sessionFactory.getCurrentSession()
					.createQuery("from Ticketing where ticketStatus='Open' or ticketStatus='Not Accepted' and region='"
							+ region + "' and city ='" + city + "'")
					.list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getUnassignedTechniciansData");
			impLogger.error(e);
		}
		return data_list;
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> managerClosedTickets(String username) {
		List<TechnicianTicketInfo> data_list = null;
		try {
			data_list = sessionFactory.getCurrentSession()
					.createQuery("from TechnicianTicketInfo where manager='" + username + "' and ticketStatus='Closed'")
					.list();
		} catch (Exception e) {

			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-managerClosedTickets");
			impLogger.error(e);
		}
		return data_list;
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> managerNotAcceptedTickets(String username) {
		List<TechnicianTicketInfo> data_list = null;
		try {
			data_list = sessionFactory.getCurrentSession().createQuery(
					"from TechnicianTicketInfo where manager='" + username + "' and ticketStatus='Not Accepted'")
					.list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-managerNotAcceptedTickets");
			impLogger.error(e);
		}
		return data_list;
	}

	@SuppressWarnings("unchecked")
	public List<Technician> getManagerTechnicians(String username) {
		List<Technician> data_list = null;
		try {
			data_list = sessionFactory.getCurrentSession()
					.createQuery("from Technician where manager='" + username + "'").list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-managerNotAcceptedTickets");
			impLogger.error(e);
		}
		return data_list;
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> techAssignedTicketsData(String username) {
		List<TechnicianTicketInfo> data_list = null;
		try {
			data_list = sessionFactory.getCurrentSession().createQuery(
					"from TechnicianTicketInfo where ticketStatus='Assigned' and technicianId='" + username + "'")
					.list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-managerNotAcceptedTickets");
			impLogger.error(e);
		}
		return data_list;
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> techAcceptedTicketsData(String username) {
		List<TechnicianTicketInfo> data_list = null;
		try {
			data_list = sessionFactory.getCurrentSession().createQuery("from TechnicianTicketInfo where technicianId='"
					+ username + "' and (ticketStatus='Accepted' or ticketStatus='InProgress')").list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-techAcceptedTicketsData");
			impLogger.error(e);
		}

		return data_list;
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> techNotAcceptedTickets(String username) {
		List<TechnicianTicketInfo> data_list = null;
		try {

			data_list = sessionFactory.getCurrentSession().createQuery(
					"from TechnicianTicketInfo where technicianId='" + username + "' and ticketStatus='Not Accepted'")
					.list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-techNotAcceptedTickets");
			impLogger.error(e);
		}
		return data_list;
		// System.out.println("not accepted :
		// "+sessionFactory.getCurrentSession().createQuery("from
		// TechnicianTicketInfo where technicianId='"+username+"' and
		// ticketStatus='Not Accepted'").list());
	}

	@SuppressWarnings("unchecked")
	public List<TechnicianTicketInfo> techClosedTicketsData(String username) {
		List<TechnicianTicketInfo> data_list = null;
		try {
			data_list = sessionFactory.getCurrentSession()
					.createQuery(
							"from TechnicianTicketInfo where ticketStatus='Closed' and technicianId='" + username + "'")
					.list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-techNotAcceptedTickets");
			impLogger.error(e);
		}
		return data_list;
	}

	public String assignTechnician(TechnicianTicketInfo technicianTicket) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(technicianTicket);
			impLogger.info("Ticket assignTechnician" + technicianTicket.getTechnicianName());
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-assignTechnician");
			impLogger.error(e);
		}
		return "Assigned";
	}

	public String updateTicketingStatus(String ticketId, String siteId) {
		try {
			Query q1 = sessionFactory.getCurrentSession()
					.createQuery("from Ticketing where ticketNum ='" + ticketId + "' and siteid='" + siteId + "'");
			Ticketing ticketing = (Ticketing) q1.list().get(0);
			ticketing.setTicketStatus("Assigned");
			sessionFactory.getCurrentSession().update(ticketing);
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-updateTicketingStatus");
			impLogger.error(e);
		}

		// }
		return "Assigned";
	}

	public Technician getTechniciansData(String technicianId) {
		return (Technician) sessionFactory.getCurrentSession().get(Technician.class, technicianId);
	}

	@SuppressWarnings("unchecked")
	public List<Ticketing> getTicketsData(String ticketNum) {
		List<Ticketing> data_list = null;
		try {
			data_list = sessionFactory.getCurrentSession()
					.createQuery("from Ticketing where ticketNum='" + ticketNum + "'").list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getTicketsData");
			impLogger.error(e);
		}
		return data_list;
	}

	public String saveTrackuser(Track_Users trackuser) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(trackuser);
			impLogger.info("saveTrackuser : SurveyDAOImpl-saveTrackuser" + trackuser.getUsername());

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-saveTrackuser");
			impLogger.error(e);
		}
		return "Success";

	}

	@SuppressWarnings("unchecked")
	public List<User> getRoles(String userName) {
		List<User> data_list = null;
		try {
			data_list = sessionFactory.getCurrentSession()
					.createQuery("select role from User where username='" + userName + "'").list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getRoles");
			impLogger.error(e);
		}
		return data_list;
	}

	public String saveTechStatus(String ticketId, String techStatus, String techId, String commentsData,
			String remarksData) {
		try {
			Query q1 = sessionFactory.getCurrentSession()
					.createQuery("from Ticketing where ticketNum ='" + ticketId + "'");
			for (int i = 0; i < q1.list().size(); i++) {
				Ticketing ticketing = (Ticketing) q1.list().get(i);
				ticketing.setTicketStatus(techStatus);
				ticketing.setComments(commentsData);
				ticketing.setRemarks(remarksData);

				sessionFactory.getCurrentSession().update(ticketing);

			}
			Query q2 = sessionFactory.getCurrentSession().createQuery(
					"from TechnicianTicketInfo where ticketNum ='" + ticketId + "' and technicianId='" + techId + "'");

			for (int i = 0; i < q2.list().size(); i++) {
				TechnicianTicketInfo technicianTicketInfo = (TechnicianTicketInfo) q2.list().get(i);

				technicianTicketInfo.setTicketStatus(techStatus);
				technicianTicketInfo.setComments(commentsData);
				technicianTicketInfo.setRemarks(remarksData);
				sessionFactory.getCurrentSession().update(technicianTicketInfo);
			}
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-saveTechStatus");
			impLogger.error(e);
		}

		return techStatus;
	}

	@SuppressWarnings("unchecked")
	public List<Site> getSiteDetails(String siteId) {
		List<Site> data_list = null;
		try {
			data_list = sessionFactory.getCurrentSession().createQuery("from Site where siteid='" + siteId + "'")
					.list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getSiteDetails");
			impLogger.error(e);
		}
		return data_list;

	}

	public void addBB(Site_Battery_Bank BB) {
		System.out.println("DAO BB id" + BB.getId());
		sessionFactory.getCurrentSession().saveOrUpdate(BB);

	}

	public void addCabinet(String updatetype, Site_Cabinet BB) {
		try {
			if (updatetype.split(";")[0].contains("Existing")) {
				BB.setId(Integer.parseInt(updatetype.split(";")[1]));
				sessionFactory.getCurrentSession().saveOrUpdate(BB);
			} else {
				sessionFactory.getCurrentSession().saveOrUpdate(BB);
			}
			impLogger.info("Function : SurveyDAOImpl-addCabinet" + BB.getId() + BB.getSiteid().getSiteid());

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-addCabinet");
			impLogger.error(e);
		}

	}

	@SuppressWarnings("unchecked")
	public List<Site_Battery_Bank> getBB(String Siteid) {
		Criteria c = sessionFactory.getCurrentSession().createCriteria(Site_Battery_Bank.class);
		List<Site_Battery_Bank> userlist = null;
		try {
			Site s = new Site();
			s.setSiteid(Siteid);
			c.add(Restrictions.eq("siteid", s));
			userlist = c.list();
			impLogger.info(
					"List From getBB" + userlist.get(0).getId() + "SiteID" + userlist.get(0).getSiteid().getSiteid());

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getBB");
			impLogger.error(e);
		}

		return userlist;
	}

	@SuppressWarnings("unchecked")
	public List<Site_Cabinet> getCabinet(String Siteid) {
		Criteria c = sessionFactory.getCurrentSession().createCriteria(Site_Cabinet.class);
		List<Site_Cabinet> userlist = null;
		try {
			Site s = new Site();
			s.setSiteid(Siteid);
			c.add(Restrictions.eq("siteid", s));
			userlist = c.list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.info("Function : SurveyDAOImpl-getCabinet");
			impLogger.error(e);
		}

		return userlist;
	}

	@SuppressWarnings("unchecked")
	public List<Site_SMPS> getSMPSDetails(String siteId) {
		List<Site_SMPS> userlist = null;

		try {
			userlist = sessionFactory.getCurrentSession().createQuery("from Site_SMPS where siteid='" + siteId + "'")
					.list();
			impLogger.info("Function : SurveyDAOImpl-getSMPSDetails Executed for" + siteId);

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-getSMPSDetails");
			impLogger.error(e);
		}
		return userlist;
	}

	@SuppressWarnings("unchecked")
	public List<Site_Generator> getGeneratorDetails(String siteId) {
		List<Site_Generator> userlist = null;
		try {
			userlist = sessionFactory.getCurrentSession()
					.createQuery("from Site_Generator where siteid='" + siteId + "'").list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-getGeneratorDetails");
			impLogger.error(e);
		}
		return userlist;
	}

	@SuppressWarnings("unchecked")
	public List<Ticketing> getCustomerlist() {
		List<Ticketing> userlist = null;
		try {
			userlist = sessionFactory.getCurrentSession().createQuery("from Ticketing").list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-getGeneratorDetails");
			impLogger.error(e);

		}
		return userlist;
	}

	@Override
	public void updateSiteDetails(String state, String siteId, String lati, String longi) {
		try {
			Query q1 = sessionFactory.getCurrentSession().createQuery("from Site where siteid ='" + siteId + "'");

			Site siteData = (Site) q1.list().get(0);

			siteData.setState(state);
			siteData.setLatitude(lati);
			siteData.setLongitude(longi);

			sessionFactory.getCurrentSession().update(siteData);
			impLogger.info("updateSiteDetails executed for" + siteId);

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-getGeneratorDetails");
			impLogger.error(e);

		}

	}

	@Override
	public void addSiteSurveyPPE(Survey_Team_PPE surveyTeamPPE) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(surveyTeamPPE);
			impLogger.info("Survey_Team_PPE added/updated for" + surveyTeamPPE.getSiteid().getSiteid());

		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Survey_Team_PPE> getSurveyTeamDetails(String selectedSiteId) {
		List<Survey_Team_PPE> Datalist = null;
		try {
			Datalist = sessionFactory.getCurrentSession()
					.createQuery("from Survey_Team_PPE where siteid='" + selectedSiteId + "'").list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-getSurveyTeamDetails");
			impLogger.error(e);

		}
		return Datalist;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TechnicianTicketInfo> managerAssignedTickets(String username) {
		List<TechnicianTicketInfo> Datalist = null;
		try {
			Datalist = sessionFactory.getCurrentSession()
					.createQuery("from TechnicianTicketInfo where manager='" + username
							+ "' and (ticketStatus='Assigned' or ticketStatus='Accepted' or ticketStatus='InProgress')")
					.list();

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-managerAssignedTickets");
			impLogger.error(e);
		}
		return Datalist;
	}

	@Override
	public String updateSiteStatus(String siteId, String ticketId) {

		try {
			Query q1 = sessionFactory.getCurrentSession()
					.createQuery("from Ticketing where siteid ='" + siteId + "' and ticketNum='" + ticketId + "'");

			for (int i = 0; i < q1.list().size(); i++) {
				Ticketing ticket = (Ticketing) q1.list().get(i);

				ticket.setTicketStatus("InProgress");
				ticket.setSurveyStatus("InProgress");

				sessionFactory.getCurrentSession().update(ticket);
			}

			Query q2 = sessionFactory.getCurrentSession().createQuery(
					"from TechnicianTicketInfo where siteid ='" + siteId + "' and ticketNum='" + ticketId + "'");

			for (int i = 0; i < q2.list().size(); i++) {
				TechnicianTicketInfo ticketInfo = (TechnicianTicketInfo) q2.list().get(i);

				ticketInfo.setTicketStatus("InProgress");
				ticketInfo.setSurveyStatus("InProgress");

				sessionFactory.getCurrentSession().update(ticketInfo);
			}
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-updateSiteStatus");
			impLogger.error(e);
		}

		return "Updated";
	}

	public String saveTowerInstallation(Tower_Installation tower) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(tower);
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-saveTowerInstallation");
			impLogger.error(e);

		}
		return "Saved";

	}

	public String storeSitesecurity(Site_Security ss) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(ss);
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-storeSitesecurity");
			impLogger.error(e);
		}
		return "Saved";
	}

	public String storeSiteSafety(Site_Safety sf) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(sf);

		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-storeSiteSafety");
			impLogger.error(e);
		}
		return "Saved";
	}

	public String storeSiteAdditional(Site_Additional_Notes sa) {
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(sa);
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-storeSiteAdditional");
			impLogger.error(e);
		}
		return "Saved";
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Tower_Installation> fetchTowerDetails(String siteid) {
		List<Tower_Installation> Datalist = null;

		try {
			Datalist = sessionFactory.getCurrentSession()
					.createQuery("from Tower_Installation  where siteid ='" + siteid + "'").list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-fetchTowerDetails");
			impLogger.error(e);
		}
		return Datalist;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Site_Security> getSecurityDetails(String siteId) {
		List<Site_Security> Datalist = null;
		try {
			Datalist = sessionFactory.getCurrentSession()
					.createQuery("from Site_Security where siteid='" + siteId + "'").list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-fetchTowerDetails");
			impLogger.error(e);
		}
		return Datalist;
	}

	@SuppressWarnings("unchecked")
	public List<Site_Safety> getSafetyDetails(String siteId) {
		List<Site_Safety> Datalist = null;
		try {
			Datalist = sessionFactory.getCurrentSession().createQuery("from Site_Safety where siteid='" + siteId + "'")
					.list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-getSafetyDetails");
			impLogger.error(e);
		}
		return Datalist;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Site_Additional_Notes> getSiteAddDetails(String siteId) {
		List<Site_Additional_Notes> Datalist = null;
		try {
			Datalist = sessionFactory.getCurrentSession()
					.createQuery("from Site_Additional_Notes where siteid='" + siteId + "'").list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-getSiteAddDetails");
			impLogger.error(e);
		}
		return Datalist;
	}

	@SuppressWarnings("unchecked")
	public List<Site_Access> getSiteAccDetails(String siteId) {
		List<Site_Access> Datalist = null;
		try {
			Datalist = sessionFactory.getCurrentSession().createQuery("from Site_Access where siteid='" + siteId + "'")
					.list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-getSiteAccDetails");
			impLogger.error(e);
		}
		return Datalist;
	}

	@SuppressWarnings("unchecked")
	public List<Site_Area> getSiteArDetails(String siteId) {
		List<Site_Area> Datalist = null;
		try {
			Datalist = sessionFactory.getCurrentSession().createQuery("from Site_Area where siteid='" + siteId + "'")
					.list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-getSiteAccDetails");
			impLogger.error(e);
		}
		return Datalist;

	}

	@SuppressWarnings("unchecked")
	public List<Site_Wiring> getPowerWiringDetails(String siteId) {
		List<Site_Wiring> Datalist = null;
		try {
			Datalist = sessionFactory.getCurrentSession().createQuery("from Site_Wiring where siteid='" + siteId + "'")
					.list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-getPowerWiringDetails");
			impLogger.error(e);
		}
		return Datalist;
	}

	@Override
	public String updateClosedSurveyStatus(String ticketId, String siteId) {
		// System.out.println("TICKET "+ticketId);

		// Calendar cal = Calendar.getInstance();
		try {
			Query q = sessionFactory.getCurrentSession().createQuery(
					"from TechnicianTicketInfo where siteid ='" + siteId + "' and ticketNum='" + ticketId + "'");
			TechnicianTicketInfo technicianTicket = (TechnicianTicketInfo) q.list().get(0);

			technicianTicket.setSurveyStatus("Completed");
			// technicianTicket.setClosedDate(cal.getTime());
			// technicianTicket.setClosedTime(cal.getTime());

			sessionFactory.getCurrentSession().update(technicianTicket);

			Query q1 = sessionFactory.getCurrentSession()
					.createQuery("from Ticketing where ticketNum ='" + ticketId + "' and siteid ='" + siteId + "'");
			Ticketing ticketing = (Ticketing) q1.list().get(0);

			ticketing.setSurveyStatus("Completed");
			// ticketing.setClosedDate(cal.getTime());
			// ticketing.setClosedTime(cal.getTime());

			sessionFactory.getCurrentSession().update(ticketing);

			List<Ticketing> statusList = sessionFactory.getCurrentSession()
					.createQuery("from Ticketing where ticketNum ='" + ticketId + "'").list();
			System.out.println("statusList " + statusList);
			int count = 0, siteCount = 0;
			siteCount = statusList.get(0).getSiteids().split(",").length;
			System.out.println("SiteCOUNT" + siteCount);
			for (int i = 0; i < statusList.size(); i++) {
				System.out.println("czsf" + statusList.get(i).getSurveyStatus());
				if (statusList.get(i).getSurveyStatus().equalsIgnoreCase("Completed")) {
					System.out.println("CoutnVal1" + count);
					count = count + 1;
					System.out.println("CoutnVal2" + count);
				}
			}

			System.out.println("COUNT" + count);
			if (count == siteCount) {
				Query q2 = sessionFactory.getCurrentSession()
						.createQuery("from TechnicianTicketInfo where ticketNum='" + ticketId + "'");
				for (int j = 0; j < q2.list().size(); j++) {
					TechnicianTicketInfo technicianTicket1 = (TechnicianTicketInfo) q2.list().get(j);

					technicianTicket1.setSurveyStatus("Closed");

					sessionFactory.getCurrentSession().update(technicianTicket1);
				}

				Query q3 = sessionFactory.getCurrentSession()
						.createQuery("from Ticketing where ticketNum ='" + ticketId + "'");

				for (int j = 0; j < q3.list().size(); j++) {
					Ticketing ticketing1 = (Ticketing) q3.list().get(j);
					ticketing1.setSurveyStatus("Closed");

					sessionFactory.getCurrentSession().update(ticketing1);
				}

			}
		} catch (Exception e) {
			System.out.println(e);
		}

		return "Updated";

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Site> ValidateLatLong(String latitude, String longitude) {
		Criteria c = sessionFactory.getCurrentSession().createCriteria(Site.class);
		try {
			c.add(Restrictions.eq("latitude", latitude));
			c.add(Restrictions.eq("longitude", longitude));
			return c.list();
		} catch (Exception e) {
			// TODO: handle exception
			impLogger.error("Function : SurveyDAOImpl-ValidateLatLong");
			impLogger.error(e);
		}
		return c.list();
	}

	@Override
	public String updateClosedStatus(String ticketId) {

		Calendar cal = Calendar.getInstance();
		try {
			Query q = sessionFactory.getCurrentSession()
					.createQuery("from TechnicianTicketInfo where ticketNum='" + ticketId + "'");

			for (int i = 0; i < q.list().size(); i++) {
				TechnicianTicketInfo technicianTicket = (TechnicianTicketInfo) q.list().get(i);

				technicianTicket.setTicketStatus("Closed");
				technicianTicket.setClosedDate(cal.getTime());
				technicianTicket.setClosedTime(cal.getTime());

				sessionFactory.getCurrentSession().update(technicianTicket);
			}

			Query q1 = sessionFactory.getCurrentSession()
					.createQuery("from Ticketing where ticketNum ='" + ticketId + "'");

			for (int i = 0; i < q1.list().size(); i++) {
				Ticketing ticketing = (Ticketing) q1.list().get(i);

				ticketing.setTicketStatus("Closed");
				ticketing.setClosedDate(cal.getTime());
				ticketing.setClosedTime(cal.getTime());

				sessionFactory.getCurrentSession().update(ticketing);
			}
		} catch (Exception e) {
			impLogger.info("Function : SurveyDAOImpl-updateClosedStatus");
			impLogger.error(e);
		}

		return "Updated";

	}

}
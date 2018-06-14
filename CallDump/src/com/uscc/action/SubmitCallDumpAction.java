package com.uscc.action;

import com.uscc.dao.*;
import com.uscc.rules.CallDumpRules;
import com.uscc.CallDump.Utils;
import com.uscc.beans.*;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

public class SubmitCallDumpAction extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		int rc = 0;

		ServletContext application = servlet.getServletContext();
		CallDumpDAO myCallDumpDAO = (CallDumpDAO) application
				.getAttribute("calldumpdaokey");

		UserDAO myUserDAO = (UserDAO) application.getAttribute("userdaokey");

		Developer submitter = myUserDAO.getUser(request.getRemoteUser());

		// Start Date of Call Dump Period
		CallDumpRequest cdreq = new CallDumpRequest();

		cdreq.setPriority(Integer.parseInt(submitter.getUserpriority()));

		// CSR CallDump
		if (request.isUserInRole("csr")) {

			// CTN
			String ctn = request.getParameter("ctn");
			try {
				Long.parseLong(ctn);
			} catch (Exception e) {
				request.setAttribute("errormsg", "Invalid Phone Number");
				return mapping.findForward("error");
			}
			if (ctn.length() != 10) {
				request.setAttribute("errormsg", "Invalid Phone Number");
				return mapping.findForward("error");
			}

			cdreq.setSearchString1(ctn);

			String market = myCallDumpDAO.getCallDumpDestination(ctn);
			if (market.equalsIgnoreCase("Unknown")) {
				request.setAttribute("errormsg", "NON-USCC CTN");
				return mapping.findForward("error");
			}
			int index = Integer.parseInt(market.substring(2, 3));
			String vswitchid = market + "ALLV";
			String dswitchid = market + "ALLD";

			switch (index) {
			case 1:
				cdreq.setSwitchesM01(vswitchid + "," + dswitchid);
				break;
			case 2:
				cdreq.setSwitchesM02(vswitchid + "," + dswitchid);
				break;
			case 3:
				cdreq.setSwitchesM03(vswitchid + "," + dswitchid);
				break;
			case 4:
				cdreq.setSwitchesM04(vswitchid + "," + dswitchid);
				break;
			case 5:
				cdreq.setSwitchesM05(vswitchid + "," + dswitchid);
				break;
			case 6:
				cdreq.setSwitchesM06(vswitchid + "," + dswitchid);
				break;
			}

			// String billcycle = request.getParameter("billcycle");
			// String month = request.getParameter("startmonth");

			// Start Date
			// String curtime = USCCDate.getSysDateTime();
			// String curyear = curtime.substring(0,4);
			// String curmonth = curtime.substring(4,6);

			// String year = curyear;

			// if ( Integer.parseInt(month) > Integer.parseInt(curmonth)) {
			// year = Integer.toString(Integer.parseInt(curyear) - 1);
			// }
			// cdreq.setStartDate(year + month + billcycle + "000000");
			// cdreq.setEndDate(USCCDate.getAdjustedDateTime(cdreq.getStartDate(),
			// Calendar.MONTH, 1));

			// End Date

		}
		
		String startdate = request.getParameter("startyear");
		startdate += Utils.PadStringBefore(request.getParameter("startmonth"), 2, "0");
		startdate += Utils.PadStringBefore(request.getParameter("startday"), 2, "0");
		startdate += Utils.PadStringBefore(request.getParameter("starthour"), 2, "0");
		startdate += request.getParameter("startmin") + "00";
		cdreq.setStartDate(startdate);
		
		String enddate = request.getParameter("endyear");
		enddate += Utils.PadStringBefore(request.getParameter("endmonth"), 2, "0");
		enddate += Utils.PadStringBefore(request.getParameter("endday"), 2, "0");
		enddate += Utils.PadStringBefore(request.getParameter("endhour"), 2, "0");
		enddate += request.getParameter("endmin") + "00";
		cdreq.setEndDate(enddate);
/*
 * Calendar sCAL = Calendar.getInstance(); sCAL.set(Calendar.YEAR,
 * Integer.parseInt(request .getParameter("startyear")));
 * sCAL.set(Calendar.MONTH, Integer.parseInt(request
 * .getParameter("startmonth")) - 1); sCAL.set(Calendar.DAY_OF_MONTH,
 * Integer.parseInt(request .getParameter("startday")));
 * sCAL.set(Calendar.HOUR_OF_DAY, Integer.parseInt(request
 * .getParameter("starthour"))); sCAL.set(Calendar.MINUTE,
 * Integer.parseInt(request .getParameter("startmin")));
 * sCAL.set(Calendar.SECOND, 0); sCAL.setLenient(false); // End Date of Call
 * Dump Period Calendar eCAL = Calendar.getInstance(); eCAL.set(Calendar.YEAR,
 * Integer.parseInt(request .getParameter("endyear"))); eCAL.set(Calendar.MONTH,
 * Integer.parseInt(request .getParameter("endmonth")) - 1);
 * eCAL.set(Calendar.DAY_OF_MONTH, Integer.parseInt(request
 * .getParameter("endday"))); eCAL.set(Calendar.HOUR_OF_DAY,
 * Integer.parseInt(request .getParameter("endhour")));
 * eCAL.set(Calendar.MINUTE, Integer.parseInt(request .getParameter("endmin")));
 * eCAL.set(Calendar.SECOND, 0); eCAL.setLenient(false);
 * 
 * 
 * try { DateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); DateFormat edf =
 * new SimpleDateFormat("yyyyMMddHHmmss");
 * cdreq.setStartDate(sdf.format(sCAL.getTime()));
 * cdreq.setEndDate(edf.format(eCAL.getTime()));
 * sdf.parse(cdreq.getStartDate()); edf.parse(cdreq.getStartDate()); } catch
 * (Exception e) { request.setAttribute("errormsg", myCallDumpDAO
 * .getErrorMessage(CallDumpDAO.INVALID_DATE)); return
 * mapping.findForward("error"); }
 */
		// NON-CSR CallDump
		if (!request.isUserInRole("csr")) {

			Enumeration<?> keys = request.getParameterNames();
			while (keys.hasMoreElements()) {
				Object el = keys.nextElement();
				String key = null;
				String keybase = null;

				key = (String) el;
				String formvalue = request.getParameter((String) el);

				if (!((key.startsWith("start")) || (key.startsWith("end")) || (key
						.startsWith("select")))) {

					// Get the field name without the number
					keybase = key.substring(0, key.length() - 1);

					int index = Integer.parseInt(key.substring(
							key.length() - 1, key.length()));
					if (key.equalsIgnoreCase("selectedsearchlist")) {
						System.out.println("Select list");
					} else if (keybase.equalsIgnoreCase("text")) {
						switch (index) {
						case 1:
							cdreq.setSearchString1(formvalue);
							break;
						case 2:
							cdreq.setSearchString2(formvalue);
							break;
						case 3:
							cdreq.setSearchString3(formvalue);
							break;
						case 4:
							cdreq.setSearchString4(formvalue);
							break;
						case 5:
							cdreq.setSearchString5(formvalue);
							break;
						case 6:
							cdreq.setSearchString6(formvalue);
							break;
						}
					} else {
						switch (index) {
						case 1:
							cdreq.setSearchStringType1(cdreq
									.getSearchStringType1()
									+ "," + keybase.toUpperCase());
							break;
						case 2:
							cdreq.setSearchStringType2(cdreq
									.getSearchStringType2()
									+ "," + keybase.toUpperCase());
							break;
						case 3:
							cdreq.setSearchStringType3(cdreq
									.getSearchStringType3()
									+ "," + keybase.toUpperCase());
							break;
						case 4:
							cdreq.setSearchStringType4(cdreq
									.getSearchStringType4()
									+ "," + keybase.toUpperCase());
							break;
						case 5:
							cdreq.setSearchStringType5(cdreq
									.getSearchStringType5()
									+ "," + keybase.toUpperCase());
							break;
						case 6:
							cdreq.setSearchStringType6(cdreq
									.getSearchStringType6()
									+ "," + keybase.toUpperCase());
							break;
						}
					}
				}

			}

			String[] values = request.getParameterValues("selectswitchlist");
			if (values != null) {
				for (int i = 0; i < values.length; i++) {
					String choice = values[i];
					int index = Integer.parseInt(choice.substring(2, 3));
					String switchid = myCallDumpDAO.cvttoSwitchAbbrev(choice);
					switch (index) {
					case 1:
						cdreq.setSwitchesM01(cdreq.getSwitchesM01() + ","
								+ switchid);
						break;
					case 2:
						cdreq.setSwitchesM02(cdreq.getSwitchesM02() + ","
								+ switchid);
						break;
					case 3:
						cdreq.setSwitchesM03(cdreq.getSwitchesM03() + ","
								+ switchid);
						break;
					case 4:
						cdreq.setSwitchesM04(cdreq.getSwitchesM04() + ","
								+ switchid);
						break;
					case 5:
						cdreq.setSwitchesM05(cdreq.getSwitchesM05() + ","
								+ switchid);
						break;
					case 6:
						cdreq.setSwitchesM06(cdreq.getSwitchesM06() + ","
								+ switchid);
						break;
					}
				}
			}
		}
		cdreq.setUserid(request.getRemoteUser());
		CallDumpRules rlz = new CallDumpRules();
		rc = rlz.isRequestValid(cdreq);
		if (rc!=CallDumpDAO.VALID_REQUEST) {
			request.setAttribute("errormsg", myCallDumpDAO.getErrorMessage(rc)); 
			return mapping.findForward("error"); 
		} 
		
		try {
			rc = myCallDumpDAO.submitCallDumpRequest(cdreq);
			if (rc != 0) {
				request.setAttribute("errormsg", myCallDumpDAO
						.getErrorMessage(rc));
				return mapping.findForward("error");
			}
		} catch (DAOException e) {
			request.setAttribute("errormsg", myCallDumpDAO.getErrorMessage(rc));
			return mapping.findForward("error");
		}
		return mapping.findForward("success");
	}
}

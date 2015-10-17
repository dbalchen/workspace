package com.uscc.action;

import com.uscc.beans.SwitchEntry;
import com.uscc.beans.CallDumpDate;
import com.uscc.dao.*;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import java.util.List;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShowCallDumpSubmitAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ServletContext application = servlet.getServletContext();
		UserDAO myUserDAO = (UserDAO) application.getAttribute("userdaokey");
		if (myUserDAO.isPassWordExpired(request.getRemoteUser())) {
			return mapping.findForward("passwordexpired");
		}
		CallDumpDAO myCallDumpDAO = (CallDumpDAO) application
				.getAttribute("calldumpdaokey");
		List<SwitchEntry> switches = myCallDumpDAO.getSwitches();

		Calendar CAL = Calendar.getInstance();
		List<CallDumpDate> years = new ArrayList<CallDumpDate>();
                
		years.add(new CallDumpDate(Integer.toString(CAL.get(Calendar.YEAR) - 1)));
		years.add(new CallDumpDate(Integer.toString(CAL.get(Calendar.YEAR))));

		List<String> mins = new ArrayList<String>();
		mins.add("00");
		mins.add("15");
		mins.add("30");
		mins.add("45");
		mins.add("59");

		List<String> months = new ArrayList<String>();
		months.add("Jan");
		months.add("Feb");
		months.add("Mar");
		months.add("Apr");
		months.add("May");
		months.add("June");
		months.add("July");
		months.add("Aug");
		months.add("Sept");
		months.add("Oct");
		months.add("Nov");
		months.add("Dec");

		List<String> days = new ArrayList<String>();
		for (int i = 1; i <= 31; i++) {
			days.add(Integer.toString(i));
		}

		List<String> hours = new ArrayList<String>();
		for (int i = 0; i <= 23; i++) {
			hours.add(Integer.toString(i));
		}

		// Set the categories as an attribute in the "request" object
		request.setAttribute("switcheskey", switches);
		request.setAttribute("yearskey", years);
		request.setAttribute("monthskey", months);
		request.setAttribute("dayskey", days);
		request.setAttribute("hourskey", hours);
		request.setAttribute("minskey", mins);

                if (request.isUserInRole("csr")) {
		   return mapping.findForward("csrsuccess");
                } else {

    		   // Dispatch/forward the request to the view
    		   return mapping.findForward("success");
                }
	}
}

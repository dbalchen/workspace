package com.uscc.action;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.DynaActionForm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletContext;

import com.uscc.dao.*;
import com.uscc.beans.*;

public class SendPasswordReminderAction extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// get a reference to the MusicDAO from the servlet context
		ServletContext application = servlet.getServletContext();
		UserDAO myUserDAO = (UserDAO) application.getAttribute("userdaokey");

		// Get the params from the user form
		DynaActionForm myForm = (DynaActionForm) form;
		String user = (String) myForm.get("user");

		Developer dev = myUserDAO.getUser(user);
		try {
			com.uscc.utils.UsccMail.sendMessage("fortress-2.uscc.com",
					"scmmgr@chi1pbs1.uscc.com", dev.getEmailAddress(),
					"DataServices Build Management System Password Reminder",
					"Your password is: " + dev.getPassword());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		// Dispatch/forward the request to the view
		return mapping.findForward("success");
	}
}

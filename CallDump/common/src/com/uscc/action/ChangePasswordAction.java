package com.uscc.action;

import com.uscc.dao.*;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ChangePasswordAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ServletContext application = servlet.getServletContext();

		UserDAO myUserDAO = (UserDAO) application.getAttribute("userdaokey");

		int success = myUserDAO.changePassword(request.getParameter("user"),
				request.getParameter("old_password"), request
						.getParameter("new_password"), request
						.getParameter("confirm_new_password"));
		if (success == 0) {
			return mapping.findForward("success");
		} else {
			if (success == 1) {
				request.setAttribute("message",
						"Old password entered was incorrect");
			} else if (success == 2) {
				request.setAttribute("message",
						"New password was not successfully confirmed");
			} else if (success == 3) {
				request
						.setAttribute("message",
								"New password is the same as previously used password.");
			} else if (success == 4) {
				request
						.setAttribute("message",
								"New password does not conform to USCC password standards.");
			} else {
				request
						.setAttribute("message",
								"Internal error resetting password, please try again later");
			}
			return mapping.findForward("failure");
		}
	}
}

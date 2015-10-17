package com.uscc.action;

import com.uscc.dao.*;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CheckPasswordStatusAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ServletContext application = servlet.getServletContext();

		UserDAO myUserDAO = (UserDAO) application.getAttribute("userdaokey");

		boolean expired = myUserDAO.getPasswordExpired(request
				.getParameter("user"));

		if (expired) {
			request.setAttribute("message", "Password is Expired");

			return mapping.findForward("expired");
		} else {
			request.setAttribute("message", "Password incorrect");

			return mapping.findForward("notexpired");
		}
	}
}

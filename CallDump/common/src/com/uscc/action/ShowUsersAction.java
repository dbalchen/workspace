package com.uscc.action;

import com.uscc.beans.Developer;
import com.uscc.dao.*;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShowUsersAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ServletContext application = servlet.getServletContext();
		UserDAO myUserDAO = (UserDAO) application.getAttribute("userdaokey");
        
        List<Developer> users = myUserDAO.getAllUsers(application.getServletContextName());

		// Set the categories as an attribute in the "request" object
		request.setAttribute("userskey", users);

		// Dispatch/forward the request to the view
		return mapping.findForward("success");
	}
}

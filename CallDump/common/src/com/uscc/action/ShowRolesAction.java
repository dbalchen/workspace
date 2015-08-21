package com.uscc.action;

import com.uscc.beans.Role;
import com.uscc.dao.*;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShowRolesAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ServletContext application = servlet.getServletContext();
		UserDAO myUserDAO = (UserDAO) application.getAttribute("userdaokey");
		if (myUserDAO.isPassWordExpired(request.getRemoteUser())) {
			return mapping.findForward("passwordexpired");
		}
        String app = request.getParameter("app");
        if (app==null) {
            app="all"; 
        }
		List<Role> roles = myUserDAO.getRoles(app);

		// Set the categories as an attribute in the "request" object
		request.setAttribute("rolekey", roles);

		// Dispatch/forward the request to the view
		return mapping.findForward("success");
	}
}

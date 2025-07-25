package com.uscc.action;

import com.uscc.dao.*;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import javax.servlet.http.HttpSession;

public class LowerPriorityAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ServletContext application = servlet.getServletContext();

		CallDumpDAO myCallDumpDAO = (CallDumpDAO) application
				.getAttribute("calldumpdaokey");
		myCallDumpDAO.lowerPriority(Integer
				.parseInt(request.getParameter("id")));

		// Dispatch/forward the request to the view
		return mapping.findForward("success");
	}
}

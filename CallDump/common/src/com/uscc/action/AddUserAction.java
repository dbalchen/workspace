package com.uscc.action;

import com.uscc.dao.*;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddUserAction extends Action {
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        try {

            ServletContext application = servlet.getServletContext();
            UserDAO myUserDAO = (UserDAO) application
                    .getAttribute("userdaokey");
            myUserDAO.addUser(request.getParameter("user"), request
                            .getParameter("firstname"), request
                            .getParameter("lastname"), request
                            .getParameter("emailaddress"), request
                            .getParameter("role"), request
                            .getParameter("userpriority"),request
                            .getParameter("phone"));
        } catch (DAOException exp) {
            if (exp.getMessage().equalsIgnoreCase("Missing Data")) {
                return mapping.findForward("missingdata");
            }
            return mapping.findForward("duplicate");
        }

        // Dispatch/forward the request to the view
        return mapping.findForward("success");
    }
}

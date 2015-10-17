package com.uscc.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.uscc.dao.UserDAO;

public class RemoveUserRoleAction extends Action {
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        ServletContext application = servlet.getServletContext();
        UserDAO myUserDAO = (UserDAO) application.getAttribute("userdaokey");
        if (myUserDAO.isPassWordExpired(request.getRemoteUser())) {
            return mapping.findForward("passwordexpired");
        }
        
        myUserDAO.removeUserRole(request.getParameter("user"), request.getParameter("role"));
        // Dispatch/forward the request to the view
        return mapping.findForward("success");        
    }
}

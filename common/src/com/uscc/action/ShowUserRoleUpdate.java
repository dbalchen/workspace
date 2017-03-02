package com.uscc.action;

import java.util.List;

import com.uscc.beans.Role;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.uscc.dao.UserDAO;

public class ShowUserRoleUpdate extends Action {
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        ServletContext application = servlet.getServletContext();
        UserDAO myUserDAO = (UserDAO) application.getAttribute("userdaokey");
        if (myUserDAO.isPassWordExpired(request.getRemoteUser())) {
            return mapping.findForward("passwordexpired");
        }
        List<Role> curroles = myUserDAO.getRolesbyUser(request.getParameter("user"),application.getServletContextName());
        List<Role> availroles = myUserDAO.getRoleNotAssignedtoUser(request.getParameter("user"),application.getServletContextName());

        for (int i=0;i<curroles.size();i++) {
            Role rl = (Role)curroles.get(i);
            System.out.println("Current Role: " + rl.getRoleName());
        }
        for (int i=0;i<availroles.size();i++) {
            Role rl = (Role)availroles.get(i);
            System.out.println("Available Role: " + rl.getRoleName());
        }


        // Set the categories as an attribute in the "request" object
        request.setAttribute("availablerolekey", availroles);
        request.setAttribute("curroleskey", curroles);
        request.setAttribute("userkey", request.getParameter("user"));
        
        // Dispatch/forward the request to the view
        return mapping.findForward("success");        
    }
}

package com.uscc.action;

import com.uscc.beans.CallDumpRequest;
import com.uscc.beans.Navigation;
import com.uscc.dao.*;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShowCallDumpRequestsAction extends Action {
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int start_rec = 1;
        int end_rec = 5;
        int max_to_show = 5;
        int numcalldumprequests = 0;
        String prevstart = null;
        String prevend = null;
        String nextstart = null;
        String nextend = null;

        ServletContext application = servlet.getServletContext();
        UserDAO myUserDAO = (UserDAO) application.getAttribute("userdaokey");
        if (myUserDAO.isPassWordExpired(request.getRemoteUser())) {
            return mapping.findForward("passwordexpired");
        }
        CallDumpDAO myCallDumpDAO = (CallDumpDAO) application
                .getAttribute("calldumpdaokey");

        String status = (String) request.getParameter("status");

        String strt = (String) request.getParameter("start");
        String endt = (String) request.getParameter("end");
        String restrict = (String) request.getParameter("restrict");
        String timeframe = (String) request.getParameter("timeframe");

        if (timeframe == null) {
            timeframe = "99999";
        }
        if (restrict == null) {
            restrict = "none";
        } else if (restrict.equalsIgnoreCase("user")) {
            restrict = request.getRemoteUser();
        }
        if (strt != null) {
            start_rec = Integer.parseInt(strt);
        }
        if (endt != null) {
            end_rec = Integer.parseInt(endt);
        }
        List<CallDumpRequest> calldumprequests = myCallDumpDAO.getCallDumpRequests(status,
                start_rec, end_rec, request.isUserInRole("admin"), restrict,
                timeframe);

        Navigation nav = new Navigation();
        if ((start_rec - max_to_show) > 0) {
            prevstart = Integer.toString(start_rec - max_to_show);
            prevend = Integer.toString(start_rec - 1);
            request.setAttribute("prevstartkey", prevstart);
            request.setAttribute("prevendkey", prevend);

        }

        numcalldumprequests = myCallDumpDAO.getNumCallDumpRequests(status,
                restrict, timeframe);
        if (end_rec < numcalldumprequests) {
            nextstart = Integer.toString(end_rec + 1);
            nextend = Integer.toString(end_rec + max_to_show);
            if ((end_rec + max_to_show) > numcalldumprequests) {
                nextend = Integer.toString(numcalldumprequests);
            }
            request.setAttribute("nextstartkey", nextstart);
            request.setAttribute("nextendkey", nextend);
        }
        nav.setNextstartkey(nextstart);
        nav.setNextendkey(nextend);
        nav.setPrevstartkey(prevstart);
        nav.setPrevendkey(prevend);
        nav.setStatus(status);
        nav.setTimeframe(timeframe);
        nav.setRestrict(restrict);

        request.setAttribute("timeframe", timeframe);
        request.setAttribute("restrict", restrict);

        ArrayList<Navigation> navparams = new ArrayList<Navigation>();
        navparams.add(nav);

        // Set the categories as an attribute in the "request" object
        request.setAttribute("calldumpkey", calldumprequests);
        request.setAttribute("navkey", navparams);

        // Dispatch/forward the request to the view
        return mapping.findForward("success");
    }
}

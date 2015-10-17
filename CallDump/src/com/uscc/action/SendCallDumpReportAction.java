package com.uscc.action;

import com.uscc.beans.CallDumpReport;
import com.uscc.dao.*;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.uscc.utils.FileUtils;
public class SendCallDumpReportAction extends Action {
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        ServletContext application = servlet.getServletContext();

        CallDumpDAO myCallDumpDAO = (CallDumpDAO) application
        .getAttribute("calldumpdaokey");
        UserDAO myUserDAO = (UserDAO) application.getAttribute("userdaokey");

        int id = Integer.parseInt(request.getParameter("id"));
        List<CallDumpReport> rpts = myCallDumpDAO.getCallDumpReports(id);
        String [] reports=null;
        try {
            String tmpdir = System.getProperty("java.io.tmpdir");
            FileUtils utils = new FileUtils();
            reports = utils.getFiles(rpts,tmpdir);
            /*for (int i = 0; i < rpts.size(); i++) {
				reports[i] = (String) rpts.get(i);
			}*/
            com.uscc.utils.UsccMail.sendMessageAttach("fortress-2.uscc.com",
                    "scmmgr@chi1pbs1.uscc.com", myUserDAO.getUser(
                            request.getRemoteUser()).getEmailAddress(),
                            "No Reply: CallDump Reports for id " + id,
                            "PLEASE DO NOT REPLY TO THIS EMAIL!!!", reports);

            // Cleanup the report files
            for (int i = 0; i < reports.length; i++) {
                File filetodelete = new File (reports[i]);
                filetodelete.delete();
            }

        } catch (Exception e) {
            System.out.println("Hit Exception emailing reports: "
                    + e.getMessage());
            System.out.println("User: " + request.getRemoteUser());
            System.out.println("Email: " + myUserDAO.getUser(request.getRemoteUser()).getEmailAddress());
            System.out.println("Reports: ");
            for (int i = 0; i < reports.length; i++) {
                System.out.println(" file: " + reports[i]);
            }
        }

        // Dispatch/forward the request to the view
        return mapping.findForward("success");
    }
}

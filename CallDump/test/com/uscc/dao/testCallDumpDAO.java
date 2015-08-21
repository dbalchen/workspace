/*******************************************************************************
 * Authors      : MPS
 * Date Written : Date
 * -----------------------------------------------------------------------------
 * Revision(s) :
 * -----------------------------------------------------------------------------
 * ################# Version 2.80 ##############################################
 * 1) Initial Revision.
 *    - Craig J. Stalsberg - 3/18/2004
 ******************************************************************************/

package com.uscc.dao;

import junit.framework.TestCase;

import java.util.Calendar;
import java.util.List;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.uscc.utils.USCCDate;
import com.uscc.beans.CallDumpReport;
import com.uscc.beans.CallDumpRequest;

public class testCallDumpDAO extends TestCase {

    /** Date File was Last Modified */
    public static final String LASTMODIFIEDDATE = "$Date:   23 Aug 2007 13:02:28  $";

    /** Version of this file */
    public static final String LASTMODIFIEDVERSION = "$Revision:   1.0  $";

    /** Last person to modify this file */
    public static final String LASTMODIFIEDBY = "$Author:   md1csta1  $";

    private Connection con = null;

    private CallDumpDAO dao = null;

    /**
     * Open connection to database
     */
    public void setUp() {
        getConnection();
        dao = new CallDumpDAO(con);
    }

    /**
     * Close database connection
     */
    public void tearDown() {
        closeConnection();
    }

    public void testcorrectSwitchlist() {
        String input = "YAKI,LONG,M05ALLD,BEND,EURE,MEDF,M05ALLV";
        String output = dao.correctSwitchlist(input);
        assertTrue(output
                .equalsIgnoreCase("LONG,MEDF,MMS,SMS,YAKI,BEND,AAA,BREW,EURE"));
    }

    public void testisValidReuqestStartDateToday() {
        String midnight=null;
        try {
            midnight = USCCDate.ConvertDateFormat(USCCDate
                    .getSysDateTime(), USCCDate.DEF_DATE_TIME_FORMAT,
                    "yyyyMMdd" + "000001");
        } catch (Exception e) {
        }
        CallDumpRequest req = new CallDumpRequest();
        req.setSwitchesM01("SMS");
        req.setSearchString1("6082209511");
        req.setStartDate(midnight);
        req.setEndDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, 2));
        assertTrue("Actual Value: " + dao.isRequestValid(req), dao.isRequestValid(req) == CallDumpDAO.INVALID_DATE);
    }

    public void testisValidReuqestTooOldStartDate() {
        CallDumpRequest req = new CallDumpRequest();
        req.setSwitchesM01("SMS");
        req.setSearchString1("6082209511");
        req.setStartDate(USCCDate.getAdjustedSysDateTime(Calendar.YEAR, -2));
        req.setEndDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -5));
        assertTrue(dao.isRequestValid(req) == CallDumpDAO.INVALID_DATE);
    }

    public void testisValidReuqestwithValidRequest() {
        CallDumpRequest req = new CallDumpRequest();
        req.setSwitchesM01("SMS");
        req.setSearchString1("6082209511");
        req.setStartDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -30));
        req.setEndDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -26));
        assertTrue(dao.isRequestValid(req) == CallDumpDAO.VALID_REQUEST);
    }

    public void testisValidReuqestwithMissingSwitch() {
        CallDumpRequest req = new CallDumpRequest();
        req.setSearchString1("6082209511");
        req.setStartDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -30));
        req.setEndDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -10));
        assertTrue(dao.isRequestValid(req) == CallDumpDAO.MISSING_SWITCH);
    }

    public void testisValidReuqestwithMissingSearchString() {
        CallDumpRequest req = new CallDumpRequest();
        req.setSwitchesM01("SMS");
        req.setStartDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -30));
        req.setEndDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -10));
        assertTrue(dao.isRequestValid(req) == CallDumpDAO.MISSING_SEARCH_STRING);
    }

    public void testAddReport() {
        try {
            String filetoadd = "/users/md1csta1/test.txt";
            dao.addReport(1000, "localhost", filetoadd);
            List<CallDumpReport> rpts = dao.getCallDumpReports(1000);
            assertTrue(rpts.size() == 1);
            assertTrue(((CallDumpReport) rpts.get(0)).getFile()
                    .equalsIgnoreCase(filetoadd));
        } catch (DAOException e) {
            assertTrue(false);
        }
    }

    public void testAddReports() {
        try {
            String filetoadd = "/users/md1csta1/test.txt";
            String filetoadd2 = "/users/md1csta1/test2.txt";
            dao.addReport(1001, "localhost", filetoadd);
            dao.addReport(1001, "localhost", filetoadd2);
            List<CallDumpReport> rpts = dao.getCallDumpReports(1001);
            assertTrue(rpts.size() == 2);
            assertTrue(((CallDumpReport) rpts.get(0)).getFile()
                    .equalsIgnoreCase(filetoadd));
            assertTrue(((CallDumpReport) rpts.get(1)).getFile()
                    .equalsIgnoreCase(filetoadd2));
        } catch (DAOException e) {
            assertTrue(false);
        }
    }

    public void testAddReportsinArray() {
        try {
            String[] reports = new String[3];
            reports[0] = "/users/md1csta1/test.txt";
            reports[1] = "/users/md1csta1/test2.txt";
            reports[2] = "/users/md1csta1/test3.txt";
            dao.addReport(1002, "localhost", reports);
            List<CallDumpReport> rpts = dao.getCallDumpReports(1002);
            assertTrue(rpts.size() == 3);
            assertTrue(((CallDumpReport) rpts.get(0)).getFile()
                    .equalsIgnoreCase(reports[0]));
            assertTrue(((CallDumpReport) rpts.get(1)).getFile()
                    .equalsIgnoreCase(reports[1]));
            assertTrue(((CallDumpReport) rpts.get(2)).getFile()
                    .equalsIgnoreCase(reports[2]));
        } catch (DAOException e) {
            assertTrue(false);
        }
    }

    private void getConnection() {
        try {
            Class.forName(System.getProperty("DBDRIVER"));
            String url = "jdbc:oracle:thin:@" + System.getProperty("HOST")
                    + ":" + System.getProperty("PORT") + ":"
                    + System.getProperty("SID");
            String user = System.getProperty("DBUSER");
            String pass = System.getProperty("DBPASS");
            con = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException e) {
            System.out.println("Unable to load Driver Class");
            e.printStackTrace(System.out);
            assertTrue(false);
        } catch (SQLException se) {
            System.out.println("SQL Exeption: " + se.getMessage());
            se.printStackTrace(System.out);
            assertTrue(false);
        }
    }

    private void closeConnection() {
        try {
            con.close();
        } catch (SQLException se) {
            return;
        }
    }

}

package com.uscc.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.List;
import com.uscc.CallDump.CallDumpManager;
import com.uscc.CallDump.XMLdomReader;
import com.uscc.utils.USCCDate;
import com.uscc.beans.CallDumpReport;
import com.uscc.beans.CallDumpRequest;
import com.uscc.beans.SwitchEntry;

import junit.framework.TestCase;

public class CallDumpDAOTest extends TestCase {
	
	private static CallDumpDAO dao = null;
	private static CallDumpManager cdm = null;
	String markets = "m01";
	String ids = "0";
	int pid = 0;
	int numberOfSeconds = 30;
	int numberOfThreads = 0;
	int x = 0;

	private Connection getConnection() throws SQLException {
		XMLdomReader xml = new XMLdomReader("config/calldump.xml");
		try {
			cdm = new CallDumpManager(xml);
			numberOfThreads = Integer.parseInt((String) xml.getTagValue("threads"));
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		cdm.start();
		try {
			Thread.sleep(numberOfSeconds * 1000);
		} catch (InterruptedException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			Class.forName(xml.getTagValue("dbdriver"));
			return (Connection) DriverManager.getConnection(xml
					.getTagValue("dburl"), xml.getTagValue("dbuser"), xml
					.getTagValue("dbpass"));
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * Need a minimum of 9 records set to 'RD', in a given market, to run this test.
	 * update CALL_DUMP_QUEUE set status = 'RD', etc...
	 * @throws SQLException
	 */
	public void testGetPendingCallDumps() throws SQLException {
		Connection conn = getConnection();
		dao = new CallDumpDAO(conn);
		
		while ((cdm.getCallDumpThreads()).size() < numberOfThreads) {
		CallDumpRequest PendingCallDumps = dao.getPendingCallDumps(markets, ids, pid);
			System.out.println("testGetPendingCallDumps");
			System.out.println("color       = " + PendingCallDumps.getColor());
			System.out.println("end date    = " + PendingCallDumps.getEndDate());
			System.out.println("id          = " + PendingCallDumps.getId());
			System.out.println("next status = " + PendingCallDumps.getNextStatus());
			System.out.println("pid         = " + PendingCallDumps.getPid());
			System.out.println("String1     = " + PendingCallDumps.getSearchString1());
			System.out.println("StringType1 = " + PendingCallDumps.getSearchStringType1());
			System.out.println("StartDate   = " + PendingCallDumps.getStartDate());
			System.out.println("Status      = " + PendingCallDumps.getStatus());
			System.out.println("SubmitDate  = " + PendingCallDumps.getSubmitDate());
			System.out.println("submitName  = " + PendingCallDumps.getsubmitName());
			System.out.println("\n");
		}
	}		

	public void test1GetCallDumpReports() throws Exception {
		int id = 1195;
		List<CallDumpReport> CallDumpReports = dao.getCallDumpReports(id);
		int a = 0;
		while (a < CallDumpReports.size()) {
			System.out.println("test1GetCallDumpReports");
			System.out.println("CallDumpReportsId   = " + CallDumpReports.get(a).getId());
			System.out.println("CallDumpReportsHost = " + CallDumpReports.get(a).getHost());
			System.out.println("CallDumpReportsFile = " + CallDumpReports.get(a).getFile());
			a++;
		}
		System.out.println("\n");
	}
	
	public void test2GetCallDumpReports() throws Exception {
		int id = 1639;
		List<CallDumpReport> CallDumpReports = dao.getCallDumpReports(id);
		int a = 0;
		while (a < CallDumpReports.size()) {
			System.out.println("test2GetCallDumpReports");
			System.out.println("CallDumpReportsId   = " + CallDumpReports.get(a).getId());
			System.out.println("CallDumpReportsHost = " + CallDumpReports.get(a).getHost());
			System.out.println("CallDumpReportsFile = " + CallDumpReports.get(a).getFile());
			a++;
		}
		System.out.println("\n");
	}
	
	/**
	 * submit_date must be > sysdate to pickup CallDumpRequests
	 * update CALL_DUMP_QUEUE set submit_date = sysdate +1, etc...
	 */
	public void testGetCallDumpRequests() {
		String status = "ALL";
		int start = 1;
		int end = 3;
	    boolean isadmin = false;
	    String restrict = "md1dsmi1";
	    String timeframe = "0";
	    
		List<CallDumpRequest> CallDumpRequests = dao.getCallDumpRequests(status, start, end, isadmin, restrict, timeframe);
		System.out.println("testGetCallDumpRequests");
		assertTrue("Actual Value: " + CallDumpRequests.size(), CallDumpRequests.size()==3);
		int a = 0;
		while (a < CallDumpRequests.size()) {		
			System.out.println("CallDumpRequestsId     = " + CallDumpRequests.get(a).getId());
			System.out.println("CallDumpRequestsStatus = " + CallDumpRequests.get(a).getStatus());
			System.out.println("CallDumpRequestsUserid = " + CallDumpRequests.get(a).getUserid());
			a++;
		}
		System.out.println("\n");		
	}
	
	public void testGetSwitches() {
		List<SwitchEntry> SwitchEntries = dao.getSwitches();
		assertTrue("Actual Value: " + SwitchEntries.size(), SwitchEntries.size()==83);
		System.out.println("testGetSwitches");
		int a = 0;
		while (a < SwitchEntries.size()) {
			System.out.println("Name       = " + SwitchEntries.get(a).name);
			a++;
		}
		System.out.println("\n");
	}
	
	public void test1GetSwitchesByType() {
		String market = "M01";
		String type = "D";
		List<SwitchEntry> SwitchEntries = dao.getSwitchesByType(market, type);
		assertTrue("Actual Value: " + SwitchEntries.size(), SwitchEntries.size()==5);
		System.out.println("test1GetSwitchesByType");
		int a = 0;
		while (a < SwitchEntries.size()) {
			System.out.println("Market     = " + SwitchEntries.get(a).market);
			System.out.println("Name       = " + SwitchEntries.get(a).name);
			System.out.println("Identifier = " + SwitchEntries.get(a).identifier);
			System.out.println("Type       = " + SwitchEntries.get(a).type);
			a++;
		}
		System.out.println("\n");
	}
	
	public void test2GetSwitchesByType() {
		String market = "M02";
		String type = "V";
		List<SwitchEntry> SwitchEntries = dao.getSwitchesByType(market, type);
		assertTrue("Actual Value: " + SwitchEntries.size(), SwitchEntries.size()==5);
		System.out.println("test1GetSwitchesByType");
		int a = 0;
		while (a < SwitchEntries.size()) {
			System.out.println("Market     = " + SwitchEntries.get(a).market);
			System.out.println("Name       = " + SwitchEntries.get(a).name);
			System.out.println("Identifier = " + SwitchEntries.get(a).identifier);
			System.out.println("Type       = " + SwitchEntries.get(a).type);
			a++;
		}
		System.out.println("\n");
	}
	
	public void test1CorrectSwitchlist() {
		String in = "M01ALLV";
		String Switchlist = dao.correctSwitchlist(in);
		System.out.println("test1CorrectSwitchlist");
		System.out.println("1CorrectSwitchlist = " + dao.correctSwitchlist(in));
		System.out.println("\n");
	}
	
	public void test2CorrectSwitchlist() {
		String in = "M02ALLD";
		String Switchlist = dao.correctSwitchlist(in);
		System.out.println("test2CorrectSwitchlist");
		System.out.println("2CorrectSwitchlist = " + dao.correctSwitchlist(in));
		System.out.println("\n");
	}
	
	public void test1IsRequestValid() {
		CallDumpRequest req = new CallDumpRequest();
        req.setSwitchesM01("SMS");
        req.setSearchString1("1234567");
        req.setStartDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -30));
        req.setEndDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -26));
        System.out.println("test1IsRequestValid");
		System.out.println("VALID_REQUEST = " + CallDumpDAO.VALID_REQUEST);
		System.out.println("\n");		
	}
	
	public void test2IsRequestValid() {
		CallDumpRequest req = new CallDumpRequest();
        req.setSwitchesM01("");
        req.setSearchString1("1234567");
        req.setStartDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -30));
        req.setEndDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -26));
        System.out.println("test2IsRequestValid");
		System.out.println("MISSING_SWITCH = " + CallDumpDAO.MISSING_SWITCH);
		System.out.println("\n");		
	}
	
	public void test3IsRequestValid() {
		CallDumpRequest req = new CallDumpRequest();
        req.setSwitchesM01("SMS");
        req.setSearchString1("");
        req.setStartDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -30));
        req.setEndDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -26));
        System.out.println("test3IsRequestValid");
		System.out.println("MISSING_SEARCH_STRING = " + CallDumpDAO.MISSING_SEARCH_STRING);
		System.out.println("\n");		
	}
	
	public void test4IsRequestValid() {
		CallDumpRequest req = new CallDumpRequest();
        req.setSwitchesM01("SMS");
        req.setSearchString1("1234567");
        req.setStartDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, 1));
        req.setEndDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, 1));
        System.out.println("test4IsRequestValid");
		System.out.println("INVALID_DATE = " + CallDumpDAO.INVALID_DATE);
		System.out.println("\n");		
	}
}

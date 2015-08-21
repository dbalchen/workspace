package com.uscc.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Calendar;
import com.uscc.CallDump.CallDumpManager;
import com.uscc.CallDump.XMLdomReader;
import com.uscc.Utilities.USCCDate;
import com.uscc.beans.CallDumpRequest;

import junit.framework.TestCase;

public class DAOExceptionTest extends TestCase {
	
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

	public void testDAOException() throws DAOException {
		Connection conn = null;
		try {
			conn = getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dao = new CallDumpDAO(conn);
		
	    System.out.println("testDAOException");
		CallDumpRequest req = new CallDumpRequest();
        req.setSwitchesM01("M01");
        req.setSearchString1("1234567");
        req.setStartDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -30));
        req.setEndDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -26));
        req.setUserid(null);
		dao.submitCallDumpRequest(req);		
	}

	public void testDAOExceptionString() throws DAOException {
		System.out.println("\n");
	    System.out.println("testDAOExceptionString");
		CallDumpRequest req = new CallDumpRequest();
        req.setSwitchesM01("M01");
        req.setSearchString1("1234567");
        req.setStartDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -30));
        req.setEndDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -26));
        req.setUserid(null);
		dao.submitCallDumpRequest(req);
	}

	public void testDAOExceptionStringThrowable() throws DAOException {
		System.out.println("\n");
	    System.out.println("testDAOExceptionStringThrowable");
		CallDumpRequest req = new CallDumpRequest();
        req.setSwitchesM01("M01");
        req.setSearchString1("1234567");
        req.setStartDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -30));
        req.setEndDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -26));
        req.setUserid(null);
		dao.submitCallDumpRequest(req);
	}

	public void testDAOExceptionThrowable() throws DAOException {
		System.out.println("\n");
	    System.out.println("testDAOExceptionThrowable");
		CallDumpRequest req = new CallDumpRequest();
        req.setSwitchesM01("M01");
        req.setSearchString1("1234567");
        req.setStartDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -30));
        req.setEndDate(USCCDate.getAdjustedSysDateTime(Calendar.HOUR, -26));
        req.setUserid(null);
		dao.submitCallDumpRequest(req);
	}	
}

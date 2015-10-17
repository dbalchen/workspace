package com.uscc.CallDump;

import com.uscc.dao.CallDumpDAO;
import java.sql.Connection;
import junit.framework.TestCase;

public class dbHandlerTest extends TestCase {
	public dbHandler dbhandler = null;
	public LogWriter log = null;
	public String driver = "oracle.jdbc.driver.OracleDriver";
	public String url = "jdbc:oracle:thin:@mad1dds1:1522:SHAREDEV";
	public String user = "calldumptest";
	public String pass = "calldumptest";

	public void testDbHandler() {

		dbhandler = new dbHandler(driver, url, user, pass);

		if (dbhandler != null) {
			assertTrue(true);
		} else {
			fail("testDbHandler has failed to intialize......");
		}
	}

	public void testSetLog() {
		openLog();
		log.println("Test the setLog method");
		dbhandler = new dbHandler(driver, url, user, pass);
		dbhandler.setLog(log);

		LogWriter test = dbhandler.getLog();

		if (test == log) {
			log.println("setLog method passed");
			assertTrue(true);
		} else {
			fail("log file is not the same...... testSetLog() failed.");
		}

	}

	public void testStart() {

		openLog();
		log.println("Test the start method");
		dbhandler = new dbHandler(driver, url, user, pass);
		dbhandler.setLog(log);
		dbhandler.start();
		log.println("start method passed");
	}

	public void testGetDao() {
		openLog();
		log.println("Test the GetDao method");
		CallDumpDAO dao = null;
		dbhandler = new dbHandler(driver, url, user, pass);
		dbhandler.setLog(log);

		dao = dbhandler.getDao();

		if (dao != null) {
			log.println("getDAO method passed");
			assertTrue(true);
		} else {
			fail("testGetDao() failed");
		}

	}

	public void testRefreshDB() {
		Connection connection = null;
		openLog();
		log.println("Test the refreshDB() method");
		dbhandler = new dbHandler(driver, url, user, pass);
		dbhandler.setLog(log);
		dbhandler.setConn(connection);
		dbhandler.refreshConnection();
		connection = dbhandler.getConn();

		if (connection != null) {
			log.println("refreshDB method passed");
			assertTrue(true);
		} else {
			fail("testRefreshDB() failed");
		}

	}

	public void testGetInfo() {
		openLog();
		log.println("Test getInfo method");
		dbhandler = new dbHandler(driver, url, user, pass);
		dbhandler.setLog(log);
		log.println("Test the getInfo() method");
		log.println(dbhandler.getInfo());
		log.println("getInfo method passed");
	}

	/**
	 * Opens a log file..
	 * 
	 */
	private void openLog() {
		String LogFileName = "Test.log";

		try {
			log = new LogWriter("log/", LogFileName);
		} catch (Exception e) {
			e.printStackTrace();
			System.out
					.println("Could not open Log File... So writing to standard out...");
		}
	}

}

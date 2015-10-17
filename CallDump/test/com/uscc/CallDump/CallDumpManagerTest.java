package com.uscc.CallDump;

import java.util.Vector;
import junit.framework.TestCase;

public class CallDumpManagerTest extends TestCase {

	private static final Vector<CallDumpSession> CallDumpThreads = null;

	private static CallDumpManager cdm = null;
	
	int id = 0;
	
/**
 * Connect to database.
 * @throws Exception
 */
	public void testRun() throws Exception {
		XMLdomReader xml = new XMLdomReader("config/calldump.xml");
		cdm = new CallDumpManager(xml);
		cdm.start();
		Thread.currentThread().sleep(6000 * 1000);
	}

	public void testGetCallDumpThreads() throws Exception {
		Vector<CallDumpSession> CallDumpThreads = cdm.getCallDumpThreads();
		System.out.println("testGetCallDumpThreads = " + CallDumpThreads.size());
	}

	public void testKill() throws Exception {
		id = 1065;
		cdm.Kill(id);
		System.out.println("testKillCallDumpId = " + id);
	}
	
	public void testBigKill() throws Exception {
		cdm.BigKill();
	}

	public void testShutdown() throws Exception {
		cdm.shutdown();
	}
}

package com.uscc.monitor;

import junit.framework.TestCase;


import java.util.Vector;
import java.util.Hashtable;


public class DialerTest extends TestCase {

	protected void setUp() throws Exception {
		super.setUp();
	}

	protected void tearDown() throws Exception {
		super.tearDown();
	}

	/*
	 * Test method for 'com.uscc.monitor.Dialer.Dialer(Vector, Vector, MarketInformation, String)'
	 */
	public void testDialer() {
		// TODO Auto-generated method stub
		   XMLReader xml = new XMLReader("unit/monitor.xml");

		    try {

		      Vector<Hashtable <String, String>> ConfigVec = xml.getSubTree("M01");

		      String StartHour = (String) ( (Hashtable<String, String>) ConfigVec
		                                   .elementAt(0)).get("StartHour");



		      Vector<Hashtable<String, String>> genVec = xml.getSubTree("general");
		      System.out.println("Starting the Dialer load\n\n");
		      
		      System.out.println("Starting the audit load\n\n");
		      MarketInformation mi = new MarketInformation(ConfigVec);
		      mi.start();
		      
		      Dialer di = new Dialer(ConfigVec, genVec, mi, StartHour);
		    }
		    catch (Exception e){
		    	System.out.println("Holy Crap");
		    	}
	}

	/*
	 * Test method for 'com.uscc.monitor.Dialer.start()'
	 */
	public void testStart() {
		// TODO Auto-generated method stub

	}

}

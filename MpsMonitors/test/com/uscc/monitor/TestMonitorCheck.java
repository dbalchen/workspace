package com.uscc.monitor;

import java.io.IOException;
import java.util.Hashtable;
import java.util.Vector;

import junit.framework.*;

public class TestMonitorCheck extends TestCase {

  protected void setUp() throws Exception {
	    super.setUp();
	  }

	  protected void tearDown() throws Exception {
	    super.tearDown();
	  }
	  
	  public void testMonitorCheck() throws IOException {
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
}

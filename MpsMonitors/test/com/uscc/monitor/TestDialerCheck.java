package com.uscc.monitor;

import java.io.IOException;
import java.util.Hashtable;
import java.util.Vector;
import junit.framework.*;

public class TestDialerCheck extends TestCase {
	private DialerCheck dialerCheck = null;
	private String rep1 = "!repage";
	private String rep2 = "Missing Block\n";

  protected void setUp() throws Exception {
    super.setUp();
  }

  protected void tearDown() throws Exception {
    super.tearDown();
  }
  
  public void testDialerCheck() throws IOException {
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

  public void test1CheckHistory(String rep1) throws IOException {
	boolean expectedReturn = false;
    boolean actualReturn = dialerCheck.checkHistory(rep1);
    assertEquals("return value", expectedReturn, actualReturn);
//    System.out.println("test1CheckHistory:");
//    System.out.println("expectedReturn: " + expectedReturn);
//    System.out.println("actualReturn  :" + actualReturn);
  }
    
  public void test2CheckHistory(String rep2) throws IOException {
    boolean expectedReturn = true;
    boolean actualReturn = dialerCheck.checkHistory(rep2);
    assertEquals("return value", expectedReturn, actualReturn);
//    System.out.println("test2CheckHistory:");
//    System.out.println("expectedReturn: " + expectedReturn);
//    System.out.println("actualReturn  :" + actualReturn);
  }
}



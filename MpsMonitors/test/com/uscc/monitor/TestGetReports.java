package com.uscc.monitor;

import junit.framework.*;

public class TestGetReports<monitor> extends TestCase {

private GetReports getReports = null;
  protected void setUp() throws Exception {
    super.setUp();
  }

  protected void tearDown() throws Exception {
    super.tearDown();
  }

  public void testGetReports() throws Exception {
    XMLReader nxml = null;
        nxml = new XMLReader("unit/monitor.xml");
        
    LogWriter LOG = null;

    LOG = new LogWriter("", "WebMonitor.log");
    getReports = new GetReports(nxml, LOG);
    
    getReports.start();
    
    while (true)
    {
    	Thread.sleep(30000);
    }
    
  }

}

package com.uscc.monitor;



import junit.framework.*;

public class TestMpsMonitor extends TestCase {
  private MpsMonitor mpsMonitor = null;

  public TestMpsMonitor(String name) {
    super(name);
  }

  protected void setUp() throws Exception {
    super.setUp();
    String name = "unit/monitor.xml";
    String tag = "KPRL3BATCH";
    mpsMonitor = new MpsMonitor(tag, name);

  }

  protected void tearDown() throws Exception {
    mpsMonitor = null;
    super.tearDown();
  }

  public void testMarketInformation() throws Exception {
    String name = "unit/monitor.xml";
    String tag = "KPRL3BATCH";
    mpsMonitor = new MpsMonitor(tag,name);

    /**@todo fill in the test code*/
  }
}

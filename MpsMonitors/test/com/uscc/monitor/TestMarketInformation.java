package com.uscc.monitor;

import junit.framework.*;
import java.util.*;

public class TestMarketInformation
    extends TestCase {
  private MarketInformation marketInformation = null;

  public TestMarketInformation(String name) {
    super(name);
  }

  protected void setUp() throws Exception {
    super.setUp();
    /**@todo verify the constructors*/
//  marketInformation = new MarketInformation(null);
  }

  protected void tearDown() throws Exception {
    marketInformation = null;
    super.tearDown();
  }

   public void testMarketInformation() throws Exception {
     String name = "unit/monitor.xml";
     XMLReader xMLReader = new XMLReader(name);
     String tag = "M01";

     Vector<Hashtable<String, String>> config = xMLReader.getSubTree(tag);
     marketInformation = new MarketInformation(config);
     marketInformation.start();
     while(true)
     {

     }
     /**@todo fill in the test code*/
   }

}

package com.uscc.monitor;

import junit.framework.*;
import java.util.*;

public class TestXMLReader
    extends TestCase {
  private XMLReader xMLReader = null;

  protected void setUp() throws Exception {
    super.setUp();
    /**@todo verify the constructors*/
    xMLReader = new XMLReader();
  }

  protected void tearDown() throws Exception {
    xMLReader = null;
    super.tearDown();
  }

  public void testXMLReader() {
    xMLReader = new XMLReader();
    /**@todo fill in the test code*/
  }

  public void testGetTagValue1() {
    String name = "unit/monitor.xml";
    xMLReader = new XMLReader(name);
    String tag = "victim";
    int ListItem = 0;
    String expectedReturn = null;
    String actualReturn = xMLReader.getTagValue(tag, ListItem);

    System.out.println( (String) actualReturn);

    //   assertEquals("return value", expectedReturn, actualReturn);
    /**@todo fill in the test code*/
  }

  public void testGetAllTagValue() {
    String name = "unit/monitor.xml";
    xMLReader = new XMLReader(name);
    String tag = "victim";
    Vector<Hashtable<String, String>> expectedReturn = null;
    Vector<String> actualReturn = xMLReader.getAllTagValue(tag);
    assertNotSame("return value", expectedReturn, actualReturn);
    for (int a = 0; a < actualReturn.size(); a++) {
      System.out.println( (String) actualReturn.get(a));
    }

    /**@todo fill in the test code*/
  }

  public void testGetSubTree() throws Exception {
    String name = "unit/monitor.xml";
    xMLReader = new XMLReader(name);
    String tag = "schedule";
    Hashtable<String, String> test;
    Vector<Hashtable<String, String>> expectedReturn = null;
    Vector<Hashtable<String, String>> actualReturn = xMLReader.getSubTree(tag);
    assertNotSame("return value", expectedReturn, actualReturn);

    for (int a = 0; a < actualReturn.size(); a++) {
      test = (Hashtable<String, String>) actualReturn.get(a);
      System.out.println("Tag Name = " + test.get("TAG_NAME"));
      System.out.println("Tag Value = " + test.get("TAG_VALUE"));
      System.out.println("Node = " + test.get("CHILD_NUM"));
    }

    /**@todo fill in the test code*/
  }

  public void testGetSubTree1() throws Exception {
    String name = "unit/monitor.xml";
    xMLReader = new XMLReader(name);
    String tag = "M01";
    Hashtable test;
    int ListItem = 0;
    Vector<Hashtable<String, String>> expectedReturn = null;
    Vector<Hashtable<String, String>> actualReturn = xMLReader.getSubTree(tag, ListItem);
    assertNotSame("return value", expectedReturn, actualReturn);
    for (int a = 0; a < actualReturn.size(); a++) {
      test = (Hashtable<String, String>) actualReturn.get(a);
      System.out.println("Tag Name = " + test.get("TAG_NAME"));
      System.out.println("Tag Value = " + test.get("TAG_VALUE"));
      System.out.println("Node = " + test.get("CHILD_NUM"));
    }

    /**@todo fill in the test code*/
  }

  public void testParseXML() throws Exception {
    String fileName = "unit/monitor.xml";
    xMLReader.parseXML(fileName);
    /**@todo fill in the test code*/

  }

}

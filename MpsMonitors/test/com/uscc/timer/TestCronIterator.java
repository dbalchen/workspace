package com.uscc.timer;

import junit.framework.*;
import java.util.*;

public class TestCronIterator extends TestCase {
  private CronIterator cronIterator = null;

  public TestCronIterator(String name) {
    super(name);
  }

  protected void setUp() throws Exception {
    super.setUp();
    /**@todo verify the constructors*/
    cronIterator = new CronIterator("*","*","*","*","*");
  }

  protected void tearDown() throws Exception {
    cronIterator = null;
    super.tearDown();
  }

  public void testCronIterator() {
    String mins = "*";
    String hrs = "*";
    String dys = "*";
    String dow = "*";
    String mth = "*";
    cronIterator = new CronIterator(mins, hrs, dys, dow, mth);
    /**@todo fill in the test code*/
  }

  public void testNxtMin() {
    Date expectedReturn = null;
    Date actualReturn = null;
    System.out.println("Test -- Next minute (* * * * *) \n");
    String mins = "*";
    String hrs = "*";
    String dys = "*";
    String dow = "*";
    String mth = "*";
    cronIterator = new CronIterator(mins, hrs, dys, dow, mth);

    for(int a = 0; a < 60; a++)
    {
      actualReturn = cronIterator.next();
      System.out.println(actualReturn.toLocaleString());
    }
//    assertEquals("return value", expectedReturn, actualReturn);
    /**@todo fill in the test code*/
  }


  public void testbyMin() {
    Date expectedReturn = null;
    Date actualReturn = null;

    System.out.println("Test by Minutes (2,10,40 * * * *)\n");
    String mins = "2,10,40";
    String hrs = "*";
    String dys = "*";
    String dow = "*";
    String mth = "*";
    cronIterator = new CronIterator(mins, hrs, dys, dow, mth);

    for(int a = 0; a < 60; a++)
    {
      actualReturn = cronIterator.next();
      System.out.println(actualReturn.toLocaleString());
    }
//    assertEquals("return value", expectedReturn, actualReturn);
    /**@todo fill in the test code*/
  }
  public void testbyHour() {
    Date expectedReturn = null;
    Date actualReturn = null;

    System.out.println("Test by Hour (* 0,6,12,18 * * *)\n");
    String mins = "0";
    String hrs = "0,6,12,18";
    String dys = "*";
    String dow = "*";
    String mth = "*";
    cronIterator = new CronIterator(mins, hrs, dys, dow, mth);

    for(int a = 0; a < 60; a++)
    {
      actualReturn = cronIterator.next();
      System.out.println(actualReturn.toLocaleString());
    }
//    assertEquals("return value", expectedReturn, actualReturn);
    /**@todo fill in the test code*/
  }


  public void testbyDay() {
    Date expectedReturn = null;
    Date actualReturn = null;

    System.out.println("Test by Day (0 12 0,14 * *)\n");
    String mins = "0";
    String hrs = "12";
    String dys = "0,14";
    String dow = "*";
    String mth = "*";
    cronIterator = new CronIterator(mins, hrs, dys, dow, mth);

    for(int a = 0; a < 60; a++)
    {
      actualReturn = cronIterator.next();
      System.out.println(actualReturn.toLocaleString());
    }
//    assertEquals("return value", expectedReturn, actualReturn);
    /**@todo fill in the test code*/
  }

  public void testbyMonth() {
      Date expectedReturn = null;
      Date actualReturn = null;

      System.out.println("Test by Month (0 12 0,14 * 0,8,11)\n");
      String mins = "0";
      String hrs = "12";
      String dys = "0,14";
      String dow = "*";
      String mth = "0,8,11";
      cronIterator = new CronIterator(mins, hrs, dys, dow, mth);

      for(int a = 0; a < 60; a++)
      {
        actualReturn = cronIterator.next();
        System.out.println(actualReturn.toLocaleString());
      }
//    assertEquals("return value", expectedReturn, actualReturn);
      /**@todo fill in the test code*/
    }

  public void testByDOW() {
    Date expectedReturn = null;
    Date actualReturn = null;
    System.out.println("Test by Day of Week (0 12 * 2-6 *)\n");
    String mins = "0";
    String hrs = "12";
    String dys = "*";
    String dow = "2-6";
    String mth = "*";
    cronIterator = new CronIterator(mins, hrs, dys, dow, mth);

    for(int a = 0; a < 60; a++)
    {
      actualReturn = cronIterator.next();
      System.out.println(actualReturn.toLocaleString());
    }
//    assertEquals("return value", expectedReturn, actualReturn);
    /**@todo fill in the test code*/
  }

  public void testNextMinHoursdays() {
    Date expectedReturn = null;
    Date actualReturn = null;
    System.out.println("Test by All (0 10,13 28 2 1)\n");
    String mins = "0";
    String hrs = "10,13";
    String dys = "28";
    String dow = "2";
    String mth = "1";
    cronIterator = new CronIterator(mins, hrs, dys, dow, mth);

    for(int a = 0; a < 60; a++)
    {
      actualReturn = cronIterator.next();
      System.out.println(actualReturn.toLocaleString());
    }
//    assertEquals("return value", expectedReturn, actualReturn);
    /**@todo fill in the test code*/
  }


}

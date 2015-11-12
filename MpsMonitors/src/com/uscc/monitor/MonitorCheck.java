package com.uscc.monitor;

import java.io.IOException;
import java.util.List;
import java.util.Hashtable;
import java.util.Enumeration;
import com.uscc.timer.CronIterator;
import com.uscc.timer.Scheduler;
import com.uscc.timer.SchedulerTask;

/**
 *
 * <p>
 * <b>Title: </b> MonitorCheck
 * </p>
 * <p>
 * <b>Description: </b> This class runs the system check and stores the
 * information ready to be accessed by outside classes.
 * </p>
 * <p>
 * <b>Copyright: </b> Copyright (c) 2005
 * </p>
 * <p>
 * <b>Company: </b> US Cellular
 * </p>
 *
 * @author David Balchen
 * @version 2.0
 */

public class MonitorCheck
    implements TimedCheck {

  /** Date File was Last Modified */
  public static final String LASTMODIFIEDDATE =
      "$Date:   14 Jan 2008 09:10:10  $";
  /** Version of this file */
  public static final String LASTMODIFIEDVERSION = "$Revision:   1.1  $";
  /** Last person to modify this file */
  public static final String LASTMODIFIEDBY = "$Author:   md1dsmi1  $";

  private CallProcess runScript = new CallProcess();

  private String Info = new String();

  private boolean SpinLock = false;

  private String Script;

  private final Scheduler scheduler = new Scheduler();

  private String minutes = "*", hours = "*", days = "*", dayofweek = "*", month = "*", disable, params = " ";

  /**
   * The MonitorCheck Constructor takes a list parameter that contains 1 audit
   * check and parameters. Then runs this check either by the minutes or
   * collector_interval.
   * @param monparameter -- A list variable that contains the name and
   * parameters of a Audit check.
   * @throws IOException 
   */
  public MonitorCheck(List<Hashtable<String, String>> monparameter) throws IOException {
    String tag_name = "";
    String tag_value = "";
    
    boolean usehours = false, usedays = false, usedow = false, usemonths = false;
    
    Hashtable<String, String> monpar;

    String colInt = "";
    
    for (int a = 0; a < monparameter.size(); a++) {
      monpar = (Hashtable<String, String>) monparameter.get(a);

      tag_name = monpar.get("TAG_NAME").trim();

      tag_value = monpar.get("TAG_VALUE").trim();

      if (tag_name.equals("minutes")) {
        minutes = tag_value;
      }
      else if (tag_name.equals("collector_interval")) {
        colInt = tag_value;
      }
      else if (tag_name.equals("usehours")) {
          usehours = true;
        }
      else if (tag_name.equals("hours") && usehours) {
          hours = tag_value;
        }
      else if (tag_name.equals("usedays")) {
          usedays = true;
        }
      else if (tag_name.equals("days") && usedays) {
          days = tag_value;
        }
      else if (tag_name.equals("usedow")) {
          usedow = true;
        }
      else if (tag_name.equals("dayofweek") && usedow) {
          dayofweek = tag_value;
        }
      else if (tag_name.equals("usemonths")) {
          usemonths = true;
        }
      else if (tag_name.equals("month") && usemonths) {
          month = tag_value;
        }
      else if (tag_name.equals("executable")) {
        Script = tag_value;
      }
      else if (tag_name.equals("disable")) {
        disable = tag_value;
      }
      else if (tag_name.equals("params")) {
        Enumeration<String> keys = monpar.keys();

        while (keys.hasMoreElements()) {
          String key = keys.nextElement();
          if (! (key.equalsIgnoreCase("TAG_NAME")
                 || key.equalsIgnoreCase("TAG_VALUE") || key
                 .equalsIgnoreCase("CHILD_NUM"))) {
            params = params + " " + key + " " + "\""
                + monpar.get(key) + "\"";
          }
        }
      }
    }

    if (!colInt.equals("")) {
      minutes = colInt;
    }
    Script = Script + params;
    System.out.println("The Monitor Check " + Script
                       + " has been started...");

    Info = runScript.exec(Script);
    
  }

  /**
   * By using the minutes parameter, run the thread.
   */

  public void start() {

    scheduler.schedule(new SchedulerTask() {
      public void run() {
        String buff = null;
		try {
			buff = runScript.exec(Script);
	        SpinLock = true;
	        Info = buff;
	        SpinLock = false;
		} catch (IOException e) {
			e.printStackTrace();
			buff = null;
			runScript = null;
			System.gc();
			runScript = new CallProcess();
			System.out.println("The Monitor Check " + Script
                       + " has been re-started...");
		}

      }

    }

    , new CronIterator(minutes, hours, days, dayofweek, month));
  }

  /**
   * Returns the boolean SpinLock variable, used to block access while
   * information is being updated.
   *
   * @return Boolean SpinLock variable.
   */
  public boolean getSpinLock() {
    return SpinLock;
  }

  /**
   * Gets the information of the last run of the system check.
   *
   * @return Monitor Information
   */
  public String getInfo() {
    return Info;
  }
  
  

}
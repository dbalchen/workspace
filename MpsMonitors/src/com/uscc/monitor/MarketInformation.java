package com.uscc.monitor;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Hashtable;
import java.util.List;
import java.util.Vector;

/**
 *
 * <p>
 * <b>Title : </b>MarketInformation
 * </p>
 * <p>
     * <b>Description: </b> This class contains all the threads and information from
 * the system checks.
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
public class MarketInformation
    extends Thread {

  /** Date File was Last Modified */
  public static final String LASTMODIFIEDDATE =
      "$Date:   14 Jan 2008 09:10:10  $";
  /** Version of this file */
  public static final String LASTMODIFIEDVERSION = "$Revision:   1.1  $";
  /** Last person to modify this file */
  public static final String LASTMODIFIEDBY = "$Author:   md1dsmi1  $";

  private Hashtable<String, TimedCheck> Monitors = new Hashtable<String, TimedCheck>();

  private TimedCheck monitorcheck = null;

  /**
   * The constructor method for the MarketInformation takes a Vector that contains
   * list of all the checks that will be run. Then starts separate threads for each
   * audit/check.
   * @param config -- Vector with the audits and configuration information.
   * @throws IOException 
   */
  public MarketInformation(Vector<Hashtable<String, String>> config) throws IOException {
    int start = 0;
    boolean flag = false;
    int a = 0;

    for (a = 1; a < config.size(); a++) {
      if (Integer.parseInt( ( (Hashtable<String, String>) config.get(a))
                           .get("CHILD_NUM")) == 1) {
        if (flag) {
          loadStartMonitor( (List<Hashtable<String, String>>) config.subList(start, a));
        }
        start = a;
        flag = true;
      }
    }
    loadStartMonitor( (List<Hashtable<String, String>>) config.subList(start, a));
  }

  private void loadStartMonitor(List<Hashtable<String, String>> conf) throws IOException {
    monitorcheck = new MonitorCheck(conf);
    monitorcheck.start();
    Monitors.put( ( (Hashtable<String, String>) conf.get(0)).get("TAG_NAME"),
                 monitorcheck);
  }

  /**
   * This method returns the information for a given check.
   *
   * @param MonitorName
   *            The monitor information you wish to obtain.
   * @param out
   *            The PrintWriter handle, can be either a file or socket.
   */
  public void GetSysInfo(String MonitorName, PrintWriter out) {

    MonitorCheck mc = (MonitorCheck) Monitors.get(MonitorName);

    while (mc.getSpinLock()) {
      try {
        sleep(100);
      }
      catch (InterruptedException e) {
        e.printStackTrace();
      }
    }
    out.println( (String) mc.getInfo());
    return;
  }

  /**
   * This method returns a MonitorCheck object.
   * @param MonitorName -- The monitor you wish to obtain.
   * @return
   */
  public MonitorCheck getMonitor(String MonitorName) {
    return (MonitorCheck) Monitors.get(MonitorName);
  }
}
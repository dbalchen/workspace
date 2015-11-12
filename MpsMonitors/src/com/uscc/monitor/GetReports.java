package com.uscc.monitor;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;
import java.util.Vector;
import java.io.PrintWriter;
import java.net.Socket;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import com.uscc.timer.CronIterator;
import com.uscc.timer.Scheduler;
import com.uscc.timer.SchedulerTask;

/**
 *
 * <p>Title: GetReports</p>
 * <p>Description: This a thread that runs within the WebMonitor servlet class
 * pulling in all reports from all the servers and storing them in memory.
 * When a request is made for a web page the servlet passes back the the stored
 * page.</p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
public class GetReports {

  /** Date File was Last Modified */
  public static final String LASTMODIFIEDDATE =
      "$Date:   14 Jan 2008 09:10:10  $";
  /** Version of this file */
  public static final String LASTMODIFIEDVERSION = "$Revision:   1.1  $";
  /** Last person to modify this file */
  public static final String LASTMODIFIEDBY = "$Author:   md1dsmi1  $";

  private final Scheduler scheduler = new Scheduler();
  private Hashtable<String, String> WebReports = new Hashtable<String, String>();
  private XMLReader xml = null;
  private LogWriter log = null;

  /**
   * The Constructor reads in a XMLReader object loads all markets information
   * and checks.
   * @param nxml -- XMLReader object.
   * @param LOG -- Handle to a log file.
   * @throws java.lang.Exception
   */
  public GetReports(XMLReader nxml, LogWriter LOG) throws Exception {
    int a, start;
    boolean flag;
    String market = null;
    String hostname = null;
    int port;

    Vector<Hashtable<String, String>> config;

    xml = nxml;
    log = LOG;
    Vector<Hashtable<String, String>> markets = xml.getChildTags("MARKET", 1);

    for (int b = 0; b < markets.size(); b++) {

      market = ( ( (Hashtable<String, String>)
                           markets.get(b)).get("TAG_NAME")).trim();

      hostname = ( ( (Hashtable<String, String>)
                             markets.get(b)).get("hostname")).trim();

      port = Integer.parseInt( ( ( (Hashtable<String, String>)
                                           markets.get(b)).get("port")).trim());

      config = xml.getSubTree(market);

      start = 0;
      flag = false;

      for (a = 1; a < config.size(); a++) {
        if (Integer.parseInt( ( (Hashtable<String, String>) config.get(a)).get(
            "CHILD_NUM")) == 1) {
          if (flag) {
            loadReport( (List<Hashtable<String, String>>) config.subList(start, a), market,
                       hostname, port);
          }
          start = a;
          flag = true;
        }
      }
      loadReport( (List<Hashtable<String, String>>) config.subList(start, a), market, hostname,
                 port);
    }
  }

  /**
   * Gets the reports for all usage collectors every 3 minutes.
   */

  public void start() {
    scheduler.schedule(new SchedulerTask() {
      public void run() {
        getReports();
      }
    }

    , new CronIterator("0,3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,57"
                       , "*", "*", "*", "*"));
  }

  private void loadReport(List<Hashtable<String, String>> conf, String market, String hostname,
                          int port) {
    String monitor = ( (String) (
        (Hashtable<String, String>) conf.get(0)).get("TAG_NAME")).trim();

    WebReports.put(monitor + market, CallMpsMonitor(hostname, port, monitor));
    WebReports.put("port" + market, Integer.toString(port));
    WebReports.put("hostname" + market, hostname);

    log.println("GetReports : Started the following monitor " + " "
                + monitor + " " + market);

  }

  private void getReports() {
    Enumeration<String> keys = WebReports.keys();

    while (keys.hasMoreElements()) {
      String key = keys.nextElement();

      if (key.indexOf("port") < 0 && key.indexOf("hostname") < 0) {
        String market = key.substring(key.indexOf("M0"));
        WebReports.put( (String) key,
                       CallMpsMonitor( (String) WebReports.get("hostname" +
            market),
                                      Integer.parseInt(
            (String) WebReports.get("port" + market)),
                                      key.substring(0, key.indexOf("M0"))));

      }
    }
  }

  /**
   * Calls a usage machine collector for a particular audit/check.
   * @param hostname -- Collectors host name.
   * @param port -- The collectors port number.
   * @param monitor -- The audit/check we want.
   * @return -- A string containg the report.
   */
  public String CallMpsMonitor(String hostname, int port, String monitor) {
    String page = "";
    try {

      Socket socket = new Socket(hostname, port);

      BufferedReader Server_in = new BufferedReader(new InputStreamReader(
          socket
          .getInputStream()));

      PrintWriter Server_out = new PrintWriter(new BufferedWriter(
          new OutputStreamWriter(socket.getOutputStream())), true);

      String Check = Server_in.readLine();

      Server_out.println(monitor);

      while ( (Check = Server_in.readLine()) != null) {
        page = page + Check;
      }

      //     page = Server_in.readLine();
      socket.close();
      Server_in.close();
      Server_out.close();
      
      System.out.println("Output =" + page);

    }
    catch (Exception e) {
      log.println(e.getMessage());
      e.printStackTrace();
    }
    return page;
  }

  /**
   * Gets the web page report for a monitor.
   * @param monitor -- The audit/check name.
   * @param market -- The usage market.
   * @return -- A string containg the report.
   */
  public String getWebReport(String monitor, String market) {
    return (WebReports.get(monitor + market));
  }

}
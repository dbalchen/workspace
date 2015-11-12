package com.uscc.monitor;

import java.util.Calendar;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;
import java.util.Vector;
import com.uscc.timer.CronIterator;
import com.uscc.timer.Scheduler;
import com.uscc.timer.SchedulerTask;

/**
 *
 * <p>
 * <b>Title : </b>Dialer
 * </p>
 * <p>
 * <b>Description: </b> This class manages the DialerCheck class as
 * well as the emailing and paging of the oncall person.
 * It runs once a day at 6:30am localtime to find who is oncall,
 * then sets each dailer with there email and pager number.
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
public class Dialer {

  /** Date File was Last Modified */
  public static final String LASTMODIFIEDDATE =
      "$Date:   14 Jan 2008 09:10:08  $";
  /** Version of this file */
  public static final String LASTMODIFIEDVERSION = "$Revision:   1.1  $";
  /** Last person to modify this file */
  public static final String LASTMODIFIEDBY = "$Author:   md1dsmi1  $";

  private final Scheduler scheduler = new Scheduler();

  private Hashtable<Object, DialerCheck> Dialers = new Hashtable<Object, DialerCheck>();

  private Vector<Hashtable<String, String>> general = null;

  private DialerCheck dialercheck = null;

  private LogWriter log = null;

  private MarketInformation marketInfo = null;

  private String starthour;

  /**
   * The contructor method for the Dialer class. Takes and XMLReader class as
   * parameter to obtain its configuration information.
   *
   * @param monitor
   *            TODO
   * @param doc --
   *            An XMLReader class that contains a parsed XML document.
   */

  /**
   * The Dialer constructor takes the below listed parameters and creates
   * DialerCheck threads.
   * @param config -- The Market information subtree.
   * @param gen -- The general info subtree.
   * @param MI -- The MarketInformation Class.
   * @param StartHour -- The hour to refresh the Dialers oncall information.
   * @throws java.lang.Exception
   */
  public Dialer(Vector<Hashtable<String, String>> config, Vector<Hashtable<String, String>> gen, MarketInformation MI,
                String StartHour) throws Exception {

    int a;
    String timestring;

    Calendar CAL = Calendar.getInstance();
    timestring = Integer.toString(CAL.get(Calendar.YEAR)) +
    		 PadZero(Integer.toString(CAL.get(Calendar.MONTH)+ 1)) +
    		 PadZero(Integer.toString(CAL.get(Calendar.DATE))) +
    		 PadZero(Integer.toString(CAL.get(Calendar.HOUR_OF_DAY))) +
    		 PadZero(Integer.toString(CAL.get(Calendar.MINUTE)));
    		
 
    log = new LogWriter("", "Dialer." + timestring + ".log");
    marketInfo = MI;
    general = gen;
    starthour = StartHour;

    int start = 0;
    boolean flag = false;

    for (a = 1; a < config.size(); a++) {
      if (Integer.parseInt( (String) config.get(a)
                           .get("CHILD_NUM")) == 1) {
        if (flag) {
          loadDialerCheck( (List<Hashtable<String, String>>) config.subList(start, a));
        }
        start = a;
        flag = true;
      }
    }
    loadDialerCheck( (List<Hashtable<String, String>>) config.subList(start, a));
    getOncall();
  }

  /**
   * Run this thread at 6:30am each morning.
   */

  public void start() {
    scheduler.schedule(new SchedulerTask() {
      public void run() {
        getOncall();
      }
    }

    , new CronIterator("30", starthour, "*", "*", "*"));
  }

  private void loadDialerCheck(List<Hashtable<String, String>> conf) {
    String monitor = ( (String) conf.get(0).get("TAG_NAME"))
        .trim();

    dialercheck = new DialerCheck(conf, marketInfo.getMonitor(monitor), log);
    dialercheck.start();
    Dialers.put(monitor, dialercheck);
    log.println("Dialer : Started the following monitor " + " " + monitor);

  }

  private void getOncall() {

    String victim = "";

    Calendar CAL = Calendar.getInstance();

    int DATE = Integer.parseInt(Integer.toString(CAL.get(Calendar.YEAR))
                                +
                                PadZero(Integer.toString(CAL.get(Calendar.MONTH) +
        1))
                                +
                                PadZero(Integer.toString(CAL.get(Calendar.DATE))));

    for (int a = 0; a < general.size(); a++) {
      String tag_name = general.get(a)
          .get("TAG_NAME");

      if (tag_name.equalsIgnoreCase("start_oncall")) {
        int startOncall = Integer
            .parseInt( general.get(a)
                      .get("TAG_VALUE"));
        a++;
        int endOncall = Integer.parseInt( general
            .get(a).get("TAG_VALUE"));

        if (DATE >= startOncall && DATE <= endOncall) {
          a++;
          victim = general.get(a)
              .get("TAG_VALUE");
        }

      }

      if (tag_name.equalsIgnoreCase("name")
          && ( general.get(a).get("TAG_VALUE"))
          .equalsIgnoreCase(victim)) {
        a++;
        String pager = ( general.get(a)
                        .get("TAG_VALUE"));
        a++;
        String email = ( general.get(a)
                        .get("TAG_VALUE"));
        setEmailPager(email, pager);
      }
    }
    log.println("Dialer: Person oncall -- " + victim);
  }

  private void setEmailPager(String email, String pager) {
    Enumeration<Object> keys = Dialers.keys();

    while (keys.hasMoreElements()) {
      Object key = keys.nextElement();
      dialercheck = Dialers.get( (String) key);
      dialercheck.setEmailPager(email, pager);
      Dialers.put(key, dialercheck);
    }
  }

  // This method adds zeros to the front of any string that it is passed.
  private String PadZero(String ToPad) {
    if (ToPad.length() == 1) {
      ToPad = "0" + ToPad;
    }
    return ToPad;
  }

}
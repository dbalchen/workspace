package com.uscc.monitor;

import java.io.IOException;
import java.util.Hashtable;
import java.util.List;
import com.uscc.timer.CronIterator;
import com.uscc.timer.Scheduler;
import com.uscc.timer.SchedulerTask;

/**
 *
 * <p>Title: DialerCheck</p>
 * <p>Description: This class checks its MonitorCheck class and if it is
 * not disabled and the output is not "Not Found" it emails and pages the
 * oncall person.</p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: US Cellular</p>
 * @author David Balchen
 * @version 1.0
 */

class DialerCheck
    implements TimedCheck {

  /** Date File was Last Modified */
  public static final String LASTMODIFIEDDATE =
      "$Date:   14 Jan 2008 09:10:10  $";
  /** Version of this file */
  public static final String LASTMODIFIEDVERSION = "$Revision:   1.1  $";
  /** Last person to modify this file */
  public static final String LASTMODIFIEDBY = "$Author:   md1dsmi1  $";

  private CallProcess runScript = new CallProcess();

  private final Scheduler scheduler = new Scheduler();

  private String minutes, hours, days, dayofweek, month, disable;

  private String Email, Pager, Title;

  private LogWriter log = null;

  private MonitorCheck monCheck = null;

  private boolean repage = true;

  private String History = new String();

  /**
   * The DialerCheck Constructor loads up its timing information from the
   * monparameter list.
   * @param monparameter -- Contains the threads timing information.
   * @param MC -- The MonitorCheck class.
   * @param LOG -- A handle to a log file.
   */
  public DialerCheck(List<Hashtable<String, String>> monparameter, MonitorCheck MC, LogWriter LOG) {

    String tag_name = "";
    String tag_value = "";
    Hashtable<String, String> dialpars;

    monCheck = MC;
    log = LOG;

    for (int a = 0; a < monparameter.size(); a++) {
      dialpars = (Hashtable<String, String>) monparameter.get(a);

      tag_name = ( dialpars.get("TAG_NAME")).trim();

      tag_value = ( dialpars.get("TAG_VALUE")).trim();

      if (tag_name.equals("minutes")) {
        minutes = tag_value;
      }
      else if (tag_name.equals("hours")) {
        hours = tag_value;
      }
      else if (tag_name.equals("days")) {
        days = tag_value;
      }
      else if (tag_name.equals("dayofweek")) {
        dayofweek = tag_value;
      }
      else if (tag_name.equals("month")) {
        month = tag_value;
      }
      else if (tag_name.equals("params")) {
        Title = dialpars.get("title");
      }
      else if (tag_name.equals("disable")) {
        disable = tag_value;
      }
      else if (tag_name.equals("repage")) {
        if (tag_value.trim().equals("0")) {
          repage = false;
        }
      }
    }
    log.println("DialerCheck: The Following monitor has been started "
                + Title);
  }

  /**
   * Runs the Thread per a schedule and if the report does not contain
   * the string 'Nothing Found' pages and emails the oncall person.
   */

  public void start() {

    scheduler.schedule(new SchedulerTask() {
      public void run() {
        String Report = getInfo();
        if (Report.trim().indexOf("Nothing Found") >= 0) {
          History = "";
        }
        else {
          if (disable.equalsIgnoreCase("NO") && checkHistory(Report)) {
            log.println("Dialer: " + Report);
            try {
				pageOncall(Report);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
          }
        }
      }
    }

    , new CronIterator(minutes, hours, days, dayofweek, month));
  }

  private void pageOncall(String Report) throws IOException {
    log.println("DialerCheck: " + Title);
    log.println("DialerCheck: An Error has occured... Paging Oncall Person");
    log.println("DialerCheck: Oncall Email -- " + Email);
    log.println("           : Oncall Pager -- " + Pager);
    log.println(runScript.exec("callVictim " + Title + " " + Email, Report));
    log.println(runScript.exec("callVictim " + Title + " " + Pager, Report));
  }

  /**
   * Used for re-paging. Some checks page only once per day. This method
   * checks to see if the report matches a previous page.
   * @param rep -- The report to check against the history.
   * @return -- If true page, else don't.
   */
  public boolean checkHistory(String rep) {
    if (!repage) {
      if (History.indexOf(rep) >= 0) {
        History = rep;
        return false;
      }
      History = rep;
    }
    return true;
  }

  /**
   * Gets the MonitorChecks report.
   * @return -- The MonitorCheck report.
   */
  public String getInfo() {
    return monCheck.getInfo();
  }

  /**
   * Sets the email and pager numbers.
   * @param Email -- Oncall email address.
   * @param Pager -- Oncall pager number.
   */
  public void setEmailPager(String Email, String Pager) {
    this.Email = Email;
    this.Pager = Pager;
    History = "";
  }

}
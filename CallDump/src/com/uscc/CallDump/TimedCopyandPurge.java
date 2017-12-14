package com.uscc.CallDump;

import java.util.Calendar;
import java.util.Vector;
import java.util.Hashtable;
import com.uscc.timer.CronIterator;
import com.uscc.timer.Scheduler;
import com.uscc.timer.SchedulerTask;
/**
* <p> TimedCopyandPurge.java </p>
*
* <p>The TimedCopyandPurge class is a timed class that takes start time from the CallDump.xml file. 
* The purpose of this class is to run the copy and purge jobs for maintainence of the disk files.</p>
* 
* @author MPS
* @version 1.0
*/
public class TimedCopyandPurge implements TimedCheck {

	/** Date File was Last Modified */
	public static final String LASTMODIFIEDDATE = "$Date:   09 Jan 2006 14:05:12  $";

	/** Version of this file */
	public static final String LASTMODIFIEDVERSION = "$Revision:   1.0  $";

	/** Last person to modify this file */
	public static final String LASTMODIFIEDBY = "$Author:   md1dbal1  $";

	private String Info = new String();

	private boolean SpinLock = false;

	private final Scheduler scheduler = new Scheduler();

	private String minutes, hours;

	private Vector<Hashtable<String, String>> Purgedir = new Vector<Hashtable<String, String>>();

	private Vector<Hashtable<String, String>> Copydirs = new Vector<Hashtable<String, String>>();

	private LogWriter log = null;

	/**
	 * The TimedCopyandPurge Constructor takes a list parameter that contains 1
	 * audit check and parameters. Then runs this check either by the minutes or
	 * collector_interval.
	 * 
	 * @param monparameter --
	 *            A list variable that contains the name and parameters of a
	 *            Audit check.
	 */
	public TimedCopyandPurge(String hours, String minutes) {

		this.hours = hours;
		this.minutes = minutes;
	}

	/**
	 * By using the minutes parameter, run the thread.
	 */

	public void start() {
		scheduler.schedule(new SchedulerTask() {
			public void run() {

				writeLog("Starting the Copy and Purge process..");
				
				writeLog("Starting the Copy process..");

				runCopy(Copydirs);
				writeLog("Finished the Copy process..");

				writeLog("Starting the Purge process..");

				runPurge(Purgedir);
				writeLog("Finished the Purge process..");

				SpinLock = false;
				writeLog("Finished the Copy and Purge process..");
				
			}
		}, new CronIterator(minutes, hours, "*", "*", "*"));
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
	 * @return Info information
	 */
	public String getInfo() {
		return Info;
	}

	/**
	 * Run the copy command that copies files from the switch directories passed in as a parameter.
	 * @param copydir Vector containing all the switch directories to copy from....
	 */
	public void runCopy(Vector<Hashtable<String, String>> copydir) {
		String output = "";
		String from = null;
		String to = null;
		Hashtable<String, String> tmpHash = null;
		String exec = "bin/";

		for (int a = 0; a < copydir.size(); a++) {
			tmpHash = copydir.get(a);

			if (tmpHash.get("TAG_NAME").equalsIgnoreCase("from")) {
				from = tmpHash.get("TAG_VALUE");

				from = from.replaceAll("\n", "");
				from = from.replaceAll("\t", "");
			}
			if (tmpHash.get("TAG_NAME").equalsIgnoreCase("to")) {
				to = tmpHash.get("TAG_VALUE");
				to = to.replaceAll("\n", "");
				to = to.replaceAll("\t", "");
			}
			if (from != null && to != null) {
				try {
					exec = "bin/";
					writeLog("Copying from " + from + " to " + to);
					CallProcess CP = new CallProcess();
					exec = exec + "copyfiles " + from + " " + to;
					writeLog("Starting outside perl process with the following command line.");
					writeLog(exec);
					try {
						output = CP.exec(exec);
					} catch (Exception e) {
						writeLog("An exception was thrown... Copy has failed re-run by hand");
						e.printStackTrace(log.getPrintWriter());

					}
				} catch (Exception e) {
					writeLog("Error copying " + from + " to " + to);
					e.printStackTrace(log.getPrintWriter());
				}
				from = null;
				to = null;
			}
		}

	}

	/**
	 * Method to purge files that are too old
	 * @param purgedir: Vector that contains the directories to purge files from....
	 */
	public void runPurge(Vector<Hashtable<String, String>> purgedir) {
		String rmdir = null;
		Hashtable<String, String> tmpHash = null;
		String time = null;
		String output = "";
		String exec = "bin/";

		for (int a = 0; a < purgedir.size(); a++) {
			tmpHash = purgedir.get(a);

			if (tmpHash.get("TAG_NAME").equalsIgnoreCase("switch")) {
				rmdir = tmpHash.get("TAG_VALUE");

				rmdir = rmdir.replaceAll("\n", "");
				rmdir = rmdir.replaceAll("\t", "");
				try {
					exec = "bin/";
					time = purgeTime();
					writeLog("Removing files from the following directory: "
							+ rmdir);
					CallProcess CP = new CallProcess();
					exec = exec + "purgefiles " + time + " " + rmdir;
					writeLog("Starting outside perl process with the following command line.");
					writeLog(exec);
					try {
						output = CP.exec(exec);
					} catch (Exception e) {
						writeLog("An exception was thrown... Purge has failed re-run by hand");
						e.printStackTrace(log.getPrintWriter());
					}
				} catch (Exception e) {
					writeLog("Error in purge process for directory " + rmdir);
					e.printStackTrace(log.getPrintWriter());
				}
			}
		}
	}

	/**
	 * Sets the purge directories vector.
	 * @param purge: Purge directory vector.
	 */
	public void setPurgedDir(Vector<Hashtable<String, String>> purge) {
		this.Purgedir = purge;
	}
	
	/**
	 * Get the purge directory vector
	 * @return: Purge directory vector
	 */
	public Vector<Hashtable<String, String>> getPurgedDir() {
		return Purgedir;
	}
	
	/**
	 * Set the copy directory vector.
	 * @param copy: Copy directory vector.
	 */
	public void setCopyDir(Vector<Hashtable<String, String>> copy) {
		this.Copydirs = copy;
	}

	/**
	 * Get the copy directory vector.
	 * @return: Copy directory vector.
	 */
	public Vector<Hashtable<String, String>> getCopyDir() {
		return Copydirs;
	}
	
	/**
	 * Pass in a LogWriter object
	 * @param log: LogWriter object
	 */
	public void setLog(LogWriter log) {
		this.log = log;
	}

	/**
	 * This method is used to make sure that the integer passed in is at least two charectors in lenth.
	 * If it is not, add a 0 to the front.
	 * @param int2chk: Integer to check
	 * @return: String with a 2 charactor integer representation.
	 */
	private String checkInt(int int2chk) {
		String chk = Integer.toString(int2chk);

		if (chk.length() < 2) {
			chk = "0" + chk;
		}

		return chk;
	}

	/**
	 * A log method used as a wrapper so that if no LogWriter object has been passed in writes to standard out.
	 * @param msg: String to write to either a log file or standard out.
	 */
	private void writeLog(String msg) {
		if (log == null) {
			System.out.println(msg);
		} else {
			log.println(msg);
		}
	}

	/**
	 * Calculate the time that a file file can be purged. 
	 * @return: The calulated purge time.
	 * @throws Exception
	 */
	private String purgeTime() throws Exception {
		Calendar now = Calendar.getInstance();
		Calendar working;
		working = (Calendar) now.clone();
		working.add(Calendar.DAY_OF_YEAR, -368);

		String rmdate = Integer.toString(working.get(Calendar.YEAR))
				+ checkInt(working.get(Calendar.MONTH)+ 1)
				+ checkInt(working.get(Calendar.DAY_OF_MONTH));

		return rmdate;
	}
}
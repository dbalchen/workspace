package com.uscc.CallDump;

import java.util.Calendar;
import java.util.Vector;
import com.uscc.beans.CallDumpRequest; 
import java.sql.SQLException;
import com.uscc.dao.CallDumpDAO;


/**
 * <p>
 * CallDumpManager.java
 * </p>
 * <p>	//	private TimedCopyandPurge tcp = null;
 * The CallDumpManager class is the main thread to the CallDump process. It is
 * here were were all database interaction for CallDumps has been implemented.
 * Also it is where the CallDumpSession objects are created and handled.
 * @author MPS
 * @version 1.0
 */
public class CallDumpManager extends Thread {

	private int numberOfThreads;

	private int numberOfSeconds = 60;

	private String markets;

	private boolean isRunning = true;

	private dbHandler dbhandler = null;	//	private TimedCopyandPurge tcp = null;

	private Vector<CallDumpSession> CallDumpThreads = new Vector<CallDumpSession>();

	private CallDumpDAO dao = null;

	private XMLdomReader xml = null;

	private LogWriter log = null;

	private String machine = "";

	private String path = "";

	/**
	 * The Constructor method takes an XMLdomReader class gets the values and
	 * sets the global variables. In addition we initialize the
	 * TimedCopyandPurge class to automatically run the copy and purge jobs.
	 * 
	 * @param xml
	 *            XMLdomReader Class
	 * @throws Exception
	 */
	public CallDumpManager(XMLdomReader xml) throws Exception {
		this.xml = xml;

		openLog();

		dbhandler = new dbHandler(xml.getTagValue("dbdriver"), xml
				.getTagValue("dburl"), xml.getTagValue("dbuser"), xml
				.getTagValue("dbpass"));

		dbhandler.setLog(log);
		dbhandler.start();

		numberOfThreads = Integer.parseInt((String) xml.getTagValue("threads"));
		writeLog("Number of threads allowed: " + numberOfThreads);

		numberOfSeconds = Integer.parseInt((String) xml.getTagValue("wait"));
		writeLog("Check the database every: " + numberOfSeconds + " seconds");

		markets = (String) xml.getTagValue("markets");
		writeLog("Check the following markets: " + markets);

		machine = (String) xml.getTagValue("machine");
		writeLog("For the machine: " + machine);

		path = (String) xml.getTagValue("path");
		writeLog("With the path: " + path);

	}

	/**
	 * This is the main method for this class which loops until a command is
	 * given to shut down. Here we search the database for CallDumps and if one
	 * is found it creates a CallDumpSession class passes it the appropriate
	 * information, starts it, then watches it for any change in state. Once a
	 * session is complete it then updates the database with the results.
	 */
	public void run() {

		CallDumpRequest request = null;
		CallDumpSession cds = null;

		while (isRunning) {

			boolean isEmergency = false;

			try {

				if (dbhandler.validateConnection()){
					try {

						dao = dbhandler.getDao();

						request = dao.getPendingCallDumps(markets, getCurrentId(),
								getServerPid());

						if (request.getSearchString1().indexOf("=") >= 0
								|| request.getSearchString1().indexOf("*") >= 0) {
							isEmergency = true;
						}


					} catch (SQLException s) {
						writeLog("No CallDumps for this server at this time....");

					}

					while (((CallDumpThreads.size() < numberOfThreads && request != null) || isEmergency)) 
					{
						cds = new CallDumpSession(request.getId());
						cds.setLog(log);

//						cds.setMachineName(machine);
						cds.setPath(path);

						writeLog("A CallDump has been requested with the ID:"
								+ request.getId());

						cds.setEmail(request.getsubmitName());
						writeLog("By: " + request.getsubmitName());

						cds.setSearchAndType(request.getSearchString1(), request
								.getSearchStringType1());
						cds.setSearchAndType(request.getSearchString2(), request
								.getSearchStringType2());
						cds.setSearchAndType(request.getSearchString3(), request
								.getSearchStringType3());
						cds.setSearchAndType(request.getSearchString4(), request
								.getSearchStringType4());
						cds.setSearchAndType(request.getSearchString5(), request
								.getSearchStringType5());
						cds.setSearchAndType(request.getSearchString6(), request
								.getSearchStringType6());

						
						writeLog("For the search strings and types..");
						writeLog(cds.getSearchAndType());

						cds.setStartAndEndDates(request.getStartDate(), request
								.getEndDate());

						writeLog("With the Start Date: " + request.getStartDate());
						writeLog("       and End Date: " + request.getEndDate());

						if (markets.indexOf("m01") > -1) {
							writeLog("M01 switches to search "
									+ request.getSwitchesM01());
							cds.addSwitches("m01", request.getSwitchesM01());
						} 

						if (markets.indexOf("m02") > -1) {
							writeLog("M02 switches to search "
									+ request.getSwitchesM02());
							cds.addSwitches("m02", request.getSwitchesM02());
						} 

						if (markets.indexOf("m03") > -1) {
							writeLog("M03 switches to search "
									+ request.getSwitchesM03());
							cds.addSwitches("m03", request.getSwitchesM03());
						} 
						if (markets.indexOf("m04") > -1) {
							writeLog("M04 switches to search "
									+ request.getSwitchesM04());
							cds.addSwitches("m04", request.getSwitchesM04());
						} 

						if (markets.indexOf("m05") > -1) {
							writeLog("M05 switches to search "
									+ request.getSwitchesM05());
							cds.addSwitches("m05", request.getSwitchesM05());
						} 

						if (markets.indexOf("m06") > -1) {
							writeLog("M06 switches to search "
									+ request.getSwitchesM06());
							cds.addSwitches("m06", request.getSwitchesM06());
						} 
						
						if (markets.indexOf("Data") > -1) {
							writeLog("Data switches to search "
									+ request.getSwitchesM06());
							cds.addSwitches("Data", request.getSwitchesData());
						} 
						
						writeLog("Putting request in IU Status");
						dbhandler.validateConnection();
						//dao.updateStatus(request.getId(), "IU");				

						cds.start();
						CallDumpThreads.add(cds);
						request = null;
						isEmergency = false;
						cds = null;
					}
					ThreadCheck();
				}
				else {
					writeLog("Database down....");
				}
				Thread.sleep(numberOfSeconds * 1000);


			} catch (Exception e) {
				writeLog("An Exception has been thrown in the CallDumpManager run loop.\n Assuming request failed due to database error.");
				cds = null;
				e.printStackTrace(log.getPrintWriter());
				dbhandler.refreshConnection();
			}
		}

		CleanUpAndExit();
	}

	/**
	 * Returns an integer that corresponds to which CallDump machine is running
	 * this thread. This way we keep in sync any CallDumps that run over
	 * multiple markets.
	 * 
	 * @return 1 for Knoxville 2 otherwise
	 */
	private int getServerPid() {
		if (machine.equalsIgnoreCase("knx1scd1")) {
			return 1;
		}
		return 2;
	}

	/**
	 * Every 30 seconds every CallDumpSession is check to see if they are
	 * complete. If they are the database is updated with the final status and
	 * then removed.
	 * 
	 */
	private void ThreadCheck() {
		CallDumpSession cds = null;
		String status = null;

		for (int a = 0; a < CallDumpThreads.size(); a++) {
			cds = CallDumpThreads.get(a);
			try {

				if (cds.getStatus() == 0) {
					writeLog("The CallDump request with the ID: "
							+ cds.getSessionId());
					writeLog("Has Finished Sucessfully");
					dao.updateStartTime(cds.getSessionId(), cds.getStartTime());
					dao.updateEndTime(cds.getSessionId(), cds.getEndTime());
					dao.updateFilesSearched(cds.getSessionId(), cds.getFilesSearched());
					dao.updateStatus(cds.getSessionId(), "CO");						
					writeLog("Status is CO");
					status = "CO";
					dao
					.addReport(cds.getSessionId(), machine, cds
							.getReports());

					if(status.contentEquals(dao.getCallDumpStatus(cds.getSessionId()).trim()) && dbhandler.validateConnection())
					{
						CallDumpThreads.remove(a);
					}
					else {
						dbhandler.refreshConnection();
					}

				} else {
					if (cds.getStatus() == 2) {
						writeLog("The CallDump request with the ID: "
								+ cds.getSessionId());
						writeLog("Has Finished Un-Sucessfully!!!!!!!");
						writeLog("Putting the file in AF STATUS");
						status = "AF";
						dao.updateStatus(cds.getSessionId(), "AF");
						dao.updateStartTime(cds.getSessionId(), cds.getStartTime());
						dao.updateEndTime(cds.getSessionId(), cds.getEndTime());

						if(status.contentEquals(dao.getCallDumpStatus(cds.getSessionId()).trim()) && dbhandler.validateConnection())
						{
							CallDumpThreads.remove(a);
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace(log.getPrintWriter());
				writeLog("An Exception has been thrown.. Will try to refresh Database");
				cds = null;
				dbhandler.refreshConnection();
			}
		}
	}

	/**
	 * This class goes through each active CallDumpSession class kills and
	 * removes them then shuts down this thread and exits.
	 * 
	 */
	public void BigKill() {
		int[] x;
		x = new int[CallDumpThreads.size()];
		for (int a = 0; a < CallDumpThreads.size(); a++) {
			x[a] = (CallDumpThreads.get(a).getSessionId());
		}
		for (int a = 0; a < x.length; a++) {
			Kill(x[a]);
		}
		CleanUpAndExit();
	}

	/**
	 * When given a CallDumpSession ID, will kill and remove that process from
	 * the queue.
	 * 
	 * @param id
	 * @return returns 0 if successful.
	 */
	public int Kill(int id) {
		CallDumpSession cds = null;
		writeLog("A command has been sent to kill ID: " + id);
		try {
			cds = findSession(id);
			cds.Kill();
			dao.updateStatus(id, "WA");
			dao.updateEndTime(id, cds.getEndTime());
			writeLog("The ID: " + id + " has been killed");
		} catch (Exception e) {
			writeLog("Could not kill ID: " + id);
			writeLog(e.getMessage());
			writeLog("WARNING... There is a hanging Thread");
		}
		return 0;
	}

	/**
	 * Returns the Vector that contains all the active CallDumpSession threads.
	 * 
	 * @return the vector
	 */
	public Vector<CallDumpSession> getCallDumpThreads() {
		return CallDumpThreads;
	}

	/**
	 * Returns a string that contains all the CallDumpSession IDs.
	 * 
	 * @return an ID string
	 */
	private String getCurrentId() {
		String ids = "";
		if (CallDumpThreads.size() != 0) {
			for (int a = 0; a < CallDumpThreads.size() - 1; a++) {
				ids += Integer.toString(CallDumpThreads.get(a).getSessionId())
				+ ",";
			}

			ids += Integer.toString(CallDumpThreads.get(
					CallDumpThreads.size() - 1).getSessionId());
		}
		return ids;
	}

	/**
	 * Returns a Calendar object that contains the current time
	 * 
	 * @return
	 */
	private String getSysDateTime() {
		Calendar CAL = Calendar.getInstance();

		String CurDateTime = Integer.toString(CAL.get(Calendar.YEAR))
		+ Utils.PadStringBefore(Integer.toString(CAL
				.get(Calendar.MONTH) + 1), 2, "0")
				+ Utils.PadStringBefore(Integer
						.toString(CAL.get(Calendar.DATE)), 2, "0")
						+ Utils.PadStringBefore(Integer.toString(CAL
								.get(Calendar.HOUR_OF_DAY)), 2, "0")
								+ Utils.PadStringBefore(Integer.toString(CAL
										.get(Calendar.MINUTE)), 2, "0")
										+ Utils.PadStringBefore(Integer.toString(CAL
												.get(Calendar.SECOND)), 2, "0");

		return (CurDateTime);
	}

	/**
	 * Given a session ID return the CallDumpSession object.
	 * 
	 * @param id
	 *            Session ID
	 * @return the CallDumpSession with the passed in ID.
	 */
	private CallDumpSession findSession(int id) {
		CallDumpSession cds = null;

		for (int a = 0; a < CallDumpThreads.size(); a++) {
			cds = CallDumpThreads.get(a);

			if (cds.getSessionId() == id) {
				CallDumpThreads.remove(a);
				return cds;
			}
		}
		return null;
	}

	/**
	 * Opens a log file..
	 * 
	 */
	private void openLog() {
		String LogFileName = "CallDump." + getSysDateTime() + ".log";

		try {
			log = new LogWriter("log/", LogFileName);
		} catch (Exception e) {
			e.printStackTrace();
			System.out
			.println("Could not open Log File... So writing to standard out...");
		}
	}

	/**
	 * Writes the string passed as a parameter to the logfile.
	 * 
	 * @param out
	 *            the string to write to the log
	 */
	private void writeLog(String out) {
		if (log == null) {
			System.out.println(out);
		} else {
			log.println(out);
		}
	}

	/**
	 * Waits for all the threads to finish then exits the object.
	 * 
	 */
	private void CleanUpAndExit() {
		while (!CallDumpThreads.isEmpty()) {
			try {
				ThreadCheck();
				Thread.sleep(numberOfSeconds * 1000);
			} catch (Exception e) {
				writeLog("An Exception has been thrown in the CleanUpAndExit Method...");
				writeLog("May have to kill the process by hand");
			}
		}

		writeLog("All processes complete.. Closing Log file...");
		log.close();
		dbhandler.Close();
	}

	/**
	 * Sets the isRunning flag to false.
	 * 
	 */
	public void shutdown() {
		isRunning = false;
	}
}
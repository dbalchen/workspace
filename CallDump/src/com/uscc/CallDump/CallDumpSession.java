package com.uscc.CallDump;
import java.io.File;
import java.io.FilenameFilter;
import java.util.Calendar;
import java.util.Arrays;
import java.util.ArrayList;

/**
*  <p> CallDumpSession.java </p>
*
* <p> The class corresponds to an individual CallDump and the total number of these threads corespond to threads entry
* in the CallDump.xml file. It is this class that starts the perl process that extracts the information then keeps
* track of when it finishs. Once the process finishes it will set the return code which is then passed back to 
* the CallDumpManager class. </p>
* @author MPS
* @version 1.0
*/
public class CallDumpSession extends Thread {

	private int id;

	private int status = 1;

	private String SearchAndType = "";

	private LogWriter log = null;

	private String Switches = "";

	private String startDate;

	private String endDate;

	private String email;

//	private boolean othermkt;

	private String exec = "bin/CallDumpRequest";

	private String timestamp = "";

//	private String machine = "";

	private String path = "";

//	private String startTime = "";
	
	private String endTime = "";
	
	private String filesSearched = "";
	
	public CallDumpSession(int id) {
		this.id = id;
	}

	/**
	* This method calls the outside perl process waits until it receives a return code and once
	* received sets the status code variable.
	*/
	public void run() {

		String output = null;
		CallProcess CP = new CallProcess();
		String [] toutput = null;

		timestamp = getSysDateTime();
		
		exec = exec + " " + Switches + " " + SearchAndType + " " + startDate
		+ " " + endDate + " " + email + " " + timestamp;

		writeLog("Starting outside perl process with the following command line.");
		writeLog(exec);
		try {
			output = CP.exec(exec);
			output = output.replaceAll("(\\r|\\n)", "");
			
		} catch (Exception e) {
			writeLog("An exception was thrown... Thread will be killed!!!!!");
			e.printStackTrace(log.getPrintWriter());
			status = 2;
		}
		writeLog("The out from the called program: " + output);
		
		if ((output != null) && (output.trim().endsWith(":0"))) {
			
			toutput  = output.split(":");
			ArrayList<String> tArray = new ArrayList<String> (Arrays.asList(toutput));
			filesSearched = toutput[tArray.size() - 2];
			
			status = 0;
		} else {
			status = 2;
		}
		
		endTime = getSysDateTime();
		writeLog("CallDump Session has ended at time :" + endTime);
	}

	/**
	* Returns a String Array that contains the names and file paths for all the reports
	* created.
	* @return a String Array with the reports.
	*/
	public String [] getReports()
	{
		String [] Reports = null;
		FilenameFilter filter = new FilenameFilter() {
			public boolean accept(File dir, String name) {
				if((name.indexOf(timestamp)>= 0) && (name.endsWith("xls")))
				{
					return true;
				}
				return false;
			}};

			File dir = new File("reports");

			Reports = dir.list(filter);

			for(int a = 0; a < Reports.length; a++)
			{
				Reports[a] = path + "reports/" + Reports[a];
				writeLog("Writing Report: " + Reports[a]);
			}

			return Reports;

	}

	/**
	* Adds a switch and market to the search.
	* @param market: market name
	* @param switches: switch name
	*/
	public void addSwitches(String market, String switches) {
		if (switches != null)
			Switches += market + ";" + switches + ":";
	}

	/**
	* Gets a list of switches that will be searched.
	* @return: a list of switches
	*/
	public String getSwitches()
	{
		return Switches;
	}

	/**
	* Returns the status of the CallDump
	* @return: returns the status.
	*/
	public int getStatus() {
		return status;
	}

	/**
	* Sets the start and Date for a CallDump
	* @param startDate: The start date
	* @param endDate: The end date
	*/
	public void setStartAndEndDates(String startDate, String endDate) {
		this.startDate = startDate;
		this.endDate = endDate;
	}

	/**
	* Returns the start Time
	* @return: the start Time
	*/
	public String getStartTime()
	{
		
		return timestamp;
	}

	/**
	* Returns the end Time
	* @return: The end Time
	*/
	public String getEndTime()
	{
		return endTime;
	}

	/**
	* Returns the total number of files searched.
	* @return filesSearched;
	*/
	public String getFilesSearched()
	{
		return filesSearched;
	}
	/**
	* Returns the start date
	* @return: the start date
	*/
	public String getStartDate()
	{
		return startDate;
	}

	/**
	* Returns the end date
	* @return: The end date
	*/
	public String getEndDate()
	{
		return endDate;
	}

	/**
	* Sets the email address for the person requesting the CallDump.
	* @param email: The email address
	*/
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	* Returns the CallDump requestors email address
	* @return: The email address
	*/
	public String getEmail()
	{
		return email;
	}

	/**
	* Set the search string and the type of search
	* @param search: search string
	* @param type: Search type
	*/
	public void setSearchAndType(String search, String type) {
		if (search != null)
			SearchAndType += search + ";" + type + ":";
	}

	/**
	* Returns the search string and type of Search
	* @return: The search and type.
	*/
	public String getSearchAndType() {
		return SearchAndType;
	}

	/**
	* Returns the database ID for the CallDump.
	* @return: Database ID
	*/
	public int getSessionId() {
		return id;
	}

	/**
	* Sets to true if the query crosses both machines.
	* @param othermkt: True if using both machines.
	*/
//	public void setOtherMarket(boolean othermkt) {
//		this.othermkt = othermkt;
//	}

	/**
	* Returns true if query is cross machines, false otherwise.
	* @return: True if cross machines, False otherwise.
	*/
//	public boolean getOtherMarket() {
//		return othermkt;
//	}

	/**
	* Sets the machine name
	* @param machine: Machine name
	*/
	/*
	public void setMachineName(String machine)
	{
		this.machine = machine;
	}
*/
	/**
	* Sets the path where the CallDump main directory exists.
	* @param path
	*/
	public void setPath(String path)
	{
		this.path = path;
	}
	
	/**
	* Kills the thread and deletes the pid file.
	* @return: the status code of 2
	*/
	public int Kill() {

		String filepid = "run/" + "pid." + timestamp;
		writeLog("Killing the thread... removing the file " + filepid);

		File pidfile = new File(filepid);
		if(pidfile.exists())
		{
			if(!pidfile.delete())
			{
				writeLog("Could not delete the PID file... Some cleanup will need to be done");
			}
		}
		return 2;
	}

	/**
	* Sets the logfile object to this class.
	* @param log: The logWriter class
	*/
	public void setLog(LogWriter log) {
		this.log = log;
	}

	/**
	* Wrapper around the LogWriter class.
	* @param out: String to print to the log.
	*/
	public void writeLog(String out) {

		out = id + ": " + out; 
		if (log == null) {
			System.out.println(out);
		} else {
			log.println(out);
		}
	}

	/**
	* Sets the timestamp for the CallDump
	* @param timestamp: The Calldumps timestamp.
	*/
	public void setTimeStamp(String timestamp) {
		this.timestamp = timestamp;
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
}

package com.uscc.CallDump;

import com.uscc.timer.CronIterator;
import com.uscc.timer.Scheduler;
import com.uscc.timer.SchedulerTask;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import com.uscc.dao.CallDumpDAO;

/**
 * <p>
 * dbHandler.java
 * </p>
 * <p>
 * The dbHandler was a direct result of a re-design to handle the CallDump when
 * the database was down for a significant amount of time. It's jobs is to
 * monitor the database, periodically refresh the connection as well restart the
 * connection when it is down.
 * 
 * @author MPS
 * @version 1.0
 */
public class dbHandler implements TimedCheck {

	private Connection connection = null;
	private CallDumpDAO dao = null;
	private LogWriter log = null;
	private String driver = null;
	private String url = null;
	private String user = null;
	private String pass = null;
	private boolean gate = true;
	// The number of database connection retries before giving up till the next timed refresh.
	private int retrys = 3;

	private final Scheduler scheduler = new Scheduler();

	public dbHandler(String driver, String url, String user, String pass)
	{
		this.driver = driver;
		this.url = url;
		this.user = user;
		this.pass = pass;

	}

	public void start() {
		writeLog("Opening Database Connection");
		connection = getConnection();

		if (!gate) {
			System.err
			.println("A Database connection could not be established during startup.... \nCallDump Terminated!!!!!");
			System.exit(2);
		}

		scheduler.schedule(new SchedulerTask() {
			// Do regular database refresh here...
			public void run() {
				writeLog("Timed Database Refresh.....");
				gate = true;
				refreshConnection();
			}
			// The timed database refresh happens every 2 hours.
		}, new CronIterator("0","2,4,6,8,10,12,14,16,18,20,22", "*", "*","*"));
	}

	public CallDumpDAO getDao()
	{
		if (gate == false) {
			writeLog("Database is down.... returning null.....");
			return null;
		}
		if (dao == null) {
			writeLog("Initilize CallDumpDAO");
			dao = new CallDumpDAO(connection);
		}
		return dao;
	}

	public Connection getConn() {
		return connection;
	}

	public void setConn(Connection connection) {
		this.connection = connection;
	}

	public LogWriter getLog() {
		return log;
	}

	public void setLog(LogWriter log) {
		this.log = log;
	}

	public void refreshConnection() {

		dao = null;
		System.gc();

		if (gate) {
			writeLog("Refreshing the database connections.....");
			closeConnection(connection);
			connection = null;
			writeLog("Opening Database Connection");
			connection = getConnection();
		}

	}

	/**
	 * Closes the database connection that is passed as a parameter.
	 * 
	 * @param conn
	 *            The connection to close.
	 */
	private void closeConnection(Connection conn) {
		try {
			conn.close();
		} catch (Exception se) {
			se.printStackTrace(log.getPrintWriter());
			return;
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
	 * Returns a database connection.
	 * 
	 * @return database connection
	 */
	private Connection getConnection() {
		Connection conn = null;
		int trys = 0;

		while (conn == null && trys < retrys && gate) {
			try {
				Class.forName(driver);
				conn = (Connection) DriverManager
				.getConnection(url, user, pass);

				validateConnection(conn);

			} catch (Exception e) {
				conn = null;
				trys++;
				writeLog("Unable to establish a Database connection. => " + trys);
			}
		}
		if (trys == retrys) {
			writeLog("Maximum number of database retrys " + retrys + " has been reached... Wait till Database refresh.");
			gate = false;
		}
		return conn;
	}

	public boolean validateConnection() throws Exception
	{
		return validateConnection(connection);
	}

	public boolean validateConnection(Connection con) throws Exception
	{
		Statement myStmt = null;
		String sql = "select 1 from dual";

		if(gate)
		{
			myStmt = con.createStatement();
			myStmt.executeQuery(sql);	
			myStmt.close();		
		}
               
                myStmt = null;
		return gate;
	}

	public String getInfo() {
		return "The dbHandler class";
	}

	public boolean isGate() {
		return gate;
	}

	public void setGate(boolean gate) {
		this.gate = gate;
	}

	public int getRetrys() {
		return retrys;
	}

	public void setRetrys(int retrys) {
		this.retrys = retrys;
	}

	public void Close()
	{
		closeConnection(connection);
	}
}

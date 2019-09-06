package com.uscc.dao;

import com.uscc.beans.*;
import com.uscc.utils.USCCDate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.List;
import java.util.Hashtable;
import java.util.StringTokenizer;
import java.text.ParseException;

import javax.sql.DataSource;

/**
 * <p>
 * CallDumpDAO.java
 * </p>
 * <p>
 * This class provides the access to all the elements needed for database access
 * for the CallDump
 * </p>
 * 
 * @author MPS
 * @version 1.0
 */
public class CallDumpDAO extends DAO {
	public static final int VALID_REQUEST = 0;

	public static final int MISSING_SWITCH = 1;

	public static final int MISSING_SEARCH_STRING = 2;

	public static final int INVALID_DATE = 3;

	/**
	 * Constructs the data accessor with the given data source
	 */
	public CallDumpDAO(DataSource theDataSource) {
		super(theDataSource);
	}

	public CallDumpDAO(Connection con) {
		super(con);
	}

	public String cvttoSwitchAbbrev(String choice) {
		Connection tempConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		String result = null;
		try {
			tempConn = getConnection();
			myStmt = tempConn.createStatement();

			String Sql = " select identifier from switches where market||':'||name = '"
					+ choice + "'";
			myRs = myStmt.executeQuery(Sql);
			while (myRs.next()) {
				result = myRs.getString("identifier");
				break;
			}
		} catch (SQLException exc) {
			logError(exc);
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}
		return result;
	}

	public int getNumCallDumpRequests(String status, String restrict,
			String timeframe) {
		Connection tempConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		int index = 0;
		if (status.equalsIgnoreCase("NOCO")) {
			status = "'RD','IU','WA','IP','CP','AF'";
		}
		if (status.equalsIgnoreCase("ALL")) {
			status = "'RD','IU','WA','CO','IP','CP','AF'";
		}
		if (status.equalsIgnoreCase("CO")) {
			status = "'CO'";
		}
		try {
			tempConn = getConnection();
			myStmt = tempConn.createStatement();
			String Sql = " select t1.*, t2.first, t2.last, decode(t1.status,'RD','66CC66','IU','FFFF99','IP','FFFF99','FF0000') color, ";
			Sql += "              to_char(t1.start_date, 'YYYY-MON-DD HH24:MI') sd, to_char(t1.end_date, 'YYYY-MON-DD HH24:MI') endd, ";
			Sql += "              decode(t1.status, 'RD','WA','WA','RD',t1.status) chng_status";
			Sql += "         from call_dump_queue t1, users t2 ";
			Sql += "        where t1.userid = t2.userid ";
			Sql += "          and t1.status in (" + status + ")";
			Sql += "          and t1.submit_date >= sysdate - " + timeframe;
			if (!restrict.equalsIgnoreCase("none")) {
				Sql += "          and t1.userid = '" + restrict + "'";
			}
			myRs = myStmt.executeQuery(Sql);
			while (myRs.next()) {
				index++;
			}
		} catch (SQLException exc) {
			logError(exc);
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}
		return index;
	}

	public void addReport(int id, String host, String[] reports)
			throws DAOException {
		for (int i = 0; i < reports.length; i++) {
			addReport(id, host, reports[i]);
		}
	}

	public void addReport(int id, String host, String report)
			throws DAOException {
		Connection tempConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;

		try {
			tempConn = getConnection();
			tempConn.setAutoCommit(false);
			String sql = "insert into call_dump_reports values (?,?,?) ";
			myStmt = tempConn.prepareStatement(sql);
			myStmt.setString(3, report);
			myStmt.setString(2, host);
			myStmt.setInt(1, id);
			myStmt.executeUpdate();
			tempConn.commit();
			myStmt.close();
		} catch (SQLException se) {
			System.out.println("SQLERROR: " + se.getMessage());
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}
	}

	public CallDumpRequest getPendingCallDumps(String markets, String ids,
			int pid) throws SQLException {
		Connection tempConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		CallDumpRequest req = new CallDumpRequest();

		String[] marketArray = markets.split(",");

		ArrayList<String> tmpArray = new ArrayList<String>(
				Arrays.asList(marketArray));

		String sql = "SELECT q.ID,q.status,u.email_address email,TO_CHAR(q.start_date,'YYYYMMDDHH24MI') sd,"
				+ "TO_CHAR(q.end_date,'YYYYMMDDHH24MI') endd,"
				+ "q.switches_m01,q.switches_m02,q.switches_m03,q.switches_m04,q.switches_m05,q.switches_m06,"
				+ "q.search_string_1,q.search_string_2,q.search_string_3,q.search_string_4,q.search_string_5,"
				+ "q.search_string_6,q.search_string_type_1,q.search_string_type_2,q.search_string_type_3,"
				+ "q.search_string_type_4,q.search_string_type_5,q.search_string_type_6,q.pid "
				+ "FROM call_dump_queue q, users u WHERE u.userid = q.USERID AND "
				+ "(q.status = 'RD' or (q.status = 'IP' and q.pid != "
//				+ "(q.status = 'ZD' or (q.status = 'IP' and q.pid != "
				+ pid
				+ ") or (q.status = 'CP' and q.pid != " + pid + ") ) AND (";

		for (int a = 0; a < tmpArray.size() - 1; a++) {
			sql += "switches_" + tmpArray.get(a).toLowerCase()
					+ " is not null or ";
		}
		sql += "switches_" + tmpArray.get(tmpArray.size() - 1).toLowerCase()
				+ " is not null)";

		if (ids.trim().length() != 0) {
			String[] idS = ids.split(",");
			tmpArray = new ArrayList<String>(Arrays.asList(idS));
			sql += " AND (";
			for (int a = 0; a < tmpArray.size() - 1; a++) {
				sql += "q.ID != " + tmpArray.get(a) + " or ";
			}
			sql += "q.ID != " + tmpArray.get(tmpArray.size() - 1) + ")";
		}

		// sql += " and rownum < 2 ORDER BY u.user_priority,q.PRIORITY";
		sql += " ORDER BY u.user_priority,q.PRIORITY";
		tempConn = getConnection();
		myStmt = tempConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_READ_ONLY);

		myRs = myStmt.executeQuery(sql);

		myRs.last();
		// Stop the loop when the cursor is positioned before the first row
		while (!myRs.isBeforeFirst()) {

			if ((myRs.getString("search_string_1").indexOf("=") != -1)
					|| (myRs.getString("search_string_1").indexOf("*") != -1)) {
				break;
			}
			try {
				myRs.previous();
			} catch (Exception e) {
				break;
			}
		}

		if (myRs.isBeforeFirst()) {
			myRs.next();
		}
		//

		req.setId(myRs.getInt("id"));
		req.setStatus(myRs.getString("status"));
		req.setStartDate(myRs.getString("sd"));
		req.setEndDate(myRs.getString("endd"));
		req.setSwitchesM01(myRs.getString("switches_m01"));
		req.setSwitchesM02(myRs.getString("switches_m02"));
		req.setSwitchesM03(myRs.getString("switches_m03"));
		req.setSwitchesM04(myRs.getString("switches_m04"));
		req.setSwitchesM05(myRs.getString("switches_m05"));
		req.setSwitchesM06(myRs.getString("switches_m06"));

		req.setSearchString1(trimString(myRs.getString("search_string_1")));
		req.setSearchString2(trimString(myRs.getString("search_string_2")));
		req.setSearchString3(trimString(myRs.getString("search_string_3")));
		req.setSearchString4(trimString(myRs.getString("search_string_4")));
		req.setSearchString5(trimString(myRs.getString("search_string_5")));
		req.setSearchString6(trimString(myRs.getString("search_string_6")));

		req.setSearchStringType1(myRs.getString("search_string_type_1"));
		req.setSearchStringType2(myRs.getString("search_string_type_2"));
		req.setSearchStringType3(myRs.getString("search_string_type_3"));
		req.setSearchStringType4(myRs.getString("search_string_type_4"));
		req.setSearchStringType5(myRs.getString("search_string_type_5"));
		req.setSearchStringType6(myRs.getString("search_string_type_6"));
		req.setPid(myRs.getInt("pid"));
		req.setsubmitName(myRs.getString("email"));

		cleanup(myRs, myStmt, tempConn);

		return req;
	}

	private String trimString(String strim) {
		if (strim != null) {
			return strim.trim();
		}
		return strim;
	}

	public List<CallDumpReport> getCallDumpReports(int id) {
		Connection tempConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		ArrayList<CallDumpReport> theList = new ArrayList<CallDumpReport>();
		try {
			tempConn = getConnection();
			myStmt = tempConn.createStatement();
			String Sql = " select * from call_dump_reports where id = " + id
					+ " order by id, file_name ";
			myRs = myStmt.executeQuery(Sql);
			while (myRs.next()) {
				CallDumpReport rpt = new CallDumpReport();
				rpt.setId(myRs.getInt("id"));
				rpt.setFile(myRs.getString("file_name"));
				rpt.setHost(myRs.getString("hostname"));
				theList.add(rpt);
			}
		} catch (SQLException exc) {
			logError(exc);
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}
		theList.trimToSize();
		return theList;
	}

	/* CQ223895: Slowness in Show Completed Requests */
	public List<CallDumpRequest> getCallDumpRequests(String status, int start,
			int end, boolean isadmin, String restrict, String timeframe) {
		Connection tempConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		int index = 0;
		UserDAO udao = null;
		int numrows = end - start;
		String s = "/*";
		String e = "*/";
		Connection con = getConnection();

		ArrayList<CallDumpRequest> theList = new ArrayList<CallDumpRequest>();

		if (status.equalsIgnoreCase("NOCO")) {
			status = "'RD','IU','WA','IP','CP','AF'";
		}
		if (status.equalsIgnoreCase("ALL")) {
			status = "'RD','IU','WA','CO','IP','CP','AF'";
		}
		if (status.equalsIgnoreCase("CO")) {
			status = "'CO'";
		}
		try {
			tempConn = getConnection();
			myStmt = tempConn.createStatement();
			String Sql = "select * from (select " + s + " first_rows("
					+ numrows + ")" + e + " t1.*, ";
			Sql += "     decode(t1.status,'RD','66CC66','IU','FFFF99','CP','FFFF99','IP','FFFF99','CO','#6495ED','AF','FF0000','9999CC') color,";
			Sql += "             to_char(t1.start_date, 'YYYY-MON-DD HH24:MI') sd, to_char(t1.end_date, 'YYYY-MON-DD HH24:MI') endd, ";
			Sql += "             decode(t1.status, 'RD','WA','WA','RD',t1.status) chng_status, ";
			/*
			 * Sql +=
			 * "             to_char(t1.submit_date, 'YYYY-MON-DD HH24:MI') subd, row_number() over (order by t1.status, priority desc, id) rn "
			 * ;
			 */
			Sql += "             to_char(t1.submit_date, 'YYYY-MON-DD HH24:MI') subd, row_number() over (order by t1.status, priority, id) rn ";
			Sql += "        from call_dump_queue t1 ";
			Sql += "       where t1.status in (" + status + ")";
			Sql += "         and t1.submit_date >= sysdate - " + timeframe;
			if (!restrict.equalsIgnoreCase("none")) {
				Sql += "     and t1.userid = '" + restrict + "'";
			}

			/*
			 * Sql +=
			 * "    order by t1.status, priority desc, id) where rn between " +
			 * start + " and " + end + " order by rn";
			 */
			Sql += "    ) where rn between " + start + " and " + end
					+ " order by rn";

			myRs = myStmt.executeQuery(Sql);
			udao = new UserDAO(con);

			while (myRs.next()) {
				int priority = myRs.getInt("priority");
				int id = myRs.getInt("id");

				CallDumpRequest req = new CallDumpRequest();
				req.setId(id);
				req.setPriority(priority);
				req.setStatus(myRs.getString("status"));
				req.setUserid(myRs.getString("userid"));
				req.setStartDate(myRs.getString("sd"));
				req.setSubmitDate(myRs.getString("subd"));
				req.setEndDate(myRs.getString("endd"));
				req.setSwitchesM01(myRs.getString("switches_m01"));
				req.setSwitchesM02(myRs.getString("switches_m02"));
				req.setSwitchesM03(myRs.getString("switches_m03"));
				req.setSwitchesM04(myRs.getString("switches_m04"));
				req.setSwitchesM05(myRs.getString("switches_m05"));
				req.setSwitchesM06(myRs.getString("switches_m06"));
				req.setSearchString1(myRs.getString("search_string_1"));
				req.setSearchString2(myRs.getString("search_string_2"));
				req.setSearchString3(myRs.getString("search_string_3"));
				req.setSearchString4(myRs.getString("search_string_4"));
				req.setSearchString5(myRs.getString("search_string_5"));
				req.setSearchString6(myRs.getString("search_string_6"));
				req.setSearchStringType1(myRs.getString("search_string_type_1"));
				req.setSearchStringType2(myRs.getString("search_string_type_2"));
				req.setSearchStringType3(myRs.getString("search_string_type_3"));
				req.setSearchStringType4(myRs.getString("search_string_type_4"));
				req.setSearchStringType5(myRs.getString("search_string_type_5"));
				req.setSearchStringType6(myRs.getString("search_string_type_6"));
				req.setPid(myRs.getInt("pid"));

				Developer dev = udao.getUser(myRs.getString("userid"));
				req.setsubmitName(dev.getFirstName() + " " + dev.getLastName());

				req.setColor(myRs.getString("color"));
				req.setNextStatus(myRs.getString("chng_status"));
				theList.add(req);
			}
		} catch (SQLException exc) {
			logError(exc);

			// throw new DAOException(exc);
		} finally {
			cleanup(myRs, myStmt, tempConn);
			cleanup(null, null, con);
		}
		return theList;
	}

	// public List<CallDumpRequest> getCallDumpRequests(String status, int
	// start, int end,
	// boolean isadmin, String restrict, String timeframe) {
	// Connection tempConn = null;
	// Statement myStmt = null;
	// ResultSet myRs = null;
	// int index = 0;
	//
	// ArrayList<CallDumpRequest> theList = new ArrayList<CallDumpRequest>();
	//
	// if (status.equalsIgnoreCase("NOCO")) {
	// status = "'RD','IU','WA','IP','CP','AF'";
	// }
	// if (status.equalsIgnoreCase("ALL")) {
	// status = "'RD','IU','WA','CO','IP','CP','AF'";
	// }
	// if (status.equalsIgnoreCase("CO")) {
	// status = "'CO'";
	// }
	// try {
	// tempConn = getConnection();
	// myStmt = tempConn.createStatement();
	// String Sql = "select t1.*,t2.first,t2.last,";
	// Sql +=
	// "     decode(t1.status,'RD','66CC66','IU','FFFF99','CP','FFFF99','IP','FFFF99','CO','#6495ED','AF','FF0000','9999CC') color,";
	// Sql +=
	// "             to_char(t1.start_date, 'YYYY-MON-DD HH24:MI') sd, to_char(t1.end_date, 'YYYY-MON-DD HH24:MI') endd, ";
	// Sql +=
	// "             decode(t1.status, 'RD','WA','WA','RD',t1.status) chng_status, ";
	// Sql +=
	// "             to_char(t1.submit_date, 'YYYY-MON-DD HH24:MI') subd ";
	// Sql += "        from call_dump_queue t1, users t2 ";
	// Sql += "       where t1.userid = t2.userid ";
	// Sql += "         and t1.status in (" + status + ")";
	// Sql += "         and t1.submit_date >= sysdate - " + timeframe;
	// if (!restrict.equalsIgnoreCase("none")) {
	// Sql += "     and t1.userid = '" + restrict + "'";
	// }
	// Sql += "    order by t1.status, priority desc, id";
	//
	// myRs = myStmt.executeQuery(Sql);
	// while (myRs.next()) {
	// index++;
	// if (index >= start && index <= end) {
	// int priority = myRs.getInt("priority");
	// int id = myRs.getInt("id");
	//
	// CallDumpRequest req = new CallDumpRequest();
	// req.setId(id);
	// req.setPriority(priority);
	// req.setStatus(myRs.getString("status"));
	// req.setUserid(myRs.getString("userid"));
	// req.setStartDate(myRs.getString("sd"));
	// req.setSubmitDate(myRs.getString("subd"));
	// req.setEndDate(myRs.getString("endd"));
	// req.setSwitchesM01(myRs.getString("switches_m01"));
	// req.setSwitchesM02(myRs.getString("switches_m02"));
	// req.setSwitchesM03(myRs.getString("switches_m03"));
	// req.setSwitchesM04(myRs.getString("switches_m04"));
	// req.setSwitchesM05(myRs.getString("switches_m05"));
	// req.setSwitchesM06(myRs.getString("switches_m06"));
	// req.setSearchString1(myRs.getString("search_string_1"));
	// req.setSearchString2(myRs.getString("search_string_2"));
	// req.setSearchString3(myRs.getString("search_string_3"));
	// req.setSearchString4(myRs.getString("search_string_4"));
	// req.setSearchString5(myRs.getString("search_string_5"));
	// req.setSearchString6(myRs.getString("search_string_6"));
	// req.setSearchStringType1(myRs
	// .getString("search_string_type_1"));
	// req.setSearchStringType2(myRs
	// .getString("search_string_type_2"));
	// req.setSearchStringType3(myRs
	// .getString("search_string_type_3"));
	// req.setSearchStringType4(myRs
	// .getString("search_string_type_4"));
	// req.setSearchStringType5(myRs
	// .getString("search_string_type_5"));
	// req.setSearchStringType6(myRs
	// .getString("search_string_type_6"));
	// req.setPid(myRs.getInt("pid"));
	// req.setsubmitName(myRs.getString("first") + " "
	// + myRs.getString("last"));
	// req.setColor(myRs.getString("color"));
	// req.setNextStatus(myRs.getString("chng_status"));
	// theList.add(req);
	// }
	// }
	// } catch (SQLException exc) {
	// logError(exc);
	//
	// // throw new DAOException(exc);
	// } finally {
	// cleanup(myRs, myStmt, tempConn);
	// }
	// return theList;
	// }

	public void removeCallDump(int id) throws DAOException {
		Connection tempConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;
		try {
			tempConn = getConnection();
			tempConn.setAutoCommit(false);
			String sql = "delete from call_dump_queue where status in ('RD','WA','AF') and id = ? ";
			myStmt = tempConn.prepareStatement(sql);
			myStmt.setInt(1, id);
			myStmt.executeUpdate();
			tempConn.commit();
			myStmt.close();
		} catch (SQLException se) {
			System.out.println("SQLERROR: " + se.getMessage());
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}
	}

	public void updateStartTime(int id, String start) throws DAOException {
		Connection tempConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;
		try {
			tempConn = getConnection();
			tempConn.setAutoCommit(false);
			String sql = "update call_dump_queue set JOB_START = to_date(?,'YYYYMMDDHH24MISS') where id = ? ";
			myStmt = tempConn.prepareStatement(sql);
			myStmt.setString(1, start);
			myStmt.setInt(2, id);
			myStmt.executeUpdate();
			tempConn.commit();
			myStmt.close();
		} catch (SQLException se) {
			System.out.println("SQLERROR: " + se.getMessage());
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}
	}

	public void updateEndTime(int id, String end) throws DAOException {
		Connection tempConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;
		try {
			tempConn = getConnection();
			tempConn.setAutoCommit(false);
			String sql = "update call_dump_queue set JOB_END = to_date(?,'YYYYMMDDHH24MISS') where id = ? ";
			myStmt = tempConn.prepareStatement(sql);
			myStmt.setString(1, end);
			myStmt.setInt(2, id);
			myStmt.executeUpdate();
			tempConn.commit();
			myStmt.close();
		} catch (SQLException se) {
			System.out.println("SQLERROR: " + se.getMessage());
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}
	}

	public void updateFilesSearched(int id, String filesSearched)
			throws DAOException {
		Connection tempConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;
		try {
			tempConn = getConnection();
			tempConn.setAutoCommit(false);
			String sql = "update call_dump_queue set FILES_SEARCHED = "
					+ filesSearched + " where id = ? ";
			myStmt = tempConn.prepareStatement(sql);
			myStmt.setInt(1, id);
			myStmt.executeUpdate();
			tempConn.commit();
			myStmt.close();
		} catch (SQLException se) {
			System.out.println("SQLERROR: " + se.getMessage());
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}
	}

	public void updateStatus(int id, String status) throws DAOException {
		Connection tempConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;
		try {
			tempConn = getConnection();
			tempConn.setAutoCommit(false);
			tempConn.setAutoCommit(false);
			String sql = "update call_dump_queue set status = '" + status
					+ "' where id = ? ";
			myStmt = tempConn.prepareStatement(sql);
			myStmt.setInt(1, id);
			myStmt.executeUpdate();
			tempConn.commit();
			myStmt.close();
		} catch (SQLException se) {
			System.out.println("SQLERROR: " + se.getMessage());
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}
	}

	public void updatePid(int id, int pid) throws DAOException {
		Connection tempConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;
		try {
			tempConn = getConnection();
			tempConn.setAutoCommit(false);
			String sql = "update call_dump_queue set pid = '" + pid
					+ "' where id = ? ";
			myStmt = tempConn.prepareStatement(sql);
			myStmt.setInt(1, id);
			myStmt.executeUpdate();
			tempConn.commit();
			myStmt.close();
		} catch (SQLException se) {
			System.out.println("SQLERROR: " + se.getMessage());
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}
	}

	public String getCallDumpStatus(int id) throws SQLException {
		Connection tempConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		String results;

		tempConn = getConnection();
		myStmt = tempConn.createStatement();
		String sql = "SELECT status FROM call_dump_queue where id = "
				+ Integer.toString(id);
		myRs = myStmt.executeQuery(sql);
		myRs.next();
		results = myRs.getString("status");
		cleanup(myRs, myStmt, tempConn);
		return results;
	}

	public String getCallDumpDestination(String ctn) throws SQLException {
		Connection tempConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;
		String results = "Unknown";

		tempConn = getConnection();
		myStmt = tempConn.createStatement();
		String sql = "  SELECT t2.RELATED_MARKET MKT ";
		sql += "    FROM NPA_NXX_VH T1, MARKET t2 ";
		sql += "   WHERE '" + ctn + "'";
		sql += " BETWEEN NPA||NXX||BEGIN_LINE_RANGE ";
		sql += "     AND NPA||NXX||END_LINE_RANGE ";
		sql += "     AND T1.SUB_MARKET_CODE = T2.MARKET_CODE ";

		myRs = myStmt.executeQuery(sql);
		while (myRs.next()) {
			results = myRs.getString("MKT");
		}
		cleanup(myRs, myStmt, tempConn);
		return results;
	}

	public void lowerPriority(int id) throws DAOException {
		Connection tempConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;

		try {
			tempConn = getConnection();
			tempConn.setAutoCommit(false);
			String sql = "update call_dump_queue set priority = priority - 1 where status in ('WA','RD','AF') and priority > 0 and id = ?";
			myStmt = tempConn.prepareStatement(sql);
			myStmt.setInt(1, id);
			myStmt.executeUpdate();
			tempConn.commit();
			myStmt.close();
		} catch (SQLException se) {
			System.out.println("SQLERROR: " + se.getMessage());
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}
	}

	public void raisePriority(int id) throws DAOException {
		Connection tempConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;
		try {
			tempConn = getConnection();
			tempConn.setAutoCommit(false);
			String sql = "update call_dump_queue set priority = priority + 1 where status in ('WA','RD','AF') and id = ? ";
			myStmt = tempConn.prepareStatement(sql);
			myStmt.setInt(1, id);
			myStmt.executeUpdate();
			tempConn.commit();
			myStmt.close();
		} catch (SQLException se) {
			System.out.println("SQLERROR: " + se.getMessage());
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}
	}

	public List<SwitchEntry> getSwitches() {
		ArrayList<SwitchEntry> theList = new ArrayList<SwitchEntry>();
		Connection tempConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;

		try {
			tempConn = getConnection();
			myStmt = tempConn.createStatement();

			String Sql = "select * ";
			Sql += "  from switches ";
			Sql += " where effective_date < sysdate ";
			Sql += "   and nvl(expiration_date,sysdate+1) > sysdate ";
			Sql += " order by market, name";

			myRs = myStmt.executeQuery(Sql);
			while (myRs.next()) {
				SwitchEntry sw = new SwitchEntry();
				String name = myRs.getString("market") + ":"
						+ myRs.getString("name");
				sw.setMarket(myRs.getString("market"));
				sw.setName(name);
				theList.add(sw);
			}

		} catch (SQLException exc) {
			logError(exc);

			// throw new DAOException(exc);
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}

		return theList;
	}

	public ArrayList<SwitchEntry> getSwitchesByType(String market, String type) {
		ArrayList<SwitchEntry> theList = new ArrayList<SwitchEntry>();
		Connection tempConn = null;
		Statement myStmt = null;
		ResultSet myRs = null;

		try {
			tempConn = getConnection();
			myStmt = tempConn.createStatement();

			String Sql = "select * ";
			Sql += "  from switches ";
			Sql += " where market = '" + market + "'";
			Sql += "   and type = '" + type + "'";
			Sql += "   and effective_date < sysdate ";
			Sql += "   and nvl(expiration_date,sysdate+1) > sysdate ";
			Sql += " order by market, identifier desc";

			myRs = myStmt.executeQuery(Sql);
			while (myRs.next()) {
				SwitchEntry sw = new SwitchEntry();
				String name = myRs.getString("market") + ":"
						+ myRs.getString("name");
				sw.setMarket(myRs.getString("market"));
				sw.setName(name);
				sw.setIdentifier(myRs.getString("identifier"));
				theList.add(sw);
			}

		} catch (SQLException exc) {
			logError(exc);

			// throw new DAOException(exc);
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}

		return theList;
	}

	public String getErrorMessage(int rc) {
		switch (rc) {
		case MISSING_SWITCH:
			return "No switch was entered";
		case MISSING_SEARCH_STRING:
			return "No Search String was entered";
		case INVALID_DATE:
			return "Invalid Start or End Date was entered";
		}
		return "Unknown error, please contact MPS Support";
	}

	public int submitCallDumpRequest(CallDumpRequest req) throws DAOException {
		Connection tempConn = null;
		PreparedStatement myStmt = null;
		ResultSet myRs = null;

//		int rc = isRequestValid(req);
//		if (rc != VALID_REQUEST) {
//			return rc;
//		}

		try {
			tempConn = getConnection();
			tempConn.setAutoCommit(false);
			
			String sql = "insert into call_dump_queue"
					+ " values"
					+ " (calldump.nextval,?,?,?, SYSDATE, to_date(?,'YYYYMMDDHH24MISS'), to_date(?,'YYYYMMDDHH24MISS'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,null,null,0)";

			myStmt = tempConn.prepareStatement(sql);

			// set the parameters
			myStmt.setInt(1, 0);
			myStmt.setString(2, "RD");
			myStmt.setString(3, req.getUserid());
			myStmt.setString(4, req.getStartDate());
			myStmt.setString(5, req.getEndDate());

			myStmt.setString(6, correctSwitchlist(req.getSwitchesM01()));
			myStmt.setString(7, correctSwitchlist(req.getSwitchesM02()));
			myStmt.setString(8, correctSwitchlist(req.getSwitchesM03()));
			myStmt.setString(9, correctSwitchlist(req.getSwitchesM04()));
			myStmt.setString(10, correctSwitchlist(req.getSwitchesM05()));
			myStmt.setString(11, correctSwitchlist(req.getSwitchesM06()));

			myStmt.setString(12, req.getSearchString1().replaceFirst(";", ""));
			myStmt.setString(13, req.getSearchString2().replaceFirst(";", ""));
			myStmt.setString(14, req.getSearchString3().replaceFirst(";", ""));
			myStmt.setString(15, req.getSearchString4().replaceFirst(";", ""));
			myStmt.setString(16, req.getSearchString5().replaceFirst(";", ""));
			myStmt.setString(17, req.getSearchString6().replaceFirst(";", ""));
			myStmt.setString(18,
					req.getSearchStringType1().replaceFirst(";", ""));
			myStmt.setString(19,
					req.getSearchStringType2().replaceFirst(";", ""));
			myStmt.setString(20,
					req.getSearchStringType3().replaceFirst(";", ""));
			myStmt.setString(21,
					req.getSearchStringType4().replaceFirst(";", ""));
			myStmt.setString(22,
					req.getSearchStringType5().replaceFirst(";", ""));
			myStmt.setString(23,
					req.getSearchStringType6().replaceFirst(";", ""));
			myStmt.setInt(24, req.getPid());
			myStmt.executeUpdate();
			tempConn.commit();
			myStmt.close();
		} catch (SQLException exc) {
			logError(exc);
			throw new DAOException(exc);
		} finally {
			cleanup(myRs, myStmt, tempConn);
		}
		return 0;

	}

	// Correct the switch list, convert the "ALL" to the appropriate detailed
	// list.
	public String correctSwitchlist(String in) {
		if (in.equalsIgnoreCase("")) {
			return in;
		}
		StringTokenizer toks = new StringTokenizer(in, ",");
		Hashtable<String, String> switches = new Hashtable<String, String>();

		while (toks.hasMoreTokens()) {
			String tok = toks.nextToken();
			String mkt = tok.substring(0, 3);
			if (tok.indexOf("ALLV") > 0) {
				ArrayList<SwitchEntry> voiceSwitches = getSwitchesByType(mkt,
						"V");
				for (int i = 0; i < voiceSwitches.size(); i++) {
					addSwitchtoList(switches, voiceSwitches.get(i)
							.getIdentifier());
				}
			} else if (tok.indexOf("ALLD") > 0) {
				ArrayList<SwitchEntry> voiceSwitches = getSwitchesByType(mkt,
						"D");
				for (int i = 0; i < voiceSwitches.size(); i++) {
					addSwitchtoList(switches, voiceSwitches.get(i)
							.getIdentifier());
				}
			} else {
				addSwitchtoList(switches, tok);
			}
		}
		StringBuffer correctlist = new StringBuffer();
		Enumeration<String> collect = switches.keys();
		while (collect.hasMoreElements()) {
			String el = collect.nextElement();
			correctlist.append(el);
			if (collect.hasMoreElements()) {
				correctlist.append(",");
			}
		}
		return correctlist.toString();
	}

	private void addSwitchtoList(Hashtable<String, String> switchhash,
			String switchtoadd) {
		String entry = switchhash.get(switchtoadd);
		if (entry == null) {
			switchhash.put(switchtoadd, switchtoadd);
		}
	}

	// Is the request valiad according to the following criteria
	// 1) Date is within 1 year
	// 2) At least one search string is entered
	// 3) At least one switch is entered
//	public int isRequestValid(CallDumpRequest req) {
//		if ((req.getSwitchesM01().equalsIgnoreCase(""))
//				&& (req.getSwitchesM02().equalsIgnoreCase(""))
//				&& (req.getSwitchesM03().equalsIgnoreCase(""))
//				&& (req.getSwitchesM04().equalsIgnoreCase(""))
//				&& (req.getSwitchesM05().equalsIgnoreCase(""))
//				&& (req.getSwitchesM06().equalsIgnoreCase(""))) {
//			return MISSING_SWITCH;
//		}
//		if ((req.getSearchString1().equalsIgnoreCase(""))
//				&& (req.getSearchString2().equalsIgnoreCase(""))
//				&& (req.getSearchString3().equalsIgnoreCase(""))
//				&& (req.getSearchString4().equalsIgnoreCase(""))
//				&& (req.getSearchString5().equalsIgnoreCase(""))
//				&& (req.getSearchString6().equalsIgnoreCase(""))) {
//			return MISSING_SEARCH_STRING;
//		}
//
//		try {
//
//			String startd = req.getStartDate();
//			String endd = req.getEndDate();
//
//			// Is start and end date valid dates
//			USCCDate.ConvertDateFormatCheckValidity(startd,
//					USCCDate.DEF_DATE_TIME_FORMAT, "CST6CDT",
//					USCCDate.DEF_DATE_TIME_FORMAT, "CST6CDT");
//			USCCDate.ConvertDateFormatCheckValidity(endd,
//					USCCDate.DEF_DATE_TIME_FORMAT, "CST6CDT",
//					USCCDate.DEF_DATE_TIME_FORMAT, "CST6CDT");
//			// is start date lt end date
//			if (USCCDate.CompareDates(startd, USCCDate.DEF_DATE_TIME_FORMAT,
//					endd, USCCDate.DEF_DATE_TIME_FORMAT) != USCCDate.DATE_OLDER) {
//				System.out.println("Date check 1:"
//						+ startd
//						+ ":"
//						+ endd
//						+ ":"
//						+ USCCDate.CompareDates(startd,
//								USCCDate.DEF_DATE_TIME_FORMAT, endd,
//								USCCDate.DEF_DATE_TIME_FORMAT));
//				return INVALID_DATE;
//			}
//
//			String yearago = USCCDate.getAdjustedSysDateTime(Calendar.YEAR, -1);
//			if (USCCDate.CompareDates(startd, USCCDate.DEF_DATE_TIME_FORMAT,
//					yearago, USCCDate.DEF_DATE_TIME_FORMAT) == USCCDate.DATE_OLDER) {
//				System.out.println("Date check 2:"
//						+ startd
//						+ ":"
//						+ yearago
//						+ ":"
//						+ USCCDate.CompareDates(startd,
//								USCCDate.DEF_DATE_TIME_FORMAT, yearago,
//								USCCDate.DEF_DATE_TIME_FORMAT));
//				return INVALID_DATE;
//			}
//
//		} catch (ParseException pe) {
//			return INVALID_DATE;
//		}
//		return VALID_REQUEST;
//	}
}

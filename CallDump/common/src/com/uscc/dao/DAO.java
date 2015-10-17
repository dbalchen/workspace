package com.uscc.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.logging.Level;
import java.util.logging.Logger;

import javax.sql.DataSource;

/**
 * DAO: Base class for the data accessors
 * 
 * @author Darbchad
 * @version Nov 19, 2003 - 12:09:43 PM
 */
public abstract class DAO {
	/**
	 * Flag to sort by title
	 */
	public static final int SORT_BY_TITLE = 0;

	/**
	 * Flag to sort by price
	 */
	public static final int SORT_BY_PRICE = 1;

	/**
	 * Flag to sort by stock count
	 */
	public static final int SORT_BY_STOCK_COUNT = 2;

	private boolean dataSourceConnection = true;

	/**
	 * Reference to the data source
	 */
	protected DataSource dataSource;

	protected Connection conn;

	/**
	 * Reference to logger
	 */
	protected Logger logger = Logger.getLogger("rain");

	/**
	 * Construct the DAO based on data source
	 * 
	 * @param theDataSource
	 */
	public DAO(DataSource theDataSource) {
		setDataSource(theDataSource);
	}

	public DAO(Connection conn) {
		dataSourceConnection = false;
		this.conn = conn;
	}

	public DAO() {
	}

	/**
	 * Set the DATABASE Connection
	 * 
	 * @param con
	 *            connection (already open)
	 */
	public void setConnection(Connection con) {
		this.conn = con;
		dataSourceConnection = false;
	}

	/**
	 * Get the current connection
	 * 
	 * @return conn - Open connection
	 */
	public Connection getConnection() {
		if (!dataSourceConnection) {
			return this.conn;
		}

		try {
			return this.dataSource.getConnection();
		} catch (SQLException se) {
			return null;
		}
	}

	/**
	 * Set the data source
	 * 
	 * @param theDataSource
	 */
	protected void setDataSource(DataSource theDataSource) {
		dataSource = theDataSource;
		dataSourceConnection = true;
	}

	/**
	 * Utility method to clean up database resources.
	 * 
	 * @param myRs
	 *            the result set
	 * @param myStmt
	 *            the statment
	 * @param tempConn
	 *            the connection
	 */
	protected void cleanup(ResultSet myRs, Statement myStmt, Connection tempConn) {
		try {
			if (myRs != null) {
				myRs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		try {
			if (myStmt != null) {
				myStmt.close();
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
		}

		try {
			if (tempConn != null) {
				if (dataSourceConnection) {
					tempConn.close();
				}
			}
		} catch (SQLException e2) {
			e2.printStackTrace();
		}
	}

	/**
	 * Log a message
	 * 
	 * @param message
	 */
	protected void log(Object message) {
		logger.info(message.toString());
	}

	/**
	 * Log an error w/ the given message
	 * 
	 * @param message
	 * @param thrown
	 */
	protected void logError(Object message, Throwable thrown) {
		logger.log(Level.SEVERE, message.toString(), thrown);
	}

	/**
	 * Log an error
	 * 
	 * @param thrown
	 */
	protected void logError(Throwable thrown) {
		logError("", thrown);
	}
}
